import 'package:tcc_bag_finder/app/presentation/collaborator/init_user_trip/controller/init_user_trip_dropdown_controller.dart';
import 'package:tcc_bag_finder/app/presentation/collaborator/stores/collaborator_provider.dart';
import 'package:tcc_bag_finder/app/presentation/user/auth/mixins/user_validation_mixin.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_icons.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_text_styles.dart';
import 'package:tcc_bag_finder/domain/entity/traveler_entity.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class InitUserTripDropdownField extends StatefulWidget {
  final String hintText;
  final String fieldType;
  final bool isRequired;
  final void Function(TravelerEntity?)? onChanged;

  const InitUserTripDropdownField({
    super.key,
    required this.hintText,
    required this.fieldType,
    required this.isRequired,
    this.onChanged,
  });

  @override
  State<InitUserTripDropdownField> createState() =>
      _InitUserTripDropdownFieldState();
}

class _InitUserTripDropdownFieldState extends State<InitUserTripDropdownField>
    with ValidationMixin {
  final CollaboratorProvider _collaboratorProvider =
      Modular.get<CollaboratorProvider>();
  final InitUserTripDropdownController _controller =
      Modular.get<InitUserTripDropdownController>();
  final TextEditingController textEditingController = TextEditingController();

  List<TravelerEntity> items = [];
  TravelerEntity? selectedValue;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadTravelers();
  }

  Future<void> _loadTravelers() async {
    final travelers = await _collaboratorProvider.getAllTravelers();
    setState(() {
      items = travelers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppDimensions.paddingSmall,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField2<TravelerEntity>(
          hint: Text(
            widget.hintText,
            textAlign: TextAlign.left,
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.secondaryGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
          validator: (value) {
            final error = validateField(
              value.toString(),
              widget.hintText,
              widget.fieldType,
              widget.isRequired,
            );
            setState(() {
              errorMessage = error;
            });

            return error;
          },
          decoration: InputDecoration(
            hintText: widget.hintText,
            fillColor: AppColors.primary.withOpacity(
              0.3,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium,
              vertical: AppDimensions.paddingLarge,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall * 0.5,
              ),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall * 0.5,
              ),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall * 0.5,
              ),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall * 0.5,
              ),
              borderSide: BorderSide.none,
            ),
            filled: true,
            hintStyle: TextStyle(
              color: AppColors.secondaryGrey,
              fontSize: AppDimensions.fontMedium,
              fontWeight: FontWeight.bold,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingSmall,
              ),
              child: AppIconsSecondaryGrey.personIcon,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: AppDimensions.iconMedium,
              minHeight: AppDimensions.iconMedium,
            ),
          ),
          items: items
              .map(
                (
                  item,
                ) =>
                    DropdownMenuItem<TravelerEntity>(
                  value: item,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AppIconsSecondaryGrey.personIcon,
                      Text(
                        item.fullName,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppColors.secondaryGrey,
                                  fontSize: AppDimensions.fontMedium,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
          value: _controller.value,
          onChanged: (TravelerEntity? value) {
            setState(
              () {
                _controller.onChange(
                  value,
                );
                widget.onChanged?.call(value);
              },
            );
          },
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall * 0.5,
              ),
              color: AppColors.secondary,
            ),
          ),
          menuItemStyleData: MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.zero,
            overlayColor: WidgetStatePropertyAll(
              AppColors.secondary,
            ),
          ),
          dropdownSearchData: DropdownSearchData(
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingSmall,
                vertical: AppDimensions.paddingSmall * 0.5,
              ),
              child: TextFormField(
                expands: false,
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.secondaryGrey,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  fillColor: AppColors.primary.withOpacity(
                    0.3,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingMedium,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusSmall * 0.5,
                    ),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  hintStyle: TextStyle(
                    color: AppColors.secondaryGrey,
                    fontSize: AppDimensions.fontMedium,
                    fontWeight: FontWeight.bold,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingSmall,
                    ),
                    child: AppIconsPrimary.searchIcon,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: AppDimensions.iconMedium,
                    minHeight: AppDimensions.iconMedium,
                  ),
                ),
              ),
            ),
          ),
          onMenuStateChange: (isOpen) {
            if (!isOpen) {}
          },
        ),
      ),
    );
  }
}
