import 'package:bag_finder/core/entity/bag_status_entity.dart';
import 'package:bag_finder/core/enums/bag_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:bag_finder/core/widgets/bag_item_widget.dart';


class HomeTravelerPage extends StatefulWidget {
  final String travelerId;

  const HomeTravelerPage({super.key, required this.travelerId});

  @override
  State<HomeTravelerPage> createState() => _HomeTravelerPageState();
}

class _HomeTravelerPageState extends State<HomeTravelerPage> {
  final List<BagStatusEntity> _bagStatuses = [];
  bool showTimeline = false;

  void _onRFIDRead(String bagId, BagStatusEnum newStatus) {
    // Simula uma leitura POST do leitor RFID
    setState(() {
      showTimeline = true;
      _bagStatuses.add(
        BagStatusEntity(
          bagId: bagId,
          status: newStatus.toLiteral(),
        ),
      );
    });
  }

  Widget _buildTimeline() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _bagStatuses.length,
        itemBuilder: (context, index) {
          final bagStatus = _bagStatuses[index];
          final statusEnum = BagStatusEnum.values.firstWhere(
            (e) => e.toLiteral() == bagStatus.status,
            orElse: () => BagStatusEnum.CHECKED_IN,
          );

          return _buildTimelineItem(statusEnum, index == _bagStatuses.length - 1);
        },
      ),
    );
  }

  Widget _buildTimelineItem(BagStatusEnum status, bool isLast) {
    final color = isLast ? Colors.green : Colors.grey;
    final icon = _getStatusIcon(status);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Descrição do status à esquerda
          Expanded(
            child: Text(
              status.toLiteral(),
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: isLast ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          // Ícone à direita
          Icon(icon, color: color, size: 24),
        ],
      ),
    );
  }

  IconData _getStatusIcon(BagStatusEnum status) {
    switch (status) {
      case BagStatusEnum.CHECKED_IN:
        return Icons.home;
      case BagStatusEnum.IN_TRANSIT:
        return Icons.flight_takeoff;
      case BagStatusEnum.ARRIVED:
        return Icons.flight_land;
      case BagStatusEnum.READY_FOR_PICKUP:
        return Icons.luggage;
      case BagStatusEnum.COLLECTED:
        return Icons.check_circle;
      default:
        return Icons.circle_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Bag Finder'),
        backgroundColor: Colors.teal,
        elevation: 4,
      ),
      body: Center(
        child: Container(
          width: 400,
          margin: const EdgeInsets.symmetric(vertical: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Olá, traveler 1 👋',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[700],
                ),
              ),
              const SizedBox(height: 20),
              if (showTimeline)
                _buildTimeline()
              else
                Column(
                  children: [
                    const Text(
                      'Nenhum status disponível ainda.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.wifi_tethering),
                      label: const Text('Simular leitura RFID'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Exemplo de simulação de mudança de status
                        final simulatedStatus = [
                          BagStatusEnum.CHECKED_IN,
                          BagStatusEnum.IN_TRANSIT,
                          BagStatusEnum.ARRIVED,
                          BagStatusEnum.READY_FOR_PICKUP,
                          BagStatusEnum.COLLECTED,
                        ];
                        final next = simulatedStatus[
                            (_bagStatuses.length) % simulatedStatus.length];
                        _onRFIDRead('BAG123', next);
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
