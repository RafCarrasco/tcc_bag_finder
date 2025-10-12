import 'dart:async';
import 'package:bag_finder/core/enums/bag_status_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/entity/bag_status_entity.dart';
import '../../core/entity/bag_entity.dart';
import '../../core/entity/traveler_entity.dart';
import '../../core/entity/trip_history_entity.dart';
import '../../repositories/trip_repository.dart';
import '../../infra/repositories/traveler_repository_impl.dart';
import '../../infra/repositories/bag_repository_impl.dart';
import '../../core/failures/traveler_failure.dart';
import '../../features/auth/controller/auth_controller.dart';
import '../../usecase/bag/get_user_bags_usecase.dart';

class TravelerProvider extends ChangeNotifier {
  final TravelerRepositoryImpl repository;
  final BagRepositoryImpl bagRepository;
  final AuthService authService;
  final ITripRepository tripRepository;
  final IGetUserBagsUsecase getUserBagsUsecase;

  TravelerProvider(
    this.repository,
    this.authService,
    this.tripRepository,
    this.bagRepository,
    this.getUserBagsUsecase,
  );

  TripEntity? _currentTrip;
  List<BagEntity>? _bags;
  List<TripEntity>? _trips;
  bool _isLoading = false;
  List<TripHistoryEntity> _history = [];
  bool _isTripComplete = false;
  int _checkedBags = 0;
  List<BagStatusEntity> _bagStatus = [];
  
  List<BagStatusEntity> get bagStatus => _bagStatus;
  TripEntity? get currentTrip => _currentTrip;
  List<BagEntity>? get bags => _bags;
  List<TripEntity>? get trips => _trips;
  bool get isLoading => _isLoading;
  List<TripHistoryEntity> get history => _history;
  bool get isTripComplete => _isTripComplete;
  int get checkedBags => _checkedBags;
  List<TravelerEntity> _travelers = [];
  List<TravelerEntity> get travelers => _travelers;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getTravelerHistory(String travelerId) async {
    _setLoading(true);
    final result =
        await tripRepository.getTravelerHistory(travelerId: travelerId);

    result.fold(
      (failure) {
        _history = [];
      },
      (history) {
        _history = history;
      },
    );
    _setLoading(false);
  }

  Future<void> checkIsTripDone({required TripEntity trip}) async {
    // final result = await repository.isTripDone(tripId: trip.id);
    // result.fold(
    //   (_) => _isTripComplete = false,
    //   (isDone) => _isTripComplete = isDone,
    // );
    // notifyListeners();
  }

  void updateCheckedBags(int value) {
    _checkedBags = value;
    notifyListeners();
  }

  void checkTripCompletion() {
    if (_bags != null && _checkedBags >= _bags!.length) {
      _isTripComplete = true;
    }
    notifyListeners();
  }

  Future<void> getAllTravelers() async {
    if (!authService.isLoggedIn) {
      debugPrint("Nenhum usuário logado, não é possível buscar travelers");
      return;
    }

    final currentUser = authService.user;
    debugPrint("Usuário logado: ${currentUser?.fullName}");

    final result = await repository.getAllTravelers();

    result.fold(
      (failure) {
        if (failure is TravelerReadError) {
          debugPrint(failure.errorMessage);
        }
      },
      (travs) {
        _travelers = travs;
        notifyListeners();
      },
    );
  }

  Future<TravelerEntity?> getTravelerById(String id) async {
    _setLoading(true);

    final result = await repository.getTravelerById(id: id);

    TravelerEntity? traveler;

    result.fold(
      (failure) {
        if (failure is TravelerReadError) {
          debugPrint('Erro ao buscar traveler: ${failure.errorMessage}');
        } else {
          debugPrint('Erro desconhecido ao buscar traveler: $failure');
        }
      },
      (trav) {
        traveler = trav;
      },
    );

    _setLoading(false);
    return traveler;
  }

  Future<void> getBagsByTripId(String tripId) async {
    _setLoading(true);
    try {
      final result = await bagRepository.getBagsByTripId(tripId: tripId);

      result.fold(
        (failure) {
          debugPrint('Erro ao buscar malas da viagem $tripId: $failure');
          _bags = [];
        },
        (bags) {
          _bags = bags;
        },
      );
    } catch (e) {
      debugPrint('Exceção em getBagsByTripId: $e');
      _bags = [];
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getBagsByUserId(String userId) async {
    _setLoading(true);
    debugPrint('🎒 Buscando malas do usuário: $userId');

    try {
      final result = await getUserBagsUsecase(userId: userId);

      result.fold(
        (failure) {
          debugPrint('❌ Erro ao buscar malas do usuário $userId: $failure');
          _bags = [];
        },
        (bagsList) {
          debugPrint(
              '✅ ${bagsList.length} malas encontradas para o usuário $userId');
          _bags = bagsList;
        },
      );
    } catch (e, st) {
      debugPrint('🚨 Exceção em getBagsByUserId: $e');
      debugPrint(st.toString());
      _bags = [];
    } finally {
      _setLoading(false);
    }

    notifyListeners();
  }

  Future<bool> validateTravelerEmailAndCPF(String email, String cpf) async {
    final result = await repository.getAllTravelers();
    bool isValid = false;

    result.fold(
      (failure) {
        debugPrint("Erro ao buscar viajantes: $failure");
      },
      (travelers) {
        isValid = travelers.any(
          (traveler) =>
              traveler.email != null &&
              traveler.cpf != null &&
              traveler.email.toLowerCase() == email.toLowerCase() &&
              traveler.cpf!.replaceAll(RegExp(r'\D'), '') ==
                  cpf.replaceAll(RegExp(r'\D'), ''),
        );
      },
    );

    return isValid;
  }

  Future<void> deleteBagStatusByBagId(String bagId) async {
    try {
      await bagRepository.deleteBagStatusByBagId(epc: bagId);
    } catch (e) {
      print('Erro ao deletar status da bag: $e');
    }
  }

  Future<void> updateBag(String bagId) async {
    try {
      await bagRepository.updateBag(bag: bagId);
    } catch (e) {
      print('Erro ao deletar status da bag: $e');
    }
  }
}
