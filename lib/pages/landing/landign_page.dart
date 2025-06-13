import 'package:bag_finder/pages/landing/safely_remove_page.dart';
import 'package:bag_finder/pages/landing/track_page.dart';
import 'package:bag_finder/pages/landing/track_your_bag_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../controller/landing_page_step_progess.dart';

class WelcomeLandingPage extends StatelessWidget {
  const WelcomeLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<LandingPageStepProgess>();

    return Scaffold(
      body: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: PageView(
          controller: controller.pageController,
          physics: const ScrollPhysics(
            parent: NeverScrollableScrollPhysics(),
          ),
          scrollDirection: Axis.horizontal,
          children: const [
            TrackYourBagPage(),
            TrackPage(),
            SafelyRemovePage(),
          ],
        ),
      ),
    );
  }
}
