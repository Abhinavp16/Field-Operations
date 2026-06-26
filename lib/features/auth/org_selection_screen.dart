import 'package:flutter/material.dart';

import '../../app/app_colors.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../shared/widgets/app_background.dart';
import '../../shared/widgets/app_header.dart';
import '../../shared/widgets/field_panel.dart';
import '../../shared/widgets/primary_action_button.dart';
import '../../shared/widgets/status_chip.dart';

class OrgSelectionScreen extends StatefulWidget {
  const OrgSelectionScreen({super.key});

  static const routeName = '/organization';

  @override
  State<OrgSelectionScreen> createState() => _OrgSelectionScreenState();
}

class _OrgSelectionScreenState extends State<OrgSelectionScreen> {
  String _region = 'North Region';
  String _sector = 'Sector 7';
  String _unit = 'Field Team Bravo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Column(
          children: [
            const AppHeader(
              title: 'Field Operations',
              subtitle: 'Deployment configuration',
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                children: [
                  FieldPanel(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'ACCESS SCOPE',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            const Spacer(),
                            const StatusChip(label: 'Mock session'),
                          ],
                        ),
                        const SizedBox(height: 18),
                        _SelectionRow(
                          icon: Icons.business_outlined,
                          label: 'Organization',
                          value: 'Afora Field Operations',
                          locked: true,
                        ),
                        const SizedBox(height: 12),
                        _ChoiceRow(
                          icon: Icons.public,
                          label: 'Region',
                          value: _region,
                          values: const [
                            'North Region',
                            'East Region',
                            'West Region',
                          ],
                          onChanged: (value) => setState(() => _region = value),
                        ),
                        const SizedBox(height: 12),
                        _ChoiceRow(
                          icon: Icons.map_outlined,
                          label: 'Sector',
                          value: _sector,
                          values: const ['Sector 7', 'Sector 12', 'Sector 18'],
                          onChanged: (value) => setState(() => _sector = value),
                        ),
                        const SizedBox(height: 12),
                        _ChoiceRow(
                          icon: Icons.groups_outlined,
                          label: 'Unit',
                          value: _unit,
                          values: const [
                            'Field Team Bravo',
                            'Safety Team Delta',
                            'Inspection Unit 3',
                          ],
                          onChanged: (value) => setState(() => _unit = value),
                        ),
                        const SizedBox(height: 22),
                        PrimaryActionButton(
                          label: 'Confirm selection',
                          icon: Icons.check_circle_outline,
                          onPressed: () => Navigator.of(
                            context,
                          ).pushReplacementNamed(DashboardScreen.routeName),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const FieldPanel(
                    child: Row(
                      children: [
                        Icon(
                          Icons.satellite_alt_outlined,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Local telemetry and offline records will initialize after selection.',
                            style: TextStyle(
                              color: AppColors.mutedText,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectionRow extends StatelessWidget {
  const _SelectionRow({
    required this.icon,
    required this.label,
    required this.value,
    this.locked = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceHigh,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outline),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Icon(
            locked ? Icons.lock_outline : Icons.chevron_right,
            color: AppColors.mutedText,
            size: 18,
          ),
        ],
      ),
    );
  }
}

class _ChoiceRow extends StatelessWidget {
  const _ChoiceRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.values,
    required this.onChanged,
  });

  final IconData icon;
  final String label;
  final String value;
  final List<String> values;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      dropdownColor: AppColors.surfaceHigh,
      decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
      items: values
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: (value) {
        if (value != null) onChanged(value);
      },
    );
  }
}
