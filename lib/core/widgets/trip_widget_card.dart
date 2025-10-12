import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import '../../../shared/providers/traveler_provider.dart';
import '../../../core/entity/bag_entity.dart';
import '../../../core/entity/trip_history_entity.dart';

class TripCardWidget extends StatefulWidget {
  final TripHistoryEntity trip;

  const TripCardWidget({super.key, required this.trip});

  @override
  State<TripCardWidget> createState() => _TripCardWidgetState();
}

class _TripCardWidgetState extends State<TripCardWidget> {
  final travelerProvider = Modular.get<TravelerProvider>();
  bool isLoading = true;
  List<BagEntity> bags = [];

  @override
  void initState() {
    super.initState();
    loadBags();
  }

  Future<void> loadBags() async {
    await travelerProvider.getBagsByTripId(widget.trip.tripId);

    if (mounted) {
      setState(() {
        bags = travelerProvider.bags ?? [];
        isLoading = false;
      });
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
    final trip = widget.trip;
    final date = DateFormat('dd/MM/yyyy').format(trip.statusTime);

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho da viagem
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${trip.origin} → ${trip.destination}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _statusColor(trip.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _statusColor(trip.status),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    trip.status,
                    style: TextStyle(
                      color: _statusColor(trip.status),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Data: $date',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),

            const Divider(height: 28),

            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (bags.isEmpty)
              const Text(
                'Nenhuma bagagem associada.',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              )
            else ...[
              const Text(
                'Malas associadas:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              ...bags.map((bag) {
                final bagDate = bag.createdAt != null
                    ? DateFormat('dd/MM/yyyy HH:mm').format(bag.createdAt!)
                    : '-';
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Printed Code: ${bag.printedCode ?? '-'}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Criada em: $bagDate',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.luggage,
                        color: Colors.teal,
                        size: 28,
                      ),
                    ],
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }
}
