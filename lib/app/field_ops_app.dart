import 'package:flutter/material.dart';

import '../features/auth/login_screen.dart';
import '../features/auth/org_selection_screen.dart';
import '../features/auth/splash_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import 'app_theme.dart';

class FieldOpsApp extends StatelessWidget {
  const FieldOpsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Field Operations',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        OrgSelectionScreen.routeName: (_) => const OrgSelectionScreen(),
        DashboardScreen.routeName: (_) => const DashboardScreen(),
      },
    );
  }
}
