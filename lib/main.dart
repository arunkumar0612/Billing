import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/CustomPDF_Controllers/SUBSCRIPTION_CustomPDF_Invoice_actions.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/SUBSCRIPTION_ClientReq_actions.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/SUBSCRIPTION_Quote_actions.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/Subscription_actions.dart';
import 'package:ssipl_billing/4.SALES/controllers/CustomPDF_Controllers/CustomPDF_DC_actions.dart';
import 'package:ssipl_billing/4.SALES/controllers/CustomPDF_Controllers/CustomPDF_Invoice_actions.dart';
import 'package:ssipl_billing/4.SALES/controllers/CustomPDF_Controllers/CustomPDF_Quote_actions.dart';
import 'package:ssipl_billing/4.SALES/controllers/Sales_actions.dart';
import 'package:ssipl_billing/7.HIERARCHY/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/API-/invoker.dart';
import 'package:ssipl_billing/IAM-/controllers/IAM_actions.dart';
import 'package:ssipl_billing/NOTIFICATION-/Notification_actions.dart';
import 'package:ssipl_billing/ROUTES-/app_routes.dart';
import 'package:ssipl_billing/THEMES-/style.dart';

import '4.SALES/controllers/ClientReq_actions.dart';
import '4.SALES/controllers/DC_actions.dart';
import '4.SALES/controllers/Invoice_actions.dart';
import '4.SALES/controllers/Quote_actions.dart';
import '4.SALES/controllers/RFQ_actions.dart';

// 33AADCK2098J1ZF
Future<void> main() async {
  // Initialize Flutter bindings
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<NotificationController>(() => NotificationController());

////////////////////////////---IAM-----////////////////////////////////////
  Get.lazyPut<IAMController>(() => IAMController());
  Get.lazyPut<SessiontokenController>(() => SessiontokenController());
  Get.lazyPut<LoginController>(() => LoginController());
  Get.lazyPut<RegisterController>(() => RegisterController());
  Get.lazyPut<ForgotpasswordController>(() => ForgotpasswordController());
  Get.lazyPut<NewpasswordController>(() => NewpasswordController());
  Get.lazyPut<Invoker>(() => Invoker());
  Get.lazyPut<VerifyOTPControllers>(() => VerifyOTPControllers());
  Get.lazyPut<SalesController>(() => SalesController());
  Get.lazyPut<DcController>(() => DcController(), tag: "main");
  Get.lazyPut<DcController>(() => DcController(), tag: "ref");

////////////////////////////----SALES----////////////////////////////////////
  Get.lazyPut<ClientreqController>(() => ClientreqController());
  Get.lazyPut<InvoiceController>(() => InvoiceController());
  Get.lazyPut<QuoteController>(() => QuoteController());
  Get.lazyPut<RfqController>(() => RfqController());
  Get.lazyPut<DcController>(() => DcController());
  Get.lazyPut<CustomPDF_InvoiceController>(() => CustomPDF_InvoiceController());
  Get.lazyPut<CustomPDF_QuoteController>(() => CustomPDF_QuoteController());
  Get.lazyPut<CustomPDF_DcController>(() => CustomPDF_DcController());

  ////////////////////////--------HIERARCHY-------/////////////////////////////
  Get.lazyPut<HierarchyController>(() => HierarchyController());

  ////////////////////////////----SUBSCRIPTION----////////////////////////////////////
  Get.lazyPut<SubscriptionController>(() => SubscriptionController());

  Get.lazyPut<SUBSCRIPTION_CustomPDF_InvoiceController>(() => SUBSCRIPTION_CustomPDF_InvoiceController());
  Get.lazyPut<SUBSCRIPTION_QuoteController>(() => SUBSCRIPTION_QuoteController());
  Get.lazyPut<SUBSCRIPTION_ClientreqController>(() => SUBSCRIPTION_ClientreqController());
  // Get.lazyPut<ViewsendController>(() => ViewsendController());
  // if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.linux)) {
  //   await windowManager.ensureInitialized();
  //   WindowOptions windowOptions = const WindowOptions(
  //     minimumSize: Size(1200, 700),
  //     center: true,
  //     backgroundColor: Colors.transparent,
  //     title: 'ERP system',
  //   );
  //   await windowManager.waitUntilReadyToShow(
  //     windowOptions,
  //     () async {
  //       await windowManager.show();
  //       await windowManager.focus();
  //       await windowManager.maximize();
  //     },
  //   );
  // }
  // List<int> odd_array = [];
  // List<int> even_array = [];
  // List<int> final_array = [];

  // for (int i = 1; i <= 10; i++) {
  //   if (i % 2 == 0) {
  //     even_array.add(i); // Corrected: Even numbers go to `even_array`
  //   } else {
  //     odd_array.add(i); // Corrected: Odd numbers go to `odd_array`
  //   }
  // }
  // print("Odd Array: $odd_array");
  // print("Even Array: $even_array");

  // final_array.addAll(odd_array);
  // final_array.addAll(even_array);

  // print("Final Array: $final_array");
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
