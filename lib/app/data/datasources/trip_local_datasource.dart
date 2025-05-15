import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';

abstract class ITripLocalDatasource {
  Future<List<TripEntity>> getTrips();

  Future<void> updateTrip({
    required int index,
    required TripEntity trip,
  });

  Future<void> deleteTrip({
    required int index,
  });

  Future<void> addTrip({
    required TripEntity trip,
  });

  Future<TripEntity?> findTripById({
    required String tripId,
  });

  Future<int> findTripIndexById({
    required String tripId,
  });

  Future<void> clearTrips();

  Future<void> close();

  Future<List<TripEntity>> getAllTripsByResponsibleId({
    required String responsibleCollaboratorId,
  });

  Future<List<TripEntity>> getAllTripsByTraveler({
    required String travelerId,
  });

  Future<List<TripEntity>> getTripsByStatusAndId({
    required String travelerId,
    required bool? isDone,
  });
}
