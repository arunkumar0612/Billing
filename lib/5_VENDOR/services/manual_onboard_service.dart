// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/manual_onboard_actions.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/manual_onboard_entities.dart';
import 'package:ssipl_billing/5_VENDOR/views/Manual_onboard/show_Manual_onboard.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/THEMES/style.dart';

// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../API/invoker.dart';

mixin ManualOnboardService {
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final ManualOnboardController manualOnboardController = Get.find<ManualOnboardController>();

  final loader = LoadingOverlay();

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

    final regPath = manualOnboardController.manualOnboardModel.GSTregCertiPickedFile.value?.files.single.path;
    final panPath = manualOnboardController.manualOnboardModel.vendorPANPickedFile.value?.files.single.path;
    final chequePath = manualOnboardController.manualOnboardModel.cancelledChequePickedFile.value?.files.single.path;
    final logoPath = manualOnboardController.manualOnboardModel.logoPickedFile.value?.files.single.path;

    // if (regPath != null && panPath != null && chequePath != null) {
    //   // All three files are selected, so upload them
    //   postData(
    //     context,

    //   );
    // }
  }

  void postData(context) async {
    try {
      if (manualOnboardController.postDataValidation()) {
        await Error_dialog(context: context, title: "POST", content: "All fields must be filled", onOk: () {});
        return;
      }
      loader.start(context);
      ManualOnboard allVendorData = ManualOnboard(
          vendorName: manualOnboardController.manualOnboardModel.vendorNameController.value.text,
          address: manualOnboardController.manualOnboardModel.vendorAddressController.value.text,
          state: manualOnboardController.manualOnboardModel.vendorAddressStateController.value.text,
          pincode: manualOnboardController.manualOnboardModel.vendorAddressPincodeController.value.text,
          contactPersonName: manualOnboardController.manualOnboardModel.contactpersonName.value.text,
          contactPersonDesignation: manualOnboardController.manualOnboardModel.contactPersonDesignation.value.text,
          contactPersonPhone: manualOnboardController.manualOnboardModel.contactPersonPhoneNumber.value.text,
          email: manualOnboardController.manualOnboardModel.contactPersonEmail.value.text,
          businessType: manualOnboardController.manualOnboardModel.typeOfBusiness.value.text,
          yearOfEstablishment: manualOnboardController.manualOnboardModel.yearOfEstablishment.value.text,
          gstNumber: manualOnboardController.manualOnboardModel.vendorGstNo.value.text,
          panNumber: manualOnboardController.manualOnboardModel.vendorPanNo.value.text,
          annualTurnover: double.tryParse(manualOnboardController.manualOnboardModel.vendorAnnualTurnover.value.text) ?? 0.0,
          productsServices: manualOnboardController.manualOnboardModel.productInputController.value.text,
          hsnSacCode: manualOnboardController.manualOnboardModel.HSNcodeController.value.text,
          description: manualOnboardController.manualOnboardModel.descriptionOfProducts.value.text,
          bankName: manualOnboardController.manualOnboardModel.vendorBankName.value.text,
          branchName: manualOnboardController.manualOnboardModel.vendorBankBranch.value.text,
          accountNumber: manualOnboardController.manualOnboardModel.vendorBankAccountNumber.value.text,
          ifscCode: manualOnboardController.manualOnboardModel.vendorBankIfsc.value.text,
          isoCertification: manualOnboardController.manualOnboardModel.isoCertification.value.text,
          otherCertifications: manualOnboardController.manualOnboardModel.otherCertification.value.text);

      await send_data(context, jsonEncode(allVendorData.toJson()));
    } catch (e) {
      await Error_dialog(context: context, title: "POST", content: "$e", onOk: () {});
    }
  }

  dynamic send_data(context, String jsonData) async {
    try {
      final logoPath = manualOnboardController.manualOnboardModel.logoPickedFile.value?.files.single.path;
      final regPath = manualOnboardController.manualOnboardModel.GSTregCertiPickedFile.value?.files.single.path;
      final panPath = manualOnboardController.manualOnboardModel.vendorPANPickedFile.value?.files.single.path;
      final chequePath = manualOnboardController.manualOnboardModel.cancelledChequePickedFile.value?.files.single.path;

      if (regPath == null || panPath == null || chequePath == null || logoPath == null) {
        await Error_dialog(context: context, title: "Missing Files", content: "Please upload all required documents.", onOk: () {});
        return;
      }
      File logoFile = File(logoPath);
      File regFile = File(regPath);
      File panFile = File(panPath);
      File chequeFile = File(chequePath);
      Map<String, dynamic> files = {
        "logo_upload": logoFile,
        "registration_certificate": regFile,
        "pan_upload": panFile,
        "cancelled_cheque": chequeFile,
      };
      Map<String, dynamic> response = await apiController.MultiSeperateFiles(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, files, API.addVendor);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          loader.stop();
          await Success_dialog(context: context, title: "SUCCESS, VENDOR ADDED SUCCESSFULLY", content: value.message!, onOk: () {});
          Navigator.of(context).pop(true);
          manualOnboardController.resetData();
        } else {
          loader.stop();
          await Error_dialog(context: context, title: 'Sending data', content: value.message ?? "", onOk: () {});
        }
      } else {
        loader.stop();
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      loader.stop();
      Error_dialog(context: context, title: "ERROR", content: "$e");
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
