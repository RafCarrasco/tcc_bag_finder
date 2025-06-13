enum UserRoleEnum {
  COLLABORATOR,
  ADMIN,
  TRAVELER,
  OTHER
}

extension UserRoleEnumExtension on UserRoleEnum {
  String toLiteral() {
    switch (this) {
      case UserRoleEnum.ADMIN:
        return 'ADMIN';
      case UserRoleEnum.COLLABORATOR:
        return 'COLLABORATOR';
      case UserRoleEnum.TRAVELER:
        return 'TRAVELER';
      case UserRoleEnum.OTHER:
        return 'OTHER';
    }
  }
}