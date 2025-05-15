import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_icons.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TripHistoryItemWidget extends StatelessWidget {
  final String collaboratorName;
  final TripEntity trip;

  const TripHistoryItemWidget({
    super.key,
    required this.trip,
    required this.collaboratorName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12,
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.2,
            ),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingSmall),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(
                  12,
                ),
                topRight: Radius.circular(
                  12,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIconsSecondary.airPlaneModeIcon,
                Expanded(
                  child: Center(
                    child: Text(
                      trip.id,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.paddingLarge,
              horizontal: AppDimensions.paddingMedium,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(
                        'Nome do colaborador:',
                        collaboratorName,
                        context,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      _buildInfoRow(
                        'Status:',
                        trip.isDone ? 'Finalizada' : 'Em andamento',
                        context,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      _buildInfoRow(
                        'Última atualização:',
                        trip.updatedAt != null
                            ? DateFormat(
                                'dd/MM/yyyy HH:mm',
                              ).format(
                                trip.updatedAt!,
                              )
                            : ' - ',
                        context,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      _buildInfoRow(
                        'Data de criação:',
                        DateFormat(
                          'dd/MM/yyyy HH:mm',
                        ).format(trip.createdAt),
                        context,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label ',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryGrey,
              ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.secondaryGrey,
                ),
          ),
        ),
      ],
    );
  }
}
