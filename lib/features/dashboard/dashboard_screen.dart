import 'package:flutter/material.dart';

import '../../app/app_colors.dart';
import '../../shared/widgets/app_background.dart';
import '../../shared/widgets/app_header.dart';
import '../../shared/widgets/field_panel.dart';
import '../../shared/widgets/status_chip.dart';

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
      const _PlaceholderPage(title: 'Operations Map', icon: Icons.map_outlined),
      const _PlaceholderPage(title: 'Reports', icon: Icons.assignment_outlined),
      const _PlaceholderPage(title: 'Settings', icon: Icons.settings_outlined),
    ];

    return Scaffold(
      body: AppBackground(
        child: Column(
          children: [
            AppHeader(
              title: 'Field Operations',
              subtitle: 'North Region / Sector 7',
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.signal_cellular_alt,
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
        backgroundColor: AppColors.surface.withValues(alpha: 0.96),
        indicatorColor: AppColors.primaryContainer,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            label: 'Home',
          ),
          NavigationDestination(icon: Icon(Icons.map_outlined), label: 'Map'),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Logs',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class _DashboardHome extends StatelessWidget {
  const _DashboardHome();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
      children: [
        const Row(
          children: [
            Expanded(
              child: _MetricCard(
                label: 'Active operations',
                value: '12',
                icon: Icons.bolt_outlined,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _MetricCard(
                label: 'Field personnel',
                value: '86',
                icon: Icons.groups_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Expanded(
              child: _MetricCard(
                label: 'Safety alerts',
                value: '2',
                icon: Icons.warning_amber_rounded,
                color: AppColors.error,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _MetricCard(
                label: 'Network health',
                value: '98%',
                icon: Icons.router_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        FieldPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'OPERATION OVERVIEW',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const Spacer(),
                  const StatusChip(label: 'Live'),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: 190,
                decoration: BoxDecoration(
                  color: AppColors.mapBase,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.outline),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(painter: _MiniMapPainter()),
                    ),
                    const Positioned(
                      left: 28,
                      top: 42,
                      child: _MapPoint(
                        label: 'OPS-12',
                        color: AppColors.primary,
                      ),
                    ),
                    const Positioned(
                      right: 48,
                      bottom: 42,
                      child: _MapPoint(label: 'ALERT', color: AppColors.error),
                    ),
                    const Positioned(
                      right: 12,
                      top: 12,
                      child: StatusChip(label: 'Map mock', showDot: false),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        FieldPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RECENT ACTIVITY',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(height: 12),
              const _ActivityRow(
                time: '09:24',
                title: 'Checkpoint CP-02 updated',
                status: 'Completed',
              ),
              const _ActivityRow(
                time: '09:11',
                title: 'Incident report submitted',
                status: 'Review',
              ),
              const _ActivityRow(
                time: '08:52',
                title: 'Team Bravo joined operation',
                status: 'Active',
              ),
            ],
          ),
        ),
      ],
    );
  }
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
          const SizedBox(height: 14),
          Text(value, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 2),
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
              fontWeight: FontWeight.w700,
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

class _MapPoint extends StatelessWidget {
  const _MapPoint({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.7),
                blurRadius: 18,
                spreadRadius: 4,
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _MiniMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.outline.withValues(alpha: 0.25)
      ..strokeWidth = 0.8;
    for (double x = 0; x < size.width; x += 28) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 28) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final routePaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final path = Path()
      ..moveTo(32, 58)
      ..quadraticBezierTo(
        size.width * 0.45,
        24,
        size.width - 58,
        size.height - 50,
      );
    canvas.drawPath(path, routePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: FieldPanel(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.primary, size: 42),
              const SizedBox(height: 14),
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(
                'This module will be expanded in the next UI step.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
