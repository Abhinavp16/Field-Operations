import 'package:flutter/material.dart';

import '../../app/app_colors.dart';
import '../../app/app_state.dart';
import '../../shared/widgets/field_panel.dart';
import '../../shared/widgets/field_scaffold.dart';
import '../../shared/widgets/mock_map.dart';
import '../../shared/widgets/status_chip.dart';

class CheckpointsScreen extends StatelessWidget {
  const CheckpointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = FieldOpsStateScope.of(context);
    return FieldScaffold(
      title: 'Checkpoints',
      subtitle: 'Bridge Safety Sweep',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          const MockMap(height: 210, mode: 'Route'),
          const SizedBox(height: 14),
          FieldPanel(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${state.completedCheckpoints} / ${state.checkpoints.length} checkpoints complete',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                FilledButton.icon(
                  onPressed: () {
                    state.completeActiveCheckpoint();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Active checkpoint updated'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.check_circle_outline, size: 18),
                  label: const Text('Update'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          ...state.checkpoints.map(
            (cp) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: FieldPanel(
                borderColor: cp.status == 'Active' ? AppColors.primary : null,
                child: Row(
                  children: [
                    Icon(
                      cp.status == 'Completed'
                          ? Icons.check_circle_outline
                          : Icons.radio_button_checked,
                      color: _statusColor(cp.status),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cp.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            'Assigned: Field Team Bravo',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    StatusChip(
                      label: cp.status,
                      color: _statusColor(cp.status),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    return switch (status) {
      'Completed' => AppColors.primary,
      'Active' => AppColors.secondary,
      _ => AppColors.mutedText,
    };
  }
}
