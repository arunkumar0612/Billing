import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/VendorList_actions.dart';
// import 'package:ssipl_billing/5_VENDOR/controllers/vendorList_actions.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/Vendor_entities.dart';
import 'package:ssipl_billing/5_VENDOR/views/vendorList/Manual_onboard/show_Manual_onboard.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/THEMES/style.dart';

import '../../API/invoker.dart';

mixin VendorlistServices {
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final VendorListController vendorListController = Get.find<VendorListController>();
  final loader = LoadingOverlay();

  void nextTab(context) async {
    vendorListController.nextTab();
  }

  void backTab(context) async {
    vendorListController.backTab();
  }

  Future<void> allFilesAction({
    required BuildContext context,
    required Future<bool> Function(BuildContext) pickFunction,
  }) async {
    bool picked = await pickFunction(context);
    if (!picked) return;

    // final regPath = vendorListController.vendorListModel.GSTregCertiPickedFile.value?.files.single.path;
    // final panPath = vendorListController.vendorListModel.vendorPANPickedFile.value?.files.single.path;
    // final chequePath = vendorListController.vendorListModel.cancelledChequePickedFile.value?.files.single.path;
    // final logoPath = vendorListController.vendorListModel.logoPickedFile.value?.files.single.path;

    // if (regPath != null && panPath != null && chequePath != null) {
    //   // All three files are selected, so upload them
    //   postData(
    //     context,

    //   );
    // }
  }

  void get_VendorList(context) async {
    try {
      Map<String, dynamic> body = {"vendorid": 0};
      Map<String, dynamic>? response = await apiController.GetbyQueryString(body, API.fetch_vendorList);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          vendorListController.updateVendorList(value);
          vendorListController.search(vendorListController.vendorListModel.searchQuery.value);
          // await Basic_dialog(context: context,showCancel: false, title: 'Organization List', content: value.message!, onOk: () {});
          // clientreqController.update_CompanyList(value);
        } else {
          await Error_dialog(context: context, title: 'Fetching Vendor List Error', content: value.message ?? "", onOk: () {});
          Navigator.of(context).pop();
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
        Navigator.of(context).pop();
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
      Navigator.of(context).pop();
    }
  }

  Future<bool> pickFile(BuildContext context, String logoType, int id) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg'], lockParentWindow: true);
    if (result != null) {
      final file = File(result.files.single.path!);
      final fileLength = await file.length();
      if (fileLength > 2 * 1024 * 1024) {
        Error_dialog(context: context, title: 'Error', content: 'Selected file exceeds 2MB in size.');
        return false;
      } else {
        // uploadImage(context, file, logoType, id);
        return true;
      }
    }
    return false;
  }

  Future<bool> Get_vendorFile({required BuildContext context, required int vendorId, required String type}) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"vendorid": vendorId, 'type': type}, API.getVendorFiles);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          // showPDF(context, type, pdfFile)
          await vendorListController.PDFfileApiData(value);
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

  void postData(context, String type) async {
    try {
      if (vendorListController.postDataValidation(type)) {
        await Error_dialog(context: context, title: "POST", content: "All fields must be filled", onOk: () {});
        return;
      }
      loader.start(context);
      // Convert File? to Uint8List? for vendorLogo
      Uint8List? logoBytes;
      if (vendorListController.vendorListModel.uploadedLogo.value != null) {
        logoBytes = await vendorListController.vendorListModel.uploadedLogo.value!.readAsBytes();
      }

      VendorList allVendorData = VendorList(
        vendorId: vendorListController.vendorListModel.vendorId.value,
        vendorName: vendorListController.vendorListModel.vendorNameController.value.text,
        address: vendorListController.vendorListModel.vendorAddressController.value.text,
        state: vendorListController.vendorListModel.vendorAddressStateController.value.text,
        pincode: vendorListController.vendorListModel.vendorAddressPincodeController.value.text,
        contactPersonName: vendorListController.vendorListModel.contactpersonName.value.text,
        contactPersonDesignation: vendorListController.vendorListModel.contactPersonDesignation.value.text,
        contactPersonPhone: vendorListController.vendorListModel.contactPersonPhoneNumber.value.text,
        email: vendorListController.vendorListModel.contactPersonEmail.value.text,
        businessType: vendorListController.vendorListModel.typeOfBusiness.value.text,
        yearOfEstablishment: vendorListController.vendorListModel.yearOfEstablishment.value.text,
        gstNumber: vendorListController.vendorListModel.vendorGstNo.value.text,
        panNumber: vendorListController.vendorListModel.vendorPanNo.value.text,
        annualTurnover: vendorListController.vendorListModel.vendorAnnualTurnover.value.text,
        productsServices: vendorListController.vendorListModel.productInputController.value.text,
        hsnSacCode: vendorListController.vendorListModel.HSNcodeController.value.text,
        description: vendorListController.vendorListModel.descriptionOfProducts.value.text,
        bankName: vendorListController.vendorListModel.vendorBankName.value.text,
        branchName: vendorListController.vendorListModel.vendorBankBranch.value.text,
        accountNumber: vendorListController.vendorListModel.vendorBankAccountNumber.value.text,
        ifscCode: vendorListController.vendorListModel.vendorBankIfsc.value.text,
        isoCertification: vendorListController.vendorListModel.isoCertification.value.text,
        otherCertifications: vendorListController.vendorListModel.otherCertification.value.text,
        registrationCertificatePath: vendorListController.vendorListModel.GSTregCerti_uploadedPath.value,
        panUploadPath: vendorListController.vendorListModel.PAN_uploadedPath.value,
        cancelledChequePath: vendorListController.vendorListModel.cheque_uploadedPath.value,
        vendorLogo: logoBytes,
      );

      await send_data(context, jsonEncode(allVendorData.toJson()), type);
    } catch (e) {
      await Error_dialog(context: context, title: "POST", content: "$e", onOk: () {});
    }
  }

  dynamic send_data(BuildContext context, String jsonData, String type) async {
    try {
      bool isFileChanged = vendorListController.vendorListModel.logoFileChanged.value ||
          vendorListController.vendorListModel.gstRegFileChanged.value ||
          vendorListController.vendorListModel.panFileChanged.value ||
          vendorListController.vendorListModel.chequeFileChanged.value;
      if (type != 'update' || isFileChanged) {
        // Validate and upload files only for new vendor
        final logoPath = vendorListController.vendorListModel.uploadedLogo_path.value;
        final regPath = vendorListController.vendorListModel.GSTregCerti_uploadedPath.value;
        final panPath = vendorListController.vendorListModel.PAN_uploadedPath.value;
        final chequePath = vendorListController.vendorListModel.cheque_uploadedPath.value;

        // if (regPath == null || panPath == null || chequePath == null || logoPath == null) {
        //   loader.stop();
        //   await Error_dialog(
        //     context: context,
        //     title: "Missing Files",
        //     content: "Please upload all required documents.",
        //     onOk: () {},
        //   );
        //   return;
        // }

        // Rename files before uploading
        final logoFile = await renameFile(File(logoPath ?? ''), 'logo_upload');
        final gstRegFile = await renameFile(File(regPath ?? ' '), 'registration_certificate');
        final panFile = await renameFile(File(panPath ?? ' '), 'pan_upload');
        final chequeFile = await renameFile(File(chequePath ?? ''), 'cancelled_cheque');

        final List<File> renamedFiles = [logoFile, gstRegFile, panFile, chequeFile];

        // Send to ADD API
        Map<String, dynamic> response = await apiController.Multer(
          sessiontokenController.sessiontokenModel.sessiontoken.value,
          jsonData,
          renamedFiles,
          API.addVendor,
        );

        if (response['statusCode'] == 200) {
          CMDmResponse value = CMDmResponse.fromJson(response);
          loader.stop();
          if (value.code) {
            await Success_dialog(
              context: context,
              title: "SUCCESS",
              content: value.message!,
              onOk: () {},
            );
            Navigator.of(context).pop(true);
            vendorListController.resetData();
          } else {
            await Error_dialog(
              context: context,
              title: "Sending Data",
              content: value.message ?? "",
              onOk: () {},
            );
          }
        } else {
          loader.stop();
          await Error_dialog(
            context: context,
            title: "SERVER DOWN",
            content: "Please contact administration!",
            onOk: () {},
          );
        }
      } else {
        // Update mode - send only JSON without file uploads
        Map<String, dynamic> response = await apiController.SendByQuerystring(
          jsonData,
          API.addVendor,
        );

        if (response['statusCode'] == 200) {
          CMDmResponse value = CMDmResponse.fromJson(response);
          loader.stop();
          if (value.code) {
            await Success_dialog(
              context: context,
              title: "UPDATED",
              content: value.message!,
              onOk: () {},
            );
            Navigator.of(context).pop(true);
            vendorListController.resetData();
          } else {
            await Error_dialog(
              context: context,
              title: "Update Failed",
              content: value.message ?? "",
              onOk: () {},
            );
          }
        } else {
          loader.stop();
          await Error_dialog(
            context: context,
            title: "SERVER DOWN",
            content: "Please contact administration!",
            onOk: () {},
          );
        }
      }
    } catch (e) {
      loader.stop();
      await Error_dialog(
        context: context,
        title: "ERROR",
        content: "$e",
        onOk: () {},
      );
    }
  }

  Future<File> renameFile(File original, String newName) async {
    final tempDir = await getTemporaryDirectory();
    final newPath = "${tempDir.path}/$newName";
    return original.copy(newPath);
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
                    if (vendorListController.anyHavedata()) {
                      bool? proceed = await Warning_dialog(
                        context: context,
                        title: 'Warning',
                        content: "The data may be lost. Do you want to proceed?",
                      );

                      if (proceed == true) {
                        Navigator.of(context).pop();
                        vendorListController.resetData();
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
