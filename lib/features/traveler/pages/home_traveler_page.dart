import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import '../../../shared/providers/traveler_provider.dart';
import '../../../shared/providers/user_provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/trip/trip_list_widget.dart';

class HomeTravelerPage extends StatefulWidget {
  final String travelerId;

  const HomeTravelerPage({
    super.key,
    required this.travelerId,
  });

  @override
  State<HomeTravelerPage> createState() => _HomeTravelerPageState();
}

class _HomeTravelerPageState extends State<HomeTravelerPage> {
  final travelerProvider = Modular.get<TravelerProvider>();
  final userProvider = Modular.get<UserProvider>();

  String? collaboratorName;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await travelerProvider.getTripsByStatus(
        travelerId: widget.travelerId,
        isDone: false,
      );

      if (travelerProvider.currentTrip == null) {
        setState(() => isLoading = false);
        return;
      }

      final collaborator = await userProvider.getUser(
        userId: travelerProvider.currentTrip!.responsibleCollaboratorId,
      );

      setState(() {
        collaboratorName = collaborator?.fullName;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final user = userProvider.user;

    return Scaffold(
      body: Column(
        children: [
          /// Header verde reto
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            width: double.infinity,
            color: AppColors.primary,
            child: Row(
              children: [
                /// Avatar (ícone de mala)
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.luggage,
                    size: 32,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),

                /// Saudação com nome destacado
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      children: [
                        const TextSpan(text: "Olá, "),
                        TextSpan(
                          text: user?.fullName.isNotEmpty == true
                              ? user!.fullName
                              : "Viajante",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const TextSpan(text: "!"),
                      ],
                    ),
                  ),
                ),

                /// Ícone de notificação
                IconButton(
                  onPressed: () {
                    // Exemplo: abrir notificações
                  },
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),

          /// Conteúdo branco com cantos arredondados em cima
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Consumer<TravelerProvider>(
                builder: (context, travelerProvider, _) {
                  if (travelerProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (travelerProvider.currentTrip == null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.warning,
                              color: AppColors.primary, size: 50),
                          const SizedBox(height: 8),
                          Text(
                            'Nenhuma viagem iniciada!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return TripListWidget(
                    travelerId: widget.travelerId,
                    bags: travelerProvider.bags ?? [],
                    collaboratorName: collaboratorName ?? "",
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
