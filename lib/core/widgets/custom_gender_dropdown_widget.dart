import 'package:flutter/material.dart';

import '../enums/user_gender_enum.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';

class GenderDropdown extends StatefulWidget {
  final UserGenderEnum? initialValue;
  final Function(UserGenderEnum?) onChanged;
  final Icon prefixIcon;

  const GenderDropdown({
    super.key,
    this.initialValue,
    required this.onChanged,
    required this.prefixIcon,
  });

  @override
  State<GenderDropdown> createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  UserGenderEnum? _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppDimensions.paddingSmall,
      ),
      child: DropdownButtonFormField<UserGenderEnum>(
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          floatingLabelStyle: TextStyle(
            color: AppColors.secondaryGrey,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          hintStyle: TextStyle(
            color: AppColors.secondaryGrey,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          labelText: 'Gênero',
          fillColor: AppColors.primary.withOpacity(
            0.3,
          ),
          isCollapsed: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingSmall,
            ),
            child: widget.prefixIcon,
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 24,
            minHeight: 24,
          ),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
            vertical: AppDimensions.paddingLarge,
          ),
        ),
        value: _selectedGender,
        items: UserGenderEnum.values.map((gender) {
          return DropdownMenuItem<UserGenderEnum>(
            alignment: Alignment.center,
            value: gender,
            child: Text(
              gender.name,
            ),
          );
        }).toList(),
        onChanged: (UserGenderEnum? newValue) {
          setState(() {
            _selectedGender = newValue;
          });
          widget.onChanged(
            newValue,
          );
        },
      ),
    );
  }
}
