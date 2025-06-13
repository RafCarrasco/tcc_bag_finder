import 'package:bag_finder/core/enums/bag_status_enum.dart';
import 'package:flutter/material.dart';
import '../../entity/bag_entity.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';

class BagConfirmationDialog extends StatelessWidget {
  final BagEntity bag;
  final VoidCallback onConfirmArrival;
  final VoidCallback onNotArrived;

  const BagConfirmationDialog({
    super.key,
    required this.bag,
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
                  bag.status.toLiteral(),
                ),
                _buildInfoRow(
                  'Descrição:',
                  bag.description == null ? 'Sem descrição' : bag.description!,
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
