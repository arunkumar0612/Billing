// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ssipl_billing/THEMES/style.dart';

class LoadingOverlay {
  static final LoadingOverlay _instance = LoadingOverlay._internal();
  factory LoadingOverlay() => _instance;

  LoadingOverlay._internal();

  BuildContext? _dialogContext;
  Completer<void>? _completer;

  Future<void> start(BuildContext context) async {
    if (_dialogContext != null || (_completer?.isCompleted == false)) return;

    _completer = Completer<void>();

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent manual dismissal
      builder: (dialogContext) {
        _dialogContext = dialogContext;
        // ignore: duplicate_ignore
        // ignore: deprecated_member_use
        return Scaffold(
            backgroundColor: Colors.transparent,
            body: WillPopScope(
              onWillPop: () async => false, // Disable back button
              child: Stack(
                children: [
                  // Background Blur
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  // Loading Box
                  Center(
                    child: Container(
                      width: 520,
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(color: Colors.black26, blurRadius: 10),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Animated Progress Bar
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              minHeight: 9,
                              backgroundColor: Colors.grey[300],
                              valueColor: const AlwaysStoppedAnimation<Color>(Primary_colors.Color3),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Loading Text
                          const Text(
                            "Loading, please wait...",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );

    return _completer!.future;
  }

  void stop() {
    if (_dialogContext != null && Navigator.canPop(_dialogContext!)) {
      Navigator.of(_dialogContext!).pop();
      _dialogContext = null;
      _completer?.complete();
    }
  }
}

class LoadingWithStyledIndicator extends StatefulWidget {
  const LoadingWithStyledIndicator({super.key});

  @override
  _LoadingWithStyledIndicatorState createState() => _LoadingWithStyledIndicatorState();
}

class _LoadingWithStyledIndicatorState extends State<LoadingWithStyledIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Center Image (Ensure this image exists in assets)
        Image.asset(
          'assets/images/black.jpg', // Update path if needed
          width: 70,
          height: 70,
          color: Colors.white,
        ),
        // Circular Animated Loader
        SizedBox(
          width: 120,
          height: 120,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: CircularIndicatorPainter(_controller.value),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CircularIndicatorPainter extends CustomPainter {
  final double progress;
  CircularIndicatorPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = SweepGradient(
        colors: [
          //  const Color.fromARGB(255, 100, 111, 255).withOpacity(0.0),
          const Color.fromARGB(255, 100, 111, 255).withOpacity(0.0),
          const Color.fromARGB(255, 100, 111, 255).withOpacity(0.2),
          const Color.fromARGB(255, 100, 111, 255).withOpacity(0.5),
          const Color.fromARGB(255, 100, 111, 255).withOpacity(0.8),
        ],
        stops: const [0.0, 0.3, 0.7, 1.0],
        transform: GradientRotation(progress * 2 * 3.14),
      ).createShader(Rect.fromCircle(center: size.center(Offset.zero), radius: size.width / 2))
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
