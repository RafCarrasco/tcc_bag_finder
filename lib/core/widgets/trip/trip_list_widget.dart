import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import '../../entity/bag_entity.dart';
import '../../../shared/providers/traveler_provider.dart';
import '../../utils/app_dimensions.dart';
import 'trip_header_widget.dart';
import '../bag/bag_timeline_widget.dart';

class TripListWidget extends StatefulWidget {
  final String travelerId;
  final List<BagEntity> bags;
  final String collaboratorName;

  const TripListWidget({
    super.key,
    required this.travelerId,
    required this.bags,
    required this.collaboratorName,
  });

  @override
  State<TripListWidget> createState() => _TripListWidgetState();
}

class _TripListWidgetState extends State<TripListWidget> {
  final travelerProvider = Modular.get<TravelerProvider>();

  DateTime get date => travelerProvider.currentTrip!.createdAt;
  String get airportDestination =>
      travelerProvider.currentTrip!.description.airportDestination;
  String get airportOrigin =>
      travelerProvider.currentTrip!.description.airportOrigin;

  @override
  void initState() {
    super.initState();
    travelerProvider.checkIsTripDone(
      trip: travelerProvider.currentTrip!,
    );
  }

  String _mapStatus(String status) {
    switch (status) {
      case 'DELIVERED':
        return 'Entregue';
      case 'IN_TRANSIT':
        return 'Em trânsito';
      case 'CHECKED_IN':
        return 'Despachada';
      case 'CREATED':
        return 'Criada';
      default:
        return status;
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'DELIVERED':
        return Colors.green;
      case 'IN_TRANSIT':
        return Colors.orange;
      case 'CHECKED_IN':
        return Colors.blue;
      case 'CREATED':
        return Colors.grey;
      default:
        return Colors.black87;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
            vertical: AppDimensions.paddingSmall,
          ),
          child: TripHeaderWidget(
            airportDestination: airportDestination,
            airportOrigin: airportOrigin,
            tripId: travelerProvider.currentTrip!.id,
            date: date,
            collaboratorName: widget.collaboratorName,
            checkedBags:
                widget.bags.where((bag) => bag.status == "DELIVERED").length,
            bags: widget.bags.length,
          ),
        ),

        const SizedBox(height: 8),

        Expanded(
          child: Consumer<TravelerProvider>(
            builder: (context, provider, child) {
              if (widget.bags.isEmpty) {
                return const Center(
                  child: Text(
                    "Nenhuma bagagem registrada nesta viagem.",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: widget.bags.length,
                itemBuilder: (context, index) {
                  final bag = widget.bags[index];

                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading:
                          const Icon(Icons.luggage, color: Colors.blueGrey),
                      title: Text(bag.description ?? "Sem descrição"),
                      subtitle: Text(
                        "Status: ${_mapStatus(bag.status.name)}",
                        style: TextStyle(
                          color: _statusColor(bag.status.name),
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          builder: (_) => SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: BagTimelineWidget(bagId: bag.id),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
