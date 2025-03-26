import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/controllers/Main_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/CustomPDF_Controllers/CustomPDF_DC_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/CustomPDF_Controllers/CustomPDF_Invoice_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/CustomPDF_Controllers/CustomPDF_Quote_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/Sales_actions.dart';
import 'package:ssipl_billing/controllers/SUBSCRIPTIONcontrollers/CustomPDF_Controllers/SUBSCRIPTION_CustomPDF_Invoice_actions.dart';
import 'package:ssipl_billing/controllers/SUBSCRIPTIONcontrollers/SUBSCRIPTION_ClientReq_actions.dart';
import 'package:ssipl_billing/controllers/SUBSCRIPTIONcontrollers/SUBSCRIPTION_Invoice_actions.dart';
import 'package:ssipl_billing/controllers/SUBSCRIPTIONcontrollers/SUBSCRIPTION_Quote_actions.dart';
import 'package:ssipl_billing/controllers/SUBSCRIPTIONcontrollers/Subscription_actions.dart';
import 'package:ssipl_billing/routes/app_routes.dart';
import 'package:ssipl_billing/themes/style.dart';
// import 'package:ssipl_billing/controllers/viewSend_actions.dart';
// import 'package:window_manager/window_manager.dart';
import 'controllers/SALEScontrollers/ClientReq_actions.dart';
import 'controllers/SALEScontrollers/DC_actions.dart';
import 'controllers/IAM_actions.dart';
import 'controllers/SALEScontrollers/Invoice_actions.dart';
import 'controllers/SALEScontrollers/Quote_actions.dart';
import 'controllers/SALEScontrollers/RFQ_actions.dart';
import 'services/APIservices/invoker.dart';

Future<void> main() async {
  // Initialize Flutter bindings
  WidgetsFlutterBinding.ensureInitialized();

////////////////////////////----IAM----////////////////////////////////////
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
  Get.lazyPut<MainController>(() => MainController());

  ////////////////////////--------HIERARCHY-------/////////////////////////////
  Get.lazyPut<HierarchyController>(() => HierarchyController());

  ////////////////////////////----SUBSCRIPTION----////////////////////////////////////
  Get.lazyPut<SUBSCRIPTION_InvoiceController>(() => SUBSCRIPTION_InvoiceController());
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
  runApp(const MyApp());
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
