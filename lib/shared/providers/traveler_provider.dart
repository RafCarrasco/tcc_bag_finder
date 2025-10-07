import 'package:flutter/foundation.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/entity/bag_entity.dart';
import '../../core/entity/traveler_entity.dart';
import '../../repositories/trip_repository.dart';
import '../../infra/repositories/traveler_repository_impl.dart';
import '../../core/failures/traveler_failure.dart';
import '../../features/auth/controller/auth_controller.dart';

class TravelerProvider extends ChangeNotifier {
  final TravelerRepositoryImpl repository;
  final AuthService authService;
  final ITripRepository tripRepository;

  TravelerProvider(this.repository, this.authService,this.tripRepository);

  TripEntity? _currentTrip;
  List<BagEntity>? _bags;
  List<TripEntity>? _trips;
  bool _isLoading = false;

  bool _isTripComplete = false;
  int _checkedBags = 0;

  TripEntity? get currentTrip => _currentTrip;
  List<BagEntity>? get bags => _bags;
  List<TripEntity>? get trips => _trips;
  bool get isLoading => _isLoading;

  bool get isTripComplete => _isTripComplete;
  int get checkedBags => _checkedBags;
  List<TravelerEntity> _travelers = [];
  List<TravelerEntity> get travelers => _travelers;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getTripsByStatus({
    required String travelerId,
    required bool isDone,
  }) async {
    _setLoading(true);

    final result = await tripRepository.getTripsByStatusAndId(
      travelerId: travelerId,
      isDone: isDone,
    );
    result.fold(
      (failure) {
        _currentTrip = null;
        _bags = [];
        _trips = [];
      },
      (trips) {
        _trips = trips;
        if (trips.isNotEmpty) {
          _currentTrip = trips.first;
          _bags = _currentTrip?.bags ?? [];
        } else {
          _currentTrip = null;
          _bags = [];
        }
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

    final result = await repository.getAllTravelers(
    );

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

  Future<void> addCpf(String cpf) async {
    _setLoading(true);
    final result = await repository.insertTravelerCpfIfNotExists(cpf: cpf);

    result.fold(
      (failure) {
        if (failure is TravelerReadError) {
          debugPrint('Erro ao inserir CPF: ${failure.errorMessage}');
        } else {
          debugPrint('Erro desconhecido ao inserir CPF: $failure');
        }
      },
      (response) {
        if (response['created'] == true) {
          debugPrint('CPF cadastrado com sucesso: ${response['cpf']}');
        } else {
          debugPrint('CPF já existia, sem alterações: ${response['cpf']}');
        }
      },
    );

    _setLoading(false);
  }

}
