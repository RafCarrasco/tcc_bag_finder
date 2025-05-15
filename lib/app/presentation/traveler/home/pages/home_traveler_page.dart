import 'package:tcc_bag_finder/app/presentation/traveler/home/widget/appbar/home_app_bar_widget.dart';
import 'package:tcc_bag_finder/app/presentation/traveler/home/widget/trip_list_widget.dart';
import 'package:tcc_bag_finder/app/presentation/traveler/stores/traveler_provider.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/app/presentation/user/stores/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

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
  var provider = Modular.get<UserProvider>();
  late String? collaboratorName;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await travelerProvider.getTripsByStatus(
      travelerId: widget.travelerId,
      isDone: false,
    );

    if (travelerProvider.currentTrip == null) {
      setState(() {
        isLoading = false;
      });

      return;
    }

    final collaborator = await provider.getUser(
      userId: travelerProvider.currentTrip!.responsibleCollaboratorId,
    );

    setState(() {
      collaboratorName = collaborator?.fullName;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
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
            userName: provider.user!.fullName,
            hint: 'Procure sua bagagem...',
          ),
        ),
        Expanded(
          child: Consumer<TravelerProvider>(
            builder: (context, travelerProvider, _) {
              if (travelerProvider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (travelerProvider.currentTrip == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.warning,
                        color: AppColors.primary,
                        size: 50,
                      ),
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

              if (travelerProvider.currentTrip != null) {
                return TripListWidget(
                  travelerId: widget.travelerId,
                  bags: travelerProvider.bags ?? [],
                  collaboratorName: collaboratorName ?? "",
                );
              }

              return Container();
            },
          ),
        ),
      ],
    );
  }
}
