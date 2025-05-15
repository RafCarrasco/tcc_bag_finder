import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginLandingPage extends StatefulWidget {
  const LoginLandingPage({
    super.key,
  });

  @override
  State<LoginLandingPage> createState() => _LoginLandingPageState();
}

class _LoginLandingPageState extends State<LoginLandingPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      left: false,
      right: false,
      bottom: false,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            right: AppDimensions.paddingMedium,
            left: AppDimensions.paddingMedium,
            bottom: AppDimensions.paddingMedium,
          ),
          child: SizedBox(
            height: screenHeight, 
            child: const RouterOutlet(),
          ),
        ),
      ),
    );
  }
}
