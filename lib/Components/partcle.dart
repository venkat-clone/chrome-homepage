import 'dart:math';

import 'package:chrome_home_page/colors.dart';
import 'package:flutter/material.dart';

class Particle {
  Offset position;
  final Paint paint;
  Offset velocity;
  Particle(
      {required this.position, required this.paint, required this.velocity});
}

class ParticlesScreen extends StatefulWidget {
  @override
  _ParticlesScreenState createState() => _ParticlesScreenState();
}

class _ParticlesScreenState extends State<ParticlesScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey _layoutKey = GlobalKey();
  Offset? _layoutPosition;

  List<Particle> particles = [];
  Size _size = Size(400, 400);
  late AnimationController _animationController;
  Offset mousePosition = Offset.infinite;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateLayoutPosition();
    });
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _animationController.addListener(() {
      moveParticles();
    });
  }

  void updateLayoutPosition() {
    final RenderBox? renderBox =
        _layoutKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        _layoutPosition = renderBox.localToGlobal(Offset.zero);
      });
    }
  }

  void generateParticles() {
    particles.clear();
    final random = Random();

    for (int i = 0; i < 400; i++) {
      final x = random.nextDouble() * _size.width;
      final y = random.nextDouble() * _size.height;
      final vx = (x % 3) * (x % 2 != 0 ? -1 : 1);
      final vy = (y % 3) * (y % 2 != 0 ? -1 : 1);
      final position = Offset(x, y);
      final paint = Paint()..color = Colors.blue;
      particles.add(Particle(
          position: position, paint: paint, velocity: Offset(vx / 3, vy / 3)));
    }
  }

  void moveParticles() {
    particles.forEach((particle) {
      particle.position += particle.velocity * 5;
      if (mousePosition.isFinite) {
        particle.position += particle.velocity;
      }
      if (particle.position.dx < 0 ||
          particle.position.dx > _size.width ||
          particle.position.dy < 0 ||
          particle.position.dy > _size.height) {
        particle.velocity =
            Offset(particle.velocity.dx * -1, particle.velocity.dy * -1);
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      key: _layoutKey,
      builder: (BuildContext context, BoxConstraints constraints) {
        if (_size == Size(400, 400)) {
          final screenSize = MediaQuery.of(context).size;
          _size = Size(screenSize.width - 50, screenSize.height - 100);

          // _size = Size(constraints.maxWidth, constraints.maxHeight);
          generateParticles();
        }
        return MouseRegion(
          onHover: (event) {
            mousePosition = Offset(
                event.position.dx - (_layoutPosition?.dx ?? 0.0),
                event.position.dy - (_layoutPosition?.dy ?? 0.0));
          },
          onExit: (event) {
            mousePosition = Offset.infinite;
          },
          child: CustomPaint(
            painter: ParticlesPainter(
                particles: particles, mousePoint: mousePosition),
            size: _size,
          ),
        );
      },
    );
  }
}

class ParticlesPainter extends CustomPainter {
  final List<Particle> particles;
  final Offset mousePoint;
  final Paint linePaint = Paint()..color = Colors.blue.withOpacity(0.15);
  final Paint mousePaint = Paint()..color = primary.withOpacity(0.2);

  ParticlesPainter({required this.particles, required this.mousePoint});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw particles
    particles.forEach((particle) {
      canvas.drawCircle(particle.position, 5, particle.paint);
    });

    // Draw random paths between particles
    final random = Random();
    final mousePosition = mousePoint;

    particles.forEach((source) {
      final sourcePosition = source.position;

      // Check if the source particle is within the mouse distance threshold
      final dx = mousePosition.dx - sourcePosition.dx;
      final dy = mousePosition.dy - sourcePosition.dy;
      final mouseDistance = sqrt(dx * dx + dy * dy);

      particles.forEach((destination) {
        if (source != destination) {
          final destinationPosition = destination.position;

          // Check if the particles are within the distance threshold
          final dx = destinationPosition.dx - sourcePosition.dx;
          final dy = destinationPosition.dy - sourcePosition.dy;
          final distance = sqrt(dx * dx + dy * dy);
          if (distance >= 130) {
            return;
          }

          // Draw path between particles
          // canvas.drawLine(sourcePosition, destinationPosition, linePaint);

          if (random.nextDouble() < 0.25) {
            canvas.drawLine(sourcePosition, destinationPosition, linePaint);
          }
        }
      });
      if (mouseDistance >= 300) {
        return;
      }
      // Draw path between particle and mouse position
      canvas.drawLine(sourcePosition, mousePosition, mousePaint);
    });

    // final random = Random();
    // particles.forEach((source) {
    //   particles.forEach((destination) {
    //     if (source != destination) {
    //       final dx = destination.position.dx - source.position.dx;
    //       final dy = destination.position.dy - source.position.dy;
    //       final distance = sqrt(dx * dx + dy * dy);

    //       final mdx = mousePoint.dx - source.position.dx;
    //       final mdy = mousePoint.dy - source.position.dy;
    //       final mouseDistance = sqrt(mdx * mdx + mdy * mdy);

    //       // Draw path if distance is within a threshold
    //       if (distance < 100 && random.nextDouble() < 0.15) {
    //         canvas.drawLine(source.position, destination.position, linePaint);
    //       }
    //       if (mouseDistance < 200) {
    //         canvas.drawLine(source.position, mousePoint, mousePaint);
    //       }
    //     }
    //   });
    // });
  }

  @override
  bool shouldRepaint(ParticlesPainter oldDelegate) {
    return particles != oldDelegate.particles;
  }
}
