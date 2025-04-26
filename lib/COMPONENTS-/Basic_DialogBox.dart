import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

// import '../../THEMES-/style.dart';

// Future<bool?> Basic_dialog({
//   required BuildContext context,
//   required String title,
//   required String content,
//   required bool showCancel, // Show the Cancel button
//   VoidCallback? onOk, // Optional action for the OK button
// }) async {
//   return await showDialog<bool>(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         // shadowColor: Primary_colors.Color3,
//         titlePadding: const EdgeInsets.all(5),
//         backgroundColor: const Color.fromARGB(255, 194, 198, 253), // Matching background color
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10), // Consistent with Snackbar
//         ),
//         title: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(7),
//             color: Primary_colors.Color3,
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(7),
//             child: Text(
//               title,
//               style: const TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//         content: Text(
//           content,
//           style: const TextStyle(color: Primary_colors.Light, fontSize: 12), // Adjusting text color for visibility
//         ),
//         actions: [
//           if (showCancel)
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(false), // Cancel returns `false`
//               child: const Text('Cancel', style: TextStyle(color: Primary_colors.Light, fontSize: 14, fontWeight: FontWeight.bold)),
//             ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(true); // OK returns `true`
//               if (onOk != null) {
//                 onOk(); // Call onOk only if it's provided
//               }
//             },
//             child: const Text('OK', style: TextStyle(color: Primary_colors.Light, fontSize: 14, fontWeight: FontWeight.bold)),
//           ),
//         ],
//       );
//     },
//   );
// }

