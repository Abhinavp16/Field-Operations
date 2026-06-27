import 'package:flutter/material.dart';

import '../../app/app_colors.dart';
import '../../shared/widgets/field_panel.dart';
import '../../shared/widgets/field_scaffold.dart';
import '../../shared/widgets/status_chip.dart';

class PersonnelScreen extends StatelessWidget {
  const PersonnelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final people = [
      ('Asha Rao', 'Team Lead', 'Active', AppColors.primary, '98%'),
      ('Kabir Sen', 'Field Member', 'Standby', AppColors.secondary, '82%'),
      ('Mira Das', 'Safety Officer', 'Active', AppColors.primary, '91%'),
      ('Dev Malik', 'Comms Tech', 'Weak Signal', AppColors.error, '45%'),
    ];
    return FieldScaffold(
      title: 'Personnel',
      subtitle: 'Field team tracking',
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        itemCount: people.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final person = people[index];
          return FieldPanel(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.surfaceHighest,
                  child: Text(
                    person.$1.characters.first,
                    style: const TextStyle(color: AppColors.primary),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        person.$1,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        person.$2,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    StatusChip(label: person.$3, color: person.$4),
                    const SizedBox(height: 8),
                    Text(
                      'SIG ${person.$5}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
