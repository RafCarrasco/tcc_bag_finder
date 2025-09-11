
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';

class AppVersionDialog extends StatelessWidget {
  final String appVersion;

  const AppVersionDialog({
    super.key,
    required this.appVersion,
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
        child: const Center(
          child: Text(
            'Versão do App',
            style: TextStyle(
              color: Colors.white,
              fontSize: AppDimensions.fontMedium,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      titlePadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'A versão atual do aplicativo é:',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 10),
          Text(
            appVersion,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
          ),
          const SizedBox(height: 20),
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(
                AppDimensions.paddingMedium,
              ),
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppDimensions.radiusSmall,
                ),
              ),
            ),
            child: const Text(
              'Fechar',
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
        ],
      ),
    );
  }
}
