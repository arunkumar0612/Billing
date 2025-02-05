import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/Sales_actions.dart';
import 'package:window_manager/window_manager.dart';
import 'controllers/ClientReq_actions.dart';
import 'controllers/Credit_actions.dart';
import 'controllers/DC_actions.dart';
import 'controllers/Debit_actions.dart';
import 'controllers/IAM_actions.dart';
import 'controllers/Invoice_actions.dart';
import 'controllers/Quote_actions.dart';
import 'controllers/RFQ_actions.dart';
import 'routes/app_routes.dart';
import 'services/APIservices/invoker.dart';

Future<void> main() async {
  // Initialize Flutter bindings
  WidgetsFlutterBinding.ensureInitialized();

////////////////////////////----IAM----////////////////////////////////////
  Get.lazyPut<SessiontokenController>(() => SessiontokenController());
  Get.lazyPut<LoginController>(() => LoginController());
  Get.lazyPut<RegisterController>(() => RegisterController());
  Get.lazyPut<ForgotpasswordController>(() => ForgotpasswordController());
  Get.lazyPut<NewpasswordController>(() => NewpasswordController());
  Get.lazyPut<Invoker>(() => Invoker());
  Get.lazyPut<VerifyOTPControllers>(() => VerifyOTPControllers());
  Get.lazyPut<SalesController>(() => SalesController());
  // final SalesController salesController =Get.f

////////////////////////////----SALES----////////////////////////////////////
  Get.lazyPut<ClientreqController>(() => ClientreqController());
  Get.lazyPut<InvoiceController>(() => InvoiceController());
  Get.lazyPut<QuoteController>(() => QuoteController());
  Get.lazyPut<RFQController>(() => RFQController());
  Get.lazyPut<CreditController>(() => CreditController());
  Get.lazyPut<DebitController>(() => DebitController());
  Get.lazyPut<DCController>(() => DCController());
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
