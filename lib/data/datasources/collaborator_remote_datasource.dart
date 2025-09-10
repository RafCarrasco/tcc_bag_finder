import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/entity/traveler_entity.dart';
import '../../core/entity/collaborator_entity.dart';
import '../../core/entity/trip_entity.dart';

class CollaboratorRemoteDataSource {
  final String baseUrl;

  CollaboratorRemoteDataSource({required this.baseUrl});

  Future<List<CollaboratorEntity>> getCollaboratorsByResponsibleId(
      String id) async {
    final response = await http.get(Uri.parse('$baseUrl/collaborators/$id'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => CollaboratorEntity.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar colaboradores por responsável');
    }
  }

  Future<List<TripEntity>> getTripsByTravelerId({
    required String travelerId,
    required String responsibleId,
  }) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/travelers/$travelerId/trips?responsible=$responsibleId'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => TripEntity.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar trips por travelerId');
    }
  }

  Future<List<TripEntity>> getAllTripsByResponsible(
      String responsibleId) async {
    final response = await http
        .get(Uri.parse('$baseUrl/collaborators/$responsibleId/trips'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => TripEntity.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar trips por responsável');
    }
  }

  Future<List<TravelerEntity>> getAllTravelers() async {
    final response = await http.get(Uri.parse('$baseUrl/travelers'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => TravelerEntity.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar viajantes');
    }
  }
}
