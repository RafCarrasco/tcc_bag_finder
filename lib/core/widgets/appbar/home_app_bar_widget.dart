import 'package:bag_finder/shared/providers/bag_status_provider.dart';
import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';
import 'home_welcome_user_widget.dart';
import 'trip_history_panel_search_bar_widget.dart';

class HomeTravelerAppBarWidget extends StatelessWidget {
  final String userName;
  final String userId;
  final String hint;
  const HomeTravelerAppBarWidget({
    super.key,
    required this.userName,
    required this.userId,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: const EdgeInsets.only(
        top: AppDimensions.paddingMedium,
        left: AppDimensions.paddingSmall,
        right: AppDimensions.paddingSmall,
        bottom: AppDimensions.paddingSmall,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/logo_appbar.png',
            height: 50,
            filterQuality: FilterQuality.high,
          ),
          HomeWelcomeUserWidget(
            userName: userName,
          ),       
          const SizedBox(
            height: AppDimensions.verticalSpaceMedium,
          ),
          TripHistoryPanelSearchBarWidget(
            travelerId: userId,
            hint: hint,
          ),
        ],
      ),
    );
  }
}
