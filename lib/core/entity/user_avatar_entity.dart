import 'package:flutter/material.dart';

class UserAvatarEntity {
  final int colorValue;
  final String iconName;

  UserAvatarEntity({
    required this.colorValue,
    required this.iconName,
  });

  Color get color => Color(colorValue);

  IconData get icon => _iconDataFromName(iconName);

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

  Map<String, dynamic> toJson() {
    return {
      'colorValue': colorValue,
      'iconName': iconName,
    };
  }

  factory UserAvatarEntity.fromJson(Map<String, dynamic>? json) {
    if (json == null) return UserAvatarEntity.empty();

    return UserAvatarEntity(
      colorValue: json['colorValue'] ?? 0x00000000,
      iconName: json['iconName'] ?? 'person',
    );
  }
}
