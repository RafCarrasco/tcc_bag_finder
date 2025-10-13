import 'dart:convert';
import 'package:bag_finder/core/entity/bag_entity.dart';
import 'package:bag_finder/core/entity/bag_status_entity.dart';
import 'package:bag_finder/core/enums/bag_status_enum.dart';
import 'package:bag_finder/core/failures/bag_failure.dart';
import 'package:bag_finder/infra/repositories/bag_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
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
          print('Erro ao buscar bag por EPC: $failure');
        },
        (bag) {

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
      print('Erro ao processar mensagem do WebSocket: $e');
    }
  }

  Future<void> loadUserBags(String userId) async {
    try {

      final Either<BagFailure, List<BagStatusEntity>> result =
          await bagRepository.getBagsStatusById(userId: userId);

      result.fold(
        (failure) {
          print('❌ [loadUserBags] Falha: $failure');
        },
        (bagsList) {
          final consolidadas = _consolidarBags(bagsList);

          _bags
            ..clear()
            ..addAll(consolidadas);

          notifyListeners();
        },
      );
    } catch (e, stack) {
      print('💥 [loadUserBags] Erro inesperado: $e');
    }
  }

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
    });

    return consolidadas;
  }
}