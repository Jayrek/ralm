import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedTarotCardWidget extends StatefulWidget {
  const AnimatedTarotCardWidget({super.key});

  @override
  State<AnimatedTarotCardWidget> createState() =>
      _AnimatedTarotCardWidgetState();
}

class _AnimatedTarotCardWidgetState extends State<AnimatedTarotCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5), // Speed of animation
    )..repeat(); // Continuously loops the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            height: 200,
            width: 130,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: CustomPaint(
              painter: GradientBorderPainter(_controller.value),
              child: Container(
                margin: EdgeInsets.all(4), // Space for border effect
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class GradientBorderPainter extends CustomPainter {
  final double progress;

  GradientBorderPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final gradient = SweepGradient(
      startAngle: 0.0,
      endAngle: 2 * pi,
      colors: [
        Colors.purple,
        Colors.blue,
        Colors.cyan,
        Colors.green,
        Colors.yellow,
        Colors.orange,
        Colors.red,
        Colors.purple,
      ],
      stops: List.generate(8, (index) => (progress + index * 0.5) % 1),
    );

    final paint =
        Paint()
          ..shader = gradient.createShader(rect)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4; // Thickness of border

    final borderRadius = BorderRadius.circular(10);
    final rrect = borderRadius.toRRect(rect);
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
