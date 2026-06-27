import 'package:flutter/material.dart';

import '../../app/app_colors.dart';
import '../../shared/widgets/field_panel.dart';
import '../../shared/widgets/field_scaffold.dart';
import '../../shared/widgets/mock_map.dart';
import '../../shared/widgets/status_chip.dart';

class CheckpointsScreen extends StatelessWidget {
  const CheckpointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final checkpoints = [
      ('CP-01 Alpha', 'Completed', AppColors.primary),
      ('CP-02 Bravo', 'Active', AppColors.secondary),
      ('CP-03 Charlie', 'Pending', AppColors.mutedText),
    ];
    return FieldScaffold(
      title: 'Checkpoints',
      subtitle: 'Bridge Safety Sweep',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          const MockMap(height: 210, mode: 'Route'),
          const SizedBox(height: 14),
          ...checkpoints.map(
            (cp) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: FieldPanel(
                borderColor: cp.$2 == 'Active' ? AppColors.primary : null,
                child: Row(
                  children: [
                    Icon(
                      cp.$2 == 'Completed'
                          ? Icons.check_circle_outline
                          : Icons.radio_button_checked,
                      color: cp.$3,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cp.$1,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            'Assigned: Field Team Bravo',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    StatusChip(label: cp.$2, color: cp.$3),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
