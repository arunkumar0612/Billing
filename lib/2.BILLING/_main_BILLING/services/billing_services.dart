// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ssipl_billing/2.BILLING/Vouchers/models/entities/voucher_entities.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/controllers/Billing_actions.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/models/entities/Billing_entities.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/PDF_methods/showPDF.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

mixin main_BillingService {
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final MainBilling_Controller mainBilling_Controller = Get.find<MainBilling_Controller>();
  final loader = LoadingOverlay();

  Future<void> Get_Mainbilling_SUBcustomerList() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.get_ledgerSubscriptionCustomers);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          mainBilling_Controller.billingModel.subCustomerList.value = value.data.map((e) => MainbillingCustomerInfo.fromJson(e)).toList();
          mainBilling_Controller.search(mainBilling_Controller.billingModel.searchQuery.value);
          // print('ijhietjwe${view_LedgerController.view_LedgerModel.subCustomerList}');
          // salesController.addToCustompdfList(value);
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

  Future<void> Get_Mainbilling_SALEScustomerList() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.get_ledgerSalesCustomers);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          mainBilling_Controller.billingModel.salesCustomerList.value = value.data.map((e) => MainbillingCustomerInfo.fromJson(e)).toList();
          mainBilling_Controller.search(mainBilling_Controller.billingModel.searchQuery.value);
          // print(view_LedgerController.view_LedgerModel.salesCustomerList);
          // salesController.addToCustompdfList(value);
        } else {
          if (kDebugMode) {
            print("error : ${value.message}");
          }
          // await Error_dialog(context: context, title: 'Sales List', content: value.message ?? 'Error');
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

  void get_SubscriptionInvoiceList() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({
        "plantype": mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.plantype.value.toLowerCase() == 'show all'
            ? ''
            : mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.plantype.value.toLowerCase(),
        "paymentstatus": mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.paymentstatus.value.toLowerCase() == 'show all'
            ? ''
            : mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.paymentstatus.value.toLowerCase(),

        // "customerid": "SB_1",
        "customerid": mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.selectedcustomerid.value == 'None'
            ? ''
            : mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.selectedcustomerid.value,
        "startdate": mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.fromdate.value.toString(),
        "enddate": mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.todate.value.toString(),
      }, API.billing_subscriptionInvoice);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          mainBilling_Controller.billingModel.subscriptionInvoiceList.clear();
          mainBilling_Controller.billingModel.allSubscriptionInvoices.clear();
          for (int i = 0; i < value.data.length; i++) {
            mainBilling_Controller.addto_SubscriptionInvoiceList(SubscriptionInvoice.fromJson(value.data[i]));
            mainBilling_Controller.search(mainBilling_Controller.billingModel.searchQuery.value);
            // print(value.data[i]['Overdue_history']);
          }
          // await Basic_dialog(context: context,showCancel: false, title: 'Organization List', content: value.message!, onOk: () {});
          // clientreqController.update_OrganizationList(value);
        } else {
          print('Subscription invoice List Error');
          // await Error_dialog(context: context, title: 'Subscription invoice List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        print("SERVER DOWN -- Please contact administration!");
        // Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      print('ERROR -- $e');
      // Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  Future<bool> Get_transactionPDFfile({required BuildContext context, required int transactionID}) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"transactionid": transactionID}, API.get_transactionBinaryfile);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          await mainBilling_Controller.PDFfileApiData(value);
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

  Future<bool> Get_receiptPDFfile({required BuildContext context, required int transactionID}) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"transactionid": transactionID}, API.get_receiptBinaryfile);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          await mainBilling_Controller.PDFfileApiData(value);
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

  void get_SalesInvoiceList() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({
        "paymentstatus": mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.paymentstatus.value.toLowerCase() == 'show all'
            ? ''
            : mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.paymentstatus.value.toLowerCase(),

        // "customerid": "SB_1",
        "customerid": mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.selectedcustomerid.value == 'None'
            ? ''
            : mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.selectedcustomerid.value,
        "startdate": mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.fromdate.value.toString(),
        "enddate": mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.todate.value.toString(),
      }, API.billing_salesInvoice);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          mainBilling_Controller.billingModel.allSalesInvoices.clear();
          mainBilling_Controller.billingModel.salesInvoiceList.clear();
          for (int i = 0; i < value.data.length; i++) {
            SalesInvoice element = SalesInvoice.fromJson(value.data[i]);
            mainBilling_Controller.addto_SalesInvoiceList(element);
          }
          mainBilling_Controller.search(mainBilling_Controller.billingModel.searchQuery.value);
          // await Basic_dialog(context: context,showCancel: false, title: 'Organization List', content: value.message!, onOk: () {});
          // clientreqController.update_OrganizationList(value);
        } else {
          print('Fetching Organization List Error');

          // await Error_dialog(context: context, title: 'Fetching Organization List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        print("SERVER DOWN -- Please contact administration!");

        // Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      print('ERROR -- $e');

      // Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  Future<bool> Get_SalesPDFfile({
    required BuildContext context,
    required String invoiceNo,
  }) async {
    try {
      mainBilling_Controller.billingModel.pdfFile.value = null;
      Map<String, dynamic>? response = await apiController.GetbyQueryString({'invoicenumber': invoiceNo}, API.sales_getbinaryfile_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          await mainBilling_Controller.PDFfileApiData(value);
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

  void GetDashboardData() async {
    try {
      var query = {
        "type": mainBilling_Controller.billingModel.type.value,
        "fromDate": mainBilling_Controller.billingModel.dashboard_startDateController.value.text,
        "toDate": mainBilling_Controller.billingModel.dashboard_endDateController.value.text,
      };
      Map<String, dynamic>? response = await apiController.GetbyQueryString(query, API.get_dashboardData);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          mainBilling_Controller.set_dashBoardData(DashboardStats.fromJson(value.data['dashboard']));
          mainBilling_Controller.search(mainBilling_Controller.billingModel.searchQuery.value);
          // await mainBilling_Controller.PDFfileApiData(value);

          // await Basic_dialog(context: context, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
        } else {
          // await Error_dialog(context: context, title: 'PDF file Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        // Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      // Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  Future<bool> GetSubscriptionPDFfile({
    required BuildContext context,
    required String invoiceNo,
  }) async {
    try {
      mainBilling_Controller.billingModel.pdfFile.value = null;
      Map<String, dynamic>? response = await apiController.GetbyQueryString({'invoicenumber': invoiceNo}, API.subscription_getRecurredBinaryfile_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          await mainBilling_Controller.PDFfileApiData(value);
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

  Future<void> get_VoucherDetails(context, int voucherID) async {
    Map<String, dynamic>? response = await apiController.GetbyQueryString(
      {'voucherid': voucherID},
      API.getvoucherlist,
    );
    // print('asfasfasa${voucherController.voucherModel.voucherSelectedFilter.value.fromdate.toString()}');
    if (response?['statusCode'] == 200) {
      CMDlResponse value = CMDlResponse.fromJson(
        response ?? {},
      );
      if (value.code) {
        InvoicePaymentVoucher voucherData = InvoicePaymentVoucher.fromJson(value.data[0]);
        // print(voucherData.clientAddress);
        showVoucherDetails(context, voucherData);
        // voucherModel.voucher_list.add(InvoicePaymentVoucher.fromJson(value.data[i]));
        // // print(value.data);
        // voucherController.add_Voucher(value);
        // voucherController.update();
      } else {
        // await Error_dialog(context: context, title: 'ERROR', content: value.message ?? "", onOk: () {});
      }
    } else {
      // Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
    }
    // loader.stop();
  }

  void showVoucherDetails(BuildContext context, InvoicePaymentVoucher voucher) {
    final GlobalKey _invoiceCopyKey = GlobalKey();
    final GlobalKey _voucherCopyKey = GlobalKey();
    final GlobalKey _GSTcopyKey = GlobalKey();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: EdgeInsets.all(20),
          child: Container(
            width: 800,
            // padding: EdgeInsets.all(16),
            // constraints: BoxConstraints(minWidth: 300, maxWidth: 500),
            decoration: BoxDecoration(
              color: Primary_colors.Light,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10))],
            ),
            // child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Primary_colors.Color3, Primary_colors.Color3.withOpacity(0.8)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          // color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check_circle, color: Colors.green, size: 34),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'Voucher Details',
                        style: TextStyle(color: Colors.white, fontSize: Primary_font_size.Text10, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.only(right: 16, left: 16),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Primary_colors.Dark,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Primary_colors.Dark, width: 1),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        // ✅ use Flexible inside scroll views
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(color: Primary_colors.Color3.withOpacity(0.1), shape: BoxShape.circle),
                                  child: const CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Primary_colors.Color3,
                                    child: Icon(Icons.person, color: Colors.white, size: 20),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        voucher.clientName,
                                        maxLines: 1,
                                        style: const TextStyle(overflow: TextOverflow.ellipsis, color: Colors.white, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text9),
                                      ),
                                      const SizedBox(height: 4),
                                      Text("Client ID: ${voucher.customerId}", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _infoRow(Icons.location_on_outlined, voucher.clientAddress),
                            const SizedBox(height: 8),
                            _infoRow(Icons.phone_android, voucher.phoneNumber),
                            const SizedBox(height: 8),
                            _infoRow(Icons.email_sharp, voucher.emailId),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Invoice Number',
                                  style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      voucher.invoiceNumber,
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8),
                                    ),
                                    const SizedBox(width: 8),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        key: _invoiceCopyKey, // Attach the key here
                                        onTap: () async {
                                          await Clipboard.setData(ClipboardData(text: voucher.invoiceNumber));

                                          final renderBox = _invoiceCopyKey.currentContext?.findRenderObject() as RenderBox?;
                                          if (renderBox == null) return; // Early exit if not rendered

                                          final overlay = Overlay.of(context);
                                          final overlayEntry = OverlayEntry(
                                            builder: (context) => Positioned(
                                              left: renderBox.localToGlobal(Offset.zero).dx + renderBox.size.width,
                                              top: renderBox.localToGlobal(Offset.zero).dy,
                                              child: Material(
                                                color: Colors.transparent,
                                                child: Container(
                                                  padding: const EdgeInsets.all(6),
                                                  decoration: BoxDecoration(color: const Color.fromARGB(119, 33, 149, 243).withOpacity(0.8), borderRadius: BorderRadius.circular(8)),
                                                  child: const Text(
                                                    "Copied!",
                                                    style: TextStyle(color: Colors.white, fontSize: Primary_font_size.Text5),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );

                                          overlay.insert(overlayEntry);
                                          Future.delayed(const Duration(seconds: 1), overlayEntry.remove);
                                        },
                                        child: const Icon(Icons.copy, color: Colors.grey, size: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Voucher Number',
                                  style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      voucher.voucherNumber,
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8),
                                    ),
                                    const SizedBox(width: 8),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        key: _voucherCopyKey, // Attach the key here
                                        onTap: () async {
                                          await Clipboard.setData(ClipboardData(text: voucher.voucherNumber));

                                          final renderBox = _voucherCopyKey.currentContext?.findRenderObject() as RenderBox?;
                                          if (renderBox == null) return; // Early exit if not rendered

                                          final overlay = Overlay.of(context);
                                          final overlayEntry = OverlayEntry(
                                            builder: (context) => Positioned(
                                              left: renderBox.localToGlobal(Offset.zero).dx + renderBox.size.width,
                                              top: renderBox.localToGlobal(Offset.zero).dy,
                                              child: Material(
                                                color: Colors.transparent,
                                                child: Container(
                                                  padding: const EdgeInsets.all(6),
                                                  decoration: BoxDecoration(color: const Color.fromARGB(119, 33, 149, 243).withOpacity(0.8), borderRadius: BorderRadius.circular(8)),
                                                  child: const Text(
                                                    "Copied!",
                                                    style: TextStyle(color: Colors.white, fontSize: Primary_font_size.Text5),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );

                                          overlay.insert(overlayEntry);
                                          Future.delayed(const Duration(seconds: 1), overlayEntry.remove);
                                        },
                                        child: const Icon(Icons.copy, color: Colors.grey, size: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'GST Number',
                                  style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      voucher.gstNumber,
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8),
                                    ),
                                    const SizedBox(width: 8),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        key: _GSTcopyKey, // Attach the key here
                                        onTap: () async {
                                          await Clipboard.setData(ClipboardData(text: voucher.gstNumber));

                                          final renderBox = _GSTcopyKey.currentContext?.findRenderObject() as RenderBox?;
                                          if (renderBox == null) return; // Early exit if not rendered

                                          final overlay = Overlay.of(context);
                                          final overlayEntry = OverlayEntry(
                                            builder: (context) => Positioned(
                                              left: renderBox.localToGlobal(Offset.zero).dx + renderBox.size.width,
                                              top: renderBox.localToGlobal(Offset.zero).dy,
                                              child: Material(
                                                color: Colors.transparent,
                                                child: Container(
                                                  padding: const EdgeInsets.all(6),
                                                  decoration: BoxDecoration(color: const Color.fromARGB(119, 33, 149, 243).withOpacity(0.8), borderRadius: BorderRadius.circular(8)),
                                                  child: const Text(
                                                    "Copied!",
                                                    style: TextStyle(color: Colors.white, fontSize: Primary_font_size.Text5),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );

                                          overlay.insert(overlayEntry);
                                          Future.delayed(const Duration(seconds: 1), overlayEntry.remove);
                                        },
                                        child: const Icon(Icons.copy, color: Colors.grey, size: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(height: 250, width: 0.5, color: Colors.grey[500], margin: const EdgeInsets.all(20)),
                      // const SizedBox(height: 15,),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "PAYMENT BREAKUP",
                              style: TextStyle(color: Primary_colors.Color3, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 0.5),
                            ),
                            const SizedBox(height: 16),
                            _buildBreakupLine("Net Amount", "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucher.subTotal)}"),
                            _buildBreakupDivider(),
                            _buildBreakupLine("CGST (9%)", "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucher.cgst)}"),
                            _buildBreakupDivider(),
                            _buildBreakupLine("SGST (9%)", "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucher.sgst)}"),
                            _buildBreakupDivider(),
                            _buildBreakupLine("IGST", "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucher.igst)}"),
                            _buildBreakupDivider(),
                            if (voucher.tdsCalculation == 1) _buildBreakupLine("TDS (2%)", "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucher.tdsCalculationAmount)}"),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(color: Primary_colors.Color3.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Total Amount",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                                  ),
                                  Text(
                                    "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucher.totalAmount)}",
                                    style: const TextStyle(color: Primary_colors.Color3, fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //  Expanded(
                voucher.paymentDetails != null
                    ? Container(
                        margin: const EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 8),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Primary_colors.Dark,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Primary_colors.Dark, width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Payment Details',
                              style: TextStyle(color: Primary_colors.Color3, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 0.5),
                            ),
                            const SizedBox(height: 10),

                            // Header Row (non-scrollable)
                            ClipRRect(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                              child: Container(
                                color: const Color(0xFFE0E0E0),
                                child: Table(
                                  columnWidths: const {0: FlexColumnWidth(1.5), 1: FlexColumnWidth(2), 2: FlexColumnWidth(3.5), 3: FlexColumnWidth(1.5)},
                                  border: TableBorder(bottom: BorderSide(color: Colors.grey.shade400)),
                                  children: const [
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Date',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Amount Paid',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Transaction Details',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'View',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Receipt',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Scrollable Rows (only this part scrolls)
                            // Expanded(
                            if (voucher.paymentDetails != null)
                              ClipRRect(
                                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
                                child: Container(
                                  decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400)),
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(maxHeight: 200),
                                    child: SingleChildScrollView(
                                      child: Table(
                                        columnWidths: const {0: FlexColumnWidth(1.5), 1: FlexColumnWidth(2), 2: FlexColumnWidth(3.5), 3: FlexColumnWidth(1.5)},
                                        border: TableBorder(horizontalInside: BorderSide(color: Colors.grey.shade400)),
                                        children: voucher.paymentDetails!.map<TableRow>((payment) {
                                          final date = formatDate(payment.date);
                                          final amount = '₹ ${formatCurrency(payment.amount)}';
                                          // final transID = payment.transactionId;
                                          final txnDetails = payment.transanctionDetails == "" ? 'N/A' : payment.transanctionDetails;

                                          return TableRow(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  date,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(color: Colors.grey),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  amount,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(color: Colors.grey),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  txnDetails,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(color: Colors.grey),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: MouseRegion(
                                                  cursor: SystemMouseCursors.click,
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      bool success = await Get_transactionPDFfile(context: context, transactionID: payment.transactionId);
                                                      if (success) {
                                                        showPDF(context, "TRANSACTION_${payment.transactionId}", mainBilling_Controller.billingModel.pdfFile.value);
                                                      }
                                                    },
                                                    child: Image.asset('assets/images/pdfdownload.png', width: 24, height: 24),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    // PDF View
                                                    MouseRegion(
                                                      cursor: SystemMouseCursors.click,
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          bool success = await Get_receiptPDFfile(context: context, transactionID: payment.transactionId);
                                                          if (success) {
                                                            showPDF(context, "RECEIPT_${payment.transactionId}", mainBilling_Controller.billingModel.pdfFile.value);
                                                          }
                                                        },
                                                        child: Image.asset('assets/images/order.png', width: 24, height: 24),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),

                                                    // Edit / Save Button
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            // ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Primary_colors.Dark,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color.fromARGB(55, 243, 208, 96), width: 1),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.warning_amber_rounded, color: Color.fromARGB(255, 236, 190, 64), size: 20),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "No Transaction made yet!",
                                  style: TextStyle(color: Color.fromARGB(255, 236, 190, 64), fontWeight: FontWeight.w500, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBreakupDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Divider(height: 1, color: Colors.grey, thickness: 0.2),
    );
  }

  Widget _buildBreakupLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 12),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.grey, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ),
      ],
    );
  }

  Future<void> billing_refresh() async {
    // salesController.resetData();
    get_SubscriptionInvoiceList();
    get_SalesInvoiceList();
    GetDashboardData();
  }

  Future<void> selectfilterDate(BuildContext context, TextEditingController controller) async {
    final DateTime now = DateTime.now();
    final DateTime nextYear = now.add(const Duration(days: 365)); // Limit to next year

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now, // Start from today
      lastDate: nextYear, // Allow dates up to 1 year from today
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Primary_colors.Color3,
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Primary_colors.Color3,
              ),
            ),
            dialogTheme: const DialogThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final formatted = "${pickedDate.year.toString().padLeft(4, '0')}-"
          "${pickedDate.month.toString().padLeft(2, '0')}-"
          "${pickedDate.day.toString().padLeft(2, '0')}";

      controller.text = formatted;
    }
  }

  void resetmainbilling_Filters() {
    mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.plantype.value = 'Show All';
    // mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.invoicetype.value = 'Show All';
    mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.selectedsalescustomername.value = 'None';
    mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.selectedcustomerid.value = '';
    mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.selectedsubscriptioncustomername.value = 'None';
    mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.paymentstatus.value = 'Show All';
    mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.fromdate.value = '';
    mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.todate.value = '';
    // mainBilling_Controller.billingModel.filteredmainbilling_s.value = mainBilling_Controller.billingModel.mainbilling__list;
  }

  void assignmainbilling_Filters() {
    mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.plantype.value = mainBilling_Controller.billingModel.selectedplantype.value;
    // mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.invoicetype.value = mainBilling_Controller.billingModel.selectedInvoiceType.value;
    mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.selectedsalescustomername.value = mainBilling_Controller.billingModel.selectedsalescustomer.value;
    mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.selectedsubscriptioncustomername.value = mainBilling_Controller.billingModel.selectedsubcustomer.value;
    mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.selectedcustomerid.value = mainBilling_Controller.billingModel.selectedcustomerID.value;
    mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.paymentstatus.value = mainBilling_Controller.billingModel.selectedpaymentstatus.value;
    mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.fromdate.value = mainBilling_Controller.billingModel.startDateController.value.text;
    mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.todate.value = mainBilling_Controller.billingModel.endDateController.value.text;
  }

  void reassignmainbilling_Filters() {
    mainBilling_Controller.billingModel.selectedplantype.value = mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.plantype.value;
    // mainBilling_Controller.billingModel.selectedInvoiceType.value = mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.invoicetype.value;
    mainBilling_Controller.billingModel.selectedsalescustomer.value = mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.selectedsalescustomername.value;
    mainBilling_Controller.billingModel.selectedsubcustomer.value = mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.selectedsubscriptioncustomername.value;
    mainBilling_Controller.billingModel.selectedcustomerID.value = mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.selectedcustomerid.value;
    mainBilling_Controller.billingModel.selectedpaymentstatus.value = mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.paymentstatus.value;
    mainBilling_Controller.billingModel.startDateController.value.text = mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.fromdate.value;
    mainBilling_Controller.billingModel.endDateController.value.text = mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.todate.toString();
    mainBilling_Controller.billingModel.selectedMonth.value = mainBilling_Controller.billingModel.mainbilling_SelectedFilter.value.selectedmonth.value.toString();
  }
  // void resetFilters() {
  //   mainBilling_Controller.billingModel.startDateController.value.clear();
  //   mainBilling_Controller.billingModel.endDateController.value.clear();
  //   mainBilling_Controller.billingModel.selectedPaymentStatus.value = 'Show All';
  //   mainBilling_Controller.billingModel.selectedInvoiceType.value = 'Show All';
  //   mainBilling_Controller.billingModel.selectedQuickFilter.value = 'Show All';
  //   mainBilling_Controller.billingModel.selectedPackageName.value = 'Show All';
  //   mainBilling_Controller.billingModel.showCustomDateRange.value = false;
  //   // voucherController.voucherModel.filteredVouchers.value = voucherController.voucherModel.voucher_list;
  //   // voucherController.voucherModel.selectedItems.value = List.filled(voucherController.voucherModel.voucher_list.length, false);
  //   // voucherController.voucherModel.selectAll.value = false;
  //   // voucherController.voucherModel.showDeleteButton.value = false;
  // }
}
