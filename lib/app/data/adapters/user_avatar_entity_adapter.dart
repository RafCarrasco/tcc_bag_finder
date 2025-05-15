import 'package:tcc_bag_finder/domain/entity/user_avatar_entity.dart';

class UserAvatarEntityAdapter {
  static UserAvatarEntity fromJson(Map<String, dynamic> json) {
    return UserAvatarEntity(
      colorValue: json['colorValue'],
      iconName: json['iconName'],
    );
  }

  static Map<String, dynamic> toJson(UserAvatarEntity avatar) {
    return {
      'colorValue': avatar.colorValue,
      'iconName': avatar.iconName,
    };
  }
}
