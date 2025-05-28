import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/controllers/Billing_actions.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/models/entities/Billing_entities.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/THEMES/style.dart';

mixin main_BillingService {
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final MainBilling_Controller mainBilling_Controller = Get.find<MainBilling_Controller>();
  final loader = LoadingOverlay();
  void get_SubscriptionInvoiceList() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.billing_subscriptionInvoice);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          mainBilling_Controller.billingModel.allSubscriptionInvoices.clear();
          mainBilling_Controller.billingModel.allSubscriptionInvoices.clear();
          for (int i = 0; i < value.data.length; i++) {
            mainBilling_Controller.addto_SubscriptionInvoiceList(SubscriptionInvoice.fromJson(value.data[i]));
            // print(value.data[i]['Overdue_history']);
          }

          // await Basic_dialog(context: context,showCancel: false, title: 'Organization List', content: value.message!, onOk: () {});
          // clientreqController.update_OrganizationList(value);
        } else {
          // await Error_dialog(context: context, title: 'Fetching Organization List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        // Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      // Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  Future<void> selectDate(BuildContext context, TextEditingController controller) async {
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

  void get_SalesInvoiceList() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.billing_salesInvoice);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          mainBilling_Controller.billingModel.allSalesInvoices.clear();
          mainBilling_Controller.billingModel.salesInvoiceList.clear();
          for (int i = 0; i < value.data.length; i++) {
            SalesInvoice element = SalesInvoice.fromJson(value.data[i]);
            mainBilling_Controller.addto_SalesInvoiceList(element);
          }

          // await Basic_dialog(context: context,showCancel: false, title: 'Organization List', content: value.message!, onOk: () {});
          // clientreqController.update_OrganizationList(value);
        } else {
          // await Error_dialog(context: context, title: 'Fetching Organization List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        // Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      // Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  Future<bool> GetSalesPDFfile({
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

  Future<void> billing_refresh() async {
    // salesController.resetData();
    get_SubscriptionInvoiceList();
    get_SalesInvoiceList();
  }

  void resetFilters() {
    mainBilling_Controller.billingModel.startDateController.value.clear();
    mainBilling_Controller.billingModel.endDateController.value.clear();
    mainBilling_Controller.billingModel.selectedPaymentStatus.value = 'Show All';
    mainBilling_Controller.billingModel.selectedInvoiceType.value = 'Show All';
    mainBilling_Controller.billingModel.selectedQuickFilter.value = 'Show All';
    mainBilling_Controller.billingModel.selectedPackageName.value = 'Show All';
    mainBilling_Controller.billingModel.showCustomDateRange.value = false;
    // voucherController.voucherModel.filteredVouchers.value = voucherController.voucherModel.voucher_list;
    // voucherController.voucherModel.selectedItems.value = List.filled(voucherController.voucherModel.voucher_list.length, false);
    // voucherController.voucherModel.selectAll.value = false;
    // voucherController.voucherModel.showDeleteButton.value = false;
  }
}
