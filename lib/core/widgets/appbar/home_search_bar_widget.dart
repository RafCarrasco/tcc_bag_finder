import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';
import 'home_search_field_widget.dart';

class HomeSearchBarWidget extends StatelessWidget {
  final String hint;
  final void Function(String)? onChanged;
  final VoidCallback? onFilterTap;

  const HomeSearchBarWidget({
    super.key,
    required this.hint,
    this.onChanged,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: HomeSearchFieldWidget(
            hint: hint,
            onChanged: onChanged,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.filter_list,
            size: AppDimensions.iconLarge,
            color: AppColors.secondary,
          ),
          onPressed: onFilterTap,
        ),
      ],
    );
  }
}
