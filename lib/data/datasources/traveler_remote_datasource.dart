import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/entity/traveler_entity.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class TravelerRemoteDataSource {
    // final String baseUrl = dotenv.env['BASE_URL']!;
    final String baseUrl;

  TravelerRemoteDataSource({required this.baseUrl});

  Future<TravelerEntity> addTraveler(TravelerEntity traveler) async {
    final response = await http.post(
      Uri.parse('$baseUrl/travelers'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(traveler.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TravelerEntity.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao adicionar viajante: ${response.body}');
    }
  }

  Future<List<TravelerEntity>> getAllTravelers() async {
    final response = await http.get(Uri.parse('$baseUrl/travelers'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => TravelerEntity.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar viajantes: ${response.body}');
    }
  }

  Future<TravelerEntity?> getTravelerById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/travelers/$id'));

    if (response.statusCode == 200) {
      return TravelerEntity.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Erro ao buscar viajante por id: ${response.body}');
    }
  }

  Future<void> updateTraveler(TravelerEntity traveler) async {
    final response = await http.put(
      Uri.parse('$baseUrl/travelers/${traveler.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(traveler.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar viajante: ${response.body}');
    }
  }

  Future<void> deleteTraveler(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/travelers/$id'));

    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar viajante: ${response.body}');
    }
  }
}

