import 'dart:convert';
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
  final String userId;

  final List<BagStatusEntity> _bags = [];
  List<BagStatusEntity> get bags => List.unmodifiable(_bags);
  bool isLoading = false;

  RfidBagProvider({
    required this.channel,
    required this.baseUrl,
    required this.bagRepository,
    required this.userId
  }) {
    channel.stream.listen(_onMessage);
  }

  void _onMessage(dynamic message) async {
    try {
      final data = jsonDecode(message);
      final epc = data['epc'] as String?;
      if (epc == null) return;

      await loadUserBags(userId);
    } catch (e) {
      print('Erro ao processar mensagem do WebSocket: $e');
    }
  }

  Future<void> loadUserBags(String userId) async {
    try {
      // use o CAMPO do provider, não crie variável local
      isLoading = true;
      notifyListeners();

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
        },
      );
    } catch (e) {
      print('💥 [loadUserBags] Erro inesperado: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // sempre notifica, sucesso ou erro
    }
  }


  Future<void> loadBagsByPrinted(String printed,String userId) async {
    try {
      isLoading = true;
      final Either<BagFailure, List<BagStatusEntity>> result =
          await bagRepository.getBagsStatusByPrinted(printed: printed,userId:userId);

      result.fold(
        (failure) {
          print('❌ [loadUserBags] Falha: $failure');
        },
        (bagsList) {
          final consolidadas = _consolidarBags(bagsList);

          _bags
            ..clear()
            ..addAll(consolidadas);
          isLoading = false;
          notifyListeners();
        },
      );
    } catch (e, stack) {
      print('💥 [loadUserBags] Erro inesperado: $e');
    }
  }

  List<BagStatusEntity> _consolidarBags(List<BagStatusEntity> bags) {
    final Map<String, List<BagStatusEntity>> grouped = {};

    for (final bag in bags) {
      final key = '${bag.rfidTag}_${bag.bagId}';
      grouped.putIfAbsent(key, () => []);
      grouped[key]!.add(bag);
    }

    final List<BagStatusEntity> consolidadas = [];

    grouped.forEach((key, group) {
      if (group.isEmpty) return;

      group.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      final maisVelho = group.first;
      final maisNovo = group.last;

      final consolidada = maisVelho.copyWith(
        status: maisNovo.status,
        createdAt: maisNovo.createdAt,
      );

      consolidadas.add(consolidada);
    });

    return consolidadas;
  }

  Future<void> confirmBagCollection(String bagId) async {
    try {
      isLoading = true;
      await bagRepository.updateBag(bag: bagId);
      await bagRepository.deleteBagStatusByBagId(epc :bagId);
      _bags.removeWhere((bag) => bag.bagId == bagId);
    } catch (e) {
      print('Erro ao confirmar coleta: $e');
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}