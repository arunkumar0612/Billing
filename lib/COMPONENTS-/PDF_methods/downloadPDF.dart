import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';

final loader = LoadingOverlay();
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
    await OpenFilex.open(savePath);

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

Future<void> downloadExcel(BuildContext context, String filename, File? excelFile) async {
  try {
    loader.start(context);

    // ✅ Let the loader show before blocking UI
    await Future.delayed(const Duration(milliseconds: 300));

    if (excelFile == null) {
      loader.stop();
      if (kDebugMode) {
        print("No excel file found to download.");
      }
      Error_dialog(
        context: context,
        title: "No excel Found",
        content: "There is no excel file to download.",
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

    String savePath = "$selectedDirectory/$filename.xlxs";
    await excelFile.copy(savePath);
    await OpenFilex.open(savePath);

    Success_SnackBar(context, "✅ EXCEL downloaded successfully to: $savePath");
  } catch (e) {
    loader.stop();
    if (kDebugMode) {
      print("❌ Error while downloading excel: $e");
    }
    Error_dialog(
      context: context,
      title: "Error",
      content: "An error occurred while downloading the excel:\n$e",
      // showCancel: false,
    );
  }
}
