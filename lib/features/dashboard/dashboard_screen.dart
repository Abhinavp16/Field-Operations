import 'package:flutter/material.dart';

import '../../app/app_colors.dart';
import '../../app/app_state.dart';
import '../../shared/widgets/app_background.dart';
import '../../shared/widgets/app_header.dart';
import '../../shared/widgets/data_row_tile.dart';
import '../../shared/widgets/field_panel.dart';
import '../../shared/widgets/mock_map.dart';
import '../../shared/widgets/status_chip.dart';
import '../checkpoints/checkpoints_screen.dart';
import '../comms/comms_status_screen.dart';
import '../incidents/incident_report_screen.dart';
import '../logs/mission_logs_screen.dart';
import '../operations/active_operation_screen.dart';
import '../operations/operation_form_screen.dart';
import '../personnel/personnel_screen.dart';
import '../profile/profile_settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const routeName = '/dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const _DashboardHome(),
      const ActiveOperationScreen(embedded: true),
      const PersonnelScreen(embedded: true),
      const MissionLogsScreen(embedded: true),
      const _MoreScreen(),
    ];

    return Scaffold(
      body: AppBackground(
        child: Column(
          children: [
            AppHeader(
              title: _titleForTab(_tabIndex),
              subtitle: _subtitleForTab(_tabIndex),
              trailing: IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ProfileSettingsScreen(),
                  ),
                ),
                icon: const Icon(
                  Icons.account_circle_outlined,
                  color: AppColors.primary,
                ),
              ),
            ),
            Expanded(child: pages[_tabIndex]),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: (value) => setState(() => _tabIndex = value),
        backgroundColor: AppColors.surface.withValues(alpha: 0.98),
        indicatorColor: AppColors.primaryContainer,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.radar_outlined),
            label: 'Live',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            label: 'Team',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Logs',
          ),
          NavigationDestination(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }

  String _titleForTab(int index) {
    return switch (index) {
      1 => 'Live Operation',
      2 => 'Personnel',
      3 => 'Logs & Debrief',
      4 => 'Field Modules',
      _ => 'Field Operations',
    };
  }

  String _subtitleForTab(int index) {
    return switch (index) {
      1 => 'OPS-204 / Sector 7',
      2 => 'Field team tracking',
      3 => 'Searchable operation archive',
      4 => 'Connected workflows',
      _ => 'North Region / Sector 7',
    };
  }
}

class _DashboardHome extends StatelessWidget {
  const _DashboardHome();

