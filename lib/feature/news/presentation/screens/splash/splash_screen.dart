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

  late AnimationController _textController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

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

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.elasticOut),
    );

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) _textController.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([_animation, _textController]),
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

              Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'TOP',
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 4,
                            ),
                          ),
                          TextSpan(
                            text: 'News',
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w300,
                              color: Colors.white70,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

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

    final armLength = size.width * 1.5 * progress;

    final bodyRadius = size.width * 1.5 * progress;

    final curveInset = bodyRadius * 0.25;

    path.moveTo(cx, cy - bodyRadius - armLength);

    path.cubicTo(
      cx + curveInset,
      cy - bodyRadius - armLength,
      cx - bodyRadius + armLength,
      cy - curveInset,
      cx + bodyRadius + armLength,
      cy,
    );

    path.cubicTo(
      cx - bodyRadius + armLength,
      cy + curveInset,
      cx + curveInset,
      cy + bodyRadius + armLength,
      cx,
      cy + bodyRadius + armLength,
    );

    path.cubicTo(
      cx - curveInset,
      cy + bodyRadius + armLength,
      cx + bodyRadius - armLength,
      cy + curveInset,
      cx - bodyRadius - armLength,
      cy,
    );

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
