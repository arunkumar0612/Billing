// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/SUBSCRIPTION_ClientReq_actions.dart' show SUBSCRIPTION_ClientreqController;
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/SUBSCRIPTION_Quote_actions.dart' show SUBSCRIPTION_QuoteController;
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/Subscription_actions.dart' show SubscriptionController;
import 'package:ssipl_billing/3.SUBSCRIPTION/views/Process/Generate_Quote/SUBSCRIPTION_generateQuote.dart' show SUBSCRIPTION_GenerateQuote;
import 'package:ssipl_billing/3.SUBSCRIPTION/views/Process/Generate_client_req/SUBSCRIPTION_generate_clientreq.dart' show SUBSCRIPTION_Generate_clientreq;
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
  final SubscriptionController _subscriptionController = Get.find<SubscriptionController>();
  final SUBSCRIPTION_ClientreqController _clientreqController = Get.find<SUBSCRIPTION_ClientreqController>();
  final SUBSCRIPTION_QuoteController sub_quoteController = Get.find<SUBSCRIPTION_QuoteController>();
  final SubscriptionController subscriptionController = Get.find<SubscriptionController>();
  // final loader = LoadingOverlay();

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
          _subscriptionController.add_Comp(value);
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

  Future<void> get_GlobalPackageList(context) async {
    // loader.start(context);
    await Future.delayed(const Duration(milliseconds: 1000));
    Map<String, dynamic>? response;
    response = await apiController.GetbyToken(API.get_subscription_GlobalPackageList);
    if (response?['statusCode'] == 200) {
      CMDlResponse value = CMDlResponse.fromJson(response ?? {});
      if (value.code) {
        _subscriptionController.add_GlobalPackage(value);
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
          // _subscriptionController.subscriptionModel.packageselectedIndex.value = _subscriptionController.subscriptionModel.packageselectedIndex.value! - subId.length;
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

  Future<void> GetProcesscustomerList() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.subscription_getprocesscustomer_API);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Processcustomer List', content: "Processcu    stomer List fetched successfully", onOk: () {});
          _subscriptionController.subscriptionModel.processcustomerList.clear();
          // print(value.data);
          _subscriptionController.addToProcesscustomerList(value);

          // _subscriptionController.updatecustomerId(_subscriptionController.subscriptionModel.processcustomerList[_subscriptionController.subscriptionModel.showcustomerprocess.value!].customerId);
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

  Future<void> GetReccuredcustomerList() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.subscription_getrecurredcustomer_API);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Processcustomer List', content: "Processcu    stomer List fetched successfully", onOk: () {});
          _subscriptionController.subscriptionModel.recurredcustomerList.clear();
          // print(value.data);
          _subscriptionController.addToRecurredcustomerList(value);

          // _subscriptionController.updatecustomerId(_subscriptionController.subscriptionModel.processcustomerList[_subscriptionController.subscriptionModel.showcustomerprocess.value!].customerId);
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
          _subscriptionController.addTo_RecuuringInvoiceList(value);
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

  Future<void> GetProcessList(int customerid) async {
    try {
      Map<String, dynamic>? response =
          await apiController.GetbyQueryString({"customerid": customerid, "listtype": _subscriptionController.subscriptionModel.type.value}, API.subscription_getprocesslist_API);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context, showCancel: false, title: 'Process List', content: "Process List fetched successfully", onOk: () {});
          _subscriptionController.subscriptionModel.processList.clear();
          // print(value.data);
          _subscriptionController.addToProcessList(value);
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

  Future<bool> GetPDFfile(context, int eventid) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"eventid": eventid}, API.subscription_getbinaryfile_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(
          response ?? {},
        );
        if (value.code) {
          await _subscriptionController.PDFfileApiData(value);
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

  // void showPDF(context, String filename) async {
  //   if (_subscriptionController.subscriptionModel.pdfFile.value != null) {
  //     await showDialog(
  //       context: context,
  //       builder: (context) => Dialog(
  //         insetPadding: const EdgeInsets.all(20), // Adjust padding to keep it from being full screen
  //         child: SizedBox(
  //             width: MediaQuery.of(context).size.width * 0.35, // 85% of screen width
  //             height: MediaQuery.of(context).size.height * 0.95, // 80% of screen height
  //             child: Stack(
  //               children: [
  //                 SfPdfViewer.file(_subscriptionController.subscriptionModel.pdfFile.value!),
  //                 Align(
  //                     alignment: Alignment.bottomRight,
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(20),
  //                       child: IconButton(
  //                         onPressed: () {
  //                           downloadPdf(
  //                               context,
  //                               path
  //                                   .basename(filename)
  //                                   .replaceAll(RegExp(r'[\/\\:*?"<>|.]'), '') // Removes invalid symbols
  //                                   .replaceAll(" ", ""),
  //                               _subscriptionController.subscriptionModel.pdfFile.value);
  //                         },
  //                         icon: const Icon(
  //                           Icons.download,
  //                           color: Colors.blue,
  //                         ),
  //                       ),
  //                     ))
  //               ],
  //             )),
  //       ),
  //     );
  //   }
  // }

  Future<void> downloadPdf(BuildContext context, String filename, File? pdfFile) async {
    try {
      // final pdfFile = _subscriptionController.subscriptionModel.pdfFile.value;

      if (pdfFile == null) {
        if (kDebugMode) {
          print("No PDF file found to download.");
        }
        return;
      }

      // Let the user pick a folder to save the file
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      // Check if the user canceled folder selection
      if (selectedDirectory == null) {
        Error_dialog(
          context: context,
          title: "Error",
          content: "Cannot find the path. Please select a folder to save the PDF.",
          // showCancel: false,
        );
        return;
      }

      // Define the destination path
      String savePath = "$selectedDirectory/$filename.pdf";

      // Copy the PDF file to the selected directory
      await pdfFile.copy(savePath);
      Success_SnackBar(context, "PDF downloaded successfully to: $savePath");
    } catch (e) {
      Error_dialog(
        context: context,
        title: "Error",
        content: "Error downloading PDF: $e",
        // showCancel: false,
      );
    }
  }

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
        _subscriptionController.subscriptionModel.selectedIndices.clear();
        GetProcessList(_subscriptionController.subscriptionModel.customerId.value!);
        Success_SnackBar(context, "Process Deleted successfully");
        // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
      } else {
        await Error_dialog(context: context, title: 'ERROR', content: value.message ?? "", onOk: () {});
      }
    } else {
      Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
    }
  }

  void ArchiveProcesscontrol(context, List processid, int type) async {
    if (kDebugMode) {
      print(processid.toString());
    }
    Map<String, dynamic>? response = await apiController.GetbyQueryString({"processid": processid, "type": type}, API.subscription_archiveprocess_API);
    if (response?['statusCode'] == 200) {
      CMResponse value = CMResponse.fromJson(response ?? {});
      if (value.code) {
        _subscriptionController.subscriptionModel.selectedIndices.clear();
        GetProcessList(_subscriptionController.subscriptionModel.customerId.value!);
        Success_SnackBar(context, type == 0 ? "Process Unarchived successfully" : "Process Archived successfully");
        // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
      } else {
        await Error_dialog(context: context, title: type == 0 ? 'Error : Failed to unarchive the process.' : 'Error : Failed to archive the process.', content: value.message ?? "", onOk: () {});
      }
    } else {
      Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
    }
  }

  Future<bool> GetSubscriptionData(String subscriptionperiod) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"subscriptionperiod": subscriptionperiod}, API.subscription_getsubscriptiondata_API);

      // print('response: $response');
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        // print(value.data);
        if (value.code) {
          // print(value.data);
          _subscriptionController.updateSubscriptionData(value);
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

  Future<bool> Getclientprofile(context, int customerid) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"customerid": customerid}, API.subscription_clientprofile_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          _subscriptionController.updateclientprofileData(value);
          _subscriptionController.updateprofilepage(true);
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

  void GetApproval(context, int customerid, int eventid) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"eventid": eventid}, 'API.subscription_approvedquotation_API');
      if (response?['statusCode'] == 200) {
        CMResponse value = CMResponse.fromJson(response ?? {});
        if (value.code) {
          GetProcessList(customerid);
          Success_SnackBar(context, "Approval Sent successfully");
          // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
        } else {
          await Error_dialog(context: context, title: 'Approval Send add Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  Future<void> Get_subscriptionCustomPDFLsit() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.get_subscriptionCustompdf);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          _subscriptionController.addToCustompdfList(value);
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

  Future<bool> Get_RecurredPDFfile(context, int recurredPDFid) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"recurredbillid": recurredPDFid}, API.subscription_getRecurredBinaryfile_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          await subscriptionController.recurred_PDFfileApiData(value);
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

  Future<File> savePdfToTemp(Uint8List pdfData) async {
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/temp_pdf.pdf');
    await tempFile.writeAsBytes(pdfData, flush: true);
    return tempFile;
  }

  dynamic generate_client_requirement(context) async {
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //         backgroundColor: Primary_colors.Light,
    //         content: Generate_popup(
    //           type: 'E://Client_requirement.pdf',
    //         ));
    //   },
    // );
    // }
  }

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

  dynamic generate_quote(context) async {
    // bool confirmed = await GenerateQuote_dialougebox();

    // if (confirmed) {
    //   // Proceed only if the dialog was confirmed
    //   Future.delayed(const Duration(seconds: 4), () {
    //     Generate_popup.callback();
    //   });

    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //           backgroundColor: Primary_colors.Light,
    //           content: Generate_popup(
    //             type: 'E://Quote.pdf',
    //           ));
    //     },
    //   );
    // }
  }

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

  Future<void> subscription_refresh() async {
    // _subscriptionController.resetData();
    _subscriptionController.updateshowcustomerprocess(null);
    _subscriptionController.updatecustomerId(0);
    await Get_RecurringInvoiceList(null);
    await GetProcessList(0);
    await GetProcesscustomerList();
    await GetReccuredcustomerList();
    await get_CompanyList();

    await GetSubscriptionData(_subscriptionController.subscriptionModel.subscriptionperiod.value);
    await Get_subscriptionCustomPDFLsit();
  }

  int fetch_messageType() {
    if (_subscriptionController.subscriptionModel.whatsapp_selectionStatus.value && _subscriptionController.subscriptionModel.gmail_selectionStatus.value) return 3;
    if (_subscriptionController.subscriptionModel.whatsapp_selectionStatus.value) return 2;
    if (_subscriptionController.subscriptionModel.gmail_selectionStatus.value) return 1;

    return 0;
  }

  dynamic postData_sendPDF(context, int messageType, File pdf) async {
    try {
      Map<String, dynamic> queryString = {
        "emailid": _subscriptionController.subscriptionModel.emailController.value.text,
        "phoneno": _subscriptionController.subscriptionModel.phoneController.value.text,
        "feedback": _subscriptionController.subscriptionModel.feedbackController.value.text,
        "messagetype": messageType,
        "ccemail": _subscriptionController.subscriptionModel.CCemailController.value.text,
      };
      await sendPDFdata(context, jsonEncode(queryString), pdf);
    } catch (e) {
      await Error_dialog(context: context, title: "POST", content: "$e", onOk: () {});
    }
  }

// hariprasath.s@sporadsecure.com
// arunkumar.m@sporadasecure.com
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
}
