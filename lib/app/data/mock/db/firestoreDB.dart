import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:tcc_bag_finder/domain/entity/admin_entity.dart';
import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/enums/user_role_enum.dart';


class FirestoreDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserEntity>> fetchUsers() async {
    final snapshot = await _firestore.collection('users').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return AdminEntity( // ou qualquer tipo correto (Admin, Traveler, Collaborator etc.)
        id:data['id'],
        email: data['email'],
        password: data['password'],
        fullName: data['fullName'],
        phone: data['phone'],
        cpf: data['cpf'],
        role: UserRoleEnum.values.firstWhere((e) => e.toString() == data['role']),
        updatedAt: null,
        createdAt: DateTime.now(),
        company: data['company'],
      );
    }).toList();
  }
Future<List<BagEntity>> fetchBagsFromFirestore() async {
  final snapshot = await FirebaseFirestore.instance.collection('bags').get();

  return snapshot.docs.map((doc) {
    return BagEntity.fromMap(doc.data(), id: doc.id);
  }).toList();
}


Future<List<TripEntity>> fetchTripsFromFirestore(List<BagEntity> allBags) async {
  final snapshot = await FirebaseFirestore.instance.collection('trips').get();

  return snapshot.docs.map((doc) {
    final data = doc.data();
    final bagIds = List<String>.from(data['bagIds'] ?? []);
    final tripBags = allBags.where((b) => bagIds.contains(b.id)).toList();
    return TripEntity.fromMap(
      data,
      id: doc.id,
      bags: tripBags,
    );
  }).toList();
}
}
