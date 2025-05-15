import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/entity/user_entity.dart';

List<UserEntity> orderByCreatedTimeFunction({
  required List<UserEntity> list,
  bool isAscending = true,
}) {
  if (isAscending) {
    list.sort(
      (a, b) => a.createdAt.compareTo(
        b.createdAt,
      ),
    );
    return list;
  }

  list.sort(
    (a, b) => b.createdAt.compareTo(
      a.createdAt,
    ),
  );

  return list;
}

List<BagEntity> orderBagsByUpdatedTimeFunction({
  required List<BagEntity> list,
  bool isAscending = true,
}) {
  list.sort((a, b) {
    if (a.updatedAt == null && b.updatedAt == null) return 0;
    if (a.updatedAt == null) return 1;
    if (b.updatedAt == null) return -1;

    return isAscending
        ? a.updatedAt!.compareTo(
            b.updatedAt!,
          )
        : b.updatedAt!.compareTo(
            a.updatedAt!,
          );
  });

  return list;
}

List<TripEntity> orderTripsByUpdatedTimeFunction({
  required List<TripEntity> list,
  bool isAscending = true,
}) {
  list.sort((a, b) {
    if (a.updatedAt == null && b.updatedAt == null) return 0;
    if (a.updatedAt == null) return 1;
    if (b.updatedAt == null) return -1;

    return isAscending
        ? a.updatedAt!.compareTo(
            b.updatedAt!,
          )
        : b.updatedAt!.compareTo(
            a.updatedAt!,
          );
  });

  return list;
}

List<TripEntity> orderTripsByCreatedTimeFunction({
  required List<TripEntity> list,
  bool isAscending = true,
}) {
  if (isAscending) {
    list.sort(
      (a, b) => a.createdAt.compareTo(
        b.createdAt,
      ),
    );
    return list;
  }

  list.sort(
    (a, b) => b.createdAt.compareTo(
      a.createdAt,
    ),
  );

  return list;
}
