import 'package:flutter/material.dart';

import '../../app/app_colors.dart';
import '../../shared/widgets/app_background.dart';
import '../../shared/widgets/field_panel.dart';
import '../../shared/widgets/primary_action_button.dart';
import 'org_selection_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePasscode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SizedBox(height: 52),
              const Icon(
                Icons.verified_user_outlined,
                color: AppColors.primary,
                size: 46,
              ),
              const SizedBox(height: 16),
              Text(
                'Field Operations',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Authenticate to access assigned operations, notes, checkpoints, and safety reporting.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 28),
              FieldPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SECURE ACCESS',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Operator ID',
                        prefixIcon: Icon(Icons.badge_outlined),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      obscureText: _obscurePasscode,
                      decoration: InputDecoration(
                        labelText: 'Secure passcode',
                        prefixIcon: const Icon(Icons.key_outlined),
                        suffixIcon: IconButton(
                          onPressed: () => setState(
                            () => _obscurePasscode = !_obscurePasscode,
                          ),
                          icon: Icon(
                            _obscurePasscode
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    PrimaryActionButton(
                      label: 'Authenticate',
                      onPressed: () => Navigator.of(
                        context,
                      ).pushReplacementNamed(OrgSelectionScreen.routeName),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.fingerprint, size: 20),
                          label: const Text('Biometric'),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Request 2FA'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'SYS.VER 0.1.0 - UI MOCK',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0x668C9389),
                  fontSize: 11,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
