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

<<<<<<< HEAD
              return TripHeaderWidget(
                airportDestination: airportDestination,
                airportOrigin: airportOrigin,
                tripId: travelerProvider.currentTrip!.id,
                date: date,
                collaboratorName: widget.collaboratorName,
                checkedBags: checkedBags,
                bags: widget.bags.length,
              );
            },
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: Divider(
            color: AppColors.secondaryGrey.withOpacity(0.3),
            thickness: 4,
          ),
        ),
        Consumer<TravelerProvider>(
          builder: (context, provider, child) {
            if (provider.isTripComplete) {
              return Expanded(
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.primary,
                        size: 100,
                      ),
                      Text(
                        'Todos os bagagens foram entregues',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Expanded(
                child: BagPaginationWidget(
                  bags: widget.bags,
                  airportOriginCode:
                      travelerProvider.currentTrip!.origin,
                  airportDestinationCode: travelerProvider
                      .currentTrip!.destination,
                ),
              );
            }
=======
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
>>>>>>> b04f833112c61e0543a3408d3291b0d7d7a61cc8
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
