import 'package:bag_finder/core/widgets/trip_widget_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
    if (mounted) setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final userName = userProvider.user?.fullName ?? 'Viajante';
    final history = travelerProvider.history;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          // 🔹 AppBar customizada
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
            child: HomeTravelerAppBarWidget(
              userName: userName,
              hint: 'Pesquise sua viagem...',
            ),
          ),

          // 🔹 Conteúdo
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : history.isEmpty
                    ? const Center(
                        child: Text(
                          'Nenhuma viagem passada encontrada.',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      )
                    : Center(
                        child: SizedBox(
                          width: 700, // centraliza em telas grandes
                          child: ListView.builder(
                            padding: const EdgeInsets.all(24),
                            itemCount: history.length,
                            itemBuilder: (context, index) {
                              final trip = history[index];
                              return TripCardWidget(trip: trip);
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
