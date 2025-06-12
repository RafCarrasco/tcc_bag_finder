import 'package:tcc_bag_finder/app/data/repositories/bag_repository_firestore.dart';
import 'package:tcc_bag_finder/app/data/repositories/collaborator_repository_firestore.dart';
import 'package:tcc_bag_finder/app/data/repositories/traveler_repository_firestore.dart';
import 'package:tcc_bag_finder/app/data/repositories/trip_repository_firestore.dart';
import 'package:tcc_bag_finder/app/data/repositories/user_repository_firestore.dart';
import 'package:tcc_bag_finder/app/shared/services/hive/bag_hive_service.dart';
import 'package:tcc_bag_finder/app/shared/services/hive/collaborator_hive_service.dart';
import 'package:tcc_bag_finder/app/shared/services/hive/trip_hive_service.dart';
import 'package:tcc_bag_finder/app/shared/services/hive/user_hive_service.dart';
import 'package:tcc_bag_finder/domain/repositories/bag_repository.dart';
import 'package:tcc_bag_finder/domain/repositories/collaborator_repository.dart';
import 'package:tcc_bag_finder/domain/repositories/traveler_repository.dart';
import 'package:tcc_bag_finder/domain/repositories/trip_repository.dart';
import 'package:tcc_bag_finder/domain/repositories/user_repository.dart';
import 'package:tcc_bag_finder/app/data/datasources/bag_local_datasource.dart';
import 'package:tcc_bag_finder/app/data/datasources/collaborator_local_datasource.dart';
import 'package:tcc_bag_finder/app/data/datasources/trip_local_datasource.dart';
import 'package:tcc_bag_finder/app/data/datasources/user_local_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EnvironmentConfig {
  // ignore: constant_identifier_names
  static const MSS_BASE_URL = String.fromEnvironment('MSS_BASE_URL');

  // ignore: constant_identifier_names
  static const ENV = String.fromEnvironment('ENV');

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static IBagRepository getBagRepository() {
    return BagRepositoryFirestore(_firestore);
  }

  static IUserRepository getUserRepository() {
    return UserRepositoryFirestore(_firestore);
  }

  static ICollaboratorRepository getCollaboratorRepository() {
    return CollaboratorRepositoryFirestore(_firestore);
  }

  static ITripRepository getTripRepository() {
    return TripRepositoryFirestore(_firestore);
  }

  static ITravelerRepository getTravelerRepository() {
    return TravelerRepositoryFirestore(_firestore);
  }

  static IUserLocalDatasource getUserLocalDatasource() =>
      UserHiveLocalDatasource();

  static IBagLocalDatasource getBagLocalDatasource() =>
      BagHiveLocalDatasource();

  static ITripLocalDatasource getTripLocalDatasource() =>
      TripHiveLocalDatasource();

  static ICollaboratorLocalDatasource getCollaboratorLocalDatasource() =>
      CollaboratorHiveLocalDatasource();
}
