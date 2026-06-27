import 'package:flutter/material.dart';

import '../../app/app_colors.dart';
import '../../shared/widgets/data_row_tile.dart';
import '../../shared/widgets/field_panel.dart';
import '../../shared/widgets/field_scaffold.dart';
import '../../shared/widgets/mock_map.dart';
import '../../shared/widgets/status_chip.dart';

class ActiveOperationScreen extends StatelessWidget {
  const ActiveOperationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FieldScaffold(
      title: 'Active Operation',
      subtitle: 'OPS-204 / Sector 7',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          const MockMap(height: 310, mode: 'Tracking'),
          const SizedBox(height: 14),
          FieldPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'LIVE STATUS',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const Spacer(),
                    const StatusChip(label: 'Active'),
                  ],
                ),
                const SizedBox(height: 12),
                const DataRowTile(
                  label: 'Operation',
                  value: 'Bridge Safety Sweep',
                  icon: Icons.assignment_outlined,
                ),
                const DataRowTile(
                  label: 'Elapsed',
                  value: '02:14:33',
                  icon: Icons.timer_outlined,
                  valueColor: AppColors.primary,
                ),
                const DataRowTile(
                  label: 'GPS accuracy',
                  value: '+/- 3.2m',
                  icon: Icons.gps_fixed_outlined,
                ),
                const DataRowTile(
                  label: 'Offline queue',
                  value: '4 events',
                  icon: Icons.sync_outlined,
                  valueColor: AppColors.secondary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _ActionCard(
                  icon: Icons.flag_outlined,
                  label: 'Checkpoint',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ActionCard(
                  icon: Icons.report_outlined,
                  label: 'Incident',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ActionCard(
                  icon: Icons.stop_circle_outlined,
                  label: 'Close',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return FieldPanel(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(height: 8),
          Text(label, style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }
}
