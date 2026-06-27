import 'package:flutter/material.dart';

import 'app_background.dart';
import 'app_header.dart';

class FieldScaffold extends StatelessWidget {
  const FieldScaffold({
    required this.title,
    required this.child,
    super.key,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Column(
          children: [
            AppHeader(title: title, subtitle: subtitle),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
