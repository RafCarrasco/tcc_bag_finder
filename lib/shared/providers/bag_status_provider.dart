import 'dart:convert';
import 'package:bag_finder/core/entity/bag_status_entity.dart';
import 'package:bag_finder/core/failures/bag_failure.dart';
// Note: o import abaixo deve ser o caminho correto para o seu BagRepositoryImpl
import 'package:bag_finder/infra/repositories/bag_repository_impl.dart'; 
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:bag_finder/core/enums/bag_status_enum.dart'; // Import necessário para o status

// Import para a entidade completa, que é necessário para o update
import 'package:bag_finder/core/entity/bag_entity.dart'; 

class RfidBagProvider extends ChangeNotifier {
  final WebSocketChannel channel;
  final String baseUrl;
  // A classe do repositório deve ser a implementação concreta
  final BagRepositoryImpl bagRepository; 

  final List<BagStatusEntity> _bags = [];
  List<BagStatusEntity> get bags => List.unmodifiable(_bags);

  RfidBagProvider({
    required this.channel,
    required this.baseUrl,
    required this.bagRepository,
  }) {
    // Escuta mensagens do WebSocket
    channel.stream.listen(_onMessage);
  }

  /// Trata mensagens recebidas via WebSocket (com EPC da bagagem)
  void _onMessage(dynamic message) async {
    try {
      final data = jsonDecode(message);
      final epc = data['epc'] as String?;
      if (epc == null) return;

      // ✅ CORREÇÃO: Usando o nome do método da interface IBagRepository
      // Nota: Este método retorna List<BagEntity>, o que é estranho para uma busca por EPC único.
      // Vou assumir que você pega o primeiro elemento da lista, ou que o método findBagByEpc 
      // do Repositório estava fazendo isso internamente.
      final result = await bagRepository.getBagsByEPC(epc: epc); 

      result.fold(
        (failure) {
          print('Erro ao buscar bag por EPC: $failure');
        },
        // Como IBagRepository.getBagsByEPC retorna List<BagEntity>, assumo que bagList tem o item
        (bagList) { 
          if (bagList.isEmpty) return;
          final bag = BagStatusEntity.fromBagEntity(bagList.first); // Assumindo conversão para BagStatusEntity
          
          print('🧳 [Nova leitura EPC]');
          print('➡ ID: ${bag.id}');
          print('➡ Código: ${bag.printedCode}');
          print('➡ EPC: ${bag.rfidTag}');
          print('➡ Status: ${bag.status}');
          print('➡ Destino: ${bag.destination}');
          print('------------------------------------');

          final index = _bags.indexWhere((b) => b.rfidTag == epc);
          if (index != -1) {
            _bags[index] = bag;
          } else {
            _bags.add(bag);
          }

          notifyListeners();
        },
      );
    } catch (e) {
      print('Erro ao processar mensagem do WebSocket: $e');
    }
  }

  /// Carrega todas as bags do usuário e consolida registros duplicados
  Future<void> loadUserBags(String userId) async {
    try {
      print('🔍 [loadUserBags] Carregando bags do usuário: $userId...');

      // O método getBagsStatusById existe no IBagRepository
      final Either<BagFailure, List<BagStatusEntity>> result =
          await bagRepository.getBagsStatusById(userId: userId);

      result.fold(
        (failure) {
          print('❌ [loadUserBags] Falha: $failure');
        },
        (bagsList) {
          final consolidadas = _consolidarBags(bagsList);

          _bags
            ..clear()
            ..addAll(consolidadas);

          notifyListeners();

          print('✅ [loadUserBags] ${_bags.length} bags consolidadas:');
          for (final bag in _bags) {
            print('🧳 ID: ${bag.id}');
            print('📦 Código: ${bag.printedCode}');
            print('📡 EPC: ${bag.rfidTag}');
            print('🚦 Status: ${bag.status}');
            print('✈️ Destino: ${bag.destination}');
            print('------------------------------------');
          }
        },
      );
    } catch (e, stack) {
      print('💥 [loadUserBags] Erro inesperado: $e');
      print(stack);
    }
  }

  // ✅ NOVO MÉTODO: implementa a lógica de confirmação usando IBagRepository.updateBag
  Future<void> confirmBagCollection({
    required String bagId,
    required String userId,
  }) async {
    // 1. Encontrar a BagStatusEntity local.
    final bagToUpdateStatus = _bags.firstWhere(
      (bag) => bag.id == bagId,
      orElse: () => throw Exception('Bagagem não encontrada localmente.'),
    );

    // 2. Assumindo que você precisa da BagEntity completa para o updateBag do Repositório,
    // temos que buscar a BagEntity completa primeiro. Como não há um método getBagById para BagEntity,
    // usarei o getBagsById, pegando o primeiro.
    final bagEntityResult = await bagRepository.getBagsById(bagId: bagId);

    bagEntityResult.fold(
      (failure) {
        print('❌ [confirmBagCollection] Falha ao buscar BagEntity para update: $failure');
      },
      (bagEntities) async {
        if (bagEntities.isEmpty) {
          print('⚠️ [confirmBagCollection] BagEntity não encontrada para ID: $bagId');
          return;
        }
        
        final currentBag = bagEntities.first;
        
        // 3. Atualizar o status para o status de 'COLETADA'
        final updatedBag = currentBag.copyWith(
          status: BagStatusEnum.COLLECTED, // O enum deve ser referenciado corretamente
        );

        // 4. Chamar o método de atualização que existe no IBagRepository
        print('📦 [confirmBagCollection] Tentando atualizar status da bagagem: $bagId para COLETADA');
        
        final updateResult = await bagRepository.updateBag(
          bag: updatedBag,
        );

        updateResult.fold(
          (failure) {
            print('❌ [confirmBagCollection] Falha ao atualizar o status: $failure');
          },
          (_) {
            print('✅ [confirmBagCollection] Status da bagagem atualizado com sucesso. Recarregando bags...');
            // 5. Recarregar a lista para refletir a mudança
            loadUserBags(userId);
          },
        );
      },
    );
  }

  /// Consolida bags com mesmo RFID e bag_id
  /// Mantém dados do mais velho e status do mais novo
  List<BagStatusEntity> _consolidarBags(List<BagStatusEntity> bags) {
    final Map<String, List<BagStatusEntity>> grouped = {};

    // 🔹 Agrupa por combinação de rfidTag + bagId
    for (final bag in bags) {
      final key = '${bag.rfidTag}_${bag.bagId}';
      grouped.putIfAbsent(key, () => []);
      grouped[key]!.add(bag);
    }

    final List<BagStatusEntity> consolidadas = [];

    grouped.forEach((key, group) {
      if (group.isEmpty) return;

      // Ordena por createdAt (ascendente)
      group.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      final maisVelho = group.first;
      final maisNovo = group.last;

      // Cria nova bag com base no mais velho, mas com status do mais novo
      final consolidada = maisVelho.copyWith(
        status: maisNovo.status,
        createdAt: maisNovo.createdAt, // registra quando o status foi atualizado
      );

      consolidadas.add(consolidada);

      print('🧩 [Consolidado] RFID=${maisVelho.rfidTag}');
      print('  → Status antigo: ${maisVelho.status}');
      print('  → Status novo: ${maisNovo.status}');
      print('  → Base: ${maisVelho.createdAt}');
      print('  → Último update: ${maisNovo.createdAt}');
      print('------------------------------------');
    });

    return consolidadas;
  }
}