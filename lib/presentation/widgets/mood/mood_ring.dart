import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/config/theme/app_colors.dart';

import '../../controllers/mood/mood_controller.dart';

class MoodRing extends StatelessWidget {
  final double size;
  const MoodRing({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<MoodController>();
    return SizedBox(
      width: size,
      height: size,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final s = Size(constraints.maxWidth, constraints.maxHeight);
          return Obx(() {
            final angle = c.angle.value;
            final center = Offset(s.width / 2, s.height / 2);
            final radius = s.width / 2 - c.ringThickness / 2;

            final knobPos = Offset(
              center.dx + radius * cos(angle),
              center.dy + radius * sin(angle),
            );

            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onPanDown: (d) => c.onDragUpdate(d.localPosition, s),
              onPanUpdate: (d) => c.onDragUpdate(d.localPosition, s),
              onPanEnd: (_) => c.snapToActiveCenter(),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Ring with lines
                  CustomPaint(
                    painter: _RingPainter(
                      thickness: c.ringThickness,
                    ),
                  ),

                  Center(
                    child: Container(
                      width: size - c.ringThickness * 2.2,
                      height: size - c.ringThickness * 2.2,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0E1013),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 20,
                            spreadRadius: -4,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    left: knobPos.dx - 18,
                    top: knobPos.dy - 18,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 6),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white.withOpacity(.9),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double thickness;
  _RingPainter({required this.thickness});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - thickness / 2;

    const gradient = SweepGradient(
      startAngle: -pi / 2,
      endAngle: 3 * pi / 2,
      colors: [
        AppColors.ringGreen,
        AppColors.ringPurple,
        AppColors.ringPink,
        AppColors.ringOrange,
        AppColors.ringGreen,
      ],
      stops: [0.1, 0.35, 0.5, 0.75, 1.0],
      tileMode: TileMode.repeated,
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.butt; // Fixed square artifacts

    final glow = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4)
      ..strokeWidth = thickness;

    canvas.drawCircle(center, radius, glow);
    canvas.drawCircle(center, radius, paint);

    // Draw white italic lines within each color segment
    _drawSegmentLines(canvas, center, radius, thickness);
  }

  void _drawSegmentLines(
      Canvas canvas, Offset center, double radius, double thickness) {
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.butt;

    final segments = [
      {'start': -pi / 2, 'end': 0.0}, // Calm (green)
      {'start': 0.0, 'end': pi / 2}, // Content (purple)
      {'start': pi / 2, 'end': pi}, // Peaceful (pink)
      {'start': -pi, 'end': -pi / 2}, // Happy (orange)
    ];

    for (final segment in segments) {
      final start = segment['start'] as double;
      final end = segment['end'] as double;
      final segmentSpan = end - start;

      // Draw 3 lines within each segment
      for (int i = 1; i <= 3; i++) {
        final lineAngle = start + (segmentSpan * i / 4);

        // Calculate points with italic slant
        const slantOffset = 0.08; // Slant angle in radians

        final innerRadius = radius - thickness / 2;
        final outerRadius = radius + thickness / 2;

        final innerPoint = Offset(
          center.dx + innerRadius * cos(lineAngle - slantOffset),
          center.dy + innerRadius * sin(lineAngle - slantOffset),
        );

        final outerPoint = Offset(
          center.dx + outerRadius * cos(lineAngle + slantOffset),
          center.dy + outerRadius * sin(lineAngle + slantOffset),
        );

        canvas.drawLine(innerPoint, outerPoint, linePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      oldDelegate.thickness != thickness;
}
