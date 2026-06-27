import 'package:flutter/material.dart';

import '../../app/app_colors.dart';

class DataRowTile extends StatelessWidget {
  const DataRowTile({
    required this.label,
    required this.value,
    super.key,
    this.icon,
    this.valueColor,
  });

  final String label;
  final String value;
  final IconData? icon;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: AppColors.mutedText, size: 18),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Text(
              label.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? AppColors.text,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
