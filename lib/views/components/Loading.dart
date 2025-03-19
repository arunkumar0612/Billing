import 'dart:ui';

import 'package:flutter/material.dart';

// Function to Show Dialog with API Call
void showLoading(BuildContext context, Future<dynamic> Function() apiCall) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent user from dismissing manually
    builder: (context) {
      // Get a reference to Navigator
      final navigator = Navigator.of(context);

      // Start the API call and close the dialog when done
      // Future.wait([
      //   apiCall(),
      //   Future.delayed(const Duration(seconds: 2)), // Ensures at least 2 sec delay
      // ])
      Future.delayed(const Duration(seconds: 15), () {
        if (navigator.mounted) {
          navigator.pop(); // Close the loader if it's still open
        }
      });

      apiCall().then((_) {
        if (navigator.mounted) {
          navigator.pop(); // Close loader when API call completes
        }
      }).catchError((error) {
        if (navigator.mounted) {
          navigator.pop(); // Close loader on error
        }
        print("API Error: $error");
      });

      return Stack(
        children: [
          // Blurred Background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(
              color: Colors.black.withOpacity(0.8), // Dark semi-transparent overlay
            ),
          ),

          // Loading Animation
          const Center(child: LoadingWithStyledIndicator()),
        ],
      );
    },
  );
}

class LoadingOverlay {
  static final LoadingOverlay _instance = LoadingOverlay._internal();
  factory LoadingOverlay() => _instance;

  LoadingOverlay._internal();

  BuildContext? _dialogContext;

  Future<void> start(BuildContext context) async {
    if (_dialogContext != null) return; // Prevent multiple dialogs from opening

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent manual dismissal
      builder: (dialogContext) {
        _dialogContext = dialogContext;
        return Stack(
          children: [
            // Blurred Background
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            // Loading Animation
            const Center(child: LoadingWithStyledIndicator()),
          ],
        );
      },
    );
  }

  void stop() {
    if (_dialogContext != null) {
      Navigator.of(_dialogContext!).pop();
      _dialogContext = null;
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
