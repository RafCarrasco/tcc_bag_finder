import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import '../entity/bag_entity.dart';
import '../entity/bag_status_entity.dart';
import '../../shared/providers/traveler_provider.dart';

class TripListWidget extends StatefulWidget {
  final String travelerId;
  final List<BagEntity> bags;

  const TripListWidget({
    super.key,
    required this.travelerId,
    required this.bags,
  });

  @override
  State<TripListWidget> createState() => _TripListWidgetState();
}

class _TripListWidgetState extends State<TripListWidget> {
  final travelerProvider = Modular.get<TravelerProvider>();

  DateTime get date => travelerProvider.currentTrip!.createdAt;
  String get airportDestination =>
      travelerProvider.currentTrip!.destination;
  String get airportOrigin =>
      travelerProvider.currentTrip!.origin;

  @override
  void initState() {
    super.initState();
    travelerProvider.checkIsTripDone(
      trip: travelerProvider.currentTrip!,
    );
  }

    @override
  Widget build(BuildContext context) {
    return Consumer<TravelerProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.bagStatus == null || provider.bagStatus!.isEmpty) {
          return const Center(
            child: Text(
              "Nenhuma bagagem encontrada.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        }

        final bags = provider.bagStatus!;

        return ListView.builder(
          itemCount: bags.length,
          itemBuilder: (context, index) {
            final bag = bags[index];
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
      child: ListTile(
        leading: Icon(
          Icons.luggage,
          color: _getStatusColor(bag.status),
          size: 40,
        ),
        title: Text(
          bag.printedCode ?? "Código desconhecido",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Status: ${bag.status ?? 'Indefinido'}"),
            Text("Destino: ${bag.destination ?? 'N/A'}"),
            Text("Conexão: ${bag.flightConnection ?? 'N/A'}"),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'checked_in':
        return Colors.orange;
      case 'in_transit':
        return Colors.blue;
      case 'arrived':
        return Colors.green;
      case 'lost':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

}
