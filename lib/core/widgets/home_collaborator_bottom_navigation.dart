import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';
import '../utils/app_icons.dart';

class HomeCollaboratorBottomNavigation extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final String collaboratorId;

  const HomeCollaboratorBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.collaboratorId,
  });

  @override
  State<HomeCollaboratorBottomNavigation> createState() =>
      _HomeCollaboratorBottomNavigationState();
}

class _HomeCollaboratorBottomNavigationState
    extends State<HomeCollaboratorBottomNavigation> {
  bool isExpanded = false;

  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void _navigateTo(int index) {
    widget.onItemTapped(
      index,
    );

    switch (index) {
      case 0:
        Modular.to.navigate(
          '/collaborator/${widget.collaboratorId}/home',
        );
        break;
      case 1:
        Modular.to.navigate(
          '/collaborator/${widget.collaboratorId}/init-user-trip',
        );
        break;
      case 2:
        Modular.to.navigate(
          '/collaborator/${widget.collaboratorId}/search-company-trips',
        );
        break;
      case 3:
        Modular.to.pushNamed(
          '/profile/${widget.collaboratorId}',
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
              icon: AppIconsSecondary.homeIcon,
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
              icon: AppIconsSecondary.contentPasteIcon,
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
              icon: AppIconsSecondary.airPlaneModeIcon,
              iconSize: AppDimensions.iconExtraLarge,
              color: widget.selectedIndex == 2
                  ? AppColors.primary
                  : AppColors.secondaryGrey,
              onPressed: () => _navigateTo(
                2,
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              icon: AppIconsSecondary.personIcon,
              iconSize: AppDimensions.iconExtraLarge,
              color: widget.selectedIndex == 3
                  ? AppColors.primary
                  : AppColors.secondaryGrey,
              onPressed: () => _navigateTo(
                3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
