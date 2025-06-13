import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../controller/landing_page_step_progess.dart';
import '../utils/app_colors.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final LandingPageStepProgess controller;
  const ProgressIndicatorWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller.pageController,
      count: 3, 
      effect: WormEffect(
        activeDotColor: AppColors.primary,
        dotHeight: 8,
        dotWidth: 50,
        radius: 20,
        spacing: 15,
      ),
    );
  }
}