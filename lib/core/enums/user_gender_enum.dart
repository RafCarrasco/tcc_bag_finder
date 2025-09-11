enum UserGenderEnum {
  MALE,
  FEMALE,
  OTHER,
}

extension UserGenderEnumExtension on UserGenderEnum {
  String toLiteral() {
    switch (this) {
      case UserGenderEnum.MALE:
        return 'MALE';
      case UserGenderEnum.FEMALE:
        return 'FEMALE';
      case UserGenderEnum.OTHER:
        return 'OTHER';
    }
  }
}