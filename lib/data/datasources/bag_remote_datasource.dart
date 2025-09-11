import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/entity/bag_entity.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/enums/bag_status_enum.dart';

class BagRemoteDataSource {
  final String baseUrl;

  BagRemoteDataSource({required this.baseUrl});

  Future<BagEntity> addBag(BagEntity bag) async {
    final response = await http.post(
      Uri.parse('$baseUrl/bags'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(bag.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return BagEntity.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao adicionar bag: ${response.statusCode} - ${response.body}');
    }
  }

  Future<List<BagEntity>> getBagsById(String bagId) async {
    final response = await http.get(Uri.parse('$baseUrl/bags/$bagId'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => BagEntity.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Erro ao buscar bag por ID: ${response.statusCode} - ${response.body}');
    }
  }

  Future<void> updateBag(BagEntity bag) async {
    final response = await http.put(
      Uri.parse('$baseUrl/bags/${bag.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(bag.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar bag: ${response.statusCode} - ${response.body}');
    }
  }

  Future<void> deleteBag(String bagId) async {
    final response = await http.delete(Uri.parse('$baseUrl/bags/$bagId'));

    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar bag: ${response.statusCode} - ${response.body}');
    }
  }

  Future<List<BagEntity>> getBagsByUserId(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId/bags'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => BagEntity.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar bags do usuário: ${response.statusCode} - ${response.body}');
    }
  }

  Future<List<BagEntity>> getBagsByStatus(BagStatusEnum status) async {
    final response = await http.get(Uri.parse('$baseUrl/bags/status/${status.name}'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => BagEntity.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar bags por status: ${response.statusCode} - ${response.body}');
    }
  }

  Future<List<BagEntity>> getCurrentTripBagsById(TripEntity trip, String bagId) async {
    final response = await http.get(Uri.parse('$baseUrl/trips/${trip.id}/bags/$bagId'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => BagEntity.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Erro ao buscar bags da viagem atual: ${response.statusCode} - ${response.body}');
    }
  }

  Future<List<BagEntity>> getUserActiveBagsById(String userId, String bagId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId/bags/$bagId/active'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => BagEntity.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Erro ao buscar bags ativas do usuário: ${response.statusCode} - ${response.body}');
    }
  }
}
