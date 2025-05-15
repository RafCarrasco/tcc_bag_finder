import 'package:tcc_bag_finder/app/shared/screen_helper.dart';
import 'package:flutter/material.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/entity/collaborator_entity.dart';

class CollaboratorTripsDetailsDialog extends StatelessWidget {
  final List<TripEntity> trips;
  final CollaboratorEntity collaborator;

  const CollaboratorTripsDetailsDialog({
    super.key,
    required this.collaborator,
    required this.trips,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusLarge,
        ),
      ),
      contentPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.all(
        AppDimensions.paddingMedium,
      ),
      content: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(
              AppDimensions.paddingMedium,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(
                  AppDimensions.radiusLarge,
                ),
                topRight: Radius.circular(
                  AppDimensions.radiusLarge,
                ),
              ),
            ),
            child: Text(
              collaborator.fullName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: AppDimensions.fontMedium,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          trips.isEmpty
              ? Expanded(
                  child: Center(
                    child: Text(
                      'Nenhuma viagem encontrada.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                )
              : Expanded(
                  child: SizedBox(
                    height: ScreenHelper(context).heightPercentage(50),
                    width: ScreenHelper(context).widthPercentage(100),
                    child: ListView.separated(
                      itemCount: trips.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final trip = trips[index];

                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Destino: ${trip.description.airportDestination}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: AppDimensions.paddingSmall),
                            Text(
                              'Data de Partida: ${trip.createdAt.day}/${trip.createdAt.month}/${trip.createdAt.year}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: AppDimensions.paddingSmall),
                            Text(
                              'Passageiro: ${trip.travelerEntity.fullName}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
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
