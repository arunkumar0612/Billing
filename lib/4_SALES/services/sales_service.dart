// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/controllers/ClientReq_actions.dart';
import 'package:ssipl_billing/4_SALES/controllers/DC_actions.dart';
import 'package:ssipl_billing/4_SALES/controllers/Invoice_actions.dart';
import 'package:ssipl_billing/4_SALES/controllers/Quote_actions.dart';
import 'package:ssipl_billing/4_SALES/controllers/RFQ_actions.dart';
import 'package:ssipl_billing/4_SALES/views/Generate_DC/generateDC.dart';
import 'package:ssipl_billing/4_SALES/views/Generate_RFQ/generateRFQ.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/THEMES/style.dart';

// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../API/api.dart';
import '../../API/invoker.dart';
import '../../COMPONENTS-/Response_entities.dart';
import '../controllers/Sales_actions.dart';
import '../views/Generate_Invoice/generateInvoice.dart';
import '../views/Generate_Quote/generateQuote.dart';
import '../views/Generate_client_req/generate_clientreq.dart';

mixin SalesServices {
  final Invoker apiController = Get.find<Invoker>();
  final DcController dcController = Get.find<DcController>();
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  final QuoteController _quoteController = Get.find<QuoteController>();
  final RfqController rfqController = Get.find<RfqController>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final SalesController salesController = Get.find<SalesController>();
  final ClientreqController clientreqController = Get.find<ClientreqController>();
  final loader = LoadingOverlay();
  Future<void> Get_salesCustomPDFLsit() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.get_salesCustompdf);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          salesController.addToCustompdfList(value);
          salesController.search(salesController.salesModel.searchQuery.value);
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

  void GetCustomerList(context) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.sales_getcustomerlist_API);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          await Success_dialog(context: context, title: 'SUCCESS', content: "Customer List fetched successfully", onOk: () {});
          salesController.addToCustomerList(value);
          // if (kDebugMode) {
          //   print("*****************${salesController.salesModel.customerList[1].customerId}");
          // }
        } else {
          await Error_dialog(context: context, title: 'Customer List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
      if (kDebugMode) {
        print(response);
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  Future<bool> Get_customPDFfile(context, int customPDFid) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"custompdfid": customPDFid}, API.sales_getcustombinaryfile_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          await salesController.custom_PDFfileApiData(value);
          return true;
          // await Basic_dialog(context: context, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
        } else {
          await Error_dialog(
            context: context,
            title: 'PDF file Error',
            content: value.message ?? "",
            onOk: () {},
          );
        }
      } else {
        Error_dialog(
          context: context,
          title: "SERVER DOWN",
          content: "Please contact administration!",
        );
      }
      return false;
    } catch (e) {
      Error_dialog(
        context: context,
        title: "ERROR",
        content: "$e",
      );
      return false;
    }
  }

  Future<void> Get_salesProcesscustomerList() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.sales_getprocesscustomer_API);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Processcustomer List', content: "Processcustomer List fetched successfully", onOk: () {});
          salesController.salesModel.processcustomerList.clear();
          salesController.addToProcesscustomerList(value);
          salesController.search(salesController.salesModel.searchQuery.value);
          // salesController.updatecustomerId(salesController.salesModel.processcustomerList[salesController.salesModel.showcustomerprocess.value!].customerId);
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

  Future<void> Get_salesProcessList(int customerid) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"customerid": customerid, "listtype": salesController.salesModel.type.value}, API.sales_getprocesslist_API);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Process List', content: "Process List fetched successfully", onOk: () {});
          salesController.salesModel.processList.clear();
          salesController.addToProcessList(value);
          salesController.search(salesController.salesModel.searchQuery.value);
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

  void UpdateFeedback(context, int customerid, int eventid, feedback) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"eventid": eventid, "feedback": feedback}, API.sales_addfeedback_API);
      if (response?['statusCode'] == 200) {
        CMResponse value = CMResponse.fromJson(response ?? {});
        if (value.code) {
          Get_salesProcessList(customerid);
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

  Future<bool> GetSalesPDFfile({required BuildContext context, required int eventid, String? eventtype}) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"eventid": eventid, if (eventtype != null) "eventtype": eventtype}, API.sales_getbinaryfile_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          await salesController.PDFfileApiData(value);
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
    }, API.sales_deleteprocess_API);
    if (response?['statusCode'] == 200) {
      CMResponse value = CMResponse.fromJson(response ?? {});
      if (value.code) {
        salesController.salesModel.selectedIndices.clear();
        Get_salesProcessList(salesController.salesModel.customerId.value!);
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
    Map<String, dynamic>? response = await apiController.GetbyQueryString({"processid": processid, "type": type}, API.sales_archiveprocess_API);
    if (response?['statusCode'] == 200) {
      CMResponse value = CMResponse.fromJson(response ?? {});
      if (value.code) {
        salesController.salesModel.selectedIndices.clear();
        Get_salesProcessList(salesController.salesModel.customerId.value!);
        Success_SnackBar(context, type == 0 ? "Process Unarchived successfully" : "Process Archived successfully");
        // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
      } else {
        await Error_dialog(context: context, title: type == 0 ? 'Error : Failed to unarchive the process.' : 'Error : Failed to archive the process.', content: value.message ?? "", onOk: () {});
      }
    } else {
      Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
    }
  }

  Future<bool> GetSalesData(String salesperiod) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"salesperiod": salesperiod}, API.sales_getsalesdata_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          salesController.updateSalesData(value);
          salesController.search(salesController.salesModel.searchQuery.value);
        } else {
          if (kDebugMode) {
            print("error : ${value.message}");
          }
          // await Basic_dialog(context: context, title: 'Sales Data Error', content: value.message ?? "", onOk: () {}, showCancel: false);
        }
      } else {
        if (kDebugMode) {
          print("error : ${"please contact administration"}");
        }
        // Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!", showCancel: false);
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print("error : $e");
      }
      // Basic_dialog(context: context, title: "ERROR", content: "$e", showCancel: false);
      return false;
    }
  }

  Future<bool> Getclientprofile(context, int customerid) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"customerid": customerid}, API.sales_clientprofile_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          salesController.updateclientprofileData(value);
          salesController.updateprofilepage(true);
        } else {
          await Error_dialog(context: context, title: 'Client Profile Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
      return false;
    } catch (e) {
      Error_dialog(
        context: context,
        title: "ERROR",
        content: "$e",
      );
      return false;
    }
  }

  void GetApproval(context, int customerid, int eventid) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"eventid": eventid}, API.sales_approvedquotation_API);
      if (response?['statusCode'] == 200) {
        CMResponse value = CMResponse.fromJson(response ?? {});
        if (value.code) {
          Get_salesProcessList(customerid);
          Success_SnackBar(context, "Approval Sent successfully");
          // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
        } else {
          await Error_dialog(context: context, title: 'Approval Send add Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  dynamic Generate_client_reqirement_dialougebox(String value, context) async {
    await showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing the dialog by clicking outside
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Primary_colors.Dark,
          content: Stack(
            children: [
              SizedBox(
                height: 650,
                width: 900,
                child: Generate_clientreq(
                  value: value,
                ),
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
                    if (clientreqController.anyHavedata()) {
                      bool? proceed = await Warning_dialog(
                        context: context,
                        title: 'Warning',
                        content: "The data may be lost. Do you want to proceed?",
                      );

                      if (proceed == true) {
                        Navigator.of(context).pop();
                        clientreqController.resetData();
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

  dynamic generate_client_requirement(context) async {
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //         backgroundColor: Primary_colors.Light,
    //         content: Generate_popup(
    //           type: 'E://Client_requirement.pdf',
    //         ));
    //   },
    // );
    // }
  }

  dynamic GenerateInvoice_dialougebox(context, eventID) async {
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
                child: GenerateInvoice(
                  eventID: eventID,
                ),
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
                    // || ( invoiceController.invoiceModel.Invoice_gstTotals.isNotEmpty)
                    if ((invoiceController.invoiceModel.Invoice_products.isNotEmpty) ||
                        (invoiceController.invoiceModel.Invoice_noteList.isNotEmpty) ||
                        (invoiceController.invoiceModel.Invoice_recommendationList.isNotEmpty) ||
                        (invoiceController.invoiceModel.clientAddressNameController.value.text != "") ||
                        (invoiceController.invoiceModel.clientAddressController.value.text != "") ||
                        (invoiceController.invoiceModel.billingAddressNameController.value.text != "") ||
                        (invoiceController.invoiceModel.billingAddressController.value.text != "") ||
                        (invoiceController.invoiceModel.Invoice_no.value != "") ||
                        (invoiceController.invoiceModel.TitleController.value.text != "") ||
                        (invoiceController.invoiceModel.recommendationHeadingController.value.text != "")) {
                      // Show confirmation dialog
                      bool? proceed = await Warning_dialog(
                        context: context,
                        title: 'Warning',
                        content: "The data may be lost. Do you want to proceed?",
                      );

                      if (proceed == true) {
                        Navigator.of(context).pop();
                        invoiceController.resetData();
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

  dynamic generate_invoice(context) async {
    // bool confirmed = await GenerateInvoice_dialougebox();

    // if (confirmed) {
    // Proceed only if the dialog was confirmed
    // Future.delayed(const Duration(seconds: 4), () {
    //   Generate_popup.callback();
    // });

    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //         backgroundColor: Primary_colors.Light,
    //         content: Generate_popup(
    //           type: 'E://Invoice.pdf',
    //         ));
    //   },
    // );
    // }
  }

  dynamic GenerateQuote_dialougebox(context, String quoteType, int eventID) async {
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
                child: GenerateQuote(
                  quoteType: quoteType,
                  eventID: eventID,
                ),
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
                    // || ( _quoteController.quoteModel.Quote_gstTotals.isNotEmpty)
                    if ((_quoteController.quoteModel.Quote_products.isNotEmpty) ||
                        (_quoteController.quoteModel.Quote_noteList.isNotEmpty) ||
                        (_quoteController.quoteModel.Quote_recommendationList.isNotEmpty) ||
                        (_quoteController.quoteModel.clientAddressNameController.value.text != "") ||
                        (_quoteController.quoteModel.clientAddressController.value.text != "") ||
                        (_quoteController.quoteModel.billingAddressNameController.value.text != "") ||
                        (_quoteController.quoteModel.billingAddressController.value.text != "") ||
                        (_quoteController.quoteModel.Quote_no.value != "") ||
                        (_quoteController.quoteModel.gstController.value.text != "") ||
                        (_quoteController.quoteModel.recommendationHeadingController.value.text != "")) {
                      // Show confirmation dialog
                      bool? proceed = await Warning_dialog(context: context, title: 'Warning', content: "The data may be lost. Do you want to proceed?");

                      // If user confirms (Yes), clear data and close the dialog
                      if (proceed == true) {
                        Navigator.of(context).pop(); // Close the dialog
                        _quoteController.resetData();
                      }
                    } else {
                      // If no data, just close the dialog
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

  dynamic generate_quote(context) async {
    // bool confirmed = await GenerateQuote_dialougebox();

    // if (confirmed) {
    // Proceed only if the dialog was confirmed
    // Future.delayed(const Duration(seconds: 4), () {
    //   Generate_popup.callback();
    // });

    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //         backgroundColor: Primary_colors.Light,
    //         content: Generate_popup(
    //           type: 'E://Quote.pdf',
    //         ));
    //   },
    // );
    // }
  }

  dynamic GenerateRfq_dialougebox(context, eventID) async {
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
                child: GenerateRfq(
                  eventID: eventID,
                ),
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

  dynamic generate_rfq(context) async {
    // bool confirmed = await GenerateRFQ_dialougebox();

    // if (confirmed) {
    // Proceed only if the dialog was confirmed
    // Future.delayed(const Duration(seconds: 4), () {
    //   Generate_popup.callback();
    // });

    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //         backgroundColor: Primary_colors.Light,
    //         content: Generate_popup(
    //           type: 'E://RFQ.pdf',
    //         ));
    //   },
    // );
    // }
  }

// // ##################################################################################################################################################################################################################################################################################################################################################################

  dynamic GenerateDelivery_challan_dialougebox(context, eventID, eventName) async {
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
                child: GenerateDc(eventID: eventID, eventName: eventName),
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
                    // || ( invoiceController.invoiceModel.Dc_gstTotals.isNotEmpty)
                    if ((dcController.dcModel.Dc_products.isNotEmpty) ||
                        (dcController.dcModel.Dc_noteList.isNotEmpty) ||
                        (dcController.dcModel.Dc_recommendationList.isNotEmpty) ||
                        (dcController.dcModel.clientAddressNameController.value.text != "") ||
                        (dcController.dcModel.clientAddressController.value.text != "") ||
                        (dcController.dcModel.billingAddressNameController.value.text != "") ||
                        (dcController.dcModel.billingAddressController.value.text != "") ||
                        (dcController.dcModel.Dc_no.value != "") ||
                        (dcController.dcModel.TitleController.value.text != "") ||
                        (dcController.dcModel.Dc_table_heading.value != "")) {
                      // Show confirmation dialog
                      bool? proceed = await Warning_dialog(context: context, title: 'Warning', content: "The data may be lost. Do you want to proceed?");

                      if (proceed == true) {
                        Navigator.of(context).pop();
                        dcController.resetData();
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

  Future<void> sales_refresh() async {
    // salesController.resetData();
    salesController.updateshowcustomerprocess(null);
    salesController.updatecustomerId(0);
    await Get_salesProcesscustomerList();
    await GetSalesData(salesController.salesModel.salesperiod.value);
    await Get_salesCustomPDFLsit();
    await Get_salesProcessList(0);
    Get_salesCustomPDFLsit();

    salesController.update();
  }

  int fetch_messageType() {
    if (salesController.salesModel.whatsapp_selectionStatus.value && salesController.salesModel.gmail_selectionStatus.value) return 3;
    if (salesController.salesModel.whatsapp_selectionStatus.value) return 2;
    if (salesController.salesModel.gmail_selectionStatus.value) return 1;

    return 0;
  }

  dynamic postData_sendPDF(context, int messageType, File pdf) async {
    try {
      Map<String, dynamic> queryString = {
        "emailid": salesController.salesModel.emailController.value.text,
        "phoneno": salesController.salesModel.phoneController.value.text,
        "feedback": salesController.salesModel.feedbackController.value.text,
        "messagetype": messageType,
        "ccemail": salesController.salesModel.CCemailController.value.text,
      };
      await sendPDFdata(context, jsonEncode(queryString), pdf);
    } catch (e) {
      await Error_dialog(context: context, title: "POST", content: "$e", onOk: () {});
    }
  }

// hariprasath.s@sporadsecure.com
// arunkumar.m@sporadasecure.com
  dynamic sendPDFdata(context, String jsonData, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, [file], API.send_anyPDF);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          await Success_dialog(context: context, title: "SUCCESS", content: value.message!, onOk: () {});
          Navigator.of(context).pop(true);
          salesController.reset_shareData();
        } else {
          await Error_dialog(context: context, title: 'Share', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(
          context: context,
          title: "SERVER DOWN",
          content: "Please contact administration!",
        );
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
