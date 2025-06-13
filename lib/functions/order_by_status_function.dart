import '../core/entity/bag_entity.dart';
import '../core/entity/collaborator_entity.dart';
import '../core/entity/trip_entity.dart';
import '../core/enums/bag_status_enum.dart';

List<CollaboratorEntity> orderByStatusFunction({
  required List<CollaboratorEntity> list,
  bool isAscending = true,
}) {
  if (isAscending) {
    list.sort(
      (a, b) => a.isActive.toString().compareTo(
            b.isActive.toString(),
          ),
    );

    return list;
  }

  list.sort(
    (a, b) => b.isActive.toString().compareTo(
          a.isActive.toString(),
        ),
  );

  return list;
}

List<TripEntity> orderTripsByStatusFunction({
  required List<TripEntity> list,
  bool isAscending = true,
}) {
  if (isAscending) {
    list.sort(
      (a, b) => a.isDone.toString().compareTo(
            b.isDone.toString(),
          ),
    );

    return list;
  }

  list.sort(
    (a, b) => b.isDone.toString().compareTo(
          a.isDone.toString(),
        ),
  );

  return list;
}

List<BagEntity> orderBagsByStatusFunction({
  required List<BagEntity> list,
  bool isAscending = true,
}) {
  const statusPriority = {
    BagStatusEnum.CLAIMED: 0,
    BagStatusEnum.READY_FOR_PICKUP: 1,
    BagStatusEnum.ARRIVED: 2,
    BagStatusEnum.IN_TRANSIT: 3,
    BagStatusEnum.CHECKED_IN: 4,
    BagStatusEnum.LOST: 5,
    BagStatusEnum.UNKNOWN: 6,
  };

  if (isAscending) {
    list.sort(
      (a, b) {
        final priorityA = statusPriority[a.status] ?? 999;
        final priorityB = statusPriority[b.status] ?? 999;

        return isAscending
            ? priorityA.compareTo(priorityB)
            : priorityB.compareTo(priorityA);
      },
    );

    return list;
  }

  list.sort(
    (a, b) {
      final priorityA = statusPriority[a.status] ?? 999;
      final priorityB = statusPriority[b.status] ?? 999;

      return isAscending
          ? priorityB.compareTo(priorityA)
          : priorityA.compareTo(priorityB);
    },
  );

  return list;
}
