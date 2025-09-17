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
  final provider = Modular.get<UserProvider>();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await travelerProvider.getTravelerHistory(widget.travelerId);
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
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
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final userName = provider.user?.fullName ?? 'Viajante';
    final history = travelerProvider.history;

    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              AppDimensions.radiusExtraLarge,
            ),
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
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final trip = history[index];
                    final date =
                        DateFormat('dd/MM/yyyy').format(trip.statusTime);

                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${trip.origin} → ${trip.destination}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Data: $date',
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Status: ${_mapStatus(trip.lastStatus)}',
                              style: TextStyle(
                                fontSize: 14,
                                color: _statusColor(trip.lastStatus),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
