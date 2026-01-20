import 'package:flutter/material.dart';

/// Draws a liquid-like bubble background for the active navigation item.
class BubblePainter extends CustomPainter {
  /// The color of the bubble.
  final Color bubbleColor;

  /// The current animation value [0.0 - 1.0].
  final double animationValue;

  /// The horizontal offset for the bubble (slides between items).
  final double offset;

  /// The radius of the bubble.
  final double radius;

  /// Creates a [BubblePainter].
  BubblePainter({
    required this.bubbleColor,
    required this.animationValue,
    required this.offset,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = bubbleColor
      ..style = PaintingStyle.fill;

    // Use the offset to position the bubble horizontally.
    final double centerX = offset + size.width / 2;
    final double centerY = size.height / 2;

    // Allow slight deformation during movement for a liquid feel (optional polish)
    // double deformation = (0.5 - (animationValue - 0.5).abs()) * 0.1;
    // For now, keeping it clean and smooth.

    canvas.drawCircle(Offset(centerX, centerY), radius, paint);

    // Optional: Add a subtle shadow for depth
    final Path path = Path()
      ..addOval(
          Rect.fromCircle(center: Offset(centerX, centerY), radius: radius));

    canvas.drawShadow(path, Colors.black.withOpacity(0.2), 4.0, true);
  }

  @override
  bool shouldRepaint(covariant BubblePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.offset != offset ||
        oldDelegate.bubbleColor != bubbleColor ||
        oldDelegate.radius != radius;
  }
}
