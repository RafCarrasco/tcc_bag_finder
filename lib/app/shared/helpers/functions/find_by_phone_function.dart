import 'package:tcc_bag_finder/domain/entity/user_entity.dart';

UserEntity findByPhoneFunction({
  required List<UserEntity> list,
  required String phone,
}) {
  return list.firstWhere(
    (element) => element.phone == phone,
  );
}
