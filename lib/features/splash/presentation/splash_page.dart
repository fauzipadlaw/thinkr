import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thinkr/core/theme/app_colors.dart';

class SplashWrapper extends StatefulWidget {
  final Widget? child;

  const SplashWrapper({super.key, required this.child});

  @override
  State<SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  bool _showingSplash = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _controller.forward();

    Timer(const Duration(milliseconds: 1400), () {
      if (mounted) {
        setState(() {
          _showingSplash = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: _showingSplash
          ? _SplashScreen(fade: _fade)
          : widget.child ?? const SizedBox.shrink(),
    );
  }
}

class _SplashScreen extends StatelessWidget {
  final Animation<double> fade;

  const _SplashScreen({required this.fade});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.bgDeep, AppColors.bgResult],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned.fill(
            child: CustomPaint(painter: _SplashGlowPainter()),
          ),
          Center(
            child: FadeTransition(
              opacity: fade,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.9, end: 1.0).animate(fade),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 82,
                      height: 82,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [AppColors.brandPrimary, AppColors.brandAccent],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.brandPrimary.withValues(alpha: 0.5),
                            blurRadius: 30,
                            spreadRadius: 4,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 42,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Thinkr',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your decision co-pilot',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashGlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 90);

    paint.color = AppColors.brandPrimary.withValues(alpha: 0.28);
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.35), 160, paint);

    paint.color = AppColors.brandAccent.withValues(alpha: 0.22);
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.3), 180, paint);

    paint.color = AppColors.brandPurple.withValues(alpha: 0.18);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.7), 240, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
