import 'package:tcc_bag_finder/app/presentation/traveler/home/widget/appbar/home_app_bar_widget.dart';
import 'package:tcc_bag_finder/app/presentation/traveler/home/widget/trip_history_list_widget.dart';
import 'package:tcc_bag_finder/app/presentation/traveler/stores/traveler_provider.dart';
import 'package:tcc_bag_finder/app/presentation/user/stores/user_provider.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

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
  var provider = Modular.get<UserProvider>();
  late List<String> collaboratorsNames;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await travelerProvider.getTripsByStatus(
      travelerId: widget.travelerId,
      isDone: true,
    );

    final ids = travelerProvider.trips!
        .map(
          (trip) => trip.responsibleCollaboratorId,
        )
        .toList();

    final names = await provider.getAllUsersNamesByIds(
      ids: ids,
    );

    setState(() {
      collaboratorsNames = names;
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
            hint: 'Procure sua viagem...',
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
              return TripHistoryListPage(
                travelerId: widget.travelerId,
                trips: travelerProvider.trips ?? [],
                collaboratorsNames: collaboratorsNames,
              );
            },
          ),
        ),
      ],
    );
  }
}
