import 'package:tcc_bag_finder/domain/entity/user_entity.dart';

class UserUpdatedEvent {
  final UserEntity user;

  UserUpdatedEvent({
    required this.user,
  });
}
