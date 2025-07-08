import 'package:get/get.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/controller/GST_ledger_action.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/controller/TDS_ledger_action.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/controller/account_ledger_action.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/controller/view_ledger_action.dart';
import 'package:ssipl_billing/2_BILLING/Vouchers/controllers/voucher_action.dart';
import 'package:ssipl_billing/2_BILLING/_main_BILLING/controllers/Billing_actions.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/controllers/CustomPDF_Controllers/SUBSCRIPTION_CustomPDF_Invoice_actions.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/controllers/SUBSCRIPTION_ClientReq_actions.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/controllers/SUBSCRIPTION_Quote_actions.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/controllers/Subscription_actions.dart';
import 'package:ssipl_billing/4_SALES/controllers/ClientReq_actions.dart';
import 'package:ssipl_billing/4_SALES/controllers/CustomPDF_Controllers/CustomPDF_DC_actions.dart';
import 'package:ssipl_billing/4_SALES/controllers/CustomPDF_Controllers/CustomPDF_Invoice_actions.dart';
import 'package:ssipl_billing/4_SALES/controllers/CustomPDF_Controllers/CustomPDF_Quote_actions.dart';
import 'package:ssipl_billing/4_SALES/controllers/DC_actions.dart';
import 'package:ssipl_billing/4_SALES/controllers/Invoice_actions.dart';
import 'package:ssipl_billing/4_SALES/controllers/Quote_actions.dart';
import 'package:ssipl_billing/4_SALES/controllers/RFQ_actions.dart';
import 'package:ssipl_billing/4_SALES/controllers/Sales_actions.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/Quote_actions.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/RFQ_actions.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/VendorList_actions.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/Vendor_actions.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/manual_onboard_actions.dart';
import 'package:ssipl_billing/7_HIERARCHY/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/NOTIFICATION-/Notification_actions.dart';

void initialize_IAM() {
  Get.lazyPut<IAMController>(() => IAMController());
  Get.lazyPut<SessiontokenController>(() => SessiontokenController());
  Get.lazyPut<LoginController>(() => LoginController());
  Get.lazyPut<RegisterController>(() => RegisterController());
  Get.lazyPut<ForgotpasswordController>(() => ForgotpasswordController());
  Get.lazyPut<NewpasswordController>(() => NewpasswordController());
  Get.lazyPut<Invoker>(() => Invoker());
  Get.lazyPut<VerifyOTPControllers>(() => VerifyOTPControllers());
  Get.lazyPut<GST_LedgerController>(() => GST_LedgerController());
}

void initialize_others() {
  Get.lazyPut<NotificationController>(() => NotificationController());
////////////////////////////----SALES----////////////////////////////////////
  Get.lazyPut<SalesController>(() => SalesController());
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

  ////////////////////////////----BILLING----////////////////////////////////////
  Get.lazyPut<MainBilling_Controller>(() => MainBilling_Controller());
  Get.lazyPut<VoucherController>(() => VoucherController());
  Get.lazyPut<View_LedgerController>(() => View_LedgerController());
  Get.lazyPut<Account_LedgerController>(() => Account_LedgerController());
  Get.lazyPut<TDS_LedgerController>(() => TDS_LedgerController());
  Get.lazyPut<GST_LedgerController>(() => GST_LedgerController());
  Get.lazyPut<ManualOnboardController>(() => ManualOnboardController());

  ////////////////////////////----VENDOR----////////////////////////////////////
  Get.lazyPut<VendorController>(() => VendorController());
  Get.lazyPut<vendor_RfqController>(() => vendor_RfqController());
  Get.lazyPut<Vendor_QuoteController>(() => Vendor_QuoteController());
  Get.lazyPut<VendorListController>(() => VendorListController());
}
