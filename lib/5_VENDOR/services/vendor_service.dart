// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/PO_actions.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/Quote_actions.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/RFQ_actions.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/RRFQ_actions.dart';
import 'package:ssipl_billing/5_VENDOR/views/Generate_PO/generatePO.dart';
import 'package:ssipl_billing/5_VENDOR/views/Generate_RFQ/generateRFQ.dart';
import 'package:ssipl_billing/5_VENDOR/views/Generate_RRFQ/generateRRFQ.dart';
import 'package:ssipl_billing/5_VENDOR/views/Upload_Quote/uploadQuote.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/THEMES/style.dart';

// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../API/invoker.dart';
import '../controllers/Vendor_actions.dart';

mixin VendorServices {
  final Invoker apiController = Get.find<Invoker>();
  final Vendor_QuoteController quoteController = Get.find<Vendor_QuoteController>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final VendorController vendorController = Get.find<VendorController>();
  final vendor_RfqController vendor_rfqController = Get.find<vendor_RfqController>();
  final vendor_RrfqController rrfqController = Get.find<vendor_RrfqController>();
  final vendor_PoController poController = Get.find<vendor_PoController>();
  final loader = LoadingOverlay();
  Future<void> Get_vendorProcessList(int vendorid) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"vendorid": vendorid, "listtype": vendorController.vendorModel.type.value}, API.vendor_getprocesslist_API);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Process List', content: "Process List fetched successfully", onOk: () {});
          vendorController.vendorModel.processList.clear();
          vendorController.addToProcessList(value);
          // vendor_rfqController.search(vendor_rfqController.rfqModel.searchQuery.value);
        } else {
          if (kDebugMode) {
            print("error : ${value.message}");
          }
          // await Basic_dialog(context: context, showCancel: false, title: 'Process List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        if (kDebugMode) {
          print("error : ${"please contact administration"}");
        }
        // Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      if (kDebugMode) {
        print("error : $e");
      }
      // Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
    }
  }

  Future<void> Get_vendorProcesscustomerList() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.active_vendors);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Processcustomer List', content: "Processcustomer List fetched successfully", onOk: () {});
          vendorController.vendorModel.processcustomerList.clear();
          vendorController.addToVendor_customerList(value);
          vendorController.search(vendorController.vendorModel.searchQuery.value);
          // vendorController.updatecustomerId(vendorController.salesModel.processcustomerList[vendorController.salesModel.showcustomerprocess.value!].customerId);
        } else {
          if (kDebugMode) {
            print("error : ${value.message}");
          }
          // await Basic_dialog(context: context, showCancel: false, title: 'Processcustomer List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        if (kDebugMode) {
          print("error : ${"please contact administration"}");
        }
        // Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      if (kDebugMode) {
        print("error : $e");
      }
      // Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
    }
  }

  dynamic Generate_VendorRfq_dialougebox(context) async {
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
                    // || ( vendor_rfqController.rfqModel.Invoice_gstTotals.isNotEmpty)
                    if ((vendor_rfqController.rfqModel.Rfq_products.isNotEmpty) ||
                        (vendor_rfqController.rfqModel.Rfq_noteList.isNotEmpty) ||
                        (vendor_rfqController.rfqModel.Rfq_recommendationList.isNotEmpty) ||
                        // (vendor_rfqController.rfqModel.clientAddressNameController.value.text != "") ||
                        (vendor_rfqController.rfqModel.AddressController.value.text != "") ||
                        // (vendor_rfqController.rfqModel.billingAddressNameController.value.text != "") ||
                        // (vendor_rfqController.rfqModel.billingAddressController.value.text != "") ||
                        (vendor_rfqController.rfqModel.Rfq_no.value != "") ||
                        (vendor_rfqController.rfqModel.AddressController.value.text != "") ||
                        (vendor_rfqController.rfqModel.GSTIN_Controller.value.text != "") ||
                        (vendor_rfqController.rfqModel.PAN_Controller.value.text != "") ||
                        (vendor_rfqController.rfqModel.TitleController.value.text != "") ||
                        (vendor_rfqController.rfqModel.recommendationHeadingController.value.text != "")) {
                      // Show confirmation dialog
                      bool? proceed = await Warning_dialog(context: context, title: 'Warning', content: "The data may be lost. Do you want to proceed?");
                      if (proceed == true) {
                        Navigator.of(context).pop();
                        vendor_rfqController.resetData();
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

  dynamic GenerateRrfq_dialougebox(context) async {
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
                width: 1300,
                child: GenerateRrfq(),
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
                    // || ( vendor_rfqController.rfqModel.Invoice_gstTotals.isNotEmpty)
                    if ((rrfqController.rrfqModel.Rrfq_products.isNotEmpty) ||
                        (rrfqController.rrfqModel.Rrfq_noteList.isNotEmpty) ||
                        (rrfqController.rrfqModel.Rrfq_recommendationList.isNotEmpty) ||
                        // (vendor_rfqController.rfqModel.clientAddressNameController.value.text != "") ||
                        (rrfqController.rrfqModel.AddressController.value.text != "") ||
                        // (vendor_rfqController.rfqModel.billingAddressNameController.value.text != "") ||
                        // (vendor_rfqController.rfqModel.billingAddressController.value.text != "") ||
                        (rrfqController.rrfqModel.Rrfq_no.value != "") ||
                        (rrfqController.rrfqModel.AddressController.value.text != "") ||
                        (rrfqController.rrfqModel.GSTIN_Controller.value.text != "") ||
                        (rrfqController.rrfqModel.PAN_Controller.value.text != "") ||
                        (rrfqController.rrfqModel.recommendationHeadingController.value.text != "")) {
                      // Show confirmation dialog
                      bool? proceed = await Warning_dialog(context: context, title: 'Warning', content: "The data may be lost. Do you want to proceed?");
                      if (proceed == true) {
                        Navigator.of(context).pop();
                        rrfqController.resetData();
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

  dynamic GeneratePo_dialougebox(context) async {
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
                width: 1300,
                child: GeneratePo(),
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
                    if ((poController.poModel.Po_products.isNotEmpty) ||
                        (poController.poModel.Po_noteList.isNotEmpty) ||
                        (poController.poModel.Po_recommendationList.isNotEmpty) ||
                        // (rfqController.rfqModel.clientAddressNameController.value.text != "") ||
                        (poController.poModel.AddressController.value.text != "") ||
                        // (rfqController.rfqModel.billingAddressNameController.value.text != "") ||
                        // (rfqController.rfqModel.billingAddressController.value.text != "") ||
                        (poController.poModel.Po_no.value != "") ||
                        (poController.poModel.AddressController.value.text != "") ||
                        (poController.poModel.GSTIN_Controller.value.text != "") ||
                        (poController.poModel.PAN_Controller.value.text != "") ||
                        (poController.poModel.recommendationHeadingController.value.text != "")) {
                      // Show confirmation dialog
                      bool? proceed = await Warning_dialog(context: context, title: 'Warning', content: "The data may be lost. Do you want to proceed?");
                      if (proceed == true) {
                        Navigator.of(context).pop();
                        poController.resetData();
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

  dynamic uploadQuote_dialougebox(context) async {
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
                child: UploadQuote(),
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
                    // || ( vendor_rfqController.rfqModel.Invoice_gstTotals.isNotEmpty)
                    if ((quoteController.quoteModel.selectedPdf.value != null) || (quoteController.quoteModel.feedbackController.value.text != "")) {
                      // Show confirmation dialog
                      bool? proceed = await Warning_dialog(context: context, title: 'Warning', content: "The data may be lost. Do you want to proceed?");
                      if (proceed == true) {
                        Navigator.of(context).pop();
                        quoteController.resetData();
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

  void UpdateFeedback(context, int vendorid, int eventid, feedback) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"eventid": eventid, "feedback": feedback}, API.vendor_addfeedback_API);
      if (response?['statusCode'] == 200) {
        CMResponse value = CMResponse.fromJson(response ?? {});
        if (value.code) {
          Get_vendorProcessList(vendorid);
          Success_SnackBar(context, "Feedback added successfully");
          // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
        } else {
          await Error_dialog(context: context, title: 'Feedback add Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  Future<bool> Get_vendorPDFfile({required BuildContext context, required int eventid, String? eventtype}) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"eventid": eventid, if (eventtype != null) "eventtype": eventtype}, API.vendor_getPDF);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          await vendorController.PDFfileApiData(value);
          return true;
          // await Basic_dialog(context: context, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
        } else {
          await Error_dialog(context: context, title: 'PDF file Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
      return false;
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
      return false;
    }
  }

  void DeleteProcess(context, List processid) async {
    if (kDebugMode) {
      print(processid.toString());
    }
    Map<String, dynamic>? response = await apiController.GetbyQueryString({
      "processid": processid,
    }, API.vendor_deleteprocess_API);
    if (response?['statusCode'] == 200) {
      CMResponse value = CMResponse.fromJson(response ?? {});
      if (value.code) {
        vendorController.vendorModel.selectedIndices.clear();
        Get_vendorProcessList(vendorController.vendorModel.vendorId.value!);
        Success_SnackBar(context, "Process Deleted successfully");
        // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
      } else {
        await Error_dialog(context: context, title: 'Delete Process Error', content: value.message ?? "", onOk: () {});
      }
    } else {
      Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
    }
  }

  void ArchiveProcesscontrol(context, List processid, int type) async {
    if (kDebugMode) {
      print(processid.toString());
    }
    Map<String, dynamic>? response = await apiController.GetbyQueryString({"processid": processid, "type": type}, API.vendor_archiveprocess_API);
    if (response?['statusCode'] == 200) {
      CMResponse value = CMResponse.fromJson(response ?? {});
      if (value.code) {
        vendorController.vendorModel.selectedIndices.clear();
        Get_vendorProcessList(vendorController.vendorModel.vendorId.value!);
        Success_SnackBar(context, type == 0 ? "Process Unarchived successfully" : "Process Archived successfully");
        // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
      } else {
        await Error_dialog(context: context, title: type == 0 ? 'Error : Failed to unarchive the process.' : 'Error : Failed to archive the process.', content: value.message ?? "", onOk: () {});
      }
    } else {
      Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
    }
  }

  Future<void> vendor_refresh() async {
    // vendorController.resetData();
    vendorController.update_showVendorProcess(null);
    vendorController.update_showVendorProcess(null);
    await Get_vendorProcesscustomerList();
    vendorController.updatevendorId(0);
    await Get_vendorProcessList(0);
    vendorController.update();
  }
}
