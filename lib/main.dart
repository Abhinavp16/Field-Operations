import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app_state.dart';
import 'app/field_ops_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  final state = FieldOpsState(preferences: preferences);
  await state.restore();
  runApp(FieldOpsApp(state: state));
}
