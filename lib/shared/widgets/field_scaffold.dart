import 'package:flutter/material.dart';

import 'app_background.dart';
import 'app_header.dart';

class FieldScaffold extends StatelessWidget {
  const FieldScaffold({
    required this.title,
    required this.child,
    super.key,
    this.subtitle,
    this.embedded = false,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final bool embedded;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    if (embedded) return child;

    return Scaffold(
      body: AppBackground(
        child: Column(
          children: [
            AppHeader(
              title: title,
              subtitle: subtitle,
              showBack: Navigator.of(context).canPop(),
              trailing: trailing,
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
