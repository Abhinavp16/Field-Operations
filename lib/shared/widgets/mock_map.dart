import 'package:flutter/material.dart';

import '../../app/app_colors.dart';
import 'status_chip.dart';

class MockMap extends StatelessWidget {
  const MockMap({super.key, this.height = 240, this.mode = 'Live area'});

  final double height;
  final String mode;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.mapBase,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outline),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(child: CustomPaint(painter: _MapPainter())),
            const Positioned(
              left: 34,
              top: 50,
              child: _MapPoint(label: 'TEAM-A', color: AppColors.primary),
            ),
            const Positioned(
              right: 54,
              top: 86,
              child: _MapPoint(label: 'CP-02', color: AppColors.secondary),
            ),
            const Positioned(
              left: 104,
              bottom: 54,
              child: _MapPoint(label: 'ALERT', color: AppColors.error),
            ),
            Positioned(
              right: 12,
              top: 12,
              child: StatusChip(label: mode, showDot: false),
            ),
            Positioned(
              right: 12,
              bottom: 12,
              child: Column(
                children: [
                  _MapButton(icon: Icons.add),
                  const SizedBox(height: 8),
                  _MapButton(icon: Icons.remove),
                  const SizedBox(height: 8),
                  _MapButton(icon: Icons.my_location_outlined),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapButton extends StatelessWidget {
  const _MapButton({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.86),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.outline),
      ),
      child: Icon(icon, color: AppColors.text, size: 18),
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
                color: color.withValues(alpha: 0.65),
                blurRadius: 18,
                spreadRadius: 5,
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.84),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = AppColors.outline.withValues(alpha: 0.22)
      ..strokeWidth = 0.7;
    for (double x = 0; x < size.width; x += 28) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += 28) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final contour = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    for (var i = 0; i < 4; i++) {
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(size.width * .42, size.height * .42),
          width: 120 + (i * 44),
          height: 58 + (i * 26),
        ),
        contour,
      );
    }

    final route = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2;
    final path = Path()
      ..moveTo(42, 68)
      ..quadraticBezierTo(size.width * .46, 26, size.width - 62, 100)
      ..quadraticBezierTo(
        size.width * .72,
        size.height - 34,
        118,
        size.height - 64,
      );
    canvas.drawPath(path, route);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
