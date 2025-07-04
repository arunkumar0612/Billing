// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/RFQ_actions.dart';
import 'package:ssipl_billing/5_VENDOR/views/Generate_RFQ/generateRFQ.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/THEMES/style.dart';

// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../API/invoker.dart';
import '../controllers/Vendor_actions.dart';

mixin VendorServices {
  final Invoker apiController = Get.find<Invoker>();

  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final VendorController vendorController = Get.find<VendorController>();
  final vendor_RfqController rfqController = Get.find<vendor_RfqController>();
  final loader = LoadingOverlay();

  dynamic GenerateRfq_dialougebox(context) async {
    await showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing the dialog by clicking outside
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Primary_colors.Dark,
          content: Stack(
            children: [
              SizedBox(
                height: 650,
                width: 900,
                child: GenerateRfq(),
              ),
              Positioned(
                top: 3,
                right: 0,
                child: IconButton(
                  icon: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 219, 216, 216),
                    ),
                    height: 30,
                    width: 30,
                    child: const Icon(Icons.close, color: Colors.red),
                  ),
                  onPressed: () async {
                    // Check if the data has any value
                    // || ( rfqController.rfqModel.Invoice_gstTotals.isNotEmpty)
                    if ((rfqController.rfqModel.Rfq_products.isNotEmpty) ||
                        (rfqController.rfqModel.Rfq_noteList.isNotEmpty) ||
                        (rfqController.rfqModel.Rfq_recommendationList.isNotEmpty) ||
                        // (rfqController.rfqModel.clientAddressNameController.value.text != "") ||
                        (rfqController.rfqModel.AddressController.value.text != "") ||
                        // (rfqController.rfqModel.billingAddressNameController.value.text != "") ||
                        // (rfqController.rfqModel.billingAddressController.value.text != "") ||
                        (rfqController.rfqModel.Rfq_no.value != "") ||
                        (rfqController.rfqModel.TitleController.value.text != "") ||
                        (rfqController.rfqModel.recommendationHeadingController.value.text != "")) {
                      // Show confirmation dialog
                      bool? proceed = await Warning_dialog(context: context, title: 'Warning', content: "The data may be lost. Do you want to proceed?");
                      if (proceed == true) {
                        Navigator.of(context).pop();
                        rfqController.resetData();
                      }
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

// // ##################################################################################################################################################################################################################################################################################################################################################################

  String formatNumber(int number) {
    if (number >= 10000000) {
      return "₹ ${(number / 10000000).toStringAsFixed(1)}Cr";
    } else if (number >= 100000) {
      return "₹ ${(number / 100000).toStringAsFixed(1)}L";
    } else if (number >= 1000) {
      return "₹ ${(number / 1000).toStringAsFixed(1)}K";
    } else {
      return "₹ $number";
    }
  }

  Future<void> vendor_refresh() async {
    // vendorController.resetData();
    vendorController.updateshowvendorprocess(null);
    vendorController.updatevendorId(0);

    vendorController.update();
  }
}
