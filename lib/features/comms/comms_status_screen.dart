import 'package:flutter/material.dart';

import '../../app/app_colors.dart';
import '../../shared/widgets/data_row_tile.dart';
import '../../shared/widgets/field_panel.dart';
import '../../shared/widgets/field_scaffold.dart';
import '../../shared/widgets/mock_map.dart';
import '../../shared/widgets/status_chip.dart';

class CommsStatusScreen extends StatelessWidget {
  const CommsStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FieldScaffold(
      title: 'Coverage Monitor',
      subtitle: 'Network quality and blackspots',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          FieldPanel(
            child: Row(
              children: [
                const StatusChip(label: 'Optimal'),
                const Spacer(),
                Text(
                  'Uplink 98%',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const MockMap(height: 250, mode: '2 blackspots'),
          const SizedBox(height: 14),
          FieldPanel(
            child: Column(
              children: const [
                DataRowTile(
                  label: 'Cellular',
                  value: 'Strong',
                  icon: Icons.signal_cellular_alt,
                  valueColor: AppColors.primary,
                ),
                DataRowTile(
                  label: 'Wi-Fi',
                  value: 'Available',
                  icon: Icons.wifi,
                  valueColor: AppColors.secondary,
                ),
                DataRowTile(
                  label: 'Offline tile pack',
                  value: 'Ready',
                  icon: Icons.map_outlined,
                ),
                DataRowTile(
                  label: 'Last sync',
                  value: '44 sec ago',
                  icon: Icons.sync_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
