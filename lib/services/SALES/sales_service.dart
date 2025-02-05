import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/DC_actions.dart';
import 'package:ssipl_billing/controllers/Debit_actions.dart';
import 'package:ssipl_billing/controllers/IAM_actions.dart';
import 'package:ssipl_billing/controllers/Invoice_actions.dart';
import 'package:ssipl_billing/controllers/Quote_actions.dart';
import 'package:ssipl_billing/controllers/RFQ_actions.dart';
import 'package:ssipl_billing/controllers/Credit_actions.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/screens/SALES/Generate_RFQ/generateRFQ.dart';
import '../../controllers/Sales_actions.dart';
import '../../models/constants/api.dart';
import '../../models/entities/Response_entities.dart';
import '../../views/components/Basic_DialogBox.dart';
import '../../views/components/view_send_pdf.dart';
import '../../views/screens/SALES/Generate_DC/generateDC.dart';
import '../../views/screens/SALES/Generate_DebitNote/generateDebit.dart';
import '../../views/screens/SALES/Generate_Invoice/generateInvoice.dart';
import '../../views/screens/SALES/Generate_Quote/generateQuote.dart';
import '../../views/screens/SALES/Generate_creditNote/generateCredit.dart';
import '../APIservices/invoker.dart';
// import 'package:ssipl_billing/view_send_pdf.dart';

mixin SalesServices {
  final Invoker apiController = Get.find<Invoker>();
  final DCController dcController = Get.find<DCController>();
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  final QuoteController quoteController = Get.find<QuoteController>();
  final RFQController rfqController = Get.find<RFQController>();
  final CreditController creditController = Get.find<CreditController>();
  final DebitController debitController = Get.find<DebitController>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final SalesController salesController = Get.find<SalesController>();

  void GetCustomerList(context) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.sales_getcustomerlist_API);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          await Basic_dialog(context: context, title: 'Customer List', content: "Customer List fetched successfully", onOk: () {});
          salesController.addToCustomerList(value);
          print("*****************${salesController.salesModel.customerList[1].customerId}");
        } else {
          await Basic_dialog(context: context, title: 'Customer List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
      print(response);
    } catch (e) {
      Basic_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  dynamic GenerateInvoice_dialougebox(context) async {
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
                child: GenerateInvoice(),
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
                                  invoiceController.clearAll();
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
                        invoiceController.invoiceModel.Invoice_products.clear();
                        //  invoiceController.invoiceModel.Invoice_gstTotals.clear();
                        invoiceController.invoiceModel.Invoice_noteList.clear();
                        invoiceController.invoiceModel.Invoice_recommendationList.clear();
                        //  invoiceController.invoiceModel.iInvoice_productDetails.clear();
                        invoiceController.invoiceModel.clientAddressNameController.value.clear();
                        invoiceController.invoiceModel.clientAddressController.value.clear();
                        invoiceController.invoiceModel.billingAddressNameController.value.clear();
                        invoiceController.invoiceModel.billingAddressController.value.clear();
                        invoiceController.invoiceModel.Invoice_no.value = "";
                        invoiceController.invoiceModel.TitleController.value.clear();
                        invoiceController.invoiceModel.Invoice_table_heading.value = "";
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

  dynamic generate_invoice(context) async {
    // bool confirmed = await GenerateInvoice_dialougebox();

    // if (confirmed) {
    // Proceed only if the dialog was confirmed
    // Future.delayed(const Duration(seconds: 4), () {
    //   Generate_popup.callback();
    // });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Primary_colors.Light,
            content: Generate_popup(
              type: 'E://Invoice.pdf',
            ));
      },
    );
    // }
  }

  dynamic GenerateQuote_dialougebox(context) async {
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
                child: GenerateQuote(),
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
                                  quoteController.clearAll();
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

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Primary_colors.Light,
            content: Generate_popup(
              type: 'E://Quote.pdf',
            ));
      },
    );
    // }
  }

  dynamic GenerateRFQ_dialougebox(context) async {
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
                child: GenerateRFQ(),
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
                    // || ( rfqController.rfqModel.RFQ_gstTotals.isNotEmpty)
                    if ((rfqController.rfqModel.RFQ_products.isNotEmpty) ||
                        (rfqController.rfqModel.RFQ_noteList.isNotEmpty) ||
                        (rfqController.rfqModel.RFQ_recommendationList.isNotEmpty) ||
                        (rfqController.rfqModel.vendor_address_controller.value.text != "") ||
                        (rfqController.rfqModel.vendor_email_controller.value.text != "") ||
                        (rfqController.rfqModel.vendor_name_controller.value.text != "") ||
                        (rfqController.rfqModel.vendor_phone_controller.value.text != "") ||
                        (rfqController.rfqModel.RFQ_no.value != "") ||
                        (rfqController.rfqModel.RFQ_table_heading.value != "")) {
                      // Show confirmation dialog
                      bool? proceed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
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
                                  rfqController.clearAll();
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
                        rfqController.rfqModel.RFQ_products.clear();
                        //  rfqController.rfqModel.RFQ_gstTotals.clear();
                        rfqController.rfqModel.RFQ_noteList.clear();
                        rfqController.rfqModel.RFQ_recommendationList.clear();
                        //  rfqController.rfqModel.iRFQ_productDetails.clear();
                        rfqController.rfqModel.vendor_address_controller.value.clear();
                        rfqController.rfqModel.vendor_email_controller.value.clear();
                        rfqController.rfqModel.vendor_name_controller.value.clear();
                        rfqController.rfqModel.vendor_phone_controller.value.clear();
                        rfqController.rfqModel.RFQ_no.value = "";

                        rfqController.rfqModel.RFQ_table_heading.value = "";
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

  dynamic generate_rfq(context) async {
    // bool confirmed = await GenerateRFQ_dialougebox();

    // if (confirmed) {
    // Proceed only if the dialog was confirmed
    // Future.delayed(const Duration(seconds: 4), () {
    //   Generate_popup.callback();
    // });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Primary_colors.Light,
            content: Generate_popup(
              type: 'E://RFQ.pdf',
            ));
      },
    );
    // }
  }

