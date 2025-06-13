import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import '../../core/navigation/home_admin_bottom_navigation_bar.dart';
import '../../core/provider/admin_provider.dart';
import '../../core/provider/user_provider.dart';
import '../../core/widgets/screen_helper.dart';

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
