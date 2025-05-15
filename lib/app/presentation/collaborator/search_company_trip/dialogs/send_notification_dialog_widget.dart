import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:flutter/material.dart';

class SendNotificationDialogWidget extends StatelessWidget {
  final TripEntity trip;
  final VoidCallback onConfirm;

  const SendNotificationDialogWidget({
    super.key,
    required this.trip,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(
        AppDimensions.paddingSmall,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusLarge,
        ),
      ),
      title: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingMedium,
        ),
        width: double.infinity,
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
        child: const Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning,
              color: Colors.white,
              size: AppDimensions.iconMedium,
            ),
            SizedBox(
              width: AppDimensions.horizontalSpaceSmall,
            ),
            Text(
              'Excluir Colaborador',
              style: TextStyle(
                color: Colors.white,
                fontSize: AppDimensions.fontMedium,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      titlePadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.paddingSmall,
              horizontal: AppDimensions.paddingSmall,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.secondaryGrey, 
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), 
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Tem certeza que deseja excluir: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    fontSize: AppDimensions
                        .fontMedium, 
                  ),
                ),
                Expanded(
                  child: Text(
                    trip.id,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: AppDimensions.fontSmall,
                      color: AppColors.secondaryGrey,
                      fontWeight: FontWeight
                          .bold, 
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(
                    AppDimensions.paddingMedium,
                  ),
                  backgroundColor: AppColors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusSmall,
                    ),
                  ),
                ),
                child: const Text(
                  'Não',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimensions.fontMedium,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(
                    AppDimensions.paddingMedium,
                  ),
                  backgroundColor: AppColors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusSmall,
                    ),
                  ),
                ),
                child: const Text(
                  'Sim',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimensions.fontMedium,
                  ),
                ),
                onPressed: () {
                  onConfirm();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
