import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/Initialize.dart';
import 'package:ssipl_billing/ROUTES/app_routes.dart';
import 'package:ssipl_billing/ROUTES/route_names.dart';
import 'package:ssipl_billing/THEMES/style.dart';

/// This RestartWidget class allows the entire Flutter application to be programmatically restarted by rebuilding its widget tree using a new UniqueKey.
///  It wraps the app's root widget and exposes a static method restartApp that triggers a rebuild from the top, effectively resetting all UI state without restarting the actual process.

class RestartWidget extends StatefulWidget {
  final Widget child;

  const RestartWidget({super.key, required this.child});

  static void restartApp(BuildContext context) {
    final _RestartWidgetState? state = context.findAncestorStateOfType<_RestartWidgetState>();
    state?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key _key = UniqueKey();

  void restartApp() {
    setState(() {
      _key = UniqueKey(); // Rebuild the whole widget tree
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _key,
      child: widget.child,
    );
  }
}

/// The main entry point of the application
Future<void> main() async {
  // Initialize Flutter bindings
  WidgetsFlutterBinding.ensureInitialized();

  ///  Ensures that all the Flutter widgets and plugins are initialized before runApp is called
  initialize_IAM();

  /// Custom initialization method for Identity and Access Management (IAM) module
  initialize_others();

  runApp(const RestartWidget(child: MyApp()));
  DesktopWindow.setMinWindowSize(const Size(1366.0, 768.0));
}

// Key _appKey = UniqueKey();
// void reloadApp() {
//   setState(() {
//     _appKey = UniqueKey(); // Forces widget tree to rebuild
//   });
// }

/// This MyApp class is the root of the Flutter application, using GetMaterialApp from the GetX package to set up routing, theming, and global configurations.
/// It defines the app's title, initial route, available routes, custom theme (including scrollbar and text selection styles), and hides the debug banner.

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // home: const IAM(),
      title: 'ERP',
      // home: const IAM(),
      initialRoute: RouteNames.IAM, // Set the initial route
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: const IconThemeData(color: Colors.white),
        primaryColor: Primary_colors.Color3,
        useMaterial3: false,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Primary_colors.Color3,
          selectionColor: Color.fromARGB(96, 122, 122, 122),
        ),
        scrollbarTheme: ScrollbarThemeData(
          trackColor: WidgetStateProperty.all(
            const Color.fromARGB(255, 229, 204, 10),
          ),
          trackBorderColor: WidgetStateProperty.all(
            Primary_colors.Color3,
          ),
          thumbColor: const WidgetStatePropertyAll(
            Color.fromARGB(255, 90, 90, 90),
          ),
        ),
        fontFamily: 'Poppins',
      ),
    );
  }
}
