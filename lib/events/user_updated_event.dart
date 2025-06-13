import '../core/entity/user_entity.dart';

class UserUpdatedEvent {
  final UserEntity user;

  UserUpdatedEvent({
    required this.user,
  });
}
