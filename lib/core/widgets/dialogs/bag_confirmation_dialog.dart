import 'package:bag_finder/core/entity/bag_status_entity.dart';
import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';

class BagConfirmationDialog extends StatelessWidget {
  final BagStatusEntity bagStatus;
  final VoidCallback onConfirmArrival;
  final VoidCallback onNotArrived;

  const BagConfirmationDialog({
    super.key,
    required this.bagStatus,
    required this.onConfirmArrival,
    required this.onNotArrived,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusLarge,
        ),
      ),
      contentPadding: const EdgeInsets.only(
        bottom: AppDimensions.paddingSmall,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
            child: const Row(
              children: [
                Icon(
                  Icons.luggage,
                  color: Colors.white,
                  size: AppDimensions.iconLarge,
                ),
                SizedBox(
                  width: AppDimensions.horizontalSpaceMedium,
                ),
                Expanded(
                  child: Text(
                    'Confirmação de Entrega',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: AppDimensions.fontMedium,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(
              AppDimensions.paddingMedium,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoRow(
                  'Status:',
                  bagStatus.status,
                ),
                
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: onNotArrived,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.paddingMedium,
                      ),
                      backgroundColor: AppColors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusSmall,
                        ),
                      ),
                    ),
                    child: Text(
                      'Ainda não chegou',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.secondary,
                          ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: AppDimensions.horizontalSpaceMedium,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: onConfirmArrival,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.paddingMedium,
                      ),
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusSmall,
                        ),
                      ),
                    ),
                    child: Text(
                      'Confirmar Entrega',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: AppColors.secondary),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingSmall),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppDimensions.fontMedium,
            ),
          ),
          const SizedBox(width: AppDimensions.horizontalSpaceSmall),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: AppDimensions.fontSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}