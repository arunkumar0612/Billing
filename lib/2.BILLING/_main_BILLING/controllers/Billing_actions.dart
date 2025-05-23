import 'dart:io';

import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/Vouchers/models/entities/voucher_entities.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/models/constants/Billing_constants.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/models/entities/Billing_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class MainBilling_Controller extends GetxController {
  var billingModel = BillingModel();
  void addto_SubscriptionInvoiceList(SubscriptionInvoice element) {
    billingModel.subscriptionInvoiceList.add(element);
  }

  void addto_SalesInvoiceList(SalesInvoice element) {
    billingModel.salesInvoiceList.add(element);
  }

  Future<void> PDFfileApiData(CMDmResponse value) async {
    var pdfFileData = await PDFfileData.fromJson(value); // Await async function
    var binaryData = pdfFileData.data; // Extract File object
    await updatePDFfile(binaryData);
  }

  Future<void> updatePDFfile(File value) async {
    billingModel.pdfFile.value = value;
  }
}
