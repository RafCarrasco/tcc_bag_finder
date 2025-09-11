import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/entity/trip_entity.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TripRemoteDataSource {
  final String baseUrl = dotenv.env['BASE_URL']!;

  Future<TripEntity> addTrip(TripEntity trip) async {
    final response = await http.post(
      Uri.parse('$baseUrl/trips'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(trip.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TripEntity.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao criar viagem: ${response.body}');
    }
  }

  Future<List<TripEntity>> getAllTrips() async {
    final response = await http.get(Uri.parse('$baseUrl/trips'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => TripEntity.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar viagens: ${response.body}');
    }
  }

  Future<TripEntity?> getTripById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/trips/$id'));

    if (response.statusCode == 200) {
      return TripEntity.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Erro ao buscar viagem por id: ${response.body}');
    }
  }

  Future<TripEntity> updateTrip(TripEntity trip) async {
    final response = await http.put(
      Uri.parse('$baseUrl/trips/${trip.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(trip.toJson()),
    );

    if (response.statusCode == 200) {
      return TripEntity.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao atualizar viagem: ${response.body}');
    }
  }

  Future<void> deleteTrip(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/trips/$id'));

    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar viagem: ${response.body}');
    }
  }

  Future<List<TripEntity>> getAllTripsByResponsibleId(
      String responsibleCollaboratorId) async {
    final response = await http.get(
        Uri.parse('$baseUrl/trips/responsible/$responsibleCollaboratorId'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => TripEntity.fromJson(e)).toList();
    } else {
      throw Exception(
          'Erro ao buscar viagens por responsável: ${response.body}');
    }
  }

  Future<List<TripEntity>> getAllTripsByTraveler(String travelerId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/trips/traveler/$travelerId'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => TripEntity.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar viagens por viajante: ${response.body}');
    }
  }

  Future<List<TripEntity>> getTripsById(String tripId) async {
    final response = await http.get(Uri.parse('$baseUrl/trips/id/$tripId'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => TripEntity.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar viagens por ID: ${response.body}');
    }
  }

  Future<List<TripEntity>> getTripsByStatusAndId(
      bool? isDone, String travelerId) async {
    final doneParam = isDone != null ? '?isDone=$isDone' : '';
    final response = await http
        .get(Uri.parse('$baseUrl/trips/traveler/$travelerId$doneParam'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => TripEntity.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar viagens por status/id: ${response.body}');
    }
  }

  Future<bool> isTripDone(String tripId) async {
    final response = await http.get(Uri.parse('$baseUrl/trips/$tripId/status'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['isDone'] as bool;
    } else {
      throw Exception('Erro ao verificar status da viagem: ${response.body}');
    }
  }
}
