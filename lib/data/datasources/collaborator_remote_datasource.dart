import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../core/entity/tag_entity.dart';
import '../../core/entity/collaborator_entity.dart';
import '../../core/entity/trip_entity.dart';
import '../../infra/repositories/traveler_repository_impl.dart';

class CollaboratorRemoteDataSource {
  final String baseUrl;
  final TravelerRepositoryImpl travelerRepository;

  CollaboratorRemoteDataSource({
    required this.travelerRepository,
    required this.baseUrl,
  });

  Future<List<TripEntity>> getTripsByTravelerId({
    required String travelerId,
    required String responsibleId,
  }) async {
    final response = await http.get(
      Uri.parse('$baseUrl/trips/traveler/$travelerId/responsible/$responsibleId'),
    );

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list
          .map((e) => TripEntity.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Erro ao buscar viagens do traveler: ${response.body}');
    }
  }

  Future<List<TripEntity>> getAllTripsByResponsible(String responsibleId) async {
    final response = await http.get(Uri.parse('$baseUrl/trips/responsible/$responsibleId'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list
          .map((e) => TripEntity.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Erro ao buscar viagens por responsável: ${response.body}');
    }
  }
  Future<List<TripEntity>> getAllTripsByTravelerFullName(String fullName) async {
    final response = await http.get(Uri.parse('$baseUrl/trips/name/$fullName'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list
          .map((e) => TripEntity.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Erro ao buscar viagens por responsável: ${response.body}');
    }
  }

    Future<List<TripEntity>> getAllTrips() async {
  final url = Uri.parse('$baseUrl/trips');
  //print('[DEBUG] Chamando: $url');

  final response = await http.get(url);

  // print('[DEBUG] Status: ${response.statusCode}');
  // print('[DEBUG] Body: ${response.body}');

  if (response.statusCode == 200) {
    try {
      final list = jsonDecode(response.body) as List;
      // print('[DEBUG] Decodificado: ${list.length} registros');

      final trips = list
          .map((e) => TripEntity.fromJson(e as Map<String, dynamic>))
          .toList();

      // print('[DEBUG] Trips parseadas: ${trips.length}');
      return trips;
    } catch (e) {
      // print('[ERROR] Falha ao converter trips: $e');
      rethrow;
    }
  } else {
    throw Exception(
      'Erro ao buscar todas as viagens (Status ${response.statusCode}): ${response.body}',
    );
  }
}



  Future<void> insertTag(TagEntity tag) async {
    final response = await http.post(
      Uri.parse('$baseUrl/collaborators/tags'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(tag.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Erro ao inserir tag: ${response.body}');
    }
  }
}
