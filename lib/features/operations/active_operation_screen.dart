import 'package:flutter/material.dart';

import '../../app/app_colors.dart';
import '../../app/app_state.dart';
import '../../shared/widgets/data_row_tile.dart';
import '../../shared/widgets/field_panel.dart';
import '../../shared/widgets/field_scaffold.dart';
import '../../shared/widgets/mock_map.dart';
import '../../shared/widgets/status_chip.dart';
import '../checkpoints/checkpoints_screen.dart';
import '../incidents/incident_report_screen.dart';

class ActiveOperationScreen extends StatelessWidget {
  const ActiveOperationScreen({super.key, this.embedded = false});

  final bool embedded;

  @override
  Widget build(BuildContext context) {
    final state = FieldOpsStateScope.of(context);
    return FieldScaffold(
      title: 'Active Operation',
      subtitle: 'OPS-204 / Sector 7',
      embedded: embedded,
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
                    StatusChip(
                      label: state.operationStatus,
                      color: state.operationActive
                          ? AppColors.primary
                          : AppColors.mutedText,
                    ),
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
                DataRowTile(
                  label: 'Offline queue',
                  value: '${state.offlineQueue} events',
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
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const CheckpointsScreen(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ActionCard(
                  icon: Icons.report_outlined,
                  label: 'Incident',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const IncidentReportScreen(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ActionCard(
                  icon: state.operationActive
                      ? Icons.stop_circle_outlined
                      : Icons.play_circle_outline,
                  label: state.operationActive ? 'Close' : 'Reopen',
                  onTap: () {
                    if (state.operationActive) {
                      state.closeOperation();
                    } else {
                      state.reopenOperation();
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Operation ${state.operationStatus.toLowerCase()}',
                        ),
                      ),
                    );
                  },
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
  const _ActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FieldPanel(
      padding: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            children: [
              Icon(icon, color: AppColors.primary),
              const SizedBox(height: 8),
              Text(label, style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
        ),
      ),
    );
  }
}
