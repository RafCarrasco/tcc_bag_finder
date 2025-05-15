import 'package:tcc_bag_finder/app/data/datasources/hive_box_manager.dart';
import 'package:tcc_bag_finder/app/data/datasources/trip_local_datasource.dart';
import 'package:tcc_bag_finder/app/shared/themes/functions/global_snackbar.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/failures/failure.dart';
import 'package:hive/hive.dart';
import 'package:tcc_bag_finder/app/data/adapters/trip_entity_adapter.dart'
    as trip_adapter;

class TripHiveLocalDatasource implements ITripLocalDatasource {
  Future<Box<TripEntity>> get storage async =>
      await HiveBoxManager.getBox<TripEntity>('bag_box');

  @override
  Future<void> addTrip({
    required TripEntity trip,
  }) async {
    var box = await storage;

    try {
      await box.add(
        trip,
      );
    } catch (e) {
      GlobalSnackBar.error(
        ServerStorageFailure().errorMessage,
      );
    }
  }

  @override
  Future<void> updateTrip({
    required int index,
    required TripEntity trip,
  }) async {
    var box = await storage;

    try {
      await box.putAt(
        index,
        trip,
      );
    } catch (e) {
      GlobalSnackBar.error(
        ServerStorageFailure().errorMessage,
      );
    }
  }

  @override
  Future<void> clearTrips() async {
    var box = await storage;
    await box.clear();
  }

  @override
  Future<void> close() async {
    var box = await storage;
    await box.close();
  }

  @override
  Future<void> deleteTrip({required int index}) async {
    var box = await storage;

    try {
      await box.deleteAt(
        index,
      );
    } catch (e) {
      GlobalSnackBar.error(
        ServerStorageFailure().errorMessage,
      );
    }
  }

  @override
  Future<TripEntity?> findTripById({
    required String tripId,
  }) async {
    var box = await storage;
    TripEntity? result;

    var trips = box.values.toList();

    for (var trip in trips) {
      if (trip.id == tripId) {
        result = trip;
        break;
      }
    }

    return result;
  }

  @override
  Future<int> findTripIndexById({
    required String tripId,
  }) async {
    List<TripEntity> users = await getTrips();
    int index = users.indexWhere(
      (element) => element.id == tripId,
    );

    return index;
  }

  @override
  Future<List<TripEntity>> getAllTripsByResponsibleId({
    required String responsibleCollaboratorId,
  }) async {
    List<TripEntity> users = await getTrips();
    List<TripEntity> result = users
        .where(
          (element) =>
              element.responsibleCollaboratorId == responsibleCollaboratorId,
        )
        .toList();

    return result;
  }

  @override
  Future<List<TripEntity>> getAllTripsByTraveler({
    required String travelerId,
  }) async {
    List<TripEntity> users = await getTrips();
    List<TripEntity> result = users
        .where(
          (element) => element.travelerEntity.id == travelerId,
        )
        .toList();

    return result;
  }

  @override
  Future<List<TripEntity>> getTrips() async {
    var box = await storage;

    return trip_adapter.TripEntityAdapter.fromJsonList(box.values.toList());
  }

  @override
  Future<List<TripEntity>> getTripsByStatusAndId({
    required String travelerId,
    required bool? isDone,
  }) async {
    List<TripEntity> users = await getTrips();
    List<TripEntity> result = users
        .where(
          (element) =>
              element.travelerEntity.id == travelerId &&
              element.isDone == isDone,
        )
        .toList();

    return result;
  }
}
