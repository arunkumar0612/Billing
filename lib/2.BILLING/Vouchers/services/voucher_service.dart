import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:ssipl_billing/2.BILLING/Vouchers/controllers/voucher_action.dart';
import 'package:ssipl_billing/2.BILLING/Vouchers/models/entities/voucher_entities.dart';
// import 'package:ssipl_billing/2.BILLING/Vouchers/controllers/voucher_action.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

mixin VoucherService {
  final VoucherController voucherController = Get.find<VoucherController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final loader = LoadingOverlay();
  Future<bool> Get_transactionPDFfile({required BuildContext context, required int transactionID}) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"transactionid": transactionID}, API.get_transactionBinaryfile);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          await voucherController.PDFfileApiData(value);
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
    if (voucherController.voucherModel.pdfFile.value != null) {
      await showDialog(
        context: context,
        builder: (context) => Dialog(
          insetPadding: const EdgeInsets.all(20), // Adjust padding to keep it from being full screen
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.35, // 85% of screen width
              height: MediaQuery.of(context).size.height * 0.95, // 80% of screen height
              child: Stack(
                children: [
                  SfPdfViewer.file(voucherController.voucherModel.pdfFile.value!),
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
                                voucherController.voucherModel.pdfFile.value);
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

  Future<void> get_VoucherList() async {
    // loader.start(context);
    await Future.delayed(const Duration(milliseconds: 1000));
    // response;
    Map<String, dynamic>? response = await apiController.GetbyQueryString(
      {
        "vouchertype": "payment",
        "invoicetype": "subscription",
        // "customerid": "SB_1",
      },
      API.getvoucherlist,
    );
    if (response?['statusCode'] == 200) {
      CMDlResponse value = CMDlResponse.fromJson(response ?? {});
      if (value.code) {
        voucherController.add_Voucher(value);
        voucherController.update();
      } else {
        // await Error_dialog(context: context, title: 'ERROR', content: value.message ?? "", onOk: () {});
      }
    } else {
      // Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
    }
    // loader.stop();
  }

  Future<SelectedInvoiceVoucherGroup> calculate_SelectedVouchers() async {
    List<int> selectedIndices = [];
    for (int i = 0; i < voucherController.voucherModel.selectedItems.length; i++) {
      if (voucherController.voucherModel.selectedItems[i] == true) {
        selectedIndices.add(i);
      }
    }

    List<InvoicePaymentVoucher> fullList = voucherController.voucherModel.voucher_list; // assume this is populated

    List<InvoicePaymentVoucher> selected = selectedIndices.map((index) => fullList[index]).toList();

    SelectedInvoiceVoucherGroup group = SelectedInvoiceVoucherGroup(
      selectedVoucherList: selected,
      totalPendingAmount_withoutTDS: selected.fold(0, (sum, v) => sum + v.pendingAmount),
      totalPendingAmount_withTDS: selected.fold<double>(0.0, (sum, v) => sum + v.pendingAmount) - selected.fold<double>(0.0, (sum, v) => sum + v.tdsCalculationAmount),
      netAmount: selected.fold(0, (sum, v) => sum + v.subTotal),
      totalCGST: selected.fold(0, (sum, v) => sum + v.cgst),
      totalSGST: selected.fold(0, (sum, v) => sum + v.sgst),
      totalIGST: selected.fold(0, (sum, v) => sum + v.igst),
      totalTDS: selected.fold(0, (sum, v) => sum + v.tdsCalculationAmount),
    );

    return group;
  }

  Future<void> voucher_refresh() async {
    await get_VoucherList();
    voucherController.update();
  }
  // dynamic clearVoucher(context, int index) async {
  //   try {
  //     final mapData = {
  //       "date": voucherController.voucherModel.closedDate.value,
  //       "voucherid": voucherController.voucherModel.voucher_list[index].voucher_id,
  //       "vouchernumber": voucherController.voucherModel.voucher_list[index].voucherNumber,
  //       "paymentstatus": 'partial',
  //       "IGST": voucherController.voucherModel.voucher_list[index].igst,
  //       "SGST": voucherController.voucherModel.voucher_list[index].sgst,
  //       "CGST": voucherController.voucherModel.voucher_list[index].cgst,
  //       "tds": voucherController.voucherModel.voucher_list[index].tdsCalculationAmount,
  //       "grossamount": voucherController.voucherModel.voucher_list[index].totalAmount,
  //       "subtotal": voucherController.voucherModel.voucher_list[index].subTotal,
  //       "paidamount": double.parse(voucherController.voucherModel.amountCleared_controller.value.text),
  //       "clientaddressname": voucherController.voucherModel.voucher_list[index].clientName,
  //       "clientaddress": voucherController.voucherModel.voucher_list[index].clientAddress,
  //       "invoicenumber": voucherController.voucherModel.voucher_list[index].invoiceNumber,
  //       "emailid": voucherController.voucherModel.voucher_list[index].emailId,
  //       "phoneno": voucherController.voucherModel.voucher_list[index].phoneNumber,
  //       "tdsstatus": true,
  //       "invoicetype": voucherController.voucherModel.voucher_list[index].invoiceType,
  //       "gstnumber": voucherController.voucherModel.voucher_list[index].gstNumber,
  //       "feedback": voucherController.voucherModel.feedback_controller.value.text,
  //       "transactiondetails": voucherController.voucherModel.transactionDetails_controller.value.text,
  //     };
  //     ClearVoucher voucherdata = ClearVoucher.fromJson(mapData);

  //     String encodedData = json.encode(voucherdata.toJson());
  //     Map<String, dynamic>? response = await apiController.Multer(encodedData, API.clearVoucher);
  //     if (response['statusCode'] == 200) {
  //       CMDmResponse value = CMDmResponse.fromJson(response);
  //       if (value.code) {
  //         await Success_dialog(context: context, title: "LOGO", content: value.message!, onOk: () {});
  //       } else {
  //         await Error_dialog(context: context, title: 'Uploading Logo', content: value.message ?? "", onOk: () {});
  //       }
  //     } else {
  //       Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
  //     }
  //   } catch (e) {
  //     Error_dialog(context: context, title: "ERROR", content: "$e");
  //   }
  // }

  dynamic clear_ClubVoucher(context, SelectedInvoiceVoucherGroup selectedVouchers, File? file) async {
    try {
      List<Map<String, dynamic>> consolidateJSON = [];
      List<int> voucherIds = [];
      List<String> voucherNumbers = [];
      for (int i = 0; i < selectedVouchers.selectedVoucherList.length; i++) {
        voucherIds.add(selectedVouchers.selectedVoucherList[i].voucher_id);
        voucherNumbers.add(selectedVouchers.selectedVoucherList[i].voucherNumber);
        final mapData = {
          "voucherid": selectedVouchers.selectedVoucherList[i].voucher_id,
          "vouchernumber": selectedVouchers.selectedVoucherList[i].voucherNumber,
          "IGST": selectedVouchers.selectedVoucherList[i].igst,
          "SGST": selectedVouchers.selectedVoucherList[i].sgst,
          "CGST": selectedVouchers.selectedVoucherList[i].cgst,
          "tds": selectedVouchers.selectedVoucherList[i].tdsCalculationAmount,
          "grossamount": selectedVouchers.selectedVoucherList[i].totalAmount,
          "subtotal": selectedVouchers.selectedVoucherList[i].subTotal,
          "paidamount": voucherController.voucherModel.is_Deducted.value
              ? (selectedVouchers.selectedVoucherList[i].pendingAmount - selectedVouchers.selectedVoucherList[i].tdsCalculationAmount)
              : selectedVouchers.selectedVoucherList[i].totalAmount,
          "clientaddressname": selectedVouchers.selectedVoucherList[i].clientName,
          "clientaddress": selectedVouchers.selectedVoucherList[i].clientAddress,
          "invoicenumber": selectedVouchers.selectedVoucherList[i].invoiceNumber,
          "emailid": selectedVouchers.selectedVoucherList[i].emailId,
          "phoneno": selectedVouchers.selectedVoucherList[i].phoneNumber,
          "invoicetype": selectedVouchers.selectedVoucherList[i].invoiceType,
          "gstnumber": selectedVouchers.selectedVoucherList[i].gstNumber,
        };
        consolidateJSON.add(mapData);
      }
      final main_map = {
        "totalpaidamount": voucherController.voucherModel.is_Deducted.value ? selectedVouchers.totalPendingAmount_withTDS : selectedVouchers.totalPendingAmount_withoutTDS,
        "voucherlist": consolidateJSON,
        "date": voucherController.voucherModel.closedDate.value,
        "feedback": voucherController.voucherModel.feedback_controller.value.text,
        "transactiondetails": voucherController.voucherModel.transactionDetails_controller.value.text,
        "tdsstatus": voucherController.voucherModel.is_Deducted.value,
        "paymentstatus": "complete",
        "voucherids": voucherIds,
        "vouchernumbers": voucherNumbers
      };

      Clear_ClubVoucher voucherdata = Clear_ClubVoucher.fromJson(main_map);
      String encodedData = json.encode(voucherdata.toJson());
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, encodedData, file, API.clearClubVoucher);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          await Success_dialog(context: context, title: "SUCCESS", content: value.message!, onOk: () {});
          Navigator.of(context).pop(true);
        } else {
          await Error_dialog(context: context, title: 'Processing Invoice', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
      //await Refresher().refreshAll(context);
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  dynamic clearVoucher(context, int index, File? file, String VoucherType) async {
    try {
      final mapData = {
        "date": voucherController.voucherModel.closedDate.value,
        "voucherid": voucherController.voucherModel.voucher_list[index].voucher_id,
        "vouchernumber": voucherController.voucherModel.voucher_list[index].voucherNumber,
        "paymentstatus": VoucherType,
        "IGST": voucherController.voucherModel.voucher_list[index].igst,
        "SGST": voucherController.voucherModel.voucher_list[index].sgst,
        "CGST": voucherController.voucherModel.voucher_list[index].cgst,
        "tds": voucherController.voucherModel.voucher_list[index].tdsCalculationAmount,
        "grossamount": voucherController.voucherModel.voucher_list[index].totalAmount,
        "subtotal": voucherController.voucherModel.voucher_list[index].subTotal,
        "paidamount": double.parse(voucherController.voucherModel.amountCleared_controller.value.text),
        "clientaddressname": voucherController.voucherModel.voucher_list[index].clientName,
        "clientaddress": voucherController.voucherModel.voucher_list[index].clientAddress,
        "invoicenumber": voucherController.voucherModel.voucher_list[index].invoiceNumber,
        "emailid": voucherController.voucherModel.voucher_list[index].emailId,
        "phoneno": voucherController.voucherModel.voucher_list[index].phoneNumber,
        "tdsstatus": voucherController.voucherModel.is_Deducted.value,
        "invoicetype": voucherController.voucherModel.voucher_list[index].invoiceType,
        "gstnumber": voucherController.voucherModel.voucher_list[index].gstNumber,
        "feedback": voucherController.voucherModel.feedback_controller.value.text,
        "transactiondetails": voucherController.voucherModel.transactionDetails_controller.value.text,
      };
      ClearVoucher voucherdata = ClearVoucher.fromJson(mapData);

      String encodedData = json.encode(voucherdata.toJson());
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, encodedData, file, API.clearVoucher);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          await Success_dialog(context: context, title: "SUCCESS", content: value.message!, onOk: () {});
          Navigator.of(context).pop(true);
        } else {
          await Error_dialog(context: context, title: 'Processing Invoice', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
      //await Refresher().refreshAll(context);
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  void applySearchFilter(String query) {
    try {
      if (query.isEmpty) {
        voucherController.voucherModel.filteredVouchers.assignAll(voucherController.voucherModel.voucher_list);
      } else {
        final filtered = voucherController.voucherModel.voucher_list.where((voucher) {
          return voucher.clientName.toLowerCase().contains(query.toLowerCase()) || voucher.voucherNumber.toLowerCase().contains(query.toLowerCase());
        }).toList();
        voucherController.voucherModel.filteredVouchers.assignAll(filtered);
      }

      // Update selectedItems to match the new filtered list length
      voucherController.voucherModel.selectedItems.value = List<bool>.filled(voucherController.voucherModel.filteredVouchers.length, false);
      voucherController.voucherModel.selectAll.value = false;
      voucherController.voucherModel.showDeleteButton.value = false;
    } catch (e) {
      debugPrint('Error in applySearchFilter: $e');
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

  Future<void> pickFile() async {
    // Open file picker and select a file
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // Get the picked file

      voucherController.voucherModel.selectedFile.value = File(result.files.single.path!);
      voucherController.voucherModel.fileName.value = result.files.single.name;

      // Here you can handle the file upload logic
      // For example, you can send the file to a server or save it locally
    }
  }

  void updateDeleteButtonVisibility() {
    voucherController.voucherModel.showDeleteButton.value = voucherController.voucherModel.selectedItems.contains(true);
  }

  void deleteSelectedItems(BuildContext context) {
    // Create a list of indices to remove (in reverse order to avoid index shifting)
    final indicesToRemove = <int>[];
    for (int i = voucherController.voucherModel.selectedItems.length - 1; i >= 0; i--) {
      if (voucherController.voucherModel.selectedItems[i]) {
        indicesToRemove.add(i);
      }
    }

    // Remove items from voucher_list
    for (final index in indicesToRemove) {
      voucherController.voucherModel.voucher_list.removeAt(index);
    }

    // Reset selection state
    voucherController.voucherModel.selectedItems.value = List<bool>.filled(voucherController.voucherModel.voucher_list.length, false);
    voucherController.voucherModel.selectAll.value = false;
    voucherController.voucherModel.showDeleteButton.value = false;

    // Show a snackbar to confirm deletion
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted ${indicesToRemove.length} item(s)'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void showCustomDateRangePicker() {
    voucherController.voucherModel.showCustomDateRange.value = true;
    voucherController.voucherModel.selectedQuickFilter.value = 'Custom range';
  }

  void resetFilters() {
    voucherController.voucherModel.startDateController.value.clear();
    voucherController.voucherModel.endDateController.value.clear();
    voucherController.voucherModel.selectedpaymentStatus.value = 'Show All';
    voucherController.voucherModel.selectedInvoiceType.value = 'Show All';
    voucherController.voucherModel.selectedQuickFilter.value = 'Show All';
    voucherController.voucherModel.showCustomDateRange.value = false;
    voucherController.voucherModel.filteredVouchers.value = voucherController.voucherModel.voucher_list;
    voucherController.voucherModel.selectedItems.value = List.filled(voucherController.voucherModel.voucher_list.length, false);
    voucherController.voucherModel.selectAll.value = false;
    voucherController.voucherModel.showDeleteButton.value = false;
  }
}
