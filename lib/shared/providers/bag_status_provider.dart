import 'dart:convert';
import 'package:bag_finder/core/entity/bag_status_entity.dart';
import 'package:bag_finder/core/failures/bag_failure.dart';
import 'package:bag_finder/core/utils/global_snackbar.dart';
import 'package:bag_finder/infra/repositories/bag_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class RfidBagProvider extends ChangeNotifier {
  final WebSocketChannel channel;
  final String baseUrl;
  final BagRepositoryImpl bagRepository;

  final List<BagStatusEntity> _bags = [];
  List<BagStatusEntity> get bags => List.unmodifiable(_bags);

  RfidBagProvider({
    required this.channel,
    required this.baseUrl,
    required this.bagRepository,
  }) {
    // Escuta mensagens do WebSocket
    channel.stream.listen(_onMessage);
  }

  /// Trata mensagens recebidas via WebSocket (com EPC da bagagem)
  void _onMessage(dynamic message) async {
    try {
      final data = jsonDecode(message);
      final epc = data['epc'] as String?;
      if (epc == null) return;

      final result = await bagRepository.findBagByEpc(epc: epc);

      result.fold(
        (failure) {
          GlobalSnackBar.error('Erro ao buscar bag por EPC: $failure');
        },
        (bag) {
          print('🧳 [Nova leitura EPC]');
          print('➡ ID: ${bag.id}');
          print('➡ Código: ${bag.printedCode}');
          print('➡ EPC: ${bag.rfidTag}');
          print('➡ Status: ${bag.status}');
          print('➡ Destino: ${bag.destination}');
          print('------------------------------------');

          final index = _bags.indexWhere((b) => b.rfidTag == epc);
          if (index != -1) {
            _bags[index] = bag;
          } else {
            _bags.add(bag);
          }

          notifyListeners();
        },
      );
    } catch (e) {
      GlobalSnackBar.error('Erro ao processar mensagem do WebSocket: $e');
    }
  }

  /// Busca diretamente uma bagagem pelo EPC (via HTTP)
  Future<BagStatusEntity?> _getBagByEpc(String epc) async {
    try {
      final url = Uri.parse('$baseUrl/bags/status/epc/$epc');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return BagStatusEntity.fromJson(data);
      }

      if (response.statusCode == 404) {
        print('⚠️ Bag com EPC $epc não encontrada.');
        return null;
      }

      throw Exception('Erro ${response.statusCode}: ${response.body}');
    } catch (e) {
      GlobalSnackBar.error('Falha ao buscar bag pelo EPC: $e');
      return null;
    }
  }

  /// Carrega todas as bags do usuário e consolida registros duplicados
  Future<void> loadUserBags(String userId) async {
    try {
      print('🔍 [loadUserBags] Carregando bags do usuário: $userId...');

      final Either<BagFailure, List<BagStatusEntity>> result =
          await bagRepository.getBagsStatusById(userId: userId);

      result.fold(
        (failure) {
          GlobalSnackBar.error('Erro ao carregar bags: $failure');
          print('❌ [loadUserBags] Falha: $failure');
        },
        (bagsList) {
          final consolidadas = _consolidarBags(bagsList);

          _bags
            ..clear()
            ..addAll(consolidadas);

          notifyListeners();

          print('✅ [loadUserBags] ${_bags.length} bags consolidadas:');
          for (final bag in _bags) {
            print('🧳 ID: ${bag.id}');
            print('📦 Código: ${bag.printedCode}');
            print('📡 EPC: ${bag.rfidTag}');
            print('🚦 Status: ${bag.status}');
            print('✈️ Destino: ${bag.destination}');
            print('------------------------------------');
          }
        },
      );
    } catch (e, stack) {
      GlobalSnackBar.error('Falha ao carregar bags do usuário: $e');
      print('💥 [loadUserBags] Erro inesperado: $e');
      print(stack);
    }
  }

  /// Consolida bags com mesmo RFID e bag_id
  /// Mantém dados do mais velho e status do mais novo
  List<BagStatusEntity> _consolidarBags(List<BagStatusEntity> bags) {
    final Map<String, List<BagStatusEntity>> grouped = {};

    // 🔹 Agrupa por combinação de rfidTag + bagId
    for (final bag in bags) {
      final key = '${bag.rfidTag}_${bag.bagId}';
      grouped.putIfAbsent(key, () => []);
      grouped[key]!.add(bag);
    }

    final List<BagStatusEntity> consolidadas = [];

    grouped.forEach((key, group) {
      if (group.isEmpty) return;

      // Ordena por createdAt (ascendente)
      group.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      final maisVelho = group.first;
      final maisNovo = group.last;

      // Cria nova bag com base no mais velho, mas com status do mais novo
      final consolidada = maisVelho.copyWith(
        status: maisNovo.status,
        createdAt: maisNovo.createdAt, // registra quando o status foi atualizado
      );

      consolidadas.add(consolidada);

      print('🧩 [Consolidado] RFID=${maisVelho.rfidTag}');
      print('   → Status antigo: ${maisVelho.status}');
      print('   → Status novo: ${maisNovo.status}');
      print('   → Base: ${maisVelho.createdAt}');
      print('   → Último update: ${maisNovo.createdAt}');
      print('------------------------------------');
    });

    return consolidadas;
  }
}
