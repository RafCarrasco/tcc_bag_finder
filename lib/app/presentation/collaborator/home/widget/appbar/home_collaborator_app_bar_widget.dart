import 'package:tcc_bag_finder/app/presentation/collaborator/home/widget/appbar/home_welcome_collaborator_widget.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:flutter/material.dart';

class HomeCollaboratorAppBarWidget extends StatelessWidget {
  final String userName;
  final String company;
  const HomeCollaboratorAppBarWidget({
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
          HomeWelcomeCollaboratorWidget(
            userName: userName,
            companyName: company,
          ),
        ],
      ),
    );
  }
}
