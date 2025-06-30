// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/controllers/SUBSCRIPTION_ClientReq_actions.dart' show SUBSCRIPTION_ClientreqController;
import 'package:ssipl_billing/3_SUBSCRIPTION/controllers/SUBSCRIPTION_Quote_actions.dart' show SUBSCRIPTION_QuoteController;
import 'package:ssipl_billing/3_SUBSCRIPTION/controllers/Subscription_actions.dart' show SubscriptionController;
import 'package:ssipl_billing/3_SUBSCRIPTION/views/Process/Generate_Quote/SUBSCRIPTION_generateQuote.dart' show SUBSCRIPTION_GenerateQuote;
import 'package:ssipl_billing/3_SUBSCRIPTION/views/Process/Generate_client_req/SUBSCRIPTION_generate_clientreq.dart' show SUBSCRIPTION_Generate_clientreq;
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart' show Error_dialog, Success_SnackBar, Success_dialog, Warning_dialog;
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart' show SessiontokenController;
import 'package:ssipl_billing/THEMES/style.dart';

// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../API/invoker.dart';
import '../../COMPONENTS-/Response_entities.dart';

mixin SubscriptionServices {
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController _sessiontokenController = Get.find<SessiontokenController>();
  // final SubscriptionController subscriptionController = Get.find<SubscriptionController>();
  final SUBSCRIPTION_ClientreqController _clientreqController = Get.find<SUBSCRIPTION_ClientreqController>();
  final SUBSCRIPTION_QuoteController sub_quoteController = Get.find<SUBSCRIPTION_QuoteController>();
  final SubscriptionController subscriptionController = Get.find<SubscriptionController>();
  // final loader = LoadingOverlay();

  /// Uploads a list of subscription data (typically parsed from Excel) to the server.
  ///
  /// - Takes a list of maps (`excelData`) representing the subscription entries.
  /// - Converts the list to a JSON string and sends it to the server using `SendByQuerystring`.
  /// - Endpoint used: `API.subscription_uploadSubscription`.
  ///
  /// **On Success (HTTP 200 + response code true):**
  /// - Displays an alert dialog showing upload results, listing subscription IDs and messages.
  /// - Pops the current screen after closing the dialog.
  ///
  /// **On Failure (HTTP error or code false):**
  /// - Shows an error dialog with appropriate message.
  ///
  /// **On Exception:**
  /// - Catches and displays any runtime or network errors using an error dialog.
  dynamic UploadSubscription(context, List<Map<String, dynamic>> excelData) async {
    try {
      String encodedData = json.encode(excelData);
      Map<String, dynamic>? response = await apiController.SendByQuerystring(encodedData, API.subscription_uploadSubscription);
      if (response['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response);
        if (value.code) {
          // await Basic_dialog(context: context, title: "Upload Successfull", content: value.message!, onOk: () {}, showCancel: false);
          await showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text('Upload Results'),
                content: SizedBox(
                  height: 500,
                  width: 500,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.data.length,
                    itemBuilder: (context, index) {
                      final item = value.data[index];
                      return ListTile(
                        leading: Text('${item['subscriptionid'] ?? '-'}'),
                        title: Text(item['message'] ?? 'No message'),
                      );
                    },
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ],
              );
            },
          );
          Navigator.of(context).pop();
        } else {
          await Error_dialog(
            context: context,
            title: 'Error',
            content: value.message ?? "",
            onOk: () {},
          );
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  /// Displays a popup dialog showing a preview of parsed Excel data in a table format.
  ///
  /// - Accepts a list of maps (`excelData`), where each map represents a row from the Excel file.
  /// - Dynamically generates `DataColumn`s based on keys of the first map.
  /// - Displays each map’s values as `DataRow`s in a scrollable `DataTable`.
  ///
  /// **Features:**
  /// - Two scroll views: vertical and horizontal for better accessibility on large datasets.
  /// - "Cancel" button to close the dialog.
  /// - "Proceed" button to initiate data upload using `UploadSubscription(context, excelData)`.
  ///
  /// **Use Case:**
  /// - Preview Excel import before committing to upload.
  void showExcelDataPopup(context, List<Map<String, dynamic>> excelData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: SizedBox(
            width: 1200,
            height: 700,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 55,
                        columns: excelData.isNotEmpty
                            ? excelData.first.keys
                                .map(
                                  (String key) => DataColumn(
                                    label: Text(
                                      key,
                                      style: const TextStyle(color: Color.fromARGB(255, 177, 27, 27), fontSize: 10),
                                    ),
                                  ),
                                )
                                .toList()
                            : [],
                        rows: excelData.where((data) => data.values.any((value) => value != null)).map((data) {
                          return DataRow(
                            cells: data.keys.map((key) {
                              return DataCell(
                                Text(
                                  data[key]?.toString() ?? '', // Handle null values gracefully
                                  style: const TextStyle(fontSize: 10),
                                ),
                              );
                            }).toList(),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Container(
                    color: const Color.fromARGB(66, 90, 90, 90),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.red,
                            ),
                            height: 30,
                            width: 100,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel', style: TextStyle(color: Colors.white))),
                          ),
                          const SizedBox(width: 40),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blue,
                            ),
                            height: 30,
                            width: 100,
                            child: TextButton(
                                onPressed: () async {
                                  await UploadSubscription(context, excelData);
                                },
                                child: const Text(
                                  'Proceed',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ));
      },
    );
  }

  /// Fetches the list of companies from the backend API (`API.hierarchy_CompanyData`)
  /// and updates the `subscriptionController` with the fetched data.
  ///
  /// **Flow:**
  /// - Optional delay of 1 second (likely for UI smoothness or loading simulation).
  /// - Makes an authenticated GET request using `apiController.GetbyToken(...)`.
  /// - If the response is successful (`statusCode == 200` and `value.code == true`),
  ///   the company list is added to the controller via `subscriptionController.add_Comp(value)`.
  /// - Logs error messages in debug mode if the response fails or an exception occurs.
  ///
  /// **Use Case:**
  /// - Populate company dropdowns or selection lists in a subscription or hierarchy setup UI.
  Future<void> get_CompanyList() async {
    try {
      // loader.start(context);
      await Future.delayed(const Duration(milliseconds: 1000));
      Map<String, dynamic>? response;
      response = await apiController.GetbyToken(API.hierarchy_CompanyData);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(
          response ?? {},
        );

        if (value.code) {
          subscriptionController.add_Comp(value);
        } else {
          if (kDebugMode) {
            print("error : ${value.message}");
          }
          // await Basic_dialog(context: context, title: 'Fetch Company List', content: value.message ?? "", onOk: () {}, showCancel: false);
        }
      } else {
        if (kDebugMode) {
          print("error : ${"please contact administration"}");
        }
        // Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!", showCancel: false);
      }
      // loader.stop();
    } catch (e) {
      if (kDebugMode) {
        print("error : $e");
      }
      // Basic_dialog(context: context, title: "ERROR", content: "$e", showCancel: false);
    }
  }

  /// Fetches the global package list from the backend API (`API.get_subscription_GlobalPackageList`)
  /// and updates the `subscriptionController` with the fetched data.
  ///
  /// **Flow:**
  /// - Adds an artificial delay of 1 second (possibly for UX loading effects).
  /// - Performs an authenticated GET request using `apiController.GetbyToken(...)`.
  /// - If the response is successful (`statusCode == 200` and `value.code == true`),
  ///   it passes the data to `subscriptionController.add_GlobalPackage(...)`.
  /// - If the API response fails or returns an error message, it shows an `Error_dialog` with the reason.
  /// - If the server is unreachable or an unexpected issue occurs, it shows a generic "SERVER DOWN" dialog.
  ///
  /// **Use Case:**
  /// - Used in subscription systems to retrieve a list of globally available packages for assignment,
  ///   comparison, or selection in the UI.
  Future<void> get_GlobalPackageList(context) async {
    // loader.start(context);
    await Future.delayed(const Duration(milliseconds: 1000));
    Map<String, dynamic>? response;
    response = await apiController.GetbyToken(API.get_subscription_GlobalPackageList);
    if (response?['statusCode'] == 200) {
      CMDlResponse value = CMDlResponse.fromJson(response ?? {});
      if (value.code) {
        subscriptionController.add_GlobalPackage(value);
      } else {
        await Error_dialog(
          context: context,
          title: 'ERROR',
          content: value.message ?? "",
          onOk: () {},
        );
      }
    } else {
      Error_dialog(
        context: context,
        title: "SERVER DOWN",
        content: "Please contact administration!",
      );
    }
    // loader.stop();
  }

  /// Creates a global subscription package by sending required package details as query parameters
  /// to the backend API (`API.create_subscription_GlobalPackage`).
  ///
  /// **Parameters:**
  /// - `context`: BuildContext for showing dialogs and SnackBars.
  /// - `subscriptionName`: Name of the subscription package.
  /// - `noOfDevice`: Total number of devices included in the package.
  /// - `noOfCameras`: Number of cameras included in the base package.
  /// - `AdditionalCameraCharges`: Charges applicable for additional cameras.
  /// - `amount`: Total package cost.
  /// - `productDescription`: Description of the subscription or product.
  /// - `clientId`: Optional ID of the client (nullable).
  /// - `customerType`: Optional customer type identifier (nullable).
  ///
  /// **Behavior:**
  /// - Constructs a query string with the package details and static fields like GST and HSN code.
  /// - Sends a `GET` request using `apiController.GetbyQueryString(...)`.
  /// - If response is successful and `value.code == true`, it:
  ///   - Closes the current dialog (`Navigator.pop(context)`),
  ///   - Fetches the updated global package list via `get_GlobalPackageList(context)`,
  ///   - Resets package-related data using `subscriptionController.reset_packageData()`,
  ///   - Triggers UI update with `subscriptionController.update()`,
  ///   - Displays success feedback using `Success_SnackBar(...)`.
  /// - If unsuccessful, shows an error dialog with the response message.
  /// - Catches any runtime errors and displays a generic error dialog.
  ///
  /// **Use Case:**
  /// - Enables admins or sales teams to dynamically create and manage global subscription packages
  ///   from within the Flutter UI.
  void CreateGlobalPackage(
      context, String subscriptionName, int noOfDevice, int noOfCameras, int AdditionalCameraCharges, int amount, String productDescription, int? clientId, int? customerType) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({
        "subscriptionName": subscriptionName,
        "noOfDevice": noOfDevice,
        "noOfCameras": noOfCameras,
        "AdditionalCameraCharges": AdditionalCameraCharges,
        "amount": amount,
        "productDescription": productDescription,
        "clientId": clientId,
        "customerType": customerType,
        'gstpercentage': 18,
        'hsnno': 1234
      }, API.create_subscription_GlobalPackage);
      if (response?['statusCode'] == 200) {
        CMResponse value = CMResponse.fromJson(response ?? {});
        if (value.code) {
          Navigator.pop(context);
          get_GlobalPackageList(context);
          subscriptionController.reset_packageData();
          subscriptionController.update();
          Success_SnackBar(context, "Package Created successfully");
          // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
        } else {
          await Error_dialog(context: context, title: 'ERROR', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  /// Updates an existing global subscription package by sending updated package data as query parameters
  /// to the backend API (`API.update_subscription_GlobalPackage`).
  ///
  /// **Parameters:**
  /// - `context`: BuildContext for dialog and snackbar display.
  /// - `subscriptionName`: Updated name of the subscription.
  /// - `noOfDevice`: Updated number of devices in the package.
  /// - `noOfCameras`: Updated number of cameras in the base package.
  /// - `AdditionalCameraCharges`: Updated charges for additional cameras.
  /// - `amount`: Updated total package amount (as `double`).
  /// - `productDescription`: Updated description of the product/package.
  /// - `subId`: Unique ID of the subscription package being updated.
  ///
  /// **Behavior:**
  /// - Sends the updated package data using `apiController.GetbyQueryString(...)`.
  /// - On successful response with `value.code == true`, it:
  ///   - Refreshes the global package list using `get_GlobalPackageList(context)`,
  ///   - Displays a success snackbar with confirmation.
  /// - If the update fails, it shows an error dialog with the backend-provided message.
  /// - On exception, it catches and displays the error in an error dialog.
  ///
  /// **Use Case:**
  /// - Allows admin users to make corrections or updates to existing global subscription packages,
  ///   ensuring package data remains accurate and up to date.
  void UpdateGlobalPackage(context, String subscriptionName, int noOfDevice, int noOfCameras, int AdditionalCameraCharges, double amount, String productDescription, int subId) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({
        "subscriptionName": subscriptionName,
        "noOfDevice": noOfDevice,
        "noOfCameras": noOfCameras,
        "AdditionalCameraCharges": AdditionalCameraCharges,
        "amount": amount,
        "productDescription": productDescription,
        "subId": subId,
      }, API.update_subscription_GlobalPackage);
      if (response?['statusCode'] == 200) {
        CMResponse value = CMResponse.fromJson(response ?? {});
        if (value.code) {
          // Navigator.pop(context);
          get_GlobalPackageList(context);
          Success_SnackBar(context, "Package updated successfully");
          // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
        } else {
          await Error_dialog(context: context, title: 'Package update error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  /// Deletes one or more global subscription packages by their subscription IDs.
  ///
  /// **Parameters:**
  /// - `context`: The BuildContext used for showing dialogs or snackbars.
  /// - `subId`: A list of integers representing the subscription IDs to be deleted.
  ///
  /// **Behavior:**
  /// - Sends the `subId` list as query parameters to the `API.delete_subscription_GlobalPackage` endpoint.
  /// - If deletion is successful (`value.code == true`):
  ///   - Clears the selected subscription IDs from the controller.
  ///   - Removes the deleted packages from the `filteredPackages` list.
  ///   - Refreshes the package list using `get_GlobalPackageList(context)`.
  ///   - Shows a success snackbar.
  /// - If deletion fails, shows an error dialog with the backend message.
  /// - Catches any exception and displays an error dialog.
  ///
  /// **Use Case:**
  /// - Used to remove selected global subscription packages from the system, typically by an admin.
  /// - Supports bulk deletion via a list of IDs.
  Future<void> DeleteGlobalPackage(context, List<int> subId) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({
        "subId": subId,
      }, API.delete_subscription_GlobalPackage);
      if (response?['statusCode'] == 200) {
        CMResponse value = CMResponse.fromJson(response ?? {});
        if (value.code) {
          subscriptionController.subscriptionModel.selectedPackagessubscriptionID.clear();
          subscriptionController.subscriptionModel.filteredPackages.removeWhere((p) => subId.contains(p.subscriptionId));

          // subscriptionController.subscriptionModel.GloabalPackage.value.globalPackageList[subscriptionController.subscriptionModel.packageselectedIndex.value!].subscriptionId == subId
          //     ? null
          //     : subscriptionController.subscriptionModel.packageselectedIndex.value;
          // subscriptionController.subscriptionModel.GloabalPackage.value = Global_package(globalPackageList: []);

          // Navigator.pop(context);
          // subscriptionController.subscriptionModel.packageselectedIndex.value = null;

          // subscriptionController.subscriptionModel.selectedPackagessubscriptionID.clear();

          get_GlobalPackageList(context);
          // subscriptionController.subscriptionModel.packageselectedIndex.value = subscriptionController.subscriptionModel.packageselectedIndex.value! - subId.length;
          Success_SnackBar(context, "Package deleted successfully");
          // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
        } else {
          await Error_dialog(context: context, title: 'ERROR', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  /// Fetches the list of process customers for subscriptions from the backend.
  ///
  /// **Behavior:**
  /// - Sends a GET request to `API.subscription_getprocesscustomer_API` using token-based authentication.
  /// - On successful response with status code 200:
  ///   - Parses the response into a `CMDlResponse` model.
  ///   - If `value.code` is `true`, clears the existing `processcustomerList` in the controller.
  ///   - Adds the fetched customers to the controller’s list using `addToProcesscustomerList`.
  ///   - Applies the current search query to filter the list.
  /// - If an error occurs, logs the error (only in debug mode).
  ///
  /// **Note:**
  /// - UI dialogs and loaders are commented out, possibly for silent or background data fetching.
  /// - Handles server down or API errors gracefully with debug logging.
  ///
  /// **Use Case:**
  /// - Typically called when initializing or refreshing the subscription process customers view.
  Future<void> GetProcesscustomerList() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.subscription_getprocesscustomer_API);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Processcustomer List', content: "Processcu    stomer List fetched successfully", onOk: () {});
          subscriptionController.subscriptionModel.processcustomerList.clear();
          // print(value.data);
          subscriptionController.addToProcesscustomerList(value);
          subscriptionController.search(subscriptionController.subscriptionModel.searchQuery.value);

          // subscriptionController.updatecustomerId(subscriptionController.subscriptionModel.processcustomerList[subscriptionController.subscriptionModel.showcustomerprocess.value!].customerId);
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

  /// Fetches the list of recurred customers for subscriptions from the backend.
  ///
  /// **Behavior:**
  /// - Makes a GET request to `API.subscription_getrecurredcustomer_API` using a token for authentication.
  /// - If the response status code is 200:
  ///   - Parses the response into a `CMDlResponse` model.
  ///   - If `value.code` is `true`:
  ///     - Clears the existing `recurredcustomerList` in the controller.
  ///     - Adds the new list from the API using `addToRecurredcustomerList`.
  ///     - Applies any existing search query for immediate filtering.
  /// - If `value.code` is `false`, logs an error message in debug mode.
  /// - If the API call fails (non-200), logs a generic server error message.
  /// - Catches and logs any exceptions that occur during the process.
  ///
  /// **Note:**
  /// - Dialogs for UI feedback are commented out, likely indicating silent background execution.
  ///
  /// **Use Case:**
  /// - Ideal for loading recurred billing customers when managing renewals or subscription cycles.
  Future<void> GetReccuredcustomerList() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.subscription_getrecurredcustomer_API);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Processcustomer List', content: "Processcu    stomer List fetched successfully", onOk: () {});
          subscriptionController.subscriptionModel.recurredcustomerList.clear();
          // print(value.data);
          subscriptionController.addToRecurredcustomerList(value);
          subscriptionController.search(subscriptionController.subscriptionModel.searchQuery.value);

          // subscriptionController.updatecustomerId(subscriptionController.subscriptionModel.processcustomerList[subscriptionController.subscriptionModel.showcustomerprocess.value!].customerId);
        } else {
          if (kDebugMode) {
            print("error : ${value.message}");
          }
          // await Basic_dialog(context: context, showCancel: false, title: 'Recurredcustomer List Error', content: value.message ?? "", onOk: () {});
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

  /// Fetches the list of customers currently in the approval queue for subscriptions.
  ///
  /// **Functionality:**
  /// - Makes an authenticated GET request to the API endpoint: `API.subscription_getApprovalQueue_customer_API`.
  /// - If the response status code is `200`:
  ///   - Converts the JSON response into a `CMDlResponse` object.
  ///   - If `value.code` is `true`:
  ///     - Clears the current `ApprovalQueue_customerList` in the subscription model.
  ///     - Adds the fetched customers using `addTo_ApprovalQueue_customerList`.
  ///     - Re-applies any existing search filter using the current query.
  ///   - If `value.code` is `false`, logs the error message in debug mode.
  ///
  /// **Error Handling:**
  /// - Logs an error if the server responds with a non-200 status code or if an exception occurs during the API call.
  ///
  /// **Use Case:**
  /// - Used to display or manage customers who are waiting for approval in a subscription or billing workflow.
  Future<void> GetApprovalQueue_customerList() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.subscription_getApprovalQueue_customer_API);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Processcustomer List', content: "Processcu    stomer List fetched successfully", onOk: () {});
          subscriptionController.subscriptionModel.ApprovalQueue_customerList.clear();
          // // print(value.data);
          subscriptionController.addTo_ApprovalQueue_customerList(value);
          subscriptionController.search(subscriptionController.subscriptionModel.searchQuery.value);

          // subscriptionController.updatecustomerId(subscriptionController.subscriptionModel.processcustomerList[subscriptionController.subscriptionModel.showcustomerprocess.value!].customerId);
        } else {
          if (kDebugMode) {
            print("error : ${value.message}");
          }
          // await Basic_dialog(context: context, showCancel: false, title: 'Recurredcustomer List Error', content: value.message ?? "", onOk: () {});
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

  /// Retrieves the list of recurring invoices for subscriptions.
  ///
  /// **Functionality:**
  /// - If a `customerid` is provided (`id != null`):
  ///   - Sends a GET request with the `customerid` as a query parameter to the API endpoint.
  /// - If no `id` is provided:
  ///   - Sends a GET request directly to the API without filters.
  /// - On a successful response (`statusCode == 200`):
  ///   - Parses the response into a `CMDlResponse` object.
  ///   - If `value.code` is `true`:
  ///     - Adds the received data to the recurring invoice list via `addTo_RecuuringInvoiceList`.
  ///     - Triggers a search using the current search query.
  ///   - If `value.code` is `false`, logs the error message.
  ///
  /// **Error Handling:**
  /// - Logs appropriate debug information if the server fails or throws an exception.
  ///
  /// **Use Case:**
  /// - Used to populate a UI list with recurring invoice data for a specific customer or for all customers when no ID is specified.
  Future<void> Get_RecurringInvoiceList(int? id) async {
    try {
      // loader.start(context);

      Map<String, dynamic>? response;

      if (id == null) {
        response = await apiController.GetbyToken(API.get_subscription_RecurringInvoiceList);
      } else {
        Map<String, dynamic> body = {"customerid": id};
        response = await apiController.GetbyQueryString(body, API.get_subscription_RecurringInvoiceList);
      }

      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          subscriptionController.addTo_RecuuringInvoiceList(value);
          subscriptionController.search(subscriptionController.subscriptionModel.searchQuery.value);
        } else {
          if (kDebugMode) {
            print("error : ${value.message}");
          }
          // await Basic_dialog(context: context, showCancel: false, title: 'Recurring Invoice List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        if (kDebugMode) {
          print("error : ${"please contact administration"}");
        }
        // Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
      // loader.stop();
    } catch (e) {
      if (kDebugMode) {
        print("error : $e");
      }
      // Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
      // loader.stop();
    }
  }

  /// Fetches the list of invoices in the approval queue for subscriptions.
  ///
  /// **Functionality:**
  /// - If a `customerid` is provided (`id != null`):
  ///   - Sends a GET request with the `customerid` as a query parameter to the approval queue API.
  /// - If no ID is provided:
  ///   - Fetches the full approval queue list using a token-authenticated GET request.
  /// - Upon successful response (`statusCode == 200`):
  ///   - Parses the response using `CMDlResponse`.
  ///   - If the response contains valid data (`value.code == true`):
  ///     - Adds the list to the `ApprovalQueue_InvoiceList` via the controller.
  ///     - Filters the results using the current search query.
  ///   - If unsuccessful, logs the error message in debug mode.
  ///
  /// **Error Handling:**
  /// - Handles failed HTTP requests or parsing errors by logging them in debug mode.
  ///
  /// **Use Case:**
  /// - Used in modules where invoices need to be reviewed and approved, optionally filtered by customer.
  Future<void> Get_ApprovalQueueList(int? id) async {
    try {
      // loader.start(context);

      Map<String, dynamic>? response;

      if (id == null) {
        response = await apiController.GetbyToken(API.get_subscription_ApprovalQueueList);
      } else {
        Map<String, dynamic> body = {"customerid": id};
        response = await apiController.GetbyQueryString(body, API.get_subscription_ApprovalQueueList);
      }

      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          subscriptionController.addTo_ApprovalQueue_InvoiceList(value);
          subscriptionController.search(subscriptionController.subscriptionModel.searchQuery.value);
        } else {
          if (kDebugMode) {
            print("error : ${value.message}");
          }
          // await Basic_dialog(context: context, showCancel: false, title: 'Recurring Invoice List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        if (kDebugMode) {
          print("error : ${"please contact administration"}");
        }
        // Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
      // loader.stop();
    } catch (e) {
      if (kDebugMode) {
        print("error : $e");
      }
      // Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
      // loader.stop();
    }
  }

  /// Fetches the list of processes associated with a specific customer.
  ///
  /// **Parameters:**
  /// - `customerid` (int): The ID of the customer whose processes are to be fetched.
  ///
  /// **Functionality:**
  /// - Sends a GET request to `API.subscription_getprocesslist_API` with:
  ///   - `customerid` and `listtype` as query parameters.
  ///   - `listtype` is retrieved from `subscriptionController.subscriptionModel.type.value`.
  /// - If the response is successful (`statusCode == 200`) and `value.code == true`:
  ///   - Clears the current `processList`.
  ///   - Adds the fetched process list using `addToProcessList`.
  ///   - Applies filtering based on the current search query.
  /// - If unsuccessful, logs the error message in debug mode.
  ///
  /// **Error Handling:**
  /// - Captures and logs network or decoding exceptions in debug mode.
  ///
  /// **Use Case:**
  /// - This function is typically used when a user selects a customer and the app needs to display associated subscription or workflow processes.
  Future<void> GetProcessList(int customerid) async {
    try {
      Map<String, dynamic>? response =
          await apiController.GetbyQueryString({"customerid": customerid, "listtype": subscriptionController.subscriptionModel.type.value}, API.subscription_getprocesslist_API);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context, showCancel: false, title: 'Process List', content: "Process List fetched successfully", onOk: () {});
          subscriptionController.subscriptionModel.processList.clear();
          // print(value.data);
          subscriptionController.addToProcessList(value);
          subscriptionController.search(subscriptionController.subscriptionModel.searchQuery.value);
        } else {
          if (kDebugMode) {
            print("error : ${value.message}");
          }
          // await Basic_dialog(context: context, showCancel: false, title: 'Process List Error', content: value.message ?? "", onOk: () {});
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

  /// Updates feedback for a specific event associated with a customer.
  ///
  /// **Parameters:**
  /// - `context`: The build context used for displaying dialogs or snackbars.
  /// - `customerid` (int): The ID of the customer whose process list should be refreshed.
  /// - `eventid` (int): The ID of the event for which feedback is being updated.
  /// - `feedback`: The feedback content to be submitted.
  ///
  /// **Functionality:**
  /// - Sends a GET request to `API.subscription_addfeedback_API` with `eventid` and `feedback` as query parameters.
  /// - If the request is successful (`statusCode == 200`) and `value.code == true`:
  ///   - Calls `GetProcessList(customerid)` to refresh the list of customer processes.
  ///   - Displays a success snackbar to indicate feedback was added successfully.
  /// - If not successful, shows an error dialog with the response message.
  ///
  /// **Error Handling:**
  /// - Catches and displays any exception that occurs during the API call using an error dialog.
  ///
  /// **Use Case:**
  /// - Used when a user submits or updates feedback on a subscription-related event,
  ///   and the updated feedback should reflect in the UI immediately by re-fetching the process list.
  void UpdateFeedback(context, int customerid, int eventid, feedback) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"eventid": eventid, "feedback": feedback}, API.subscription_addfeedback_API);
      if (response?['statusCode'] == 200) {
        CMResponse value = CMResponse.fromJson(response ?? {});
        if (value.code) {
          GetProcessList(customerid);
          Success_SnackBar(context, "Feedback added successfully");
          // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
        } else {
          await Error_dialog(context: context, title: 'Feedback add Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  /// Fetches a PDF file associated with a specific event ID from the server.
  ///
  /// **Parameters:**
  /// - `context`: Build context used to show dialogs or alerts.
  /// - `eventid` (int): The ID of the event whose PDF file needs to be retrieved.
  ///
  /// **Returns:**
  /// - `Future<bool>`: Returns `true` if the PDF file was successfully retrieved and processed,
  ///   otherwise returns `false`.
  ///
  /// **Functionality:**
  /// - Sends a GET request with the `eventid` as a query parameter to `API.subscription_getbinaryfile_API`.
  /// - On successful response (`statusCode == 200`) and if `value.code == true`:
  ///   - Invokes `subscriptionController.PDFfileApiData(value)` to handle the received binary data.
  ///   - Returns `true` indicating success.
  /// - If `value.code` is false, shows an error dialog with the response message.
  /// - If server is down or throws an error, an appropriate error dialog is displayed.
  ///
  /// **Error Handling:**
  /// - Displays relevant error dialogs for API failure or exceptions, and returns `false`.
  ///
  /// **Use Case:**
  /// - Typically called when the user requests to view or download a previously generated PDF
  ///   associated with a subscription-related event.
  Future<bool> GetPDFfile(context, int eventid) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"eventid": eventid}, API.subscription_getbinaryfile_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(
          response ?? {},
        );
        if (value.code) {
          await subscriptionController.PDFfileApiData(value);
          return true;
          // await Basic_dialog(context: context, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
        } else {
          await Error_dialog(
            context: context,
            title: 'PDF file Error',
            content: value.message ?? "",
            onOk: () {},
          );
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

  /// Deletes one or more process records by their process IDs.
  ///
  /// **Parameters:**
  /// - `context`: The `BuildContext` used for showing dialogs and snackbars.
  /// - `processid` (`List`): A list of process IDs (usually integers) that need to be deleted.
  ///
  /// **Functionality:**
  /// - Sends a GET request to `API.subscription_deleteprocess_API` with `processid` as a query parameter.
  /// - On successful deletion (`statusCode == 200` and `value.code == true`):
  ///   - Clears the selected indices in `subscriptionModel.selectedIndices`.
  ///   - Calls `GetProcessList` to refresh the process list for the current customer.
  ///   - Shows a success snackbar confirming the deletion.
  /// - If deletion fails (`value.code == false`), displays an error dialog with the response message.
  /// - If server is down or an unexpected status code is returned, an appropriate error dialog is shown.
  ///
  /// **Use Case:**
  /// - This function is used in subscription workflows where processes (e.g., service tasks or subscriptions)
  ///   need to be removed from a customer's profile or dashboard.
  ///
  /// **Example:**
  /// ```dart
  /// DeleteProcess(context, [101, 102]);
  /// ```
  void DeleteProcess(context, List processid) async {
    if (kDebugMode) {
      print(processid.toString());
    }
    Map<String, dynamic>? response = await apiController.GetbyQueryString({
      "processid": processid,
    }, API.subscription_deleteprocess_API);
    if (response?['statusCode'] == 200) {
      CMResponse value = CMResponse.fromJson(response ?? {});
      if (value.code) {
        subscriptionController.subscriptionModel.selectedIndices.clear();
        GetProcessList(subscriptionController.subscriptionModel.customerId.value!);
        Success_SnackBar(context, "Process Deleted successfully");
        // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
      } else {
        await Error_dialog(context: context, title: 'ERROR', content: value.message ?? "", onOk: () {});
      }
    } else {
      Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
    }
  }

  /// Archives or unarchives one or more process records.
  ///
  /// **Parameters:**
  /// - `context`: The `BuildContext` for displaying dialogs and snackbars.
  /// - `processid` (`List`): A list of process IDs to archive or unarchive.
  /// - `type` (`int`): Action type:
  ///   - `1` for archive
  ///   - `0` for unarchive
  ///
  /// **Functionality:**
  /// - Sends a GET request to `API.subscription_archiveprocess_API` with `processid` and `type` as query parameters.
  /// - If the request is successful and the operation is valid:
  ///   - Clears the selected indices in `subscriptionModel.selectedIndices`.
  ///   - Refreshes the process list via `GetProcessList`.
  ///   - Shows a success snackbar indicating the archive or unarchive result.
  /// - If the operation fails, shows a context-specific error dialog.
  /// - If the server is unavailable, shows a "SERVER DOWN" error dialog.
  ///
  /// **Use Case:**
  /// - Used for managing active/inactive states of processes without deleting them.
  ///
  /// **Example:**
  /// ```dart
  /// ArchiveProcesscontrol(context, [123, 456], 1); // Archives the processes
  /// ArchiveProcesscontrol(context, [123], 0);      // Unarchives the process
  /// ```
  void ArchiveProcesscontrol(context, List processid, int type) async {
    if (kDebugMode) {
      print(processid.toString());
    }
    Map<String, dynamic>? response = await apiController.GetbyQueryString({"processid": processid, "type": type}, API.subscription_archiveprocess_API);
    if (response?['statusCode'] == 200) {
      CMResponse value = CMResponse.fromJson(response ?? {});
      if (value.code) {
        subscriptionController.subscriptionModel.selectedIndices.clear();
        GetProcessList(subscriptionController.subscriptionModel.customerId.value!);
        Success_SnackBar(context, type == 0 ? "Process Unarchived successfully" : "Process Archived successfully");
        // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
      } else {
        await Error_dialog(context: context, title: type == 0 ? 'Error : Failed to unarchive the process.' : 'Error : Failed to archive the process.', content: value.message ?? "", onOk: () {});
      }
    } else {
      Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
    }
  }

  /// Fetches subscription data based on a specified subscription period.
  ///
  /// **Parameters:**
  /// - `subscriptionperiod` (`String`): The subscription period to filter the data (e.g., "Monthly", "Yearly").
  ///
  /// **Returns:**
  /// - A `Future<bool>` indicating the success of the operation (`true` if successful, `false` otherwise).
  ///
  /// **Functionality:**
  /// - Makes a GET request to the API `subscription_getsubscriptiondata_API` with the `subscriptionperiod` as a query string.
  /// - On success and if `value.code` is `true`:
  ///   - Updates the subscription data in `subscriptionController` using `updateSubscriptionData`.
  ///   - Triggers search with the current `searchQuery`.
  /// - If the response is not successful or data is invalid:
  ///   - Logs the error in debug mode.
  /// - Always returns `false` (you may consider adjusting this to return `true` if `value.code` is `true`).
  ///
  /// **Example:**
  /// ```dart
  /// bool success = await GetSubscriptionData("Monthly");
  /// if (success) {
  ///   print("Subscription data loaded.");
  /// }
  /// ```
  Future<bool> GetSubscriptionData(String subscriptionperiod) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"subscriptionperiod": subscriptionperiod}, API.subscription_getsubscriptiondata_API);

      // print('response: $response');
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        // print(value.data);
        if (value.code) {
          // print(value.data);
          subscriptionController.updateSubscriptionData(value);
          subscriptionController.search(subscriptionController.subscriptionModel.searchQuery.value);
        } else {
          if (kDebugMode) {
            print("error : ${value.message}");
          }
          // await Basic_dialog(context: context, title: 'Subscription Data Error', content: value.message ?? "", onOk: () {}, showCancel: false);
        }
      } else {
        if (kDebugMode) {
          print("error : ${"please contact administration"}");
        }
        // Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!", showCancel: false);
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print("error : $e");
      }
      // Basic_dialog(context: context, title: "ERROR", content: "$e", showCancel: false);
      return false;
    }
  }

  /// Fetches and updates the client profile for a given customer ID.
  ///
  /// **Parameters:**
  /// - `context`: The build context for showing dialogs.
  /// - `customerid` (`int`): The ID of the customer whose profile needs to be fetched.
  ///
  /// **Returns:**
  /// - A `Future<bool>` indicating the success of the operation (`true` if successful, `false` otherwise).
  ///
  /// **Functionality:**
  /// - Makes a GET request to the `subscription_clientprofile_API` using the `customerid`.
  /// - If the response is successful and `value.code` is `true`:
  ///   - Updates the client profile data in `subscriptionController` using `updateclientprofileData`.
  ///   - Sets the profile page flag to `true` via `updateprofilepage(true)`.
  /// - If the response is invalid or unsuccessful:
  ///   - Displays an error dialog with the appropriate message.
  /// - Returns `false` regardless of outcome. *(Consider returning `true` when `value.code` is true.)*
  ///
  /// **Example Usage:**
  /// ```dart
  /// bool loaded = await Getclientprofile(context, 101);
  /// if (loaded) {
  ///   print("Client profile loaded.");
  /// }
  /// ```
  Future<bool> Getclientprofile(context, int customerid) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"customerid": customerid}, API.subscription_clientprofile_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          subscriptionController.updateclientprofileData(value);
          subscriptionController.updateprofilepage(true);
        } else {
          await Error_dialog(
            context: context,
            title: 'Client Profile Error',
            content: value.message ?? "",
            onOk: () {},
          );
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

  // void GetApproval(context, int customerid, int eventid) async {
  //   try {
  //     Map<String, dynamic>? response = await apiController.GetbyQueryString({"eventid": eventid}, 'API.subscription_approvedquotation_API');
  //     if (response?['statusCode'] == 200) {
  //       CMResponse value = CMResponse.fromJson(response ?? {});
  //       if (value.code) {
  //         GetProcessList(customerid);
  //         Success_SnackBar(context, "Approval Sent successfully");
  //         // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
  //       } else {
  //         await Error_dialog(context: context, title: 'Approval Send add Error', content: value.message ?? "", onOk: () {});
  //       }
  //     } else {
  //       Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
  //     }
  //   } catch (e) {
  //     Error_dialog(context: context, title: "ERROR", content: "$e");
  //   }
  // }

  /// Fetches the list of custom subscription PDFs and updates the controller state.
  ///
  /// **Purpose:**
  /// Retrieves the list of generated custom PDFs for subscriptions from the server and updates
  /// the UI and controller data accordingly.
  ///
  /// **Behavior:**
  /// - Sends a GET request to `API.get_subscriptionCustompdf`.
  /// - Parses the response into a `CMDlResponse`.
  /// - If successful (`value.code == true`):
  ///   - Adds the data to the controller via `addToCustompdfList()`.
  ///   - Triggers the search to update visible results using the current search query.
  /// - If the response or parsing fails, logs the error in debug mode.
  ///
  /// **Note:**
  /// UI-related dialogs (e.g., errors or confirmations) are commented out but can be re-enabled
  /// based on the use-case or environment (production vs development).
  ///
  /// **Returns:**
  /// A `Future<void>` once the network operation and data update are complete.
  Future<void> Get_subscriptionCustomPDFLsit() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.get_subscriptionCustompdf);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          subscriptionController.addToCustompdfList(value);
          subscriptionController.search(subscriptionController.subscriptionModel.searchQuery.value);
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

  /// Fetches a specific custom PDF file from the server using the provided ID.
  ///
  /// **Purpose:**
  /// This function retrieves binary PDF data for a custom subscription PDF based on
  /// its unique `customPDFid` and passes it to the controller for processing or display.
  ///
  /// **Parameters:**
  /// - `context`: The UI context for showing error dialogs.
  /// - `customPDFid`: The unique identifier of the custom PDF to fetch.
  ///
  /// **Behavior:**
  /// - Sends a GET request using query string parameters to `API.subscription_getcustombinaryfile_API`.
  /// - On success (`statusCode == 200` and `value.code == true`):
  ///   - Passes the response to `custom_PDFfileApiData()` to update the PDF file state.
  ///   - Returns `true` to indicate successful data retrieval.
  /// - On failure:
  ///   - Displays an appropriate error dialog (server error or response failure).
  ///   - Returns `false`.
  ///
  /// **Returns:**
  /// - `true` if the custom PDF file was fetched and processed successfully.
  /// - `false` if any error occurred during the request or processing.
  Future<bool> Get_customPDFfile(context, int customPDFid) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"custompdfid": customPDFid}, API.subscription_getcustombinaryfile_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          await subscriptionController.custom_PDFfileApiData(value);
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

  /// Fetches a recurred invoice PDF file using its unique ID from the server.
  ///
  /// **Purpose:**
  /// This function is responsible for retrieving a previously generated PDF invoice
  /// from a recurring billing cycle, identified by `recurredPDFid`, and passing the binary data
  /// to the `subscriptionController` for further handling (e.g., display, download).
  ///
  /// **Parameters:**
  /// - `context`: The build context used for displaying error dialogs if needed.
  /// - `recurredPDFid`: The unique identifier of the recurred invoice to retrieve.
  ///
  /// **Behavior:**
  /// - Sends a GET request using the `recurredbillid` as a query parameter to `API.subscription_getRecurredBinaryfile_API`.
  /// - If response is successful (`statusCode == 200` and `value.code == true`):
  ///   - Passes the response data to `pdfFileApiData()` for processing.
  ///   - Returns `true`.
  /// - If the request fails or the response code is false:
  ///   - Shows an error dialog and returns `false`.
  /// - Any thrown exception is caught and an error dialog is shown.
  ///
  /// **Returns:**
  /// - `true`: if the recurred PDF file is successfully retrieved and processed.
  /// - `false`: if an error occurs at any step of the operation.
  Future<bool> Get_RecurredPDFfile(context, int recurredPDFid) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"recurredbillid": recurredPDFid}, API.subscription_getRecurredBinaryfile_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          await subscriptionController.pdfFileApiData(value);
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

  Future<bool> Get_approvalPDFfile(context, int approvalPDFid) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"recurredbillid": approvalPDFid}, API.subscription_getApprovalBinaryfile_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          await subscriptionController.pdfFileApiData(value);
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

  /// Displays a dialog box for generating a client requirement form.
  ///
  /// **Purpose:**
  /// This method shows an `AlertDialog` containing the `SUBSCRIPTION_Generate_clientreq` widget,
  /// which likely serves as a form for entering client requirements related to a subscription.
  ///
  /// **Parameters:**
  /// - `value` – A `String` passed to the `SUBSCRIPTION_Generate_clientreq` widget to prefill or contextualize the form.
  /// - `context` – The build context used for rendering the dialog and handling navigation.
  ///
  /// **Behavior:**
  /// - The dialog is **non-dismissible** by tapping outside (`barrierDismissible: false`).
  /// - A close (`X`) button is shown at the top-right:
  ///   - If `_clientreqController.anyHavedata()` returns `true` (unsaved data exists):
  ///     - Shows a warning dialog asking for confirmation before closing.
  ///     - If confirmed, closes the dialog and resets the controller.
  ///   - If no data exists, closes the dialog directly.
  /// - Dialog content is rendered inside a `SizedBox` of dimensions `900 x 650`.
  /// - The dialog uses a rounded border and a dark background color (`Primary_colors.Dark`).
  ///
  /// **Returns:**
  /// - A `Future<dynamic>` that completes after the dialog is dismissed.
  dynamic Generate_client_reqirement_dialougebox(String value, context) async {
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
                child: SUBSCRIPTION_Generate_clientreq(
                  value: value,
                ),
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
                    if (_clientreqController.anyHavedata()) {
                      bool? proceed = await Warning_dialog(
                        context: context,
                        title: "Warning",
                        content: "The data may be lost. Do you want to proceed?",
                        onOk: () {},
                        // showCancel: true,
                      );
                      if (proceed == true) {
                        Navigator.of(context).pop();
                        _clientreqController.resetData();
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

// Future<void> saveFileToPrefs(Uint8List fileData, String key) async {
//   final prefs = await SharedPreferences.getInstance();
//   String base64File = base64Encode(fileData);
//   await prefs.setString(key, base64File);
// }

// Future<Uint8List?> getFileFromPrefs(String key) async {
//   final prefs = await SharedPreferences.getInstance();
//   String? base64File = prefs.getString(key);
//   return base64File != null ? base64Decode(base64File) : null;
// }

// Future<File> saveFileToTemp(Uint8List fileData, String fileName) async {
//   final tempDir = await getTemporaryDirectory();
//   final filePath = '${tempDir.path}/$fileName';
//   final file = File(filePath);
//   await file.writeAsBytes(fileData);
//   return file;
// }
  /// Saves a given PDF byte data to a temporary file on the device.
  ///
  /// **Purpose:**
  /// This method writes the provided PDF data (`Uint8List`) to a file named `temp_pdf.pdf`
  /// in the system's temporary directory, allowing it to be accessed later (e.g., for preview or upload).
  ///
  /// **Parameters:**
  /// - `pdfData` – The PDF content in `Uint8List` format to be saved.
  ///
  /// **Returns:**
  /// - A `Future<File>` that resolves to the `File` object representing the saved PDF in the temp directory.
  ///
  /// **Example Usage:**
  /// ```dart
  /// File file = await savePdfToTemp(pdfBytes);
  /// print('Saved at: ${file.path}');
  /// ```
  Future<File> savePdfToTemp(Uint8List pdfData) async {
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/temp_pdf.pdf');
    await tempFile.writeAsBytes(pdfData, flush: true);
    return tempFile;
  }

// Function to generate a client requirement
  // dynamic generate_client_requirement(context) async {
  //   // showDialog(
  //   //   context: context,
  //   //   builder: (context) {
  //   //     return AlertDialog(
  //   //         backgroundColor: Primary_colors.Light,
  //   //         content: Generate_popup(
  //   //           type: 'E://Client_requirement.pdf',
  //   //         ));
  //   //   },
  //   // );
  //   // }
  // }

  /// Displays a dialog box to generate a quote using the provided type and event ID.
  ///
  /// **Purpose:**
  /// Opens a modal dialog (non-dismissible by outside tap) to present the `SUBSCRIPTION_GenerateQuote` UI,
  /// allowing users to create or edit a quotation. If the user attempts to close the dialog and unsaved data is present,
  /// a warning confirmation will appear.
  ///
  /// **Parameters:**
  /// - `context` – The current `BuildContext` to show the dialog.
  /// - `quoteType` – A `String` specifying the type of quote to generate (e.g., 'company', 'custom').
  /// - `eventID` – The ID associated with the quote event.
  ///
  /// **Behavior:**
  /// - Loads a dialog with fixed dimensions (1300x650).
  /// - If unsaved data is detected (`sub_quoteController.anyHavedata()`), shows a warning before closing.
  /// - On confirmation, clears data and closes the dialog using `sub_quoteController.resetData()`.
  ///
  /// **Returns:**
  /// - A `Future<dynamic>` that completes once the dialog is closed.
  dynamic GenerateQuote_dialougebox(context, String quoteType, int eventID) async {
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
              SizedBox(
                height: 650,
                width: 1300,
                child: SUBSCRIPTION_GenerateQuote(
                  quoteType: quoteType,
                  eventID: eventID,
                ),
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
                    // || ( sub_quoteController.quoteModel.Quote_gstTotals.isNotEmpty)
                    if (sub_quoteController.anyHavedata()) {
                      // Show confirmation dialog
                      bool? proceed = await Warning_dialog(
                        context: context,
                        title: "Warning",
                        content: "The data may be lost. Do you want to proceed?",
                        onOk: () {},
                        // showCancel: true,
                      );

                      // If user confirms (Yes), clear data and close the dialog
                      if (proceed == true) {
                        Navigator.of(context).pop(); // Close the dialog
                        sub_quoteController.resetData();
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

// Function to generate a quote and show a popup
  // dynamic generate_quote(context) async {
  //   // bool confirmed = await GenerateQuote_dialougebox();

  //   // if (confirmed) {
  //   //   // Proceed only if the dialog was confirmed
  //   //   Future.delayed(const Duration(seconds: 4), () {
  //   //     Generate_popup.callback();
  //   //   });

  //   //   showDialog(
  //   //     context: context,
  //   //     builder: (context) {
  //   //       return AlertDialog(
  //   //           backgroundColor: Primary_colors.Light,
  //   //           content: Generate_popup(
  //   //             type: 'E://Quote.pdf',
  //   //           ));
  //   //     },
  //   //   );
  //   // }
  // }

  /// Formats an integer into a readable currency string with Indian number system units.
  ///
  /// **Purpose:**
  /// Converts a raw integer value into a shortened currency format using:
  /// - "Cr" for Crores (10 million and above)
  /// - "L" for Lakhs (1 lakh and above)
  /// - "K" for Thousands (1,000 and above)
  /// - Raw value for amounts less than 1,000
  ///
  /// **Example Outputs:**
  /// - `formatNumber(950)` → ₹ 950
  /// - `formatNumber(12500)` → ₹ 12.5K
  /// - `formatNumber(275000)` → ₹ 2.8L
  /// - `formatNumber(52000000)` → ₹ 5.2Cr
  ///
  /// **Parameters:**
  /// - `number` – The amount to format as an `int`.
  ///
  /// **Returns:**
  /// A `String` representing the formatted amount with appropriate currency unit.
  String formatNumber(int number) {
    if (number >= 10000000) {
      return "₹ ${(number / 10000000).toStringAsFixed(1)}Cr";
    } else if (number >= 100000) {
      return "₹ ${(number / 100000).toStringAsFixed(1)}L";
    } else if (number >= 1000) {
      return "₹ ${(number / 1000).toStringAsFixed(1)}K";
    } else {
      return "₹ $number";
    }
  }

  /// Refreshes all key subscription-related data in the application.
  ///
  /// **Purpose:**
  /// This method resets and reloads the complete subscription state by fetching:
  /// - Recurring invoice list (for all customers)
  /// - Approval queue list (for all customers)
  /// - Process list for default customer (ID: 0)
  /// - Lists of process customers, recurred customers, and approval queue customers
  /// - Company list
  /// - Subscription data based on current period
  /// - Custom PDF list
  ///
  /// It also resets the currently selected customer process and customer ID.
  ///
  /// **Usage:**
  /// Typically called during screen reloads or full data refreshes.
  ///
  /// **Returns:**
  /// A `Future<void>` once all API calls and state updates complete.
  Future<void> subscription_refresh() async {
    // subscriptionController.resetData();
    subscriptionController.updateshowcustomerprocess(null);
    subscriptionController.updatecustomerId(0);
    await Get_RecurringInvoiceList(null);
    Get_ApprovalQueueList(null);
    await GetProcessList(0);
    await GetProcesscustomerList();
    await GetReccuredcustomerList();
    await GetApprovalQueue_customerList();
    await get_CompanyList();

    await GetSubscriptionData(subscriptionController.subscriptionModel.subscriptionperiod.value);
    await Get_subscriptionCustomPDFLsit();
  }

  /// Determines the message type based on user selections for WhatsApp and Gmail.
  ///
  /// **Returns:**
  /// - `3` if both WhatsApp and Gmail are selected
  /// - `2` if only WhatsApp is selected
  /// - `1` if only Gmail is selected
  /// - `0` if neither is selected
  ///
  /// **Usage:**
  /// Used to identify how the message (quotation/notification) should be sent.
  ///
  /// **Example:**
  /// ```dart
  /// int type = fetch_messageType(); // Might return 3 if both selected
  /// ```
  int fetch_messageType() {
    if (subscriptionController.subscriptionModel.whatsapp_selectionStatus.value && subscriptionController.subscriptionModel.gmail_selectionStatus.value) return 3;
    if (subscriptionController.subscriptionModel.whatsapp_selectionStatus.value) return 2;
    if (subscriptionController.subscriptionModel.gmail_selectionStatus.value) return 1;

    return 0;
  }

// Function to send a PDF file with the provided context, message type, and PDF file
  dynamic postData_sendPDF(context, int messageType, File pdf) async {
    try {
      Map<String, dynamic> queryString = {
        "emailid": subscriptionController.subscriptionModel.emailController.value.text,
        "phoneno": subscriptionController.subscriptionModel.phoneController.value.text,
        "feedback": subscriptionController.subscriptionModel.feedbackController.value.text,
        "messagetype": messageType,
        "ccemail": subscriptionController.subscriptionModel.CCemailController.value.text,
      };
      await sendPDFdata(context, jsonEncode(queryString), pdf);
    } catch (e) {
      await Error_dialog(context: context, title: "POST", content: "$e", onOk: () {});
    }
  }

  /// Sends a PDF file along with JSON data to the server using a multipart request.
  ///
  /// Parameters:
  /// - [context]: The BuildContext used to show dialogs.
  /// - [jsonData]: A JSON-encoded string containing data to be sent alongside the PDF.
  /// - [file]: The PDF file to upload.
  ///
  /// The function attempts to upload the PDF and JSON data via the `apiController.Multer` method.
  /// On success (HTTP status code 200), it parses the response into a [CMDmResponse] object and
  /// shows a success dialog if the response code is true; otherwise, it shows an error dialog with the server message.
  /// If the status code is not 200, it shows a "SERVER DOWN" error dialog.
  /// Any caught exceptions result in an error dialog displaying the exception message.
  dynamic sendPDFdata(context, String jsonData, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.Multer(_sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, [file], API.send_anyPDF);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          await Success_dialog(context: context, title: "Invoice", content: value.message!, onOk: () {});
          // Navigator.of(context).pop(true);
          // invoiceController.resetData();
        } else {
          await Error_dialog(context: context, title: 'Processing Invoice', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  /// Groups selected invoices by combined email and CC email, then further groups by customer ID,
  /// and sends grouped invoices via email.
  ///
  /// Process:
  /// - Iterates over selected invoice indices from `subscriptionController.subscriptionModel`.
  /// - For each invoice, concatenates the primary email and CC email to create a grouping key.
  /// - Groups invoices by this concatenated email key, then by customer ID within each email group.
  /// - Adds the PDF path to each invoice's post data.
  /// - Iterates through each email group and its customers, sending the grouped invoices by calling `sendMail`.
  ///
  /// Notes:
  /// - Uses nested maps:
  ///    - Outer map key: concatenated email & CC email string.
  ///    - Inner map key: customer ID as string.
  ///    - Inner map value: list of invoice post data maps.
  /// - Tracks counts of sent mails, but does not return any value.
  /// - Includes some commented code indicating planned extensions or debugging prints.
  void mailByGroup() async {
    Map<String, Map<String, List<Map<String, dynamic>>>> groupedByEmail = {};
    int count = 0;
    List<String> concatinatedMails = [];
    List<String> customerIds = [];
    for (int i = 0; i < subscriptionController.subscriptionModel.selectedIndices.length; i++) {
      final invoiceData = subscriptionController.subscriptionModel.ApprovalQueue_list[subscriptionController.subscriptionModel.selectedIndices[i]];
      // final contactDetails = site['contactdetails'] as Map<String, dynamic>?;
      // // print(site);
      // final customerDetails = site['customeraccountdetails'] as Map<String, dynamic>?;
      final customerId = invoiceData.customerId;
      final email = invoiceData.emailId ?? '';
      final CCemail = invoiceData.ccEmail ?? '';
      final String concatinatedMail = "$email&$CCemail";
      // Initialize email group if needed
      if (!groupedByEmail.containsKey(concatinatedMail)) {
        groupedByEmail[concatinatedMail] = {};
        concatinatedMails.add(concatinatedMail);
      }

      // Initialize customer group inside that email
      // print(customerId);
      if (!groupedByEmail[concatinatedMail]!.containsKey(customerId.toString())) {
        groupedByEmail[concatinatedMail]![customerId.toString()] = [];
        customerIds.add(customerId.toString());
      }
      invoiceData.PostData['pdfpath'] = invoiceData.pdfData;
      // Add site to the proper list
      groupedByEmail[concatinatedMail]![customerId.toString()]!.add(invoiceData.PostData);
    }

    for (var mailEntry in groupedByEmail.entries) {
      final String emailAndCC = mailEntry.key;
      final Map<String, List<Map<String, dynamic>>> customers = mailEntry.value;

      // print('Email: $emailAndCC');
      // print('Customer Count: ${customers.length}');

      for (var customerEntry in customers.entries) {
        final String customerId = customerEntry.key;
        final List<Map<String, dynamic>> invoice = customerEntry.value;
        // print(invoice);
        print('  Customer ID: $customerId');
        print('    Invoice: ${invoice.length}');
        await sendMail(invoice);
        // for (var site in sites) {
        //   InvoicesList.add(site);
        //   // Generators.InvoiceGenerator(site);
        //   // await Future.delayed(const Duration(milliseconds: 2000));
        // }

        count++;
        // await InvoiceServices.apicall(InvoicesList, mailSenderList, count);
        // await Future.delayed(const Duration(milliseconds: 8000));
        // mailSenderList.clear();
        // InvoicesList.clear();
        // print('************************ SITES ENDED ***********************');
      }
      // print('************************ MAIL CLUB ENDED ****************************************************************************************************\n\n\n\n\n\n\n\n');
    }
  }

  /// Sends a list of grouped invoice data to the server as a JSON-encoded payload.
  ///
  /// Parameters:
  /// - [groupedInvoices]: A list of invoice data maps to be sent.
  ///
  /// The function encodes the invoice list into JSON and sends it using `apiController.SendByQuerystring`.
  /// On receiving a successful HTTP 200 response, it parses the response into a [CMDlResponse].
  /// If the response code is true, it prints the success message; otherwise, it prints the error message.
  /// Error dialogs and UI feedback are currently commented out.
  /// Exceptions during the request are caught but not shown due to commented error handling.
  dynamic sendMail(List<Map<String, dynamic>> groupedInvoices) async {
    try {
      // Map<String, dynamic> query = {
      //   "voucherid": voucherID,
      //   "date": voucherController.voucherModel.extendDueDateControllers[index].value.text,
      //   "feedback": voucherController.voucherModel.extendDueFeedbackControllers[index].value.text,
      // };
      String encodedData = json.encode(groupedInvoices);
      Map<String, dynamic>? response = await apiController.SendByQuerystring(encodedData, API.subscription_sendAutoGenerated_invoices_API);
      if (response['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response);
        if (value.code) {
          print(value.message);
          // await Success_dialog(context: context, title: "Success", content: value.message!, onOk: () {});
        } else {
          print(value.message);
          // await Error_dialog(context: context, title: 'Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        // Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      // Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
