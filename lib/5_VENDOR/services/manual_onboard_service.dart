// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/manual_onboard_actions.dart';
import 'package:ssipl_billing/5_VENDOR/views/Manual_onboard/show_Manual_onboard.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/THEMES/style.dart';

// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../API/invoker.dart';

mixin ManualOnboardService {
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final ManualOnboardController manualOnboardController = Get.find<ManualOnboardController>();

  final loader = LoadingOverlay();

// // ##################################################################################################################################################################################################################################################################################################################################################################
  void nextTab(context) async {
    manualOnboardController.nextTab();
  }

  void backTab(context) async {
    manualOnboardController.backTab();
  }

  Future<void> allFilesAction({
    required BuildContext context,
    required Future<bool> Function(BuildContext) pickFunction,
  }) async {
    bool picked = await pickFunction(context);
    if (!picked) return;

    final model = manualOnboardController.manualOnboardModel;

    final regPath = model.GSTregCertiPickedFile.value?.files.single.path;
    final panPath = model.vendorPANPickedFile.value?.files.single.path;
    final chequePath = model.cancelledChequePickedFile.value?.files.single.path;

    if (regPath != null && panPath != null && chequePath != null) {
      // All three files are selected, so upload them
      uploadAllData(
        context,
        File(regPath),
        File(panPath),
        File(chequePath),
      );
    }
  }

  void uploadAllData(context, File regFile, File panFile, File chequeFile) async {
    try {
      print('Hi');
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
      loader.stop();
    }
  }

  dynamic show_ManualOnboard_DialogBox(context) async {
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
                child: ShowManualOnboard(),
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
                    if (manualOnboardController.anyHavedata()) {
                      bool? proceed = await Warning_dialog(
                        context: context,
                        title: 'Warning',
                        content: "The data may be lost. Do you want to proceed?",
                      );

                      if (proceed == true) {
                        Navigator.of(context).pop();
                        manualOnboardController.resetData();
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
}
