import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/entity/collaborator_entity.dart';
import '../../core/entity/trip_entity.dart';

class CollaboratorRemoteDataSource {
  final String baseUrl;

  CollaboratorRemoteDataSource({required this.baseUrl});

  Future<List<CollaboratorEntity>> getCollaboratorsByResponsibleId(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/collaborators/responsible/$id'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => CollaboratorEntity.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar colaboradores por responsável: ${response.body}');
    }
  }

  Future<List<TripEntity>> getTripsByTravelerId({
    required String travelerId,
    required String responsibleId,
  }) async {
    final response = await http.get(
      Uri.parse('$baseUrl/trips/traveler/$travelerId/responsible/$responsibleId'),
    );

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => TripEntity.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar viagens do traveler: ${response.body}');
    }
  }

  Future<List<TripEntity>> getAllTripsByResponsible(String responsibleId) async {
    final response = await http.get(Uri.parse('$baseUrl/trips/responsible/$responsibleId'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => TripEntity.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar viagens por responsável: ${response.body}');
    }
  }
}
