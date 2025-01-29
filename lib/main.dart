import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

import 'routes/app_routes.dart';

Future<void> main() async {
  // Initialize Flutter bindings
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize window_manager only on supported platforms
  if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.linux)) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      minimumSize: Size(1200, 700),
      center: true,
      backgroundColor: Colors.transparent,
      title: 'B I L L I N G',
    );
    await windowManager.waitUntilReadyToShow(
      windowOptions,
      () async {
        await windowManager.show();
        await windowManager.focus();
      },
    );
  }
  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ERP',
      // home: const IAM(),
      initialRoute: '/login', // Set the initial route
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: const IconThemeData(color: Colors.white),
        primarySwatch: Colors.blue,
        useMaterial3: false,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.orange,
          selectionColor: Color.fromARGB(255, 72, 191, 147),
        ),
        scrollbarTheme: ScrollbarThemeData(
          trackColor: WidgetStateProperty.all(
            const Color.fromARGB(255, 229, 204, 10),
          ),
          trackBorderColor: WidgetStateProperty.all(
            const Color.fromARGB(255, 10, 183, 206),
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
