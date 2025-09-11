import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';
import 'home_welcome_admin_widget.dart';

class HomeAdminAppBarWidget extends StatelessWidget {
  final String userName;
  final String company;
  const HomeAdminAppBarWidget({
    super.key,
    required this.userName,
    required this.company,
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
          HomeWelcomeAdminWidget(
            userName: userName,
            companyName: company,
          ),
        ],
      ),
    );
  }
}
