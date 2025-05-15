import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/entity/user_entity.dart';

List<UserEntity> orderAlphabeticFunction({
  required List<UserEntity> list,
  bool isAscending = true,
}) {
  if (isAscending) {
    list.sort(
      (a, b) => a.fullName.compareTo(
        b.fullName,
      ),
    );

    return list;
  }

  list.sort(
    (a, b) => b.fullName.compareTo(
      a.fullName,
    ),
  );

  return list;
}

List<TripEntity> orderTripsAlphabeticFunction({
  required List<TripEntity> list,
  bool isAscending = true,
}) {
  if (isAscending) {
    list.sort(
      (a, b) => a.travelerEntity.fullName.compareTo(
        b.travelerEntity.fullName,
      ),
    );

    return list;
  }

  list.sort(
    (a, b) => b.travelerEntity.fullName.compareTo(
      a.travelerEntity.fullName,
    ),
  );

  return list;
}

List<BagEntity> orderBagsAlphabeticFunction({
  required List<BagEntity> list,
  bool isAscending = true,
}) {
  list.sort((a, b) {
    final isADescriptionNull = a.description == null;
    final isBDescriptionNull = b.description == null;

    if (isADescriptionNull && !isBDescriptionNull) return 1;
    if (!isADescriptionNull && isBDescriptionNull) return -1;
    if (isADescriptionNull && isBDescriptionNull) return 0;

    return isAscending
        ? a.description!.compareTo(b.description!)
        : b.description!.compareTo(a.description!);
  });

  return list;
}
