import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';
import '../utils/app_icons.dart';

class HomeTravelerBottomNavigation extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final String travelerId;

  const HomeTravelerBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.travelerId,
  });

  @override
  State<HomeTravelerBottomNavigation> createState() =>
      _HomeTravelerBottomNavigationState();
}

class _HomeTravelerBottomNavigationState
    extends State<HomeTravelerBottomNavigation> {
  bool isExpanded = false;

  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void _navigateTo(int index) {
    widget.onItemTapped(index);

    switch (index) {
      case 0:
        Modular.to.pushNamed(
          '/traveler/${widget.travelerId}/home',
        );
        break;
      case 1:
        Modular.to.pushNamed(
          '/traveler/${widget.travelerId}/history-panel',
        );
        break;
      case 2:
        Modular.to.pushNamed(
          '/profile/${widget.travelerId}',
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingExtraLarge * 2,
        vertical: AppDimensions.paddingSmall,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingSmall,
        ),
        decoration: BoxDecoration(
          color: AppColors.secondaryGrey,
          borderRadius: BorderRadius.circular(
            AppDimensions.radiusMedium,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              icon: widget.selectedIndex == 0
                  ? AppIconsSecondary.homeIcon
                  : AppIconsSecondaryGrey.homeIcon,
              iconSize: AppDimensions.iconExtraLarge,
              color: widget.selectedIndex == 0
                  ? AppColors.primary
                  : AppColors.secondaryGrey,
              onPressed: () => _navigateTo(
                0,
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              icon: widget.selectedIndex == 1
                  ? AppIconsSecondary.historyIcon
                  : AppIconsSecondaryGrey.historyIcon,
              iconSize: AppDimensions.iconExtraLarge,
              color: widget.selectedIndex == 1
                  ? AppColors.primary
                  : AppColors.secondaryGrey,
              onPressed: () => _navigateTo(
                1,
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              icon: widget.selectedIndex == 2
                  ? AppIconsSecondary.personIcon
                  : AppIconsSecondaryGrey.personIcon,
              iconSize: AppDimensions.iconExtraLarge,
              color: widget.selectedIndex == 2
                  ? AppColors.primary
                  : AppColors.secondaryGrey,
              onPressed: () => _navigateTo(
                2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
