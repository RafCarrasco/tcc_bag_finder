import 'package:tcc_bag_finder/app/presentation/traveler/home/widget/circular_text_display_widget.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:flutter/material.dart';

class TripHeaderWidget extends StatelessWidget {
  final DateTime date;
  final String tripId;
  final int checkedBags;
  final int bags;
  final String collaboratorName;
  final String airportOrigin;
  final String airportDestination;

  const TripHeaderWidget({
    super.key,
    required this.date,
    required this.tripId,
    required this.airportOrigin,
    required this.airportDestination,
    required this.collaboratorName,
    required this.checkedBags,
    required this.bags,
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
                'Informações Gerais da Viagem:',
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID Viagem:',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                '($tripId)',
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
                'Data Viagem:',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}',
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
                'Colaborador Responsável:',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                collaboratorName,
                overflow: TextOverflow.ellipsis,
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
                'Malas Entregues :',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                width: 4,
              ),
              checkedBags == bags
                  ? Text(
                      'Todos Malas Entregues!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryGrey,
                      ),
                    )
                  : Text(
                      '${checkedBags.toString()}/${bags.toString()}',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryGrey,
                          ),
                    ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularTextDisplay(
                airportCode: airportOrigin,
              ),
              Icon(
                Icons.keyboard_double_arrow_right_outlined,
                color: AppColors.primary,
                size: AppDimensions.iconExtraLarge,
              ),
              CircularTextDisplay(
                airportCode: airportDestination,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
