import 'package:flutter/foundation.dart';
import '../../core/entity/trip_entity.dart';
import '../../infra/repositories/collaborator_repository_impl.dart';
import '../../core/entity/tag_entity.dart';

class CollaboratorProvider extends ChangeNotifier {
  final CollaboratorRepositoryImpl repository;

  CollaboratorProvider(this.repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<TripEntity>? _trips;
  List<TripEntity>? get trips => _trips;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getAllTripsByTraveler({
    required String travelerId,
    required String responsibleId,
  }) async {
    _setLoading(true);

    final result = await repository.getTripsByTravelerId(
      travelerId: travelerId,
      responsibleId: responsibleId,
    );

    result.fold(
      (failure) => _trips = [],
      (list) => _trips = list,
    );

    _setLoading(false);
  }

  Future<void> getAllTripsByResponsible({required String responsibleId}) async {
    _setLoading(true);

    final result =
        await repository.getAllTripsByResponsible(responsibleId: responsibleId);

    result.fold(
      (failure) => _trips = [],
      (list) => _trips = list,
    );

    _setLoading(false);
  }

  void orderByAlphabetic({
    required List<TripEntity> list,
    required bool isAscending,
  }) {
    print('arrumar a funcao de order alfabetica colaborador provider');
    // _trips = [...list]..sort((a, b) {
    //     final nameA = a.travelerEntity.fullName.toLowerCase();
    //     final nameB = b.travelerEntity.fullName.toLowerCase();
    //     return isAscending ? nameA.compareTo(nameB) : nameB.compareTo(nameA);
    //   });
    notifyListeners();
  }

  void orderByCreatedTime({
    required List<TripEntity> list,
    required bool isAscending,
  }) {
    _trips = [...list]..sort((a, b) {
        return isAscending ? a.createdAt.compareTo(b.createdAt) : b.createdAt.compareTo(a.createdAt);
      });
    notifyListeners();
  }

  void orderByStatus({
    required List<TripEntity> list,
    required bool isAscending,
  }) {
    _trips = [...list]..sort((a, b) {
        return isAscending
            ? a.isDone.toString().compareTo(b.isDone.toString())
            : b.isDone.toString().compareTo(a.isDone.toString());
      });
    notifyListeners();
  }
  Future<void> getAllTripsByTravelerFullName({
    required String fullName,
  }) async {
    _setLoading(true);
    final result =
        await repository.getAllTripsByTravelerFullName(fullName: fullName);
    result.fold(
      (failure) => _trips = [],
      (list) => _trips = list,
    );
    _setLoading(false);
  }
  
  Future<void> insertTag(TagEntity tag) async {
    try {
      await repository.insertTag(tag);
    } catch (e) {
      debugPrint('Erro ao inserir tag: $e');
    }
  }
}