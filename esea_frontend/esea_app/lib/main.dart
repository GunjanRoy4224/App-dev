import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'screens/auth/login_sso_screen.dart';
import 'screens/home/app_shell.dart';

void main() {
  runApp(const EseaApp());
}

class EseaApp extends StatelessWidget {
  const EseaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ESEA Portal',
        home: const AppEntry(),
      ),
    );
  }
}

/// ENTRY POINT (IMPORTANT)
class AppEntry extends StatelessWidget {
  const AppEntry({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    if (auth.isLoading) {
      return const LoginSSOScreen();
    }

    if (!auth.isAuthenticated) {
      return const LoginSSOScreen(); // your existing SSO flow
    }

    return const AppShell();
  }
}
