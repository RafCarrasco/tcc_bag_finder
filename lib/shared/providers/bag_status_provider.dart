import 'dart:convert';
import 'package:bag_finder/core/entity/bag_status_entity.dart';
import 'package:bag_finder/core/utils/global_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

class RfidBagProvider extends ChangeNotifier {
  final WebSocketChannel channel;
  final String baseUrl;
  final List<BagStatusEntity> _bags = [];

  List<BagStatusEntity> get bags => _bags;

  RfidBagProvider({
    required this.channel,
    required this.baseUrl,
  }) {
    channel.stream.listen(_onMessage);
  }


  void _onMessage(dynamic message) async {
    try {
      final data = jsonDecode(message);
      final epc = data['epc'] as String?;
      if (epc == null) return;

      final bag = await getBagByEpc(epc);

      if (bag == null || bag.status == 'NAO_CADASTRADA') {
        GlobalSnackBar.warning('⚠️ A TAG ${epc.substring(0, 8)}... não está cadastrada!');
        return;
      }

      final index = _bags.indexWhere((b) => b.rfidTag == epc);
      if (index != -1) {
        _bags[index] = bag;
      } else {
        _bags.add(bag);
        GlobalSnackBar.success('✅ Bagagem detectada: ${bag.printedCode}');
      }

      notifyListeners();
    } catch (e) {
      GlobalSnackBar.error('Erro ao processar mensagem do WebSocket: $e');
    }
  }


  Future<BagStatusEntity?> getBagByEpc(String epc) async {
    try {
      final url = Uri.parse('$baseUrl/bags/status/epc/$epc');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return BagStatusEntity.fromJson(data);
      }

      if (response.statusCode == 404) {
        return null;
      }

      throw Exception('Erro ${response.statusCode}: ${response.body}');
    } catch (e) {
      GlobalSnackBar.error('Falha ao buscar bag pelo EPC: $e');
      return null;
    }
  }
}