// // ##################################################################################################################################################################################################################################################################################################################################################################

  dynamic GenerateDelivery_challan_dialougebox(context) async {
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
                child: GenerateDelivery_challan(),
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

                    if ((dcController.dcModel.Delivery_challan_products.isNotEmpty) ||
                        (dcController.dcModel.Delivery_challan_noteList.isNotEmpty) ||
                        (dcController.dcModel.Delivery_challan_recommendationList.isNotEmpty) ||
                        dcController.dcModel.clientAddressNameController.value.text != "" ||
                        dcController.dcModel.clientAddressController.value.text != "" ||
                        dcController.dcModel.billingAddressNameController.value.text != "" ||
                        dcController.dcModel.billingAddressController.value.text != "" ||
                        dcController.dcModel.Delivery_challan_no.value != "" ||
                        dcController.dcModel.TitleController.value.text != "" ||
                        dcController.dcModel.Delivery_challan_table_heading.value != "") {
                      // Show confirmation dialog
                      bool? proceed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
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
                                  dcController.clearAll();
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
                        dcController.dcModel.Delivery_challan_products.clear();
                        dcController.dcModel.Delivery_challan_noteList.clear();
                        dcController.dcModel.Delivery_challan_recommendationList.clear();
                        // dcController.dcModel.Delivery_challan_productDetails.clear();
                        dcController.dcModel.clientAddressNameController.value.clear();
                        dcController.dcModel.clientAddressController.value.clear();
                        dcController.dcModel.billingAddressNameController.value.clear();
                        dcController.dcModel.billingAddressController.value.clear();
                        dcController.dcModel.Delivery_challan_no.value = "";
                        dcController.dcModel.TitleController.value.clear();
                        dcController.dcModel.Delivery_challan_table_heading.value = "";
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

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Primary_colors.Light,
            content: Generate_popup(
              type: 'E://Debit.pdf',
            ));
      },
    );
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

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Primary_colors.Light,
            content: Generate_popup(
              type: 'E://Credit.pdf',
            ));
      },
    );
    // }
  }
}
