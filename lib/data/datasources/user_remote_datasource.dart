import 'dart:convert';
import 'package:bag_finder/core/entity/admin_entity.dart';
import 'package:bag_finder/core/entity/collaborator_entity.dart';
import 'package:bag_finder/core/exceptions/authentication_exceptions.dart';
import 'package:http/http.dart' as http;
import '../../../core/entity/user_entity.dart';

class UserRemoteDataSource {
  final String baseUrl;

  UserRemoteDataSource({required this.baseUrl});

 Future<UserEntity> addUser(UserEntity user) async {
  final payload = {
    'cpf': user.cpf?.replaceAll(RegExp(r'\D'), ''),
    'fullName': user.fullName.trim(),
    'email': user.email.trim().toLowerCase(),
    'password': user.password,
    'phone': user.phone,
    'role': user.role.isEmpty ? 'TRAVELER' : user.role,
    'isActive': user.isActive,
  };

  final resp = await http.post(
    Uri.parse('$baseUrl/users'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(payload),
  );

  final body = resp.body.isNotEmpty ? jsonDecode(resp.body) : null;
  final err = (body is Map && body['error'] is String)
      ? body['error'] as String
      : 'Erro ao adicionar usuário';

  if (resp.statusCode == 200 || resp.statusCode == 201) {
    return UserEntity.fromJson(body as Map<String, dynamic>);
  } else if (resp.statusCode == 409) {
    throw UserAlreadyInUseException();
  } else if (resp.statusCode == 400) {
    throw Exception(err); 
  } else {
    throw Exception('Erro (HTTP ${resp.statusCode}): $err');
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
    
    final body = response.body.isNotEmpty ? jsonDecode(response.body) : null;
    final errMessage = (body is Map && body['error'] is String)
        ? body['error'] as String
        : 'Erro ao atualizar usuário';

    if (response.statusCode == 200) {
      return UserEntity.fromJson(body as Map<String, dynamic>);
    } 
    else if (response.statusCode == 409) {
      throw UserAlreadyInUseException(); 
    } 
    else {
      throw Exception('Erro ao atualizar usuário (Status ${response.statusCode}): $errMessage');
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
      } else if ((data['role'] as String) == 'COLLABORATOR') {
        return CollaboratorEntity.fromJson(data);
      }
      return UserEntity.fromJson(data);
    } else if (response.statusCode == 401) {
      throw AuthenticationFailedException();
    } else {
      throw Exception(
          'Erro ao autenticar usuário (Status ${response.statusCode}): ${response.body}');
    }
  }

  Future<UserEntity?> getUserByCpf(String cpf) async {
    final clean = cpf.replaceAll(RegExp(r'\D'), '');
    final response = await http.get(Uri.parse('$baseUrl/users/cpf/$clean'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if ((data['role'] as String) == 'ADMIN') {
          return AdminEntity.fromJson(data);
      } else if ((data['role'] as String) == 'COLLABORATOR') {
          return CollaboratorEntity.fromJson(data);
      }
      return UserEntity.fromJson(data);
    } else if (response.statusCode == 404) {
      return null; 
    } else {
      throw Exception('Erro ao verificar CPF: ${response.body}');
    }
  }

  Future<void> resetPassword({
    required String email,
    required String cpf,
    required String newPassword,
  }) async {
    final cleanCpf = cpf.replaceAll(RegExp(r'\D'), '');
    final payload = {
      'email': email,
      'cpf': cleanCpf,
      'newPassword': newPassword,
    };

    final response = await http.post(
      Uri.parse('$baseUrl/auth/reset-password'), 
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    if (response.statusCode == 400 || response.statusCode == 404 || response.statusCode == 401) {
      final body = jsonDecode(response.body);
      throw Exception(body['error'] ?? 'Erro desconhecido ao redefinir.');
    }
    else if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Erro ao redefinir a senha (Status ${response.statusCode}): ${response.body}');
    }
  }
}
