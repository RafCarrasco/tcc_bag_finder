import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';
import 'package:tcc_bag_finder/domain/enums/bag_status_enum.dart';

abstract class IBagLocalDatasource {
  Future<List<BagEntity>> getBags();

  Future<void> updateBag({
    required int index,
    required BagEntity bag,
  });

  Future<void> deleteBag({
    required int index,
  });

  Future<void> addBag({
    required BagEntity bag,
  });

  Future<BagEntity?> findBagById({
    required String bagId,
  });

  Future<BagEntity?> findBagByUserId({
    required String bagId,
  });

  Future<BagEntity?> findBagByStatus({
    required BagStatusEnum status,
  });

  Future<List<BagEntity>> getUserActiveBagsById({
    required String userId,
    required String bagId,
  });

  Future<int> findBagIndexById({
    required String bagId,
  });

  Future<void> clearBags();

  Future<void> close();

  Future<void> saveBags(
    List<BagEntity> bags,
  );
}
