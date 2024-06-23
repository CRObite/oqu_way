import 'package:flutter/material.dart';

class RoundedCircularProgressIndicator extends CustomPainter {
  final double value;
  final Color color;
  final double strokeWidth;
  final Color backgroundColor;

  RoundedCircularProgressIndicator({
    required this.value,
    required this.color,
    required this.strokeWidth,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Paint foregroundPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = (size.width - strokeWidth) / 2;
    double startAngle = -3.14 / 2;
    double sweepAngle = 2 * 3.14 * value;

    // Draw background circle
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress indicator
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}