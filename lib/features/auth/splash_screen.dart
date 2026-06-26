import 'package:flutter/material.dart';

import '../../app/app_colors.dart';
import '../../shared/widgets/app_background.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppBackground(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.explore_outlined, color: AppColors.primary, size: 56),
              SizedBox(height: 18),
              Text(
                'Field Operations',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Secure field activity and audit platform',
                style: TextStyle(color: AppColors.mutedText, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
