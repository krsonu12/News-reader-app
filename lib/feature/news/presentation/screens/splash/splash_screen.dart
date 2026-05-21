import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader_app/core/routes/app_router.gr.dart';
import 'package:news_reader_app/core/theme/app_colors.dart';

@RoutePage()
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        context.router.replace(HomeRoute());
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Container(color: AppColors.colorNavyBlue),

              Center(
                child: CustomPaint(
                  size: Size(
                    MediaQuery.of(context).size.width * 2,
                    MediaQuery.of(context).size.height * 2,
                  ),
                  painter: SplashShapePainter(_animation.value),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Custom painter
class SplashShapePainter extends CustomPainter {
  final double progress;
  SplashShapePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.colorSkyBlue
      ..style = PaintingStyle.fill;

    final path = Path();

    final cx = size.width / 2;
    final cy = size.height / 2;

    // Arm extension
    final armLength = size.width * 1.5 * progress;
    // Central fat body
    final bodyRadius = size.width * 1.5 * progress;
    // How deep the inner curves bend inward
    final curveInset = bodyRadius * 0.25;

    // Start at top
    path.moveTo(cx, cy - bodyRadius - armLength);

    // Top → Right (rounded inward curve)
    path.cubicTo(
      cx + curveInset,
      cy - bodyRadius - armLength, // control1
      cx - bodyRadius + armLength,
      cy - curveInset, // control2
      cx + bodyRadius + armLength,
      cy, // end
    );

    // Right → Bottom
    path.cubicTo(
      cx - bodyRadius + armLength,
      cy + curveInset,
      cx + curveInset,
      cy + bodyRadius + armLength,
      cx,
      cy + bodyRadius + armLength,
    );

    // Bottom → Left
    path.cubicTo(
      cx - curveInset,
      cy + bodyRadius + armLength,
      cx + bodyRadius - armLength,
      cy + curveInset,
      cx - bodyRadius - armLength,
      cy,
    );

    // Left → Top
    path.cubicTo(
      cx + bodyRadius - armLength,
      cy - curveInset,
      cx - curveInset,
      cy - bodyRadius - armLength,
      cx,
      cy - bodyRadius - armLength,
    );

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant SplashShapePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