Future<bool?> Success_dialog({
  required BuildContext context,
  required String title,
  required String content,
  VoidCallback? onOk,
}) async {
  return await showGeneralDialog<bool>(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return ScaleTransition(
        scale: CurvedAnimation(
          parent: animation,
          curve: Curves.elasticOut,
          reverseCurve: Curves.easeOutCubic,
        ),
        child: FadeTransition(
          opacity: animation,
          child: AlertDialog(
            backgroundColor: const Color(0xFFE6F4EA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Colors.green, width: 2),
            ),
            titlePadding: const EdgeInsets.all(5),
            title: Column(
              children: [
                const SizedBox(height: 10),
                TweenAnimationBuilder(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: child,
                    );
                  },
                  child: const Icon(
                    Icons.check_circle_rounded,
                    size: 48,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TweenAnimationBuilder(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutBack,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    elevation: 3,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    if (onOk != null) {
                      onOk();
                    }
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 400),
  );
}

Future<bool?> Warning_dialog({
  required BuildContext context,
  required String title,
  required String content,
  VoidCallback? onOk,
}) async {
  return await showGeneralDialog<bool>(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.5),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        )),
        child: FadeTransition(
          opacity: animation,
          child: AlertDialog(
            backgroundColor: const Color(0xFFFFF8E1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Colors.orangeAccent, width: 2),
            ),
            titlePadding: const EdgeInsets.all(5),
            title: Column(
              children: [
                const SizedBox(height: 10),
                RotationTransition(
                  turns: Tween(begin: -0.1, end: 0.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.elasticOut,
                    ),
                  ),
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    size: 48,
                    color: Colors.orangeAccent,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TweenAnimationBuilder(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutBack,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.orange),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  ),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              TweenAnimationBuilder(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeOutBack,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    elevation: 3,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    if (onOk != null) {
                      onOk();
                    }
                  },
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 500),
  );
}

Future<bool?> Error_dialog({
  required BuildContext context,
  required String title,
  required String content,
  VoidCallback? onOk,
}) async {
  return await showGeneralDialog<bool>(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return ScaleTransition(
        scale: Tween(begin: 1.1, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.fastOutSlowIn,
          ),
        ),
        child: FadeTransition(
          opacity: animation,
          child: AlertDialog(
            backgroundColor: const Color.fromARGB(255, 255, 230, 230),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Colors.redAccent, width: 2),
            ),
            titlePadding: const EdgeInsets.all(5),
            title: Column(
              children: [
                const SizedBox(height: 10),
                TweenAnimationBuilder(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.bounceOut,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: child,
                    );
                  },
                  child: const Icon(
                    Icons.error_rounded,
                    size: 48,
                    color: Colors.redAccent,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TweenAnimationBuilder(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutBack,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    elevation: 3,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    if (onOk != null) {
                      onOk();
                    }
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 500),
  );
}

// void Basic_SnackBar(BuildContext context, String message) {
//   Flushbar(
//     message: message,
//     margin: const EdgeInsets.all(10),
//     borderRadius: BorderRadius.circular(10),
//     backgroundColor: Primary_colors.Color3, shouldIconPulse: true,
//     icon: const Icon(Icons.check_circle, color: Primary_colors.Color1),
//     duration: const Duration(seconds: 3),
//     flushbarPosition: FlushbarPosition.BOTTOM, // Change to BOTTOM if needed
//     animationDuration: const Duration(milliseconds: 500),
//     forwardAnimationCurve: Curves.fastOutSlowIn,
//     reverseAnimationCurve: Curves.easeOut,
//     leftBarIndicatorColor: Primary_colors.Color1, isDismissible: true,
//     dismissDirection: FlushbarDismissDirection.HORIZONTAL,
//     boxShadows: [
//       BoxShadow(
//         // ignore: deprecated_member_use
//         color: Primary_colors.Color3.withOpacity(0.3),
//         blurRadius: 10,
//         spreadRadius: 2,
//       ),
//     ],
//   ).show(context);
// }
void Success_SnackBar(BuildContext context, String message) {
  Flushbar(
    message: message,
    margin: const EdgeInsets.all(10),
    borderRadius: BorderRadius.circular(10),
    backgroundColor: const Color(0xFF4CAF50), // Success green
    shouldIconPulse: true,
    icon: const Icon(Icons.check_circle_outline, color: Colors.white, size: 28),
    duration: const Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.BOTTOM,
    animationDuration: const Duration(milliseconds: 500),
    forwardAnimationCurve: Curves.fastOutSlowIn,
    reverseAnimationCurve: Curves.easeOut,
    leftBarIndicatorColor: Colors.white,
    isDismissible: true,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    boxShadows: [
      BoxShadow(
        color: const Color(0xFF4CAF50).withOpacity(0.3),
        blurRadius: 10,
        spreadRadius: 2,
      ),
    ],
  ).show(context);
}

void Warning_SnackBar(BuildContext context, String message) {
  Flushbar(
    message: message,
    margin: const EdgeInsets.all(10),
    borderRadius: BorderRadius.circular(10),
    backgroundColor: const Color.fromARGB(255, 248, 165, 39), // Warning orange (Material Orange 500)
    shouldIconPulse: true,
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 28),
    duration: const Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.BOTTOM,
    animationDuration: const Duration(milliseconds: 500),
    forwardAnimationCurve: Curves.fastOutSlowIn,
    reverseAnimationCurve: Curves.easeOut,
    leftBarIndicatorColor: Colors.white,
    isDismissible: true,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    boxShadows: [
      BoxShadow(
        color: const Color(0xFFFF9800).withOpacity(0.3),
        blurRadius: 10,
        spreadRadius: 2,
      ),
    ],
  ).show(context);
}

void Error_SnackBar(BuildContext context, String message) {
  Flushbar(
    message: message,
    margin: const EdgeInsets.all(10),
    borderRadius: BorderRadius.circular(10),
    backgroundColor: const Color(0xFFF44336), // Error red (Material Red 500)
    shouldIconPulse: true,
    icon: const Icon(Icons.error_outline, color: Colors.white, size: 28),
    duration: const Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.BOTTOM,
    animationDuration: const Duration(milliseconds: 500),
    forwardAnimationCurve: Curves.fastOutSlowIn,
    reverseAnimationCurve: Curves.easeOut,
    leftBarIndicatorColor: Colors.white,
    isDismissible: true,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    boxShadows: [
      BoxShadow(
        color: const Color(0xFFF44336).withOpacity(0.3),
        blurRadius: 10,
        spreadRadius: 2,
      ),
    ],
  ).show(context);
}
