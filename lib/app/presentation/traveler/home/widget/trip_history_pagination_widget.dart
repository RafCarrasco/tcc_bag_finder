import 'package:tcc_bag_finder/app/presentation/traveler/home/widget/trip_history_item_widget.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:flutter/material.dart';

class TripHistoryPaginationWidget extends StatelessWidget {
  final List<TripEntity> trips;
  final String airportOriginCode;
  final String airportDestinationCode;
  final List<String> collaboratorsNames;

  const TripHistoryPaginationWidget({
    super.key,
    required this.trips,
    required this.airportOriginCode,
    required this.airportDestinationCode,
    required this.collaboratorsNames,
  });

  @override
  Widget build(BuildContext context) {
    if (trips.isEmpty) {
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

    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        color: Colors.transparent,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.paddingLarge,
        horizontal: AppDimensions.paddingMedium,
      ),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        final trip = trips[index];
        return TripHistoryItemWidget(
          trip: trip,
          collaboratorName: collaboratorsNames[index],
        );
      },
    );
  }
}
