import 'package:flutter/material.dart';

import '../../entity/collaborator_entity.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';
import '../profile_banner_widget.dart';


class CollaboratorDetailsDialog extends StatelessWidget {
  final CollaboratorEntity collaborator;

  const CollaboratorDetailsDialog({
    super.key,
    required this.collaborator,
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
            child: Row(
              children: [
                UserAvatarWidget(
                  name: collaborator.fullName,
                  isLarge: false,
                ),
                const SizedBox(
                  width: AppDimensions.horizontalSpaceMedium,
                ),
                Expanded(
                  child: Text(
                    collaborator.fullName,
                    style: const TextStyle(
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
                  'Email:',
                  collaborator.email,
                ),
                _buildInfoRow(
                  'ID:',
                  collaborator.id,
                ),
                _buildInfoRow(
                  'Status:',
                  collaborator.isActive ? 'Ativo' : 'Inativo',
                  icon: Icon(
                    Icons.circle,
                    color:
                        collaborator.isActive ? AppColors.green : AppColors.red,
                    size: AppDimensions.iconSmall,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
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
                  'Fechar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimensions.fontMedium,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Widget? icon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppDimensions.fontMedium,
          ),
        ),
        const SizedBox(
          width: AppDimensions.horizontalSpaceSmall,
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: AppDimensions.fontSmall,
            ),
          ),
        ),
        if (icon != null) icon,
      ],
    );
  }
}
