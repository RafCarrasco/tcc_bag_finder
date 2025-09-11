import 'package:flutter/material.dart';
import '../../entity/collaborator_entity.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';
import '../../utils/app_text_styles.dart';
import '../profile_banner_widget.dart';

class EditCollaboratorDialog extends StatefulWidget {
  final CollaboratorEntity collaborator;
  final ValueChanged<CollaboratorEntity> onSave;

  const EditCollaboratorDialog({
    super.key,
    required this.collaborator,
    required this.onSave,
  });

  @override
  State<EditCollaboratorDialog> createState() => _EditCollaboratorDialogState();
}

class _EditCollaboratorDialogState extends State<EditCollaboratorDialog> {
  late TextEditingController _emailController;
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.collaborator.email);
    _isActive = widget.collaborator.isActive;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusLarge,
        ),
      ),
      contentPadding: EdgeInsets.zero,
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
                  name: widget.collaborator.fullName,
                  isLarge: false,
                ),
                const SizedBox(
                  width: AppDimensions.horizontalSpaceMedium,
                ),
                Expanded(
                  child: Text(
                    widget.collaborator.fullName,
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
              children: [
                const Text(
                  'Email:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimensions.fontMedium,
                  ),
                ),
                const SizedBox(
                  height: AppDimensions.verticalSpaceSmall,
                ),
                TextFormField(
                  controller: _emailController,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.secondaryGrey,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingSmall,
                      vertical: AppDimensions.paddingLarge,
                    ),
                    fillColor: AppColors.textFieldBackground,
                    filled: true,
                    border: const OutlineInputBorder(),
                    hintStyle: TextStyle(
                      color: AppColors.secondaryGrey,
                      fontSize: AppDimensions.fontMedium,
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: AppColors.primary,
                    ),
                    prefixIconColor: AppColors.secondaryGrey,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusMedium,
                      ),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusMedium,
                      ),
                      borderSide: BorderSide.none,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusMedium,
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: AppDimensions.verticalSpaceLarge,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Status:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppDimensions.fontMedium,
                      ),
                    ),
                    Switch(
                      value: _isActive,
                      activeColor: AppColors.primary,
                      inactiveThumbColor: AppColors.red,
                      inactiveTrackColor: AppColors.red.withOpacity(
                        0.5,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _isActive = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(
                8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  TextButton(
                    onPressed: () {
                      final updatedCollaborator = widget.collaborator.copyWith(
                        email: _emailController.text,
                        isActive: _isActive,
                      );
                      widget.onSave(updatedCollaborator);
                      Navigator.of(context).pop();
                    },
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
                      'Salvar',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
