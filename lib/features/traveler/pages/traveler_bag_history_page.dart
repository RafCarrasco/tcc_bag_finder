import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import '../../../shared/providers/traveler_provider.dart';
import '../../../shared/providers/user_provider.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../core/widgets/appbar/history_app_bar_widget.dart';
import '../../../core/widgets/trip_widget_card.dart';

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
  final userProvider = Modular.get<UserProvider>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final travelerProvider = Modular.get<TravelerProvider>();
    await travelerProvider.getTravelerHistory(widget.travelerId);
    if (mounted) setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final userName = userProvider.user?.fullName ?? 'Viajante';

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(AppDimensions.radiusExtraLarge),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: HomeHistoryTravelerAppBarWidget(
              userId: userProvider.user?.id ?? '',
              userName: userName,
              hint: 'Pesquise sua viagem...',
            ),
          ),
          Expanded(
            child: Consumer<TravelerProvider>(
              builder: (context, travelerProvider, _) {
                final history = travelerProvider.history;
                final isLoadingProvider = travelerProvider.isLoading;
                if (isLoading || isLoadingProvider) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (history.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhuma viagem passada encontrada.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }
                return Center(
                  child: SizedBox(
                    width: 700,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(24),
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        final trip = history[index];
                        return TripCardWidget(trip: trip);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
