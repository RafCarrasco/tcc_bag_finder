import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import '../../core/provider/collaborator_provider.dart';
import '../../core/provider/user_provider.dart';
import '../../core/widgets/home_collaborator_bottom_navigation.dart';
import '../../core/widgets/screen_helper.dart';


class LandingCollaboratorPage extends StatefulWidget {
  final String collaboratorId;
  const LandingCollaboratorPage({
    super.key,
    required this.collaboratorId,
  });

  @override
  State<LandingCollaboratorPage> createState() =>
      _LandingCollaboratorPageState();
}

class _LandingCollaboratorPageState extends State<LandingCollaboratorPage> {
  int _selectedIndex = 0;

  void _onItemTapped(
    int index,
  ) {
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
        ChangeNotifierProvider<CollaboratorProvider>.value(
          value: Modular.get<CollaboratorProvider>(),
        )
      ],
      child: Scaffold(
        bottomNavigationBar: HomeCollaboratorBottomNavigation(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
          collaboratorId: widget.collaboratorId,
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
