import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/entity/collaborator_entity.dart';
import '../../core/entity/trip_entity.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AdminRemoteDataSource {
  final String baseUrl = dotenv.env['BASE_URL']!;

  Future<List<CollaboratorEntity>> getCollaboratorsByResponsibleId(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/admins/$id/collaborators'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => CollaboratorEntity.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar colaboradores: ${response.body}');
    }
  }

  Future<List<TripEntity>> getCollaboratorTripsByCollaboratorId(String collaboratorId) async {
    final response = await http.get(Uri.parse('$baseUrl/collaborators/$collaboratorId/trips'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => TripEntity.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar viagens do colaborador: ${response.body}');
    }
  }
}
