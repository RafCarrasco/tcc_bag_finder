import 'dart:async';
import 'dart:convert';
import 'package:bag_finder/core/entity/bag_status_entity.dart';
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

  Timer? _debounce;
  StreamSubscription? _sub;

  RfidBagProvider({
    required this.channel,
    required this.baseUrl,
    required this.bagRepository,
    required this.userId,
  }) {
    _sub = channel.stream.listen(_onMessage, onError: (_) {}, onDone: () {});
  }

  void _onMessage(dynamic message) {
    try {
      final data = jsonDecode(message as String);
      final epc = data['epc'] as String?;
      if (epc == null) return;

      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 250), () {
        loadUserBags(userId);
      });
    } catch (_) {}
  }

  Future<void> loadUserBags(String userId) async {
    try {
      isLoading = true;
      notifyListeners();

      final Either<BagFailure, List<BagStatusEntity>> result =
          await bagRepository.getBagsStatusById(userId: userId);

      result.fold(
        (_) {},
        (bagsList) {
          final consolidadas = _consolidarBags(bagsList);
          _bags
            ..clear()
            ..addAll(consolidadas);
        },
      );
    } catch (_) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadBagsByPrinted(String printed, String userId) async {
    try {
      isLoading = true;
      notifyListeners();

      final Either<BagFailure, List<BagStatusEntity>> result =
          await bagRepository.getBagsStatusByPrinted(printed: printed, userId: userId);

      result.fold(
        (_) {},
        (bagsList) {
          final consolidadas = _consolidarBags(bagsList);
          _bags
            ..clear()
            ..addAll(consolidadas);
        },
      );
    } catch (_) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  List<BagStatusEntity> _consolidarBags(List<BagStatusEntity> bags) {
    final Map<String, List<BagStatusEntity>> grouped = {};
    for (final bag in bags) {
      final key = '${bag.rfidTag}_${bag.bagId}';
      (grouped[key] ??= []).add(bag);
    }
    final List<BagStatusEntity> consolidadas = [];
    grouped.forEach((_, group) {
      if (group.isEmpty) return;
      group.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      final maisVelho = group.first;
      final maisNovo = group.last;
      consolidadas.add(
        maisVelho.copyWith(status: maisNovo.status, createdAt: maisNovo.createdAt),
      );
    });
    return consolidadas;
  }

  Future<void> confirmBagCollection(String bagId) async {
    try {
      isLoading = true;
      notifyListeners();
      await bagRepository.updateBag(bag: bagId);
      await bagRepository.deleteBagStatusByBagId(epc: bagId);
      _bags.removeWhere((bag) => bag.bagId == bagId);
    } catch (_) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  
  Future<String?> getBagsIdByEpc(String epc, String userId) async {
    try {
      final result = await bagRepository.getBagIdByEpcAndUser(epc: epc, userId: userId);

      return result.fold(
        (failure) {
          print('Erro ao buscar Bag ID: ${failure.toString()}');
          return null;
        },
        (bagId) => bagId, // bagId pode ser String? (null se não achou)
      );
    } catch (e) {
      print('Erro inesperado ao tentar buscar mala por EPC e userId: $e');
      return null;
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _sub?.cancel();
    channel.sink.close();
    super.dispose();
  }
}
