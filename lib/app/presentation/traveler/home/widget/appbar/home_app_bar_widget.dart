import 'package:tcc_bag_finder/app/presentation/traveler/home/widget/appbar/home_search_bar_widget.dart';
import 'package:tcc_bag_finder/app/presentation/traveler/home/widget/appbar/home_welcome_user_widget.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:flutter/material.dart';

class HomeTravelerAppBarWidget extends StatelessWidget {
  final String userName;
  final String hint;
  const HomeTravelerAppBarWidget({
    super.key,
    required this.userName,
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
          HomeWelcomeUserWidget(
            userName: userName,
          ),
          const SizedBox(
            height: AppDimensions.verticalSpaceMedium,
          ),
          HomeSearchBarWidget(
            hint: hint,
          ),
        ],
      ),
    );
  }
}
