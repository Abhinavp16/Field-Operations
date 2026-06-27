import 'package:flutter/material.dart';

import '../../app/app_colors.dart';
import '../../shared/widgets/data_row_tile.dart';
import '../../shared/widgets/field_panel.dart';
import '../../shared/widgets/field_scaffold.dart';
import '../../shared/widgets/mock_map.dart';
import '../../shared/widgets/status_chip.dart';

class MissionLogsScreen extends StatelessWidget {
  const MissionLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FieldScaffold(
      title: 'Logs & Debrief',
      subtitle: 'Searchable operation archive',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Search by ID, operation, date',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 14),
          _LogCard(
            id: 'LOG-204',
            title: 'Bridge Safety Sweep',
            status: 'Completed',
            color: AppColors.primary,
          ),
          _LogCard(
            id: 'LOG-198',
            title: 'North Route Survey',
            status: 'In Review',
            color: AppColors.secondary,
          ),
          _LogCard(
            id: 'LOG-183',
            title: 'Comms Blackspot Audit',
            status: 'Flagged',
            color: AppColors.error,
          ),
          const SizedBox(height: 8),
          FieldPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DEBRIEF SNAPSHOT',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 12),
                const MockMap(height: 170, mode: 'Playback'),
                const SizedBox(height: 10),
                const DataRowTile(label: 'Duration', value: '04:12:09'),
                const DataRowTile(label: 'Events captured', value: '38'),
                const DataRowTile(label: 'Checkpoints crossed', value: '3 / 3'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LogCard extends StatelessWidget {
  const _LogCard({
    required this.id,
    required this.title,
    required this.status,
    required this.color,
  });

  final String id;
  final String title;
  final String status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: FieldPanel(
        borderColor: color.withValues(alpha: .55),
        child: Row(
          children: [
            Container(width: 4, height: 56, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    id,
                    style: TextStyle(color: color, fontWeight: FontWeight.w800),
                  ),
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  Text(
                    '2026-06-27 09:24 IST',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            StatusChip(label: status, color: color),
          ],
        ),
      ),
    );
  }
}
