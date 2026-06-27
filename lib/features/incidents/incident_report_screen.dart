import 'package:flutter/material.dart';

import '../../app/app_colors.dart';
import '../../app/app_state.dart';
import '../../shared/widgets/field_panel.dart';
import '../../shared/widgets/field_scaffold.dart';
import '../../shared/widgets/primary_action_button.dart';
import '../../shared/widgets/status_chip.dart';

class IncidentReportScreen extends StatefulWidget {
  const IncidentReportScreen({super.key});

  @override
  State<IncidentReportScreen> createState() => _IncidentReportScreenState();
}

class _IncidentReportScreenState extends State<IncidentReportScreen> {
  String severity = 'Warning';
  final _categoryController = TextEditingController(text: 'Coverage / Safety');
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _categoryController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FieldScaffold(
      title: 'Incident Report',
      subtitle: 'Geotagged field note',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          FieldPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SEVERITY', style: Theme.of(context).textTheme.labelSmall),
                const SizedBox(height: 10),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'Info', label: Text('Info')),
                    ButtonSegment(value: 'Warning', label: Text('Warning')),
                    ButtonSegment(value: 'Critical', label: Text('Critical')),
                  ],
                  selected: {severity},
                  onSelectionChanged: (value) =>
                      setState(() => severity = value.first),
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    StatusChip(label: 'GPS Lock'),
                    SizedBox(width: 8),
                    StatusChip(label: '+/- 2.5m', showDot: false),
                  ],
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _categoryController,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    prefixIcon: Icon(Icons.category_outlined),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _noteController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelText: 'Situation note',
                    alignLabelWithHint: true,
                    hintText: 'Describe what happened...',
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.outline),
                    color: AppColors.surfaceHigh.withValues(alpha: .55),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.add_photo_alternate_outlined,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: 8),
                      Text('Attach photo / audio / document'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                PrimaryActionButton(
                  label: 'Submit report',
                  icon: Icons.send_outlined,
                  onPressed: () {
                    FieldOpsStateScope.of(context).submitIncident(severity);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$severity report queued for sync'),
                      ),
                    );
                    _noteController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