  @override
  Widget build(BuildContext context) {
    final state = FieldOpsStateScope.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        _AlertBanner(
          alertCount: state.alertCount,
          onTap: () => Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const CommsStatusScreen())),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                label: 'Active ops',
                value: state.operationActive ? '12' : '11',
                icon: Icons.bolt_outlined,
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: _MetricCard(
                label: 'Personnel',
                value: '86',
                icon: Icons.groups_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                label: 'Alerts',
                value: '${state.alertCount}',
                icon: Icons.warning_amber_rounded,
                color: AppColors.error,
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: _MetricCard(
                label: 'Network',
                value: '98%',
                icon: Icons.router_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const _QuickActionGrid(),
        const SizedBox(height: 14),
        FieldPanel(
          padding: EdgeInsets.zero,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ActiveOperationScreen()),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'GIS FIELD OVERLAY',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const Spacer(),
                      const StatusChip(label: 'Live'),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const MockMap(height: 250, mode: 'Sector 7'),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        FieldPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ACTIVE SUMMARY',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(height: 8),
              const DataRowTile(
                label: 'Current operation',
                value: 'Bridge Safety Sweep',
                icon: Icons.assignment_outlined,
              ),
              const DataRowTile(
                label: 'Team online',
                value: '8 / 9',
                icon: Icons.group_outlined,
                valueColor: AppColors.primary,
              ),
              DataRowTile(
                label: 'Pending sync',
                value: '${state.offlineQueue} records',
                icon: Icons.sync_outlined,
                valueColor: AppColors.secondary,
              ),
              DataRowTile(
                label: 'Operation status',
                value: state.operationStatus,
                icon: Icons.radio_button_checked,
                valueColor: state.operationActive
                    ? AppColors.primary
                    : AppColors.mutedText,
              ),
              DataRowTile(
                label: 'Draft operations',
                value: '${state.operationDrafts}',
                icon: Icons.drafts_outlined,
              ),
              const DataRowTile(
                label: 'Coverage blackspots',
                value: '2',
                icon: Icons.signal_cellular_connected_no_internet_4_bar,
                valueColor: AppColors.error,
              ),
              const DataRowTile(
                label: 'Last debrief generated',
                value: '17 min ago',
                icon: Icons.description_outlined,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        FieldPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RECENT ACTIVITY',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(height: 12),
              ...state.activities
                  .take(5)
                  .map(
                    (activity) => _ActivityRow(
                      time: activity.time,
                      title: activity.title,
                      status: activity.status,
                    ),
                  ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MoreScreen extends StatelessWidget {
  const _MoreScreen();

  @override
  Widget build(BuildContext context) {
    final modules = [
      _Module(
        'Live Operation',
        Icons.radar_outlined,
        const ActiveOperationScreen(),
      ),
      _Module('Personnel', Icons.groups_outlined, const PersonnelScreen()),
      _Module(
        'Logs & Debrief',
        Icons.menu_book_outlined,
        const MissionLogsScreen(),
      ),
      _Module(
        'Create Operation',
        Icons.add_circle_outline,
        const OperationFormScreen(),
      ),
      _Module('Checkpoints', Icons.flag_outlined, const CheckpointsScreen()),
      _Module(
        'Incident Report',
        Icons.report_outlined,
        const IncidentReportScreen(),
      ),
      _Module(
        'Coverage Monitor',
        Icons.settings_input_antenna,
        const CommsStatusScreen(),
      ),
      _Module(
        'Profile & Security',
        Icons.verified_user_outlined,
        const ProfileSettingsScreen(),
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemBuilder: (context, index) {
        final module = modules[index];
        return FieldPanel(
          padding: EdgeInsets.zero,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => module.screen)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer.withValues(alpha: .35),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: .35),
                      ),
                    ),
                    child: Icon(module.icon, color: AppColors.primary),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          module.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Open ${module.title.toLowerCase()} module',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: AppColors.mutedText),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemCount: modules.length,
    );
  }
}

class _AlertBanner extends StatelessWidget {
  const _AlertBanner({required this.alertCount, required this.onTap});

  final int alertCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FieldPanel(
      padding: EdgeInsets.zero,
      borderColor: AppColors.error.withValues(alpha: .55),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.errorContainer.withValues(alpha: .38),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.error,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CRITICAL WATCH',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(height: 2),
                    const Text('Sector 7 coverage degraded near Ridge Line B'),
                  ],
                ),
              ),
              StatusChip(label: '$alertCount alerts', color: AppColors.error),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionGrid extends StatelessWidget {
  const _QuickActionGrid();

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickAction(
        'New Op',
        Icons.add_circle_outline,
        const OperationFormScreen(),
      ),
      _QuickAction(
        'Report',
        Icons.report_outlined,
        const IncidentReportScreen(),
      ),
      _QuickAction(
        'Checkpoints',
        Icons.flag_outlined,
        const CheckpointsScreen(),
      ),
      _QuickAction(
        'Coverage',
        Icons.settings_input_antenna,
        const CommsStatusScreen(),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: actions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: .86,
      ),
      itemBuilder: (context, index) {
        final action = actions[index];
        return FieldPanel(
          padding: EdgeInsets.zero,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => action.screen)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(action.icon, color: AppColors.primary, size: 24),
                  const SizedBox(height: 8),
                  Text(
                    action.label.toUpperCase(),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      color: AppColors.text,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _QuickAction {
  const _QuickAction(this.label, this.icon, this.screen);

  final String label;
  final IconData icon;
  final Widget screen;
}

class _Module {
  const _Module(this.title, this.icon, this.screen);

  final String title;
  final IconData icon;
  final Widget screen;
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
    this.color = AppColors.primary,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FieldPanel(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 12),
          Text(value, style: Theme.of(context).textTheme.headlineSmall),
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({
    required this.time,
    required this.title,
    required this.status,
  });

  final String time;
  final String title;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          Text(
            time,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(child: Text(title)),
          Text(status, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
