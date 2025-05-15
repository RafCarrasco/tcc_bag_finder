import 'package:tcc_bag_finder/app/data/datasources/bag_local_datasource.dart';
import 'package:tcc_bag_finder/app/data/datasources/collaborator_local_datasource.dart';
import 'package:tcc_bag_finder/app/data/datasources/trip_local_datasource.dart';
import 'package:tcc_bag_finder/app/data/datasources/user_local_datasource.dart';
import 'package:tcc_bag_finder/app/data/mock/db/database_mock.dart';
import 'package:tcc_bag_finder/app/data/repositories/bag_repository_mock.dart';
import 'package:tcc_bag_finder/app/data/repositories/collaborator_repository_mock.dart';
import 'package:tcc_bag_finder/app/data/repositories/traveler_repository_mock.dart';
import 'package:tcc_bag_finder/app/data/repositories/trip_repository_mock.dart';
import 'package:tcc_bag_finder/app/data/repositories/user_repository_mock.dart';
import 'package:tcc_bag_finder/app/shared/services/hive/bag_hive_service.dart';
import 'package:tcc_bag_finder/app/shared/services/hive/collaborator_hive_service.dart';
import 'package:tcc_bag_finder/app/shared/services/hive/trip_hive_service.dart';
import 'package:tcc_bag_finder/app/shared/services/hive/user_hive_service.dart';
import 'package:tcc_bag_finder/domain/repositories/bag_repository.dart';
import 'package:tcc_bag_finder/domain/repositories/collaborator_repository.dart';
import 'package:tcc_bag_finder/domain/repositories/traveler_repository.dart';
import 'package:tcc_bag_finder/domain/repositories/trip_repository.dart';
import 'package:tcc_bag_finder/domain/repositories/user_repository.dart';
import 'package:tcc_bag_finder/env/env_enum.dart';

class EnvironmentConfig {
  // ignore: constant_identifier_names
  static const MSS_BASE_URL = String.fromEnvironment(
    'MSS_BASE_URL',
  );

  // ignore: constant_identifier_names
  static const ENV = String.fromEnvironment(
    'ENV',
  );

  static final MockDatabase _mockDatabase = MockDatabase();

  static IBagRepository getBagRepository() {
    EnvironmentEnum value = EnvironmentEnum.values.firstWhere(
      (element) {
        return element.name.toUpperCase() == ENV.toUpperCase();
      },
      orElse: () => EnvironmentEnum.LOCAL,
    );
    if (value == EnvironmentEnum.LOCAL) {
      return BagRepositoryMock(
        _mockDatabase,
      );
    } else {
      return BagRepositoryMock(
        _mockDatabase,
      );
    }
  }

  static IUserLocalDatasource getUserLocalDatasource() =>
      UserHiveLocalDatasource();

  static IBagLocalDatasource getBagLocalDatasource() =>
      BagHiveLocalDatasource();

  static ITripLocalDatasource getTripLocalDatasource() =>
      TripHiveLocalDatasource();

  static ICollaboratorLocalDatasource getCollaboratorLocalDatasource() =>
      CollaboratorHiveLocalDatasource();

  static ITripRepository getTripRepository() {
    EnvironmentEnum value = EnvironmentEnum.values.firstWhere(
      (element) {
        return element.name.toUpperCase() == ENV.toUpperCase();
      },
      orElse: () => EnvironmentEnum.LOCAL,
    );
    if (value == EnvironmentEnum.LOCAL) {
      return TripRepositoryMock(
        _mockDatabase,
      );
    } else {
      return TripRepositoryMock(
        _mockDatabase,
      );
    }
  }

  static ITravelerRepository getTravelerRepository() {
    EnvironmentEnum value = EnvironmentEnum.values.firstWhere(
      (element) {
        return element.name.toUpperCase() == ENV.toUpperCase();
      },
      orElse: () => EnvironmentEnum.LOCAL,
    );
    if (value == EnvironmentEnum.LOCAL) {
      return TravelerRepositoryMock(
        _mockDatabase,
      );
    } else {
      return TravelerRepositoryMock(
        _mockDatabase,
      );
    }
  }

  static IUserRepository getUserRepository() {
    EnvironmentEnum value = EnvironmentEnum.values.firstWhere(
      (element) {
        return element.name.toUpperCase() == ENV.toUpperCase();
      },
      orElse: () => EnvironmentEnum.LOCAL,
    );
    if (value == EnvironmentEnum.LOCAL) {
      return UserRepositoryMock(
        _mockDatabase,
      );
    } else {
      return UserRepositoryMock(
        _mockDatabase,
      );
    }
  }

  static ICollaboratorRepository getCollaboratorRepository() {
    EnvironmentEnum value = EnvironmentEnum.values.firstWhere(
      (element) {
        return element.name.toUpperCase() == ENV.toUpperCase();
      },
      orElse: () => EnvironmentEnum.LOCAL,
    );
    if (value == EnvironmentEnum.LOCAL) {
      return CollaboratorRepositoryMock(_mockDatabase);
    } else {
      return CollaboratorRepositoryMock(_mockDatabase);
    }
  }
}
