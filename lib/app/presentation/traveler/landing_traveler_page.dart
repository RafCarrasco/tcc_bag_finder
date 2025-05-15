import 'package:tcc_bag_finder/app/presentation/traveler/home/widget/home_traveler_bottom_navigation_widget.dart';
import 'package:tcc_bag_finder/app/presentation/traveler/stores/traveler_provider.dart';
import 'package:tcc_bag_finder/app/shared/screen_helper.dart';
import 'package:tcc_bag_finder/app/presentation/user/stores/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

class LandingTravelerPage extends StatefulWidget {
  final String travelerId;
  const LandingTravelerPage({
    super.key,
    required this.travelerId,
  });

  @override
  State<LandingTravelerPage> createState() => _LandingTravelerPageState();
}

class _LandingTravelerPageState extends State<LandingTravelerPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = ScreenHelper(context).heightPercentage(100);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>.value(
          value: Modular.get<UserProvider>(),
        ),
        ChangeNotifierProvider<TravelerProvider>.value(
          value: Modular.get<TravelerProvider>(),
        )
      ],
      child: Scaffold(
        bottomNavigationBar: HomeTravelerBottomNavigation(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
          travelerId: widget.travelerId,
        ),
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
