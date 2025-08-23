import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/entity/collaborator_entity.dart';

class CollaboratorRemoteDataSource {
  final String baseUrl;

  CollaboratorRemoteDataSource({required this.baseUrl});

  Future<CollaboratorEntity> addCollaborator(CollaboratorEntity collaborator) async {
    final response = await http.post(
      Uri.parse('$baseUrl/collaborators'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(collaborator.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return CollaboratorEntity.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao adicionar colaborador: ${response.body}');
    }
  }

  Future<List<CollaboratorEntity>> getAllCollaborators() async {
    final response = await http.get(Uri.parse('$baseUrl/collaborators'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => CollaboratorEntity.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar colaboradores: ${response.body}');
    }
  }

  Future<CollaboratorEntity?> getCollaboratorById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/collaborators/$id'));

    if (response.statusCode == 200) {
      return CollaboratorEntity.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Erro ao buscar colaborador por id: ${response.body}');
    }
  }

  Future<void> updateCollaborator(CollaboratorEntity collaborator) async {
    final response = await http.put(
      Uri.parse('$baseUrl/collaborators/${collaborator.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(collaborator.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar colaborador: ${response.body}');
    }
  }

  Future<void> deleteCollaborator(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/collaborators/$id'));

    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar colaborador: ${response.body}');
    }
  }

  Future<List<CollaboratorEntity>> getCollaboratorsByResponsibleId(String responsibleId) async {
    final response = await http.get(Uri.parse('$baseUrl/collaborators/responsible/$responsibleId'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => CollaboratorEntity.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar colaboradores por responsável: ${response.body}');
    }
  }
}
