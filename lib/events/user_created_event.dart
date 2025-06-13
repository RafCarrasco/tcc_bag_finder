import '../core/entity/user_entity.dart';

class UserCreatedEvent {
  final UserEntity user;

  UserCreatedEvent({
    required this.user,
  });
}
