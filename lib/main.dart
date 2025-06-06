import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/Initialize.dart';
import 'package:ssipl_billing/ROUTES/app_routes.dart';
import 'package:ssipl_billing/ROUTES/route_names.dart';
import 'package:ssipl_billing/THEMES/style.dart';

// 33AADCK2098J1ZF

/// The main entry point of the application
Future<void> main() async {
  // Initialize Flutter bindings
  WidgetsFlutterBinding.ensureInitialized();

  ///  Ensures that all the Flutter widgets and plugins are initialized before runApp is called
  initialize_IAM();

  /// Custom initialization method for Identity and Access Management (IAM) module
  initialize_others();

  /// Custom initialization method for other modules/services

  runApp(const MyApp());
  DesktopWindow.setMinWindowSize(const Size(1366.0, 768.0));
}

///This MyApp class is the root of the Flutter application, using GetMaterialApp from the GetX package to set up routing, theming, and global configurations.
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
          selectionColor: Color.fromARGB(97, 87, 87, 87),
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
