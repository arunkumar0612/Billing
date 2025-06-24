import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/controllers/ClientReq_actions.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';

mixin ClientreqDetailsService {
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final ClientreqController clientreqController = Get.find<ClientreqController>();
  void nextTab(context) async {
    clientreqController.nextTab();
  }

  /// Handles organization selection from a dropdown or input.
  ///
  /// This method:
  /// - Searches the `organizationList` for a matching `organizationName`.
  /// - Retrieves the corresponding `organizationId`.
  /// - Calls `get_CompanyList` with the retrieved ID.
  ///
  /// Note:
  /// - Previous clearing of company and organization data is commented out.
  /// - Assumes the selected organization name exists in the list.
  ///
  /// Parameters:
  /// - [context]: The current BuildContext.
  /// - [Orgname]: The selected organization name as a String.
  void on_Orgselected(context, Orgname) {
    // clientreqController.clear_CompanyName();
    // clientreqController.clientReqModel.organizationList.clear();
    int? id = clientreqController.clientReqModel.organizationList
        .firstWhere(
          (x) => x.organizationName == Orgname,
        )
        .organizationId;
    get_CompanyList(context, id!);
  }

  /// Handles company selection from a dropdown or input.
  ///
  /// This method:
  /// - Finds the corresponding `companyId` by matching the given company name.
  /// - Fetches the branch list associated with the selected company using `get_BranchList`.
  ///
  /// Parameters:
  /// - [context]: The current BuildContext.
  /// - [Compname]: The selected company name as a String.
  void on_Compselected(context, Compname) {
    int? id = clientreqController.clientReqModel.CompanyList
        .firstWhere(
          (x) => x.companyName == Compname,
        )
        .companyId;
    get_BranchList(context, id!);
    // get_CompanyList(context, id!);
  }

  /// Handles the MOR (Mode of Request) file picking and upload process.
  ///
  /// This asynchronous method:
  /// - Invokes a file picker through `clientreqController.pickFile`.
  /// - If a file is successfully picked (`pickedStatus == true`), it uploads the file using `uploadMor`.
  ///
  /// Parameters:
  /// - [context]: The current BuildContext used for UI-related operations.
  ///
  /// Returns:
  /// - A [Future] that completes when the operation is done.
  Future<void> MORaction(context) async {
    bool pickedStatus = await clientreqController.pickFile(context);
    if (pickedStatus) {
      uploadMor(context, clientreqController.clientReqModel.morFile.value!);
    } else {
      null;
    }
  }

  void uploadMor(context, File file) async {
    try {
      List<int> fileBytes = await file.readAsBytes();
      if (kDebugMode) {
        print("Binary Data: ${fileBytes.length}");
      } // Prints file in binary format
      Map<String, dynamic>? response = await apiController.multiPart(file, API.Upload_MOR_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Upload MOR', content: "MOR uploaded Successfully", onOk: () {});
          clientreqController.updateMOR_uploadedPath(value);
        } else {
          await Error_dialog(context: context, title: 'Upload MOR', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  /// Uploads the selected MOR (Mode of Request) file to the server.
  ///
  /// This asynchronous method:
  /// - Reads the file as bytes.
  /// - Sends the file to the backend via a multipart API request.
  /// - Parses the server response and updates the uploaded MOR path on success.
  /// - Displays appropriate error dialogs if the upload fails or if an exception occurs.
  ///
  /// Parameters:
  /// - [context]: The current BuildContext for showing dialogs.
  /// - [file]: The file to be uploaded.
  ///
  /// Returns:
  /// - A [Future] that completes when the upload operation finishes.
  void get_OrganizationList(context) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.sales_fetchOrg_list);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Organization List', content: value.message!, onOk: () {});
          clientreqController.update_OrganizationList(value);
        } else {
          await Error_dialog(context: context, title: 'Fetching Organization List Error', content: value.message ?? "", onOk: () {});
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

  /// Fetches the list of companies associated with a given organization ID.
  ///
  /// This asynchronous method:
  /// - Sends a query with the `organizationid` to the backend using `GetbyQueryString`.
  /// - If the response is successful and contains valid data:
  ///   - Parses the data into a `CMDlResponse` model.
  ///   - Updates the company list in `clientreqController` using `update_CompanyList`.
  /// - Displays an error dialog if the request fails or the response is invalid.
  ///
  /// Parameters:
  /// - [context]: The current BuildContext used for displaying dialogs.
  /// - [org_id]: The ID of the selected organization for which the company list is to be fetched.
  void get_CompanyList(context, int org_id) async {
    try {
      Map<String, dynamic> body = {"organizationid": org_id};
      Map<String, dynamic>? response = await apiController.GetbyQueryString(body, API.sales_fetchCompany_list);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Organization List', content: value.message!, onOk: () {});
          clientreqController.update_CompanyList(value);
        } else {
          await Error_dialog(context: context, title: 'Fetching Company List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  /// Fetches the list of branches associated with a given company ID.
  ///
  /// This asynchronous method:
  /// - Constructs a query using the provided `companyid`.
  /// - Sends the request to the backend using `GetbyQueryString`.
  /// - On a successful response with a valid structure:
  ///   - Parses the data into a `CMDlResponse` model.
  ///   - Updates the branch list in `clientreqController` using `update_BranchList`.
  /// - Shows an error dialog if the fetch fails, the response is invalid, or an exception occurs.
  ///
  /// Parameters:
  /// - [context]: The current BuildContext used to show dialogs.
  /// - [comp_id]: The ID of the selected company for which the branch list is requested.
  void get_BranchList(context, int comp_id) async {
    try {
      Map<String, dynamic> body = {"companyid": comp_id};
      Map<String, dynamic>? response = await apiController.GetbyQueryString(body, API.sales_fetchBranch_list);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Organization List', content: value.message!, onOk: () {});
          clientreqController.update_BranchList(value);
        } else {
          await Error_dialog(context: context, title: 'Fetching Branch List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  /// Retrieves a list of product suggestions from the backend.
  ///
  /// This asynchronous method:
  /// - Calls an API endpoint to fetch suggested products using a token-based GET request.
  /// - If the response status code is 200:
  ///   - Parses the response into a `CMDlResponse` model.
  ///   - If the response is successful (`code == true`), updates the product suggestion list
  ///     in `clientreqController` using `add_productSuggestion`.
  ///   - Otherwise, shows an error dialog with the provided message and pops the current context.
  /// - If the response status code is not 200, shows a "SERVER DOWN" error dialog and pops the context.
  /// - If any exception occurs during the process, shows a generic "ERROR" dialog with the exception message and pops the context.
  ///
  /// Parameters:
  /// - [context]: The current BuildContext used to display error dialogs and navigate.
  void get_productSuggestionList(context) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.sales_getProduct_SUGG_List);

      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          clientreqController.add_productSuggestion(value.data);
        } else {
          await Error_dialog(
            context: context,
            title: 'PRE - LOADER',
            content: value.message ?? "",
            onOk: () {},
          );
          Navigator.of(context).pop();
        }
      } else {
        Error_dialog(
          context: context,
          title: "SERVER DOWN",
          content: "Please contact administration!",
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      Error_dialog(
        context: context,
        title: "ERROR",
        content: "$e",
      );
      Navigator.of(context).pop();
    }
  }
}
