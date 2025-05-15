import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'user_avatar_entity.g.dart';

@HiveType(typeId: 8)
class UserAvatarEntity {
  @HiveField(0)
  final int colorValue; 

  @HiveField(1)
  final String iconName; 

  UserAvatarEntity({
    required this.colorValue,
    required this.iconName,
  });

  Color get color => Color(colorValue); 

  IconData get icon =>
      _iconDataFromName(iconName);

  static IconData _iconDataFromName(String iconName) {
    switch (iconName) {
      case 'person':
        return Icons.person;
    
      default:
        return Icons.help; 
    }
  }

  UserAvatarEntity copyWith({
    int? colorValue,
    String? iconName,
  }) {
    return UserAvatarEntity(
      colorValue: colorValue ?? this.colorValue,
      iconName: iconName ?? this.iconName,
    );
  }

  static UserAvatarEntity empty() {
    return UserAvatarEntity(
      colorValue: 0x00000000,
      iconName: 'person',
    );
  }
}
