import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginLandingPage extends StatefulWidget {
  const LoginLandingPage({super.key});

  @override
  State<LoginLandingPage> createState() => _LoginLandingPageState();
}

class _LoginLandingPageState extends State<LoginLandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: const RouterOutlet(),
        ),
      ),
    );
  }
}
