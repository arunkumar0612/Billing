import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/Initialize.dart';
import 'package:ssipl_billing/ROUTES-/app_routes.dart';
import 'package:ssipl_billing/THEMES-/style.dart';

// 33AADCK2098J1ZF
Future<void> main() async {
  // Initialize Flutter bindings
  WidgetsFlutterBinding.ensureInitialized();
  initialize_IAM();
  initialize_others();

  runApp(const MyApp());
  DesktopWindow.setMinWindowSize(const Size(1366.0, 768.0));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ERP',
      // home: const IAM(),
      initialRoute: '/IAM', // Set the initial route
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: const IconThemeData(color: Colors.white),
        primaryColor: Primary_colors.Color3,
        useMaterial3: false,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Primary_colors.Color3,
          selectionColor: Color.fromARGB(255, 130, 223, 230),
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
