import 'package:bag_finder/shared/providers/traveler_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/entity/bag_entity.dart';
import '../../../core/entity/trip_entity.dart';
import '../../../core/enums/bag_status_enum.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/global_snackbar.dart';

class HomeTravelerPage extends StatefulWidget {
  const HomeTravelerPage({super.key});

  @override
  State<HomeTravelerPage> createState() => _HomeTravelerPageState();
}

class _HomeTravelerPageState extends State<HomeTravelerPage> {
  @override
  void initState() {
    super.initState();
    final travelerProvider = context.read<TravelerProvider>();
    travelerProvider.fetchCurrentTrip();
  }

  @override
  Widget build(BuildContext context) {
    final travelerProvider = context.watch<TravelerProvider>();
    final TripEntity? trip = travelerProvider.currentTrip;

    if (trip == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final bags = trip.bags ?? [];

    if (bags.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('Nenhuma bagagem cadastrada nesta viagem.')),
      );
    }

    final hasConnection = trip.connection != null && trip.connection!.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Bagagens'),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: bags.length,
          itemBuilder: (context, index) {
            final bag = bags[index];

            if (bag.status == BagStatusEnum.NAO_CADASTRADA) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                GlobalSnackBar.warning(
                  'Mala ${bag.printedCode ?? bag.id} não está cadastrada!',
                );
              });
            }

            return _buildBagCard(context, bag, hasConnection, trip.connection);
          },
        ),
      ),
    );
  }

  Widget _buildBagCard(BuildContext context, BagEntity bag, bool hasConnection, String? connectionName) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusIcon(bag.status),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Código: ${bag.printedCode ?? "N/A"}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  Text('Status: ${bag.status.toLiteral()}'),
                  Text('Criada em: ${bag.createdAt.toLocal()}'),
                  if (hasConnection)
                    Text('Conexão: ${connectionName ?? "Desconhecida"}'),
                  const SizedBox(height: 8),
                  if (bag.status == BagStatusEnum.READY_FOR_PICKUP)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          GlobalSnackBar.success('Mala ${bag.printedCode ?? bag.id} coletada!');
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Coletar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon(BagStatusEnum status) {
    IconData icon;
    Color color;

    switch (status) {
      case BagStatusEnum.CHECKED_IN:
        icon = Icons.home;
        color = Colors.blue;
        break;
      case BagStatusEnum.IN_TRANSIT:
      case BagStatusEnum.IN_TRANSIT_CONNECTION:
        icon = Icons.flight_takeoff;
        color = Colors.orange;
        break;
      case BagStatusEnum.ARRIVED_AT_CONNECTION:
      case BagStatusEnum.ARRIVED:
        icon = Icons.flight_land;
        color = Colors.green;
        break;
      case BagStatusEnum.READY_FOR_PICKUP:
        icon = Icons.luggage;
        color = Colors.purple;
        break;
      case BagStatusEnum.COLLECTED:
        icon = Icons.check_circle;
        color = Colors.grey;
        break;
      default:
        icon = Icons.help_outline;
        color = Colors.red;
    }

    return CircleAvatar(
      radius: 28,
      backgroundColor: color.withOpacity(0.15),
      child: Icon(icon, color: color, size: 28),
    );
  }
}
