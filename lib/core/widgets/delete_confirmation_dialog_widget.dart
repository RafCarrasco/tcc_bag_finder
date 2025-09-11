import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';

class DeleteConfirmationWidgetDialog extends StatelessWidget {
  final String collaboratorName;
  final VoidCallback onConfirm;

  const DeleteConfirmationWidgetDialog({
    super.key,
    required this.collaboratorName,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.only(
        bottom: AppDimensions.paddingSmall,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusLarge,
        ),
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
                  Icons.warning,
                  color: Colors.white,
                  size: AppDimensions.iconMedium,
                ),
                SizedBox(
                  width: AppDimensions.horizontalSpaceSmall,
                ),
                Expanded(
                  child: Text(
                    'Excluir Colaborador',
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
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Tem certeza que deseja excluir $collaboratorName?',
              style: const TextStyle(
                fontSize: AppDimensions.fontMedium,
              ),
            ),
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
