import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class ReportProblemDialog extends StatefulWidget {
  final Function(
    String,
  ) onConfirm;

  const ReportProblemDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  State<ReportProblemDialog> createState() => _ReportProblemDialogState();
}

class _ReportProblemDialogState extends State<ReportProblemDialog> {
  final TextEditingController _problemController = TextEditingController();

  @override
  void dispose() {
    _problemController.dispose();
    super.dispose();
  }

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
              'Relatar problema',
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
            ),
            child: TextField(
              controller: _problemController,
              maxLines: 5,
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.secondaryGrey,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintStyle: Theme.of(context).textTheme.bodyLarge,
                contentPadding: const EdgeInsets.all(
                  AppDimensions.paddingSmall,
                ),
                hintText: 'Descreva o problema...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusSmall,
                  ),
                  borderSide: BorderSide(
                    color: AppColors.secondaryGrey,
                    width: 1,
                  ),
                ),
              ),
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
                  'Voltar',
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
                  'Confirmar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimensions.fontMedium,
                  ),
                ),
                onPressed: () {
                  final String problemDescription = _problemController.text;
                  widget.onConfirm(problemDescription);
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
