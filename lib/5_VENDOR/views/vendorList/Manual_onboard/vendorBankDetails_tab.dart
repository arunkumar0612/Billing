import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/VendorList_actions.dart';
import 'package:ssipl_billing/5_VENDOR/services/VendorList_service.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/COMPONENTS-/textfield.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/validators/minimal_validators.dart';

class Vendorbankdetails extends StatefulWidget with VendorlistServices {
  Vendorbankdetails({super.key});

  @override
  State<Vendorbankdetails> createState() => VendorbankdetailsState();
}

class VendorbankdetailsState extends State<Vendorbankdetails> {
  final VendorListController vendorListController = Get.find<VendorListController>();

  @override
  void initState() {
    super.initState();
    // widget.get_productSuggestionList(context);
    // widget.get_OrganizationList(context);
    // clientreqController.updateGST("33AABCC2462L1ZT");
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Form(
                    key: vendorListController.vendorListModel.vendorBankDetailsFormKey.value,
                    child: Wrap(
                      runSpacing: 25,
                      spacing: 35,
                      runAlignment: WrapAlignment.end,
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BasicTextfield(
                          digitsOnly: false,
                          width: 400,
                          readonly: false,
                          text: 'ISO Certification (If any)',
                          controller: vendorListController.vendorListModel.isoCertification.value,
                          icon: Icons.verified_rounded,
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter ISO Certification';
                          //   }
                          //   return null;
                          // },
                        ),
                        BasicTextfield(
                          digitsOnly: false,
                          width: 400,
                          readonly: false,
                          text: 'Other Certifications (If any)',
                          controller: vendorListController.vendorListModel.otherCertification.value,
                          icon: Icons.verified_rounded,
                          // validator: (value) {
                          //   return Validators.GST_validator(value);
                          // },
                        ),
                        BasicTextfield(
                          digitsOnly: false,
                          width: 400,
                          readonly: false,
                          text: 'Bank Name',
                          controller: vendorListController.vendorListModel.vendorBankName.value,
                          icon: Icons.account_balance_outlined,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter bank name';
                            }
                            return null;
                          },
                        ),
                        BasicTextfield(
                          digitsOnly: false,
                          width: 400,
                          readonly: false,
                          text: 'Bank Branch',
                          controller: vendorListController.vendorListModel.vendorBankBranch.value,
                          icon: Icons.location_on_sharp,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter bank branch';
                            }
                            return null;
                          },
                        ),
                        BasicTextfield(
                          digitsOnly: true,
                          width: 400,
                          readonly: false,
                          text: 'Account Number',
                          controller: vendorListController.vendorListModel.vendorBankAccountNumber.value,
                          icon: Icons.pin,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter account number';
                            }
                            return null;
                          },
                        ),
                        BasicTextfield(
                          digitsOnly: false,
                          width: 400,
                          readonly: false,
                          text: 'IFSC Code',
                          controller: vendorListController.vendorListModel.vendorBankIfsc.value,
                          icon: Icons.confirmation_num,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter IFSC Code';
                            }
                            return null;
                          },
                        ),
                        FormField<String>(
                          validator: (value) => Validators.fileValidator(vendorListController.vendorListModel.uploadedLogo_path.value),
                          builder: (FormFieldState<String> field) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 400,
                                  height: 50,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 53,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: field.hasError ? Colors.red : Colors.black), // Change border color based on validation
                                          borderRadius: BorderRadius.circular(4),
                                          color: Primary_colors.Dark,
                                        ),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 10),
                                            const Icon(Icons.file_copy, color: Primary_colors.Color1), // Change icon color if error
                                            const SizedBox(width: 8),
                                            SizedBox(
                                              width: 257,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  if (vendorListController.vendorListModel.uploadedLogo_path.value != null)
                                                    Text(
                                                      vendorListController.vendorListModel.uploadedLogo_path.value!,
                                                      style: const TextStyle(fontSize: 13, color: Colors.white),
                                                    ),
                                                  if (vendorListController.vendorListModel.uploadedLogo_path.value == null)
                                                    const Text(
                                                      'Please Upload Company Logo',
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color: Color.fromARGB(255, 161, 160, 160), // Change text color if error
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            ElevatedButton(
                                              onPressed: () async {
                                                await widget.allFilesAction(
                                                  context: context,
                                                  pickFunction: vendorListController.vendorLogoPickFile,
                                                );
                                                field.didChange(vendorListController.vendorListModel.uploadedLogo_path.value);
                                                // clientreqController.clientReqModel.pickedFile.refresh();
                                              },
                                              style: ButtonStyle(
                                                overlayColor: WidgetStateProperty.all<Color>(Primary_colors.Dark),
                                                foregroundColor: WidgetStateProperty.all<Color>(Primary_colors.Dark),
                                                backgroundColor: WidgetStateProperty.all<Color>(Primary_colors.Light),
                                                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                                ),
                                              ),
                                              child: const Text(
                                                'Choose File',
                                                style: TextStyle(color: Colors.white, fontSize: 11),
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (field.hasError)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      field.errorText!,
                                      style: const TextStyle(color: Colors.red, fontSize: 12),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                        FormField<String>(
                          validator: (value) => Validators.fileValidator(vendorListController.vendorListModel.GSTregCerti_uploadedPath.value),
                          builder: (FormFieldState<String> field) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 400,
                                  height: 50,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 53,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: field.hasError ? Colors.red : Colors.black), // Change border color based on validation
                                          borderRadius: BorderRadius.circular(4),
                                          color: Primary_colors.Dark,
                                        ),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 10),
                                            const Icon(Icons.file_copy, color: Primary_colors.Color1), // Change icon color if error
                                            const SizedBox(width: 8),
                                            SizedBox(
                                              width: 257,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  if (vendorListController.vendorListModel.GSTregCerti_uploadedPath.value != null)
                                                    Text(
                                                      vendorListController.vendorListModel.GSTregCerti_uploadedPath.value!,
                                                      style: const TextStyle(fontSize: 13, color: Colors.white),
                                                    ),
                                                  if (vendorListController.vendorListModel.GSTregCerti_uploadedPath.value == null)
                                                    const Text(
                                                      'Please Upload GST Reg Certificate',
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color: Color.fromARGB(255, 161, 160, 160), // Change text color if error
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            ElevatedButton(
                                              onPressed: () async {
                                                await widget.allFilesAction(
                                                  context: context,
                                                  pickFunction: vendorListController.regCertiPickFile,
                                                );
                                                field.didChange(vendorListController.vendorListModel.GSTregCerti_uploadedPath.value);
                                                // clientreqController.clientReqModel.pickedFile.refresh();
                                              },
                                              style: ButtonStyle(
                                                overlayColor: WidgetStateProperty.all<Color>(Primary_colors.Dark),
                                                foregroundColor: WidgetStateProperty.all<Color>(Primary_colors.Dark),
                                                backgroundColor: WidgetStateProperty.all<Color>(Primary_colors.Light),
                                                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                                ),
                                              ),
                                              child: const Text(
                                                'Choose File',
                                                style: TextStyle(color: Colors.white, fontSize: 11),
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (field.hasError)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      field.errorText!,
                                      style: const TextStyle(color: Colors.red, fontSize: 12),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                        FormField<String>(
                          validator: (value) => Validators.fileValidator(vendorListController.vendorListModel.uploadedLogo_path.value),
                          builder: (FormFieldState<String> field) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 400,
                                  height: 50,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 53,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: field.hasError ? Colors.red : Colors.black), // Change border color based on validation
                                          borderRadius: BorderRadius.circular(4),
                                          color: Primary_colors.Dark,
                                        ),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 10),
                                            const Icon(Icons.file_copy, color: Primary_colors.Color1), // Change icon color if error
                                            const SizedBox(width: 8),
                                            SizedBox(
                                              width: 257,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  if (vendorListController.vendorListModel.PAN_uploadedPath.value != null)
                                                    Text(
                                                      vendorListController.vendorListModel.PAN_uploadedPath.value!,
                                                      style: const TextStyle(fontSize: 13, color: Colors.white),
                                                    ),
                                                  if (vendorListController.vendorListModel.PAN_uploadedPath.value == null)
                                                    const Text(
                                                      'Please Upload PAN',
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color: Color.fromARGB(255, 161, 160, 160), // Change text color if error
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            ElevatedButton(
                                              onPressed: () async {
                                                await widget.allFilesAction(
                                                  context: context,
                                                  pickFunction: vendorListController.vendorPANpickFile,
                                                );
                                                field.didChange(vendorListController.vendorListModel.PAN_uploadedPath.value!);
                                                // clientreqController.clientReqModel.pickedFile.refresh();
                                              },
                                              style: ButtonStyle(
                                                overlayColor: WidgetStateProperty.all<Color>(Primary_colors.Dark),
                                                foregroundColor: WidgetStateProperty.all<Color>(Primary_colors.Dark),
                                                backgroundColor: WidgetStateProperty.all<Color>(Primary_colors.Light),
                                                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                                ),
                                              ),
                                              child: const Text(
                                                'Choose File',
                                                style: TextStyle(color: Colors.white, fontSize: 11),
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (field.hasError)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      field.errorText!,
                                      style: const TextStyle(color: Colors.red, fontSize: 12),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                        FormField<String>(
                          validator: (value) => Validators.fileValidator(vendorListController.vendorListModel.cheque_uploadedPath.value),
                          builder: (FormFieldState<String> field) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 400,
                                  height: 50,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 53,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: field.hasError ? Colors.red : Colors.black), // Change border color based on validation
                                          borderRadius: BorderRadius.circular(4),
                                          color: Primary_colors.Dark,
                                        ),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 10),
                                            const Icon(Icons.file_copy, color: Primary_colors.Color1), // Change icon color if error
                                            const SizedBox(width: 8),
                                            SizedBox(
                                              width: 257,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  if (vendorListController.vendorListModel.cheque_uploadedPath.value != null)
                                                    Text(
                                                      vendorListController.vendorListModel.cheque_uploadedPath.value!,
                                                      style: const TextStyle(fontSize: 13, color: Colors.white),
                                                    ),
                                                  if (vendorListController.vendorListModel.cheque_uploadedPath.value == null)
                                                    const Text(
                                                      'Please Upload Cancelled Cheque',
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color: Color.fromARGB(255, 161, 160, 160), // Change text color if error
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            ElevatedButton(
                                              onPressed: () async {
                                                await widget.allFilesAction(
                                                  context: context,
                                                  pickFunction: vendorListController.cancelledChequePickFile,
                                                );
                                                field.didChange(vendorListController.vendorListModel.cheque_uploadedPath.value);
                                                // clientreqController.clientReqModel.pickedFile.refresh();
                                              },
                                              style: ButtonStyle(
                                                overlayColor: WidgetStateProperty.all<Color>(Primary_colors.Dark),
                                                foregroundColor: WidgetStateProperty.all<Color>(Primary_colors.Dark),
                                                backgroundColor: WidgetStateProperty.all<Color>(Primary_colors.Light),
                                                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                                ),
                                              ),
                                              child: const Text(
                                                'Choose File',
                                                style: TextStyle(color: Colors.white, fontSize: 11),
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (field.hasError)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      field.errorText!,
                                      style: const TextStyle(color: Colors.red, fontSize: 12),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 75),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BasicButton(
                                colors: Colors.red,
                                text: 'Back',
                                onPressed: () async {
                                  // if (clientreqController.clientReqModel.detailsformKey.value.currentState?.validate() ?? false) {
                                  widget.backTab(context);
                                  // }
                                },
                              ),
                              const SizedBox(width: 10),
                              BasicButton(
                                colors: Colors.green,
                                text: 'Submit',
                                onPressed: () async {
                                  if (vendorListController.vendorListModel.vendorBankDetailsFormKey.value.currentState?.validate() ?? false) {
                                    widget.postData(context, 'new');
                                  }
                                  // }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  const SizedBox(
                    width: 750,
                    child: Text(
                      textAlign: TextAlign.center,
                      'Bank details ensures that all future payments are processed securely and without delays. Please ensure your documents are clear, valid, and up to date.',
                      style: TextStyle(color: Color.fromARGB(255, 124, 124, 124), fontSize: Primary_font_size.Text7),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
