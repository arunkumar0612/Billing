// ignore_for_file: depend_on_referenced_packages
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/IAM_actions.dart';
import 'package:ssipl_billing/controllers/SUBSCRIPTIONcontrollers/SUBSCRIPTION_ClientReq_actions.dart';
import 'package:ssipl_billing/controllers/SUBSCRIPTIONcontrollers/SUBSCRIPTION_Quote_actions.dart';
import 'package:ssipl_billing/models/constants/api.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/screens/SUBSCRIPTION/Generate_Quote/SUBSCRIPTION_generateQuote.dart';
import 'package:ssipl_billing/views/screens/SUBSCRIPTION/Generate_client_req/SUBSCRIPTION_generate_clientreq.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../controllers/SUBSCRIPTIONcontrollers/Subscription_actions.dart';
import '../../models/entities/Response_entities.dart';
import '../../views/components/Basic_DialogBox.dart';
import '../APIservices/invoker.dart';
import 'package:path/path.dart' as path;

mixin SubscriptionServices {
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final SubscriptionController subscriptionController = Get.find<SubscriptionController>();
  final SUBSCRIPTION_ClientreqController clientreqController = Get.find<SUBSCRIPTION_ClientreqController>();
  final SUBSCRIPTION_QuoteController quoteController = Get.find<SUBSCRIPTION_QuoteController>();
  Future<void> GetProcesscustomerList(context) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.subscription_getprocesscustomer_API);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Processcustomer List', content: "Processcu    stomer List fetched successfully", onOk: () {});
          subscriptionController.subscriptionModel.processcustomerList.clear();
          // print(value.data);
          subscriptionController.addToProcesscustomerList(value);

          // subscriptionController.updatecustomerId(subscriptionController.subscriptionModel.processcustomerList[subscriptionController.subscriptionModel.showcustomerprocess.value!].customerId);
        } else {
          await Basic_dialog(context: context, showCancel: false, title: 'Processcustomer List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
    }
  }

  Future<void> GetProcessList(context, int customerid) async {
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
        } else {
          await Basic_dialog(context: context, showCancel: false, title: 'Process List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
    }
  }

  void UpdateFeedback(context, int customerid, int eventid, feedback) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"eventid": eventid, "feedback": feedback}, API.subscription_addfeedback_API);
      if (response?['statusCode'] == 200) {
        CMResponse value = CMResponse.fromJson(response ?? {});
        if (value.code) {
          GetProcessList(context, customerid);
          Basic_SnackBar(context, "Feedback added successfully");
          // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
        } else {
          await Basic_dialog(context: context, showCancel: false, title: 'Feedback add Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
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
          await subscriptionController.PDFfileApiData(value);
          return true;
          // await Basic_dialog(context: context, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
        } else {
          await Basic_dialog(context: context, title: 'PDF file Error', content: value.message ?? "", onOk: () {}, showCancel: false);
        }
      } else {
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!", showCancel: false);
      }
      return false;
    } catch (e) {
      Basic_dialog(context: context, title: "ERROR", content: "$e", showCancel: false);
      return false;
    }
  }

  void showPDF(context, String filename) async {
    if (subscriptionController.subscriptionModel.pdfFile.value != null) {
      await showDialog(
        context: context,
        builder: (context) => Dialog(
          insetPadding: const EdgeInsets.all(20), // Adjust padding to keep it from being full screen
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.35, // 85% of screen width
            height: MediaQuery.of(context).size.height * 0.95, // 80% of screen height
            child: Stack(
              children: [
                SfPdfViewer.file(subscriptionController.subscriptionModel.pdfFile.value!),
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
                        );
                      },
                      icon: const Icon(
                        Icons.download,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Future<void> downloadPdf(BuildContext context, String filename) async {
    try {
      final pdfFile = subscriptionController.subscriptionModel.pdfFile.value;

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
        Basic_dialog(
          context: context,
          title: "Error",
          content: "Cannot find the path. Please select a folder to save the PDF.",
          showCancel: false,
        );
        return;
      }

      // Define the destination path
      String savePath = "$selectedDirectory/$filename.pdf";

      // Copy the PDF file to the selected directory
      await pdfFile.copy(savePath);
      Basic_SnackBar(context, "PDF downloaded successfully to: $savePath");
    } catch (e) {
      Basic_dialog(
        context: context,
        title: "Error",
        content: "Error downloading PDF: $e",
        showCancel: false,
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
        subscriptionController.subscriptionModel.selectedIndices.clear();
        GetProcessList(context, subscriptionController.subscriptionModel.customerId.value!);
        Basic_SnackBar(context, "Process Deleted successfully");
        // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
      } else {
        await Basic_dialog(context: context, showCancel: false, title: 'Delete Process Error', content: value.message ?? "", onOk: () {});
      }
    } else {
      Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
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
        subscriptionController.subscriptionModel.selectedIndices.clear();
        GetProcessList(context, subscriptionController.subscriptionModel.customerId.value!);
        Basic_SnackBar(context, type == 0 ? "Process Unarchived successfully" : "Process Archived successfully");
        // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
      } else {
        await Basic_dialog(
            context: context, showCancel: false, title: type == 0 ? 'Error : Failed to unarchive the process.' : 'Error : Failed to archive the process.', content: value.message ?? "", onOk: () {});
      }
    } else {
      Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
    }
  }

  Future<bool> GetSubscriptionData(context, String subscriptionperiod) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"subscriptionperiod": subscriptionperiod}, API.subscription_getsubscriptiondata_API);

      // print('response: $response');
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        // print(value.data);
        if (value.code) {
          // print(value.data);
          subscriptionController.updateSubscriptionData(value);
        } else {
          await Basic_dialog(context: context, title: 'Subscription Data Error', content: value.message ?? "", onOk: () {}, showCancel: false);
        }
      } else {
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!", showCancel: false);
      }
      return false;
    } catch (e) {
      Basic_dialog(context: context, title: "ERROR", content: "$e", showCancel: false);
      return false;
    }
  }

  Future<bool> Getclientprofile(context, int customerid) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"customerid": customerid}, API.subscription_clientprofile_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          subscriptionController.updateclientprofileData(value);
          subscriptionController.updateprofilepage(true);
        } else {
          await Basic_dialog(context: context, title: 'Client Profile Error', content: value.message ?? "", onOk: () {}, showCancel: false);
        }
      } else {
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!", showCancel: false);
      }
      return false;
    } catch (e) {
      Basic_dialog(context: context, title: "ERROR", content: "$e", showCancel: false);
      return false;
    }
  }

  void GetApproval(context, int customerid, int eventid) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({"eventid": eventid}, 'API.subscription_approvedquotation_API');
      if (response?['statusCode'] == 200) {
        CMResponse value = CMResponse.fromJson(response ?? {});
        if (value.code) {
          GetProcessList(context, customerid);
          Basic_SnackBar(context, "Approval Sent successfully");
          // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
        } else {
          await Basic_dialog(context: context, showCancel: false, title: 'Approval Send add Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
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
                    if (clientreqController.anyHavedata()) {
                      bool? proceed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: const Text("Warning"),
                            content: const Text(
                              "The data may be lost. Do you want to proceed?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false); // No action
                                },
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true); // Yes action
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          );
                        },
                      );

                      if (proceed == true) {
                        Navigator.of(context).pop();
                        clientreqController.resetData();
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
                    // || ( quoteController.quoteModel.Quote_gstTotals.isNotEmpty)
                    if ((quoteController.quoteModel.Quote_sites.isNotEmpty) ||
                        (quoteController.quoteModel.Quote_noteList.isNotEmpty) ||
                        (quoteController.quoteModel.Quote_recommendationList.isNotEmpty) ||
                        (quoteController.quoteModel.clientAddressNameController.value.text != "") ||
                        (quoteController.quoteModel.clientAddressController.value.text != "") ||
                        (quoteController.quoteModel.billingAddressNameController.value.text != "") ||
                        (quoteController.quoteModel.billingAddressController.value.text != "") ||
                        (quoteController.quoteModel.Quote_no.value != "") ||
                        (quoteController.quoteModel.TitleController.value.text != "") ||
                        (quoteController.quoteModel.Quote_table_heading.value != "")) {
                      // Show confirmation dialog
                      bool? proceed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            title: const Text("Warning"),
                            content: const Text(
                              "The data may be lost. Do you want to proceed?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false); // No action
                                },
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true); // Yes action
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          );
                        },
                      );

                      // If user confirms (Yes), clear data and close the dialog
                      if (proceed == true) {
                        Navigator.of(context).pop(); // Close the dialog
                        // Clear all the data when dialog is closed
                        quoteController.quoteModel.Quote_sites.clear();
                        //  quoteController.quoteModel.Quote_gstTotals.clear();
                        quoteController.quoteModel.Quote_noteList.clear();
                        quoteController.quoteModel.Quote_recommendationList.clear();
                        //  quoteController.quoteModel.iQuote_productDetails.clear();
                        quoteController.quoteModel.clientAddressNameController.value.clear();
                        quoteController.quoteModel.clientAddressController.value.clear();
                        quoteController.quoteModel.billingAddressNameController.value.clear();
                        quoteController.quoteModel.billingAddressController.value.clear();
                        quoteController.quoteModel.Quote_no.value = "";
                        quoteController.quoteModel.TitleController.value.clear();
                        quoteController.quoteModel.Quote_table_heading.value = "";
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

  Future<void> refresh(context) async {
    subscriptionController.resetData();
    subscriptionController.updateshowcustomerprocess(null);
    subscriptionController.updatecustomerId(0);
    await GetProcesscustomerList(context);
    await GetProcessList(context, 0);
    await GetSubscriptionData(context, subscriptionController.subscriptionModel.subscriptionperiod.value);
  }
}
