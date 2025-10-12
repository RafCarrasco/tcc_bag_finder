import 'package:bag_finder/shared/providers/bag_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/entity/bag_status_entity.dart';

class TripListWidget extends StatelessWidget {
  const TripListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RfidBagProvider>(
      builder: (context, provider, _) {
        final bags = provider.bags;

        if (bags.isEmpty) {
          return const Center(
            child: Text(
              "Nenhuma bagagem encontrada.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        }

        return ListView.builder(
          itemCount: bags.length,
          itemBuilder: (context, index) {
            final bag = bags[index];
            print(
              "Bag ${bag.printedCode} - Status: ${bag.status}, Destino: ${bag.destination}, Conexão: ${bag.flightConnection}",
            );
            return _buildBagCard(bag);
          },
        );
      },
    );
  }

  Widget _buildBagCard(BagStatusEntity bag) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: ListTile(
          leading: Icon(
            Icons.luggage,
            color: _getStatusColor(bag.status),
            size: 40,
          ),
          title: Text(
            _formatText(bag.printedCode, fallback: "Código desconhecido"),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                "Status: ${_formatText(bag.status)}",
                style: const TextStyle(color: Colors.black87, fontSize: 14),
              ),
              Text(
                "Destino: ${_formatText(bag.destination)}",
                style: const TextStyle(color: Colors.black87, fontSize: 14),
              ),
              Text(
                "Conexão: ${_formatText(bag.flightConnection)}",
                style: const TextStyle(color: Colors.black87, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Retorna cor do ícone com base no status
  Color _getStatusColor(String? status) {
    switch (status?.toUpperCase()) {
      case 'CHECKED_IN':
        return Colors.orange;
      case 'IN_TRANSIT':
        return Colors.blue;
      case 'ARRIVED':
        return Colors.green;
      case 'READY_FOR_PICKUP':
        return Colors.purple;
      case 'COLLECTED':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  // 🔹 Garante que texto nulo ou vazio mostre algo legível
  String _formatText(String? text, {String fallback = 'N/A'}) {
    if (text == null || text.trim().isEmpty) return fallback;
    return text;
  }
}
