import 'package:flutter/material.dart';
import 'home_screen.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent app exit from root
        return false;
      },
      child: const HomeScreen(),
    );
  }
}
