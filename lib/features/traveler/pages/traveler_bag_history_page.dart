import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import '../../../shared/providers/traveler_provider.dart';
import '../../../shared/providers/user_provider.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../core/widgets/appbar/home_app_bar_widget.dart';

class TravelerBagHistoryPage extends StatefulWidget {
  final String travelerId;

  const TravelerBagHistoryPage({
    super.key,
    required this.travelerId,
  });

  @override
  State<TravelerBagHistoryPage> createState() => _TravelerBagHistoryPageState();
}

class _TravelerBagHistoryPageState extends State<TravelerBagHistoryPage> {
  final travelerProvider = Modular.get<TravelerProvider>();
  final userProvider = Modular.get<UserProvider>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await travelerProvider.getTravelerHistory(widget.travelerId);
    for (var trip in travelerProvider.history) {
      await travelerProvider.getBagsByTripId(trip.tripId);
    }
    if (mounted) setState(() => isLoading = false);
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
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final userName = userProvider.user?.fullName ?? 'Viajante';
    final history = travelerProvider.history;
    final allBags = travelerProvider.bags ?? [];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppDimensions.radiusExtraLarge),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: HomeTravelerAppBarWidget(
              userName: userName,
              hint: 'Pesquise sua viagem...',
            ),
          ),
          Expanded(
            child: history.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhuma viagem passada encontrada.',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  )
                : Center(
                    child: SizedBox(
                      width: 700,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(24),
                        itemCount: history.length,
                        itemBuilder: (context, index) {
                          final trip = history[index];
                          final date = DateFormat('dd/MM/yyyy').format(trip.statusTime);

                          final tripBags = allBags
                              .where((b) => b.tripId == trip.tripId)
                              .toList();

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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                          color: _statusColor(trip.status)
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(12),
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

                                  if (tripBags.isNotEmpty)
                                    const Text(
                                      'Malas associadas:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),

                                  const SizedBox(height: 8),

                                  ...tripBags.map((bag) {
                                    final bagDate = bag.createdAt != null
                                        ? DateFormat('dd/MM/yyyy HH:mm')
                                            .format(bag.createdAt!)
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
