import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../core/entity/bag_entity.dart';
import '../../core/entity/bag_status_entity.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/enums/bag_status_enum.dart';

class BagRemoteDataSource {
  final String baseUrl;
  final http.Client client; 

  BagRemoteDataSource({required this.baseUrl, http.Client? client}) 
      : client = client ?? http.Client();

  Future<BagEntity> addBag(BagEntity bag) async {
    final response = await client.post( 
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

  Future<List<BagEntity>> getBagsByEPC(String epc) async {
    final response = await client.get(Uri.parse('$baseUrl/bags/epc/$epc')); 

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => BagEntity.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Erro ao buscar bag por EPC: ${response.statusCode} - ${response.body}');
    }
  }

  Future<List<BagEntity>> getBagsById(String bagId) async {
    final response = await client.get(Uri.parse('$baseUrl/bags/$bagId')); 

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
    final response = await client.put( 
      Uri.parse('$baseUrl/bags/${bag.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(bag.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar bag: ${response.statusCode} - ${response.body}');
    }
  }

  Future<void> deleteBag(String bagId) async {
    final response = await client.delete(Uri.parse('$baseUrl/bags/$bagId')); 

    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar bag: ${response.statusCode} - ${response.body}');
    }
  }

  Future<List<BagEntity>> getBagsByUserId(String userId) async {
    final response = await client.get(Uri.parse('$baseUrl/users/$userId/bags')); 

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => BagEntity.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar bags do usuário: ${response.statusCode} - ${response.body}');
    }
  }

  Future<List<BagEntity>> getBagsByStatus(BagStatusEnum status) async {
    final response = await client.get(Uri.parse('$baseUrl/bags/status/${status.name}')); 

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => BagEntity.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar bags por status: ${response.statusCode} - ${response.body}');
    }
  }

  Future<List<BagEntity>> getCurrentTripBagsById(TripEntity trip, String bagId) async {
    final response = await client.get(Uri.parse('$baseUrl/trips/${trip.id}/bags/$bagId')); 

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
    final response = await client.get(Uri.parse('$baseUrl/users/$userId/bags/$bagId/active')); 

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => BagEntity.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Erro ao buscar bags ativas do usuário: ${response.statusCode} - ${response.body}');
    }
  }
  
  Future<List<BagEntity>> getBagsByTripId(String tripId) async {
    final response = await client.get(Uri.parse('$baseUrl/bags/trips/$tripId')); 

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => BagEntity.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar bags da viagem: ${response.statusCode} - ${response.body}');
    }
  }

  Future<List<BagStatusEntity>> getBagsStatusById(String userId) async {
    final response = await client.get(Uri.parse('$baseUrl/bags/status/user/$userId')); 

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => BagStatusEntity.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Erro ao buscar bags ativas do usuário: ${response.statusCode} - ${response.body}');
    }
  }
  
  Future<BagStatusEntity> findBagByEpc(String epc) async {
    try {
      final url = Uri.parse('$baseUrl/bags/status/epc/$epc');
      final response = await client.get(url); 

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return BagStatusEntity.fromJson(data);
      } else if (response.statusCode == 404) {
        throw Exception('Bag com EPC $epc não encontrada.');
      } else {
        throw Exception('Erro ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      throw Exception('Erro ao buscar bag por EPC: $e');
    }
  }
  
  // ✅ CORREÇÃO CRÍTICA: Assinatura alterada para aceitar o 'trip' (como o Repository envia)
  Future<void> finalizeBagCollection({required TripEntity trip}) async {
    final response = await client.patch(
      // ✅ CORREÇÃO NA URL: Usando trip.id, pois é uma "collection" (viagem)
      Uri.parse('$baseUrl/trips/${trip.id}/finalize-collection'), 
      headers: {'Content-Type': 'application/json'},
      // Envia o corpo necessário para a API (pode ser o ID da viagem ou status)
      body: jsonEncode({'trip_id': trip.id, 'status': 'COLLECTED'}), 
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao finalizar coleta da viagem ${trip.id}: ${response.statusCode} - ${response.body}');
    }
  }
}