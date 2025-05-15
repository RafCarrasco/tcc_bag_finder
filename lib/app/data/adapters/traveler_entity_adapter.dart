import 'package:tcc_bag_finder/domain/entity/traveler_entity.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/entity/user_entity.dart';

import 'user_entity_adapter.dart' as user_adapter;
import 'package:tcc_bag_finder/app/data/adapters/trip_entity_adapter.dart'
    as trip_adapter;


class TravelerEntityAdapter {
  static TravelerEntity fromJson(
    Map<String, dynamic> json,
  ) {
    UserEntity baseUser = user_adapter.UserEntityAdapter.fromJson(
      json,
    );

    List<TripEntity>? bags = json['bags'] != null
        ? List<TripEntity>.from(
            json['bags'].map(
              (item) => trip_adapter.TripEntityAdapter.fromJson(
                item,
              ),
            ),
          )
        : <TripEntity>[];

    return TravelerEntity(
      id: baseUser.id,
      email: baseUser.email,
      password: baseUser.password,
      fullName: baseUser.fullName,
      phone: baseUser.phone,
      avatar: baseUser.avatar,
      role: baseUser.role,
      createdAt: baseUser.createdAt,
      updatedAt: baseUser.updatedAt,
      bags: bags,
    );
  }

  static Map<String, dynamic> toJson(TravelerEntity traveler) {
    Map<String, dynamic> json = user_adapter.UserEntityAdapter.toJson(
      traveler,
    );

    json['bags'] = traveler.bags
        .map(
          (bag) => trip_adapter.TripEntityAdapter.toJson(
            bag,
          ),
        )
        .toList();

    return json;
  }
}
