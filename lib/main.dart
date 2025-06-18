import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/Initialize.dart';
import 'package:ssipl_billing/ROUTES/app_routes.dart';
import 'package:ssipl_billing/ROUTES/route_names.dart';
import 'package:ssipl_billing/THEMES/style.dart';

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

// 33AADCK2098J1ZF
Future<void> main() async {
  // Initialize Flutter bindings
  WidgetsFlutterBinding.ensureInitialized();
  initialize_IAM();
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
