import 'package:tcc_bag_finder/app/presentation/admin/stores/admin_provider.dart';
import 'package:tcc_bag_finder/app/shared/screen_helper.dart';
import 'package:tcc_bag_finder/app/presentation/user/stores/user_provider.dart';
import 'package:tcc_bag_finder/app/presentation/admin/home/widget/home_admin_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

class LandingAdminPage extends StatefulWidget {
  final String adminId;
  const LandingAdminPage({
    super.key,
    required this.adminId,
  });

  @override
  State<LandingAdminPage> createState() => _LandingAdminPageState();
}

class _LandingAdminPageState extends State<LandingAdminPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = ScreenHelper(context).heightPercentage(
      100,
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>.value(
          value: Modular.get<UserProvider>(),
        ),
        ChangeNotifierProvider<AdminProvider>.value(
          value: Modular.get<AdminProvider>(),
        )
      ],
      child: Scaffold(
        bottomNavigationBar: HomeAdminBottomNavigation(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
          adminId: widget.adminId,
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
