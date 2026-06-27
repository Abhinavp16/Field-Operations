import 'package:flutter/material.dart';

import '../../app/app_colors.dart';
import '../../shared/widgets/data_row_tile.dart';
import '../../shared/widgets/field_panel.dart';
import '../../shared/widgets/field_scaffold.dart';
import '../../shared/widgets/status_chip.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FieldScaffold(
      title: 'Profile & Security',
      subtitle: 'Device and access status',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          FieldPanel(
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.surfaceHighest,
                  child: Icon(Icons.person_outline, color: AppColors.primary),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Operator A. Rao',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Field Team Bravo / Sector 7',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const StatusChip(label: 'Verified'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          FieldPanel(
            child: Column(
              children: const [
                DataRowTile(
                  label: 'Device state',
                  value: 'Managed',
                  icon: Icons.phone_android,
                  valueColor: AppColors.primary,
                ),
                DataRowTile(
                  label: 'Biometric',
                  value: 'Enabled',
                  icon: Icons.fingerprint,
                ),
                DataRowTile(
                  label: 'Local retention',
                  value: 'Minimal',
                  icon: Icons.storage_outlined,
                ),
                DataRowTile(
                  label: 'Audit logging',
                  value: 'Active',
                  icon: Icons.history,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
