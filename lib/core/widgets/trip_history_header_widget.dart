import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';

class TripHistoryHeaderWidget extends StatelessWidget {
  final int tripsCount;
  final int activeTripsCount;

  const TripHistoryHeaderWidget({
    super.key,
    required this.tripsCount,
    required this.activeTripsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: AppDimensions.paddingSmall,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingSmall,
        vertical: AppDimensions.paddingMedium,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(
          0.9,
        ),
        borderRadius: BorderRadius.circular(
          16,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.2,
            ),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Histórico de Viagens:',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              )
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Text(
                'Viagens Realizadas:',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                '$tripsCount',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryGrey,
                    ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Viagens Ativas:',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                '$activeTripsCount',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryGrey,
                    ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Viagens Concluidas:',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                '${tripsCount - activeTripsCount}',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryGrey,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
