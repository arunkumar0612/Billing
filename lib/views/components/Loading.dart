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
        // PNG Image
        Image.asset(
          color: Colors.white,
          'assets/images/black.jpg', // Replace with your image
          width: 70,
          height: 70,
        ),
        // Stylish Circular Progress Indicator
        SizedBox(
          width: 120,
          height: 120,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return ShaderMask(
                shaderCallback: (Rect bounds) {
                  return SweepGradient(
                    startAngle: 0.0,
                    endAngle: 3.14 * 2,
                    colors: [
                      const Color.fromARGB(255, 100, 111, 255).withOpacity(0.0),
                      const Color.fromARGB(255, 100, 111, 255).withOpacity(0.0),
                      const Color.fromARGB(255, 100, 111, 255).withOpacity(0.0),
                      const Color.fromARGB(255, 100, 111, 255).withOpacity(0.4),
                      const Color.fromARGB(255, 100, 111, 255).withOpacity(0.5),
                    ],
                    stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
                    transform: GradientRotation(_controller.value * 12.56),
                  ).createShader(bounds);
                },
                child: Container(width: 130, height: 130, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(1), width: 6))),
              );
            },
          ),
        ),
      ],
    );
  }
}
