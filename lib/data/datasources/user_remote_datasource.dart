import 'dart:convert';
import 'package:bag_finder/core/entity/admin_entity.dart';
import 'package:bag_finder/core/entity/collaborator_entity.dart';
import 'package:http/http.dart' as http;
import '../../../core/entity/user_entity.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserRemoteDataSource {
  final String baseUrl = dotenv.env['BASE_URL']!;

  Future<UserEntity> addUser(UserEntity user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserEntity.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao adicionar usuário: ${response.body}');
    }
  }

  Future<UserEntity?> getUserById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id'));

    if (response.statusCode == 200) {
      return UserEntity.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      return null; 
    } else {
      throw Exception('Erro ao buscar usuário por id: ${response.body}');
    }
  }

  Future<List<UserEntity>> getAllUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => UserEntity.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar todos usuários: ${response.body}');
    }
  }

  Future<UserEntity> updateUser(UserEntity user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/${user.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return UserEntity.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao atualizar usuário: ${response.body}');
    }
  }

  Future<void> deleteUser(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/users/$id'));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Erro ao deletar usuário: ${response.body}');
    }
  }

  Future<List<String>> getAllUsersByIds(List<String> ids) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/by-ids'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'ids': ids}),
    );

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.cast<String>();
    } else {
      throw Exception('Erro ao buscar usuários por IDs: ${response.body}');
    }
  }

  Future<UserEntity?> getUserByEmail(String email) async {
    final response = await http.get(Uri.parse('$baseUrl/users/email/$email'));

    if (response.statusCode == 200) {
      return UserEntity.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Erro ao buscar usuário por email: ${response.body}');
    }
  }

  Future<List<UserEntity>> getUsersByName(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/users/name/$name'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => UserEntity.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar usuários por nome: ${response.body}');
    }
  }

  Future<UserEntity?> authenticateUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if ((data['role'] as String) == 'ADMIN') {
        return AdminEntity.fromJson(data);
      }else if((data['role'] as String) == 'COLLABORATOR'){
        return CollaboratorEntity.fromJson(data);
      }
      return UserEntity.fromJson(data);
    } else if (response.statusCode == 401) {
      return null;
    } else {
      throw Exception('Erro ao autenticar usuário: ${response.body}');
    }
  }
}
