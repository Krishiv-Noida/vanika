import 'dart:math' as math;
import 'package:flutter/material.dart';

class Particle3D {
  double x;
  double y;
  double z;
  double origZ;
  double radius;
  double speed;
  double alpha;
  double phase;
  Color color;

  Particle3D({
    required this.x,
    required this.y,
    required this.z,
    required this.origZ,
    required this.radius,
    required this.speed,
    required this.alpha,
    required this.phase,
    required this.color,
  });
}

/// Canvas-based 3D botanical particles projector matching web-ui BotanicalParticles3D.tsx
class BotanicalParticles3D extends StatefulWidget {
  final int count;
  final Widget? child;

  const BotanicalParticles3D({
    super.key,
    this.count = 35,
    this.child,
  });

  @override
  State<BotanicalParticles3D> createState() => _BotanicalParticles3DState();
}

class _BotanicalParticles3DState extends State<BotanicalParticles3D>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle3D> _particles = [];
  final math.Random _random = math.Random();

  final List<Color> _sporeColors = const [
    Color(0xFF86EFAC), // Emerald light
    Color(0xFF4ADE80), // Mint green
    Color(0xFFFACC15), // Golden botanical pollen
    Color(0xFFBBF7D0), // Pale botanical glow
  ];

  @override
  void initState() {
    super.initState();
    _initParticles();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  void _initParticles() {
    _particles.clear();
    for (int i = 0; i < widget.count; i++) {
      final z = _random.nextDouble() * 700 + 50;
      _particles.add(
        Particle3D(
          x: (_random.nextDouble() - 0.5) * 500,
          y: (_random.nextDouble() - 0.5) * 800,
          z: z,
          origZ: z,
          radius: _random.nextDouble() * 2.2 + 0.8,
          speed: _random.nextDouble() * 0.5 + 0.2,
          alpha: _random.nextDouble() * 0.5 + 0.3,
          phase: _random.nextDouble() * math.pi * 2,
          color: _sporeColors[_random.nextInt(_sporeColors.length)],
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return CustomPaint(
                painter: _BotanicalParticlesPainter(
                  particles: _particles,
                  progress: _controller.value,
                ),
              );
            },
          ),
        ),
        if (widget.child != null) widget.child!,
      ],
    );
  }
}

class _BotanicalParticlesPainter extends CustomPainter {
  final List<Particle3D> particles;
  final double progress;

  _BotanicalParticlesPainter({
    required this.particles,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == 0 || size.height == 0) return;

    final cx = size.width / 2;
    final cy = size.height / 2;
    const fov = 350.0;
    final time = progress * math.pi * 2;

    // Sort by Z descending for depth buffer order
    particles.sort((a, b) => b.z.compareTo(a.z));

    for (final p in particles) {
      // Drift mechanics
      p.z -= p.speed;
      p.y += math.sin(time + p.phase) * 0.25;
      p.x += math.cos(time + p.phase * 0.7) * 0.18;

      if (p.z <= 10) {
        p.z = 750;
        p.x = (math.Random().nextDouble() - 0.5) * size.width * 1.3;
        p.y = (math.Random().nextDouble() - 0.5) * size.height * 1.3;
      }

      // 3D Perspective Projection
      final scale = fov / (fov + p.z);
      final projX = cx + p.x * scale;
      final projY = cy + p.y * scale;
      final projRadius = p.radius * scale * 1.5;

      if (projX < -30 || projX > size.width + 30 || projY < -30 || projY > size.height + 30) {
        continue;
      }

      final depthAlpha = (1.0 - (p.z / 800)).clamp(0.1, 0.85) * p.alpha;
      final pulse = 0.8 + 0.2 * math.sin(time * 2 + p.phase);

      // Glowing outer bloom
      final bloomPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            p.color.withValues(alpha: (depthAlpha * pulse).clamp(0.0, 1.0)),
            p.color.withValues(alpha: (depthAlpha * 0.3 * pulse).clamp(0.0, 1.0)),
            Colors.transparent,
          ],
          stops: const [0.0, 0.45, 1.0],
        ).createShader(
          Rect.fromCircle(
            center: Offset(projX, projY),
            radius: projRadius * 3.5,
          ),
        );

      canvas.drawCircle(Offset(projX, projY), projRadius * 3.5, bloomPaint);

      // Bright Core
      final corePaint = Paint()
        ..color = p.color.withValues(alpha: (depthAlpha * 1.2 * pulse).clamp(0.0, 1.0))
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(projX, projY), math.max(0.4, projRadius * 0.6), corePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _BotanicalParticlesPainter oldDelegate) => true;
}
