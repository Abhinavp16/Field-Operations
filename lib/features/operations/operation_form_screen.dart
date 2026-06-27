import 'package:flutter/material.dart';

import '../../app/app_colors.dart';
import '../../shared/widgets/field_panel.dart';
import '../../shared/widgets/field_scaffold.dart';
import '../../shared/widgets/primary_action_button.dart';

class OperationFormScreen extends StatefulWidget {
  const OperationFormScreen({super.key});

  @override
  State<OperationFormScreen> createState() => _OperationFormScreenState();
}

class _OperationFormScreenState extends State<OperationFormScreen> {
  String type = 'Safety Patrol';
  String priority = 'Standard';

  @override
  Widget build(BuildContext context) {
    return FieldScaffold(
      title: 'Create Operation',
      subtitle: 'Initialize field activity record',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          FieldPanel(
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Designation',
                    prefixIcon: Icon(Icons.edit_square),
                  ),
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  initialValue: type,
                  decoration: const InputDecoration(
                    labelText: 'Operation type',
                    prefixIcon: Icon(Icons.category_outlined),
                  ),
                  dropdownColor: AppColors.surfaceHigh,
                  items:
                      const [
                            'Safety Patrol',
                            'Inspection',
                            'Recovery Support',
                            'Route Survey',
                          ]
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                  onChanged: (value) => setState(() => type = value ?? type),
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  initialValue: priority,
                  decoration: const InputDecoration(
                    labelText: 'Priority',
                    prefixIcon: Icon(Icons.priority_high_outlined),
                  ),
                  dropdownColor: AppColors.surfaceHigh,
                  items: const ['Low', 'Standard', 'High', 'Critical']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => priority = value ?? priority),
                ),
                const SizedBox(height: 14),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Sector / Region',
                    prefixIcon: Icon(Icons.map_outlined),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Brief notes',
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 20),
                PrimaryActionButton(
                  label: 'Save draft',
                  icon: Icons.save_outlined,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
