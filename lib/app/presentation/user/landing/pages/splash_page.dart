import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(
        milliseconds: 3500,
      ),
      () {
        Modular.to.navigate(
          '/welcome',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Center(
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
                fontSize: 48,
              ),
          child: AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText(
                "Bag Finder",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
