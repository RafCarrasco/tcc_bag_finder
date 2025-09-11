import 'package:flutter/material.dart';
import '../../entity/bag_entity.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';

class EditBagDescriptionDialog extends StatelessWidget {
  final BagEntity bag;
  final Future<void> Function(String) onEditConfirmation;
  final VoidCallback onNotArrived;
  final TextEditingController descriptionController = TextEditingController();

  EditBagDescriptionDialog({
    super.key,
    required this.bag,
    required this.onEditConfirmation,
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
                    'Edição da descrição',
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
                TextField(
                  style: TextStyle(
                    color: AppColors.secondaryGrey,
                    fontWeight: FontWeight.bold,
                  ),
                  controller: descriptionController,
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintText: "Atualize a descrição",
                    filled: true,
                    fillColor: Colors.transparent,
                    hintStyle: TextStyle(
                      color: AppColors.secondaryGrey,
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(
                      15,
                    ),
                  ),
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
                    onPressed: () => onEditConfirmation(descriptionController
                        .text), // Passando o texto para a função
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
                      'Confirmar Alteração',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.secondary,
                          ),
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
}
