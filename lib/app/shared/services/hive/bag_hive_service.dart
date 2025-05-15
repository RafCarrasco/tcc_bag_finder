import 'package:tcc_bag_finder/app/data/datasources/bag_local_datasource.dart';
import 'package:tcc_bag_finder/app/data/datasources/hive_box_manager.dart';
import 'package:tcc_bag_finder/app/shared/themes/functions/global_snackbar.dart';
import 'package:tcc_bag_finder/domain/enums/bag_status_enum.dart';
import 'package:tcc_bag_finder/domain/failures/failure.dart';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';

class BagHiveLocalDatasource implements IBagLocalDatasource {
  Future<Box<BagEntity>> get storage async =>
      await HiveBoxManager.getBox<BagEntity>('bag_box');

  @override
  Future<void> addBag({required BagEntity bag}) async {
    var box = await storage;

    try {
      await box.add(bag);
    } catch (e) {
      GlobalSnackBar.error(
        ServerStorageFailure().errorMessage,
      );
    }
  }

  @override
  Future<void> updateBag({required int index, required BagEntity bag}) async {
    var box = await storage;

    try {
      await box.putAt(
        index,
        bag,
      );
    } catch (e) {
      GlobalSnackBar.error(
        ServerStorageFailure().errorMessage,
      );
    }
  }

  @override
  Future<void> deleteBag({required int index}) async {
    var box = await storage;

    try {
      await box.deleteAt(index);
    } catch (e) {
      GlobalSnackBar.error(
        ServerStorageFailure().errorMessage,
      );
    }
  }

  @override
  Future<BagEntity?> findBagById({required String bagId}) async {
    var box = await storage;

    BagEntity? result;

    var bags = box.values.toList();

    for (var bag in bags) {
      if (bag.id == bagId) {
        result = bag;
        break;
      }
    }

    return result;
  }

  @override
  Future<int> findBagIndexById({required String bagId}) async {
    List<BagEntity> bags = await getBags();
    int index = bags.indexWhere((element) => element.id == bagId);

    return index;
  }

  @override
  Future<void> clearBags() async {
    var box = await storage;
    await box.clear();
  }

  @override
  Future<void> close() async {
    var box = await storage;
    await box.close();
  }

  @override
  Future<BagEntity?> findBagByStatus({
    required BagStatusEnum status,
  }) async {
    List<BagEntity> bags = await getBags();

    BagEntity? bag = bags.firstWhereOrNull(
      (element) => element.status == status,
    );

    return bag;
  }

  @override
  Future<BagEntity?> findBagByUserId({
    required String bagId,
  }) async {
    List<BagEntity> bags = await getBags();

    BagEntity? bag = bags.firstWhereOrNull(
      (element) => element.id == bagId,
    );

    return bag;
  }

  @override
  Future<List<BagEntity>> getBags() async {
    var box = await storage;

    return box.values.toList().cast<BagEntity>();
  }

  @override
  Future<void> saveBags(List<BagEntity> bags) async {}

  @override
  Future<List<BagEntity>> getUserActiveBagsById({
    required String userId,
    required String bagId,
  }) async {
    List<BagEntity> bags = await getBags();

    List<BagEntity> filteredBags = bags
        .where(
          (e) =>
              e.ownerId == userId &&
              e.id.toLowerCase().contains(bagId.toLowerCase()) &&
              e.status != BagStatusEnum.CLAIMED,
        )
        .toList();

    return filteredBags;
  }
}
