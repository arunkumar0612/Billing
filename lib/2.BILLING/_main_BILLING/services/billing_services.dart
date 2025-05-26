import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/controllers/Billing_actions.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/models/entities/Billing_entities.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
    final DateTime tomorrow = DateTime(now.year, now.month, now.day, 23, 59);

    // Step 1: Show Date Picker
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: tomorrow,
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
      // Step 2: Show Time Picker
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              timePickerTheme: const TimePickerThemeData(
                dialHandColor: Primary_colors.Color3,
                entryModeIconColor: Primary_colors.Color3,
              ),
              colorScheme: const ColorScheme.light(
                primary: Primary_colors.Color3,
                onPrimary: Colors.white,
                onSurface: Colors.black87,
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        final DateTime fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Check if the selected datetime exceeds tomorrow
        if (fullDateTime.isAfter(tomorrow)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Date/time cannot exceed tomorrow.')),
          );
          return;
        }

        final formatted = "${fullDateTime.year.toString().padLeft(4, '0')}-"
            "${fullDateTime.month.toString().padLeft(2, '0')}-"
            "${fullDateTime.day.toString().padLeft(2, '0')} "
            "${pickedTime.hour.toString().padLeft(2, '0')}:"
            "${pickedTime.minute.toString().padLeft(2, '0')}";

        controller.text = formatted;
      }
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

  void showPDF(context, String filename) async {
    if (mainBilling_Controller.billingModel.pdfFile.value != null) {
      await showDialog(
        context: context,
        builder: (context) => Dialog(
          insetPadding: const EdgeInsets.all(20), // Adjust padding to keep it from being full screen
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.35, // 85% of screen width
              height: MediaQuery.of(context).size.height * 0.95, // 80% of screen height
              child: Stack(
                children: [
                  SfPdfViewer.file(mainBilling_Controller.billingModel.pdfFile.value!),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: IconButton(
                          onPressed: () {
                            downloadPdf(
                                context,
                                path
                                    .basename(filename)
                                    .replaceAll(RegExp(r'[\/\\:*?"<>|.]'), '') // Removes invalid symbols
                                    .replaceAll(" ", ""),
                                mainBilling_Controller.billingModel.pdfFile.value);
                          },
                          icon: const Icon(
                            Icons.download,
                            color: Colors.blue,
                          ),
                        ),
                      ))
                ],
              )),
        ),
      );
    }
  }

  Future<File> savePdfToTemp(Uint8List pdfData) async {
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/temp_pdf.pdf');
    await tempFile.writeAsBytes(pdfData, flush: true);
    return tempFile;
  }

  Future<void> downloadPdf(BuildContext context, String filename, File? pdfFile) async {
    try {
      loader.start(context);

      // ✅ Let the loader show before blocking UI
      await Future.delayed(const Duration(milliseconds: 300));

      if (pdfFile == null) {
        loader.stop();
        if (kDebugMode) {
          print("No PDF file found to download.");
        }
        Error_dialog(
          context: context,
          title: "No PDF Found",
          content: "There is no PDF file to download.",
          // showCancel: false,
        );
        return;
      }

      await Future.delayed(const Duration(milliseconds: 100));

      String? selectedDirectory = await FilePicker.platform.getDirectoryPath(lockParentWindow: true);

      // ✅ Always stop loader after native call
      loader.stop();

      if (selectedDirectory == null) {
        if (kDebugMode) {
          print("User cancelled the folder selection.");
        }
        Error_dialog(
          context: context,
          title: "Cancelled",
          content: "Download cancelled. No folder was selected.",
          // showCancel: false,
        );
        return;
      }

      String savePath = "$selectedDirectory/$filename.pdf";
      await pdfFile.copy(savePath);

      Success_SnackBar(context, "✅ PDF downloaded successfully to: $savePath");
    } catch (e) {
      loader.stop();
      if (kDebugMode) {
        print("❌ Error while downloading PDF: $e");
      }
      Error_dialog(
        context: context,
        title: "Error",
        content: "An error occurred while downloading the PDF:\n$e",
        // showCancel: false,
      );
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
