import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/ClientReq_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/DC_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/Debit_actions.dart';
import 'package:ssipl_billing/controllers/IAM_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/Invoice_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/Quote_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/Credit_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/RFQ_actions.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/screens/SALES/Generate_DC/generateDC.dart';
import 'package:ssipl_billing/views/screens/SALES/Generate_RFQ/generateRFQ.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../controllers/SALEScontrollers/Sales_actions.dart';
import '../../models/constants/api.dart';
import '../../models/entities/Response_entities.dart';
import '../../views/components/Basic_DialogBox.dart';
import '../../views/screens/SALES/Generate_DebitNote/generateDebit.dart';
import '../../views/screens/SALES/Generate_Invoice/generateInvoice.dart';
import '../../views/screens/SALES/Generate_Quote/generateQuote.dart';
import '../../views/screens/SALES/Generate_client_req/generate_clientreq.dart';
import '../../views/screens/SALES/Generate_creditNote/generateCredit.dart';
import '../APIservices/invoker.dart';
// import 'package:ssipl_billing/view_send_pdf.dart';

mixin SalesServices {
  final Invoker apiController = Get.find<Invoker>();
  final DcController dcController = Get.find<DcController>();
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  final QuoteController quoteController = Get.find<QuoteController>();
  final RfqController rfqController = Get.find<RfqController>();
  final CreditController creditController = Get.find<CreditController>();
  final DebitController debitController = Get.find<DebitController>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final SalesController salesController = Get.find<SalesController>();
  final ClientreqController clientreqController = Get.find<ClientreqController>();

  void GetCustomerList(context) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.sales_getcustomerlist_API);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          await Basic_dialog(context: context, showCancel: false, title: 'Customer List', content: "Customer List fetched successfully", onOk: () {});
          salesController.addToCustomerList(value);
          // if (kDebugMode) {
          //   print("*****************${salesController.salesModel.customerList[1].customerId}");
          // }
        } else {
          await Basic_dialog(context: context, showCancel: false, title: 'Customer List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
      if (kDebugMode) {
        print(response);
      }
    } catch (e) {
      Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
    }
  }

  Future<void> GetProcesscustomerList(context) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.sales_getprocesscustomer_API);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Processcustomer List', content: "Processcustomer List fetched successfully", onOk: () {});
          salesController.salesModel.processcustomerList.clear();
          salesController.addToProcesscustomerList(value);

          // salesController.updatecustomerId(salesController.salesModel.processcustomerList[salesController.salesModel.showcustomerprocess.value!].customerId);
        } else {
          await Basic_dialog(context: context, showCancel: false, title: 'Processcustomer List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
    }
  }

  Future<void> GetProcessList(context, int customerid) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"customerid": customerid, "listtype": salesController.salesModel.type.value}, API.sales_getprocesslist_API);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Process List', content: "Process List fetched successfully", onOk: () {});
          salesController.salesModel.processList.clear();
          salesController.addToProcessList(value);
        } else {
          await Basic_dialog(context: context, showCancel: false, title: 'Process List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
    }
  }

  void UpdateFeedback(context, int customerid, int eventid, feedback) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"eventid": eventid, "feedback": feedback}, API.sales_addfeedback_API);
      if (response?['statusCode'] == 200) {
        CMResponse value = CMResponse.fromJson(response ?? {});
        if (value.code) {
          GetProcessList(context, customerid);
          Basic_SnackBar(context, "Feedback added successfully");
          // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
        } else {
          await Basic_dialog(context: context, showCancel: false, title: 'Feedback add Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
    }
  }

  Future<bool> GetPDFfile(context, int eventid) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"eventid": eventid}, API.sales_getbinaryfile_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          await salesController.PDFfileApiData(value);
          return true;
          // await Basic_dialog(context: context, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
        } else {
          await Basic_dialog(context: context, title: 'PDF file Error', content: value.message ?? "", onOk: () {}, showCancel: false);
        }
      } else {
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!", showCancel: false);
      }
      return false;
    } catch (e) {
      Basic_dialog(context: context, title: "ERROR", content: "$e", showCancel: false);
      return false;
    }
  }

  void showPDF(context) async {
    if (salesController.salesModel.pdfFile.value != null) {
      await showDialog(
        context: context,
        builder: (context) => Dialog(
          insetPadding: const EdgeInsets.all(20), // Adjust padding to keep it from being full screen
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.35, // 85% of screen width
            height: MediaQuery.of(context).size.height * 0.95, // 80% of screen height
            child: SfPdfViewer.file(salesController.salesModel.pdfFile.value!),
          ),
        ),
      );
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
        GetProcessList(context, salesController.salesModel.customerId.value!);
        Basic_SnackBar(context, "Process Deleted successfully");
        // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
      } else {
        await Basic_dialog(context: context, showCancel: false, title: 'Delete Process Error', content: value.message ?? "", onOk: () {});
      }
    } else {
      Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
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
        GetProcessList(context, salesController.salesModel.customerId.value!);
        Basic_SnackBar(context, type == 0 ? "Process Unarchived successfully" : "Process Archived successfully");
        // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
      } else {
        await Basic_dialog(
            context: context, showCancel: false, title: type == 0 ? 'Error : Failed to unarchive the process.' : 'Error : Failed to archive the process.', content: value.message ?? "", onOk: () {});
      }
    } else {
      Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
    }
  }

  Future<bool> GetSalesData(context, String salesperiod) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"salesperiod": salesperiod}, API.sales_getsalesdata_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          salesController.updateSalesData(value);
        } else {
          await Basic_dialog(context: context, title: 'Sales Data Error', content: value.message ?? "", onOk: () {}, showCancel: false);
        }
      } else {
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!", showCancel: false);
      }
      return false;
    } catch (e) {
      Basic_dialog(context: context, title: "ERROR", content: "$e", showCancel: false);
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
          await Basic_dialog(context: context, title: 'Client Profile Error', content: value.message ?? "", onOk: () {}, showCancel: false);
        }
      } else {
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!", showCancel: false);
      }
      return false;
    } catch (e) {
      Basic_dialog(context: context, title: "ERROR", content: "$e", showCancel: false);
      return false;
    }
  }

  void GetApproval(context, int customerid, int eventid) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"eventid": eventid}, API.sales_approvedquotation_API);
      if (response?['statusCode'] == 200) {
        CMResponse value = CMResponse.fromJson(response ?? {});
        if (value.code) {
          GetProcessList(context, customerid);
          Basic_SnackBar(context, "Approval Sent successfully");
          // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
        } else {
          await Basic_dialog(context: context, showCancel: false, title: 'Approval Send add Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
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
                      bool? proceed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: const Text("Warning"),
                            content: const Text(
                              "The data may be lost. Do you want to proceed?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false); // No action
                                },
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true); // Yes action
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          );
                        },
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
                        (invoiceController.invoiceModel.Invoice_table_heading.value != "")) {
                      // Show confirmation dialog
                      bool? proceed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: const Text("Warning"),
                            content: const Text(
                              "The data may be lost. Do you want to proceed?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false); // No action
                                },
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  invoiceController.resetData();
                                  Navigator.of(context).pop(true); // Yes action
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          );
                        },
                      );

                      if (proceed == true) {
                        Navigator.of(context).pop();
                        invoiceController.invoiceModel.Invoice_products.clear();
                        invoiceController.invoiceModel.Invoice_noteList.clear();
                        invoiceController.invoiceModel.Invoice_recommendationList.clear();
                        invoiceController.invoiceModel.clientAddressNameController.value.clear();
                        invoiceController.invoiceModel.clientAddressController.value.clear();
                        invoiceController.invoiceModel.billingAddressNameController.value.clear();
                        invoiceController.invoiceModel.billingAddressController.value.clear();
                        invoiceController.invoiceModel.Invoice_no.value = "";
                        invoiceController.invoiceModel.TitleController.value.clear();
                        invoiceController.invoiceModel.Invoice_table_heading.value = "";
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
                    // || ( quoteController.quoteModel.Quote_gstTotals.isNotEmpty)
                    if ((quoteController.quoteModel.Quote_products.isNotEmpty) ||
                        (quoteController.quoteModel.Quote_noteList.isNotEmpty) ||
                        (quoteController.quoteModel.Quote_recommendationList.isNotEmpty) ||
                        (quoteController.quoteModel.clientAddressNameController.value.text != "") ||
                        (quoteController.quoteModel.clientAddressController.value.text != "") ||
                        (quoteController.quoteModel.billingAddressNameController.value.text != "") ||
                        (quoteController.quoteModel.billingAddressController.value.text != "") ||
                        (quoteController.quoteModel.Quote_no.value != "") ||
                        (quoteController.quoteModel.TitleController.value.text != "") ||
                        (quoteController.quoteModel.Quote_table_heading.value != "")) {
                      // Show confirmation dialog
                      bool? proceed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            title: const Text("Warning"),
                            content: const Text(
                              "The data may be lost. Do you want to proceed?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false); // No action
                                },
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true); // Yes action
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          );
                        },
                      );

                      // If user confirms (Yes), clear data and close the dialog
                      if (proceed == true) {
                        Navigator.of(context).pop(); // Close the dialog
                        // Clear all the data when dialog is closed
                        quoteController.quoteModel.Quote_products.clear();
                        //  quoteController.quoteModel.Quote_gstTotals.clear();
                        quoteController.quoteModel.Quote_noteList.clear();
                        quoteController.quoteModel.Quote_recommendationList.clear();
                        //  quoteController.quoteModel.iQuote_productDetails.clear();
                        quoteController.quoteModel.clientAddressNameController.value.clear();
                        quoteController.quoteModel.clientAddressController.value.clear();
                        quoteController.quoteModel.billingAddressNameController.value.clear();
                        quoteController.quoteModel.billingAddressController.value.clear();
                        quoteController.quoteModel.Quote_no.value = "";
                        quoteController.quoteModel.TitleController.value.clear();
                        quoteController.quoteModel.Quote_table_heading.value = "";
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
                        (rfqController.rfqModel.Rfq_table_heading.value != "")) {
                      // Show confirmation dialog
                      bool? proceed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: const Text("Warning"),
                            content: const Text(
                              "The data may be lost. Do you want to proceed?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false); // No action
                                },
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  rfqController.resetData();
                                  Navigator.of(context).pop(true); // Yes action
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          );
                        },
                      );

                      if (proceed == true) {
                        Navigator.of(context).pop();
                        rfqController.rfqModel.Rfq_products.clear();
                        rfqController.rfqModel.Rfq_noteList.clear();
                        rfqController.rfqModel.Rfq_recommendationList.clear();
                        // rfqController.rfqModel.clientAddressNameController.value.clear();
                        rfqController.rfqModel.AddressController.value.clear();
                        // rfqController.rfqModel.billingAddressNameController.value.clear();
                        // rfqController.rfqModel.billingAddressController.value.clear();
                        rfqController.rfqModel.Rfq_no.value = "";
                        rfqController.rfqModel.TitleController.value.clear();
                        rfqController.rfqModel.Rfq_table_heading.value = "";
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

  dynamic GenerateDelivery_challan_dialougebox(context, eventID) async {
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
                child: GenerateDc(
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
                      bool? proceed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            title: const Text("Warning"),
                            content: const Text(
                              "The data may be lost. Do you want to proceed?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false); // No action
                                },
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  dcController.resetData();
                                  Navigator.of(context).pop(true); // Yes action
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          );
                        },
                      );

                      if (proceed == true) {
                        Navigator.of(context).pop();
                        dcController.dcModel.Dc_products.clear();
                        dcController.dcModel.Dc_noteList.clear();
                        dcController.dcModel.Dc_recommendationList.clear();
                        dcController.dcModel.clientAddressNameController.value.clear();
                        dcController.dcModel.clientAddressController.value.clear();
                        dcController.dcModel.billingAddressNameController.value.clear();
                        dcController.dcModel.billingAddressController.value.clear();
                        dcController.dcModel.Dc_no.value = "";
                        dcController.dcModel.TitleController.value.clear();
                        dcController.dcModel.Dc_table_heading.value = "";
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

  dynamic GenerateDebit_dialougebox(context) async {
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
              const SizedBox(
                height: 650,
                width: 1300,
                child: GenerateDebit(),
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
                    // || ( debitController.debitModel.Debit_gstTotals.isNotEmpty)
                    if ((debitController.debitModel.Debit_products.isNotEmpty) ||
                        (debitController.debitModel.Debit_noteList.isNotEmpty) ||
                        (debitController.debitModel.Debit_recommendationList.isNotEmpty) ||
                        (debitController.debitModel.clientAddressNameController.value.text != "") ||
                        (debitController.debitModel.clientAddressController.value.text != "") ||
                        (debitController.debitModel.billingAddressNameController.value.text != "") ||
                        (debitController.debitModel.billingAddressController.value.text != "") ||
                        (debitController.debitModel.Debit_no.value != "") ||
                        (debitController.debitModel.Debit_table_heading.value != "")) {
                      // Show confirmation dialog
                      bool? proceed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            title: const Text("Warning"),
                            content: const Text(
                              "The data may be lost. Do you want to proceed?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false); // No action
                                },
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  debitController.clearAll();
                                  Navigator.of(context).pop(true); // Yes action
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          );
                        },
                      );

                      if (proceed == true) {
                        Navigator.of(context).pop(); // Close the dialog
                        debitController.debitModel.Debit_products.clear();
                        debitController.debitModel.Debit_noteList.clear();
                        debitController.debitModel.Debit_recommendationList.clear();
                        debitController.debitModel.Debit_no.value = "";
                        debitController.debitModel.Debit_table_heading.value = "";
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

  dynamic generate_debit(context) async {
    // bool confirmed = await GenerateDebit_dialougebox();

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
    //           type: 'E://Debit.pdf',
    //         ));
    //   },
    // );
    // }
  }

  dynamic GenerateCredit_dialougebox(context) async {
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
              const SizedBox(
                height: 650,
                width: 1300,
                child: GenerateCredit(),
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
                    // || ( creditController.creditModel.Credit_gstTotals.isNotEmpty)
                    if ((creditController.creditModel.Credit_products.isNotEmpty) ||
                        (creditController.creditModel.Credit_noteList.isNotEmpty) ||
                        (creditController.creditModel.Credit_recommendationList.isNotEmpty) ||
                        (creditController.creditModel.clientAddressNameController.value.text != "") ||
                        (creditController.creditModel.clientAddressController.value.text != "") ||
                        (creditController.creditModel.billingAddressNameController.value.text != "") ||
                        (creditController.creditModel.billingAddressController.value.text != "") ||
                        (creditController.creditModel.Credit_no.value != "") ||
                        (creditController.creditModel.Credit_table_heading.value != "")) {
                      // Show confirmation dialog
                      bool? proceed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            title: const Text("Warning"),
                            content: const Text(
                              "The data may be lost. Do you want to proceed?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false); // No action
                                },
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  creditController.clearAll();
                                  Navigator.of(context).pop(true); // Yes action
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          );
                        },
                      );

                      // If user confirms (Yes), clear data and close the dialog
                      if (proceed == true) {
                        Navigator.of(context).pop(); // Close the dialog
                        // Clear all the data when dialog is closed
                        creditController.creditModel.Credit_products.clear();
                        //  creditController.creditModel.Credit_gstTotals.clear();
                        creditController.creditModel.Credit_noteList.clear();
                        creditController.creditModel.Credit_recommendationList.clear();
                        //  creditController.creditModel.iCredit_productDetails.clear();
                        creditController.creditModel.clientAddressNameController.value.clear();
                        creditController.creditModel.clientAddressController.value.clear();
                        creditController.creditModel.billingAddressNameController.value.clear();
                        creditController.creditModel.billingAddressController.value.clear();
                        creditController.creditModel.Credit_no.value = "";
                        creditController.creditModel.Credit_table_heading.value = "";
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

  dynamic generate_credit(context) async {
    // bool confirmed = await GenerateCredit_dialougebox();

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
    //           type: 'E://Credit.pdf',
    //         ));
    //   },
    // );
    // }
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

  Future<void> refresh(context) async {
    salesController.resetData();
    salesController.updateshowcustomerprocess(null);
    salesController.updatecustomerId(0);
    await GetProcesscustomerList(context);
    await GetProcessList(context, 0);
    await GetSalesData(context, salesController.salesModel.salesperiod.value);
  }
}
