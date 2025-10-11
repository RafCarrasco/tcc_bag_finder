import '../../core/entity/bag_entity.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/entity/user_entity.dart';

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
  print('erro no order_by_created_time_tunction');
  // list.sort((a, b) {
  //   if (a.updatedAt == null && b.updatedAt == null) return 0;
  //   if (a.updatedAt == null) return 1;
  //   if (b.updatedAt == null) return -1;

  //   return isAscending
  //       ? a.updatedAt!.compareTo(
  //           b.updatedAt!,
  //         )
  //       : b.updatedAt!.compareTo(
  //           a.updatedAt!,
  //         );
  // });

  return list;
}

<<<<<<< HEAD
// List<TripEntity> orderTripsByUpdatedTimeFunction({
//   required List<TripEntity> list,
//   bool isAscending = true,
// }) {
//   list.sort((a, b) {
//     if (a.updatedAt == null && b.updatedAt == null) return 0;
//     if (a.updatedAt == null) return 1;
//     if (b.updatedAt == null) return -1;

//     return isAscending
//         ? a.updatedAt!.compareTo(
//             b.updatedAt!,
//           )
//         : b.updatedAt!.compareTo(
//             a.updatedAt!,
//           );
//   });
=======
List<TripEntity> orderTripsByUpdatedTimeFunction({
  required List<TripEntity> list,
  bool isAscending = true,
}) {
  list.sort((a, b) {
    if (a.createdAt == null && b.createdAt == null) return 0;
    if (a.createdAt == null) return 1;
    if (b.createdAt == null) return -1;

    return isAscending
        ? a.createdAt!.compareTo(
            b.createdAt!,
          )
        : b.createdAt!.compareTo(
            a.createdAt!,
          );
  });
>>>>>>> b04f833112c61e0543a3408d3291b0d7d7a61cc8

//   return list;
// }

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
