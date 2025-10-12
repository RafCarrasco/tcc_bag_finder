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
    channel.stream.listen(_onMessage);
  }

  void _onMessage(dynamic message) async {
    try {
      final data = jsonDecode(message);
      final epc = data['epc'] as String?;
      if (epc == null) return;

      final bag = await _getBagByEpc(epc);
      print('🧳 ID: ${bag!.id}');
      print('📦 Código: ${bag.printedCode}');
      print('📡 EPC: ${bag.rfidTag}');
      print('🚦 Status: ${bag.status}');
      print('✈️ Destino: ${bag.destination}');
      print('------------------------------------');
      if (bag != null) {
        final index = _bags.indexWhere((b) => b.rfidTag == epc);
        if (index != -1) {
          _bags[index] = bag;
        } else {
          _bags.add(bag);
        }
        notifyListeners();
      }
      print(_bags);
    } catch (e) {
      GlobalSnackBar.error('Erro ao processar mensagem do WebSocket: $e');
    }
  }

  Future<BagStatusEntity?> _getBagByEpc(String epc) async {
    try {
      final url = Uri.parse('$baseUrl/bags/status/epc/$epc');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return BagStatusEntity.fromJson(data);
      }

      if (response.statusCode == 404) {
        print('Bag com EPC $epc não encontrada.');
        return null;
      }

      throw Exception('Erro ${response.statusCode}: ${response.body}');
    } catch (e) {
      GlobalSnackBar.error('Falha ao buscar bag pelo EPC: $e');
      return null;
    }
  }

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
          _bags
            ..clear()
            ..addAll(bagsList);
          notifyListeners();

          print('✅ [loadUserBags] ${_bags.length} bags carregadas:');
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
}
