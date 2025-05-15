import 'package:tcc_bag_finder/app/data/adapters/bag_entity_adapter.dart'
    as bag_adapter;
import 'package:tcc_bag_finder/app/data/adapters/traveler_entity_adapter.dart';
import 'package:tcc_bag_finder/app/data/adapters/trip_description_entity_adapter.dart';
import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';

class TripEntityAdapter {
  static TripEntity fromJson(Map<String, dynamic> json) {
    var bags = json['bags'] != null
        ? List<BagEntity>.from(json['bags']
            .map((item) => bag_adapter.BagEntityAdapter.fromJson(item)))
        : null;

    return TripEntity(
      id: json['id'],
      responsibleCollaboratorId: json['responsibleCollaboratorId'],
      travelerEntity: TravelerEntityAdapter.fromJson(json['travelerEntity']),
      description: TripDescriptionEntityAdapter.fromJson(json['description']),
      time: DateTime.parse(json['time']),
      bags: bags,
      isDone: json['isDone'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  static Map<String, dynamic> toJson(TripEntity trip) {
    return {
      'id': trip.id,
      'responsibleCollaboratorId': trip.responsibleCollaboratorId,
      'travelerEntity': TravelerEntityAdapter.toJson(trip.travelerEntity),
      'description': TripDescriptionEntityAdapter.toJson(trip.description),
      'time': trip.time.toIso8601String(),
      'bags': trip.bags
          ?.map((bag) => bag_adapter.BagEntityAdapter.toJson(bag))
          .toList(),
      'isDone': trip.isDone,
      'createdAt': trip.createdAt.toIso8601String(),
      'updatedAt': trip.updatedAt?.toIso8601String(),
    };
  }

  static List<TripEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => fromJson(json)).toList();
  }
}
