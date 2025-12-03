import 'dart:math' as math;
import 'package:flutter/material.dart';

Widget buildAnimatedBackground(BuildContext context) {
  return Stack(
    children: [
      Positioned.fill(
        child: CustomPaint(
          painter: GridPainter(),
        ),
      ),
      Positioned.fill(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1e002a).withOpacity(0.4),
                Colors.black,
                Colors.black,
              ],
            ),
          ),
        ),
      ),
      // Floating Code Particles
      ...buildFloatingParticles(context),
    ],
  );
}

List<Widget> buildFloatingParticles(BuildContext context) {
  final particles = ['{ }', '< />', '[ ]', '( )', '=>', 'fn', '{}'];
  return List.generate(particles.length, (i) {
    return Positioned(
      left: (i * 200.0) % MediaQuery.of(context).size.width,
      top: (i * 150.0) % MediaQuery.of(context).size.height,
      child: AnimatedParticle(text: particles[i]),
    );
  });
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF8b5cf6).withOpacity(0.4)
      ..strokeWidth = 1;

    const spacing = 50.0;

    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i, size.height),
        paint,
      );
    }

    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(
        Offset(0, i),
        Offset(size.width, i),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


class AnimatedParticle extends StatefulWidget {
  final String text;

  const AnimatedParticle({Key? key, required this.text}) : super(key: key);

  @override
  State<AnimatedParticle> createState() => _AnimatedParticleState();
}

class _AnimatedParticleState extends State<AnimatedParticle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _animation = Tween<double>(begin: 0, end: -20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: Transform.rotate(
            angle: _controller.value * 2 * math.pi,
            child: Opacity(
              opacity: 0.3 + (_controller.value * 0.3),
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Color(0xFF8b5cf6),
                  fontSize: 14,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
