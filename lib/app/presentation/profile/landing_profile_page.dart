import 'package:tcc_bag_finder/app/shared/screen_helper.dart';
import 'package:tcc_bag_finder/app/presentation/user/stores/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

class LandingProfilePage extends StatefulWidget {
  const LandingProfilePage({
    super.key,
  });

  @override
  State<LandingProfilePage> createState() => _LandingProfilePageState();
}

class _LandingProfilePageState extends State<LandingProfilePage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = ScreenHelper(context).heightPercentage(100);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (_) => Modular.get<UserProvider>(),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          left: false,
          right: false,
          bottom: false,
          child: SingleChildScrollView(
            child: SizedBox(
              height: screenHeight,
              child: const RouterOutlet(),
            ),
          ),
        ),
      ),
    );
  }
}
