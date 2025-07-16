import 'package:flutter/material.dart';
import '../../core/constant/app_colors.dart';

class BombIcon extends StatelessWidget {
  final double size;
  final Color color;

  const BombIcon({
    super.key,
    this.size = 20,
    this.color = AppColors.bombBody,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: BombPainter(color: color),
      ),
    );
  }
}

class BombPainter extends CustomPainter {
  final Color color;

  BombPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Draw the main bomb body (circle)
    final center = Offset(size.width * 0.5, size.height * 0.55);
    final radius = size.width * 0.35;
    canvas.drawCircle(center, radius, paint);

    // Draw the fuse
    final fusePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.12;

    final path = Path();
    path.moveTo(size.width * 0.5, size.height * 0.2);
    path.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.1,
      size.width * 0.8,
      size.height * 0.2,
    );

    canvas.drawPath(path, fusePaint);

    // Draw the highlight (small circle)
    final highlightPaint = Paint()
      ..color = AppColors.bombHighlight
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(center.dx - radius * 0.3, center.dy - radius * 0.3),
      radius * 0.2,
      highlightPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 