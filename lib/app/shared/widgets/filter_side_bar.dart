import 'package:tcc_bag_finder/app/shared/objects/filter_option_object.dart';
import 'package:tcc_bag_finder/app/shared/screen_helper.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:flutter/material.dart';

class FilterSidebar extends StatelessWidget {
  final List<FilterOption> options;

  const FilterSidebar({super.key, required this.options});

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color iconColor = Colors.white,
  }) {
    return ListTile(
      onTap: onTap,
      
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
        vertical: AppDimensions.paddingSmall,
      ),
      leading: Container(
        padding: const EdgeInsets.all(
          10.0,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: AppDimensions.iconMedium,
        ),
      ),
      title: Text(
        label,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
      ),
      hoverColor: AppColors.primary.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: ScreenHelper(context).widthPercentage(
            40,
          ),
          height: 5,
          margin: const EdgeInsets.only(
            bottom: AppDimensions.paddingSmall,
            top: AppDimensions.paddingSmall,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(
              2,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: options.map((option) {
            return _buildListTile(
              context,
              icon: option.icon,
              label: option.label,
              onTap: option.onTap,
              iconColor: option.iconColor ?? Colors.white,
            );
          }).toList(),
        ),
      ],
    );
  }
}
