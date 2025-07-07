import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/manual_onboard_actions.dart';
import 'package:ssipl_billing/5_VENDOR/services/manual_onboard_service.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/COMPONENTS-/textfield.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/validators/minimal_validators.dart';

class Vendorbankdetails extends StatefulWidget with ManualOnboardService {
  Vendorbankdetails({super.key});

  @override
  State<Vendorbankdetails> createState() => VendorbankdetailsState();
}

class VendorbankdetailsState extends State<Vendorbankdetails> {
  final ManualOnboardController manualOnboardController = Get.find<ManualOnboardController>();

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
                    key: manualOnboardController.manualOnboardModel.vendorBankDetailsFormKey.value,
                    child: Wrap(
                      runSpacing: 25,
                      spacing: 35,
                      runAlignment: WrapAlignment.end,
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BasicTextfield(
                          digitsOnly: true,
                          width: 400,
                          readonly: false,
                          text: 'ISO Certification (If any)',
                          controller: manualOnboardController.manualOnboardModel.vendorAddressController.value,
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
                          controller: manualOnboardController.manualOnboardModel.vendorAddressStateController.value,
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
                          controller: manualOnboardController.manualOnboardModel.vendorBankName.value,
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
                          controller: manualOnboardController.manualOnboardModel.vendorBankBranch.value,
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
                          controller: manualOnboardController.manualOnboardModel.vendorBankAccountNumber.value,
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
                          controller: manualOnboardController.manualOnboardModel.vendorBankIfsc.value,
                          icon: Icons.confirmation_num,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter IFSC Code';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            // Update the list of products when the input changes
                            manualOnboardController.updateHSNcodeList(value);
                          },
                        ),
                        FormField<FilePickerResult>(
                          validator: (value) => Validators.fileValidator(manualOnboardController.manualOnboardModel.logoPickedFile.value),
                          builder: (FormFieldState<FilePickerResult> field) {
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
                                                  if (manualOnboardController.manualOnboardModel.logoPickedFile.value != null)
                                                    Text(
                                                      manualOnboardController.manualOnboardModel.logoPickedFile.value!.files.single.name,
                                                      style: const TextStyle(fontSize: 13, color: Colors.white),
                                                    ),
                                                  if (manualOnboardController.manualOnboardModel.logoPickedFile.value == null)
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
                                                  pickFunction: manualOnboardController.vendorLogoPickFile,
                                                );
                                                field.didChange(manualOnboardController.manualOnboardModel.logoPickedFile.value);
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
                        FormField<FilePickerResult>(
                          validator: (value) => Validators.fileValidator(manualOnboardController.manualOnboardModel.GSTregCertiPickedFile.value),
                          builder: (FormFieldState<FilePickerResult> field) {
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
                                                  if (manualOnboardController.manualOnboardModel.GSTregCertiPickedFile.value != null)
                                                    Text(
                                                      manualOnboardController.manualOnboardModel.GSTregCertiPickedFile.value!.files.single.name,
                                                      style: const TextStyle(fontSize: 13, color: Colors.white),
                                                    ),
                                                  if (manualOnboardController.manualOnboardModel.GSTregCertiPickedFile.value == null)
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
                                                  pickFunction: manualOnboardController.regCertiPickFile,
                                                );
                                                field.didChange(manualOnboardController.manualOnboardModel.GSTregCertiPickedFile.value);
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
                        FormField<FilePickerResult>(
                          validator: (value) => Validators.fileValidator(manualOnboardController.manualOnboardModel.vendorPANPickedFile.value),
                          builder: (FormFieldState<FilePickerResult> field) {
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
                                                  if (manualOnboardController.manualOnboardModel.vendorPANPickedFile.value != null)
                                                    Text(
                                                      manualOnboardController.manualOnboardModel.vendorPANPickedFile.value!.files.single.name,
                                                      style: const TextStyle(fontSize: 13, color: Colors.white),
                                                    ),
                                                  if (manualOnboardController.manualOnboardModel.vendorPANPickedFile.value == null)
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
                                                  pickFunction: manualOnboardController.vendorPANpickFile,
                                                );
                                                field.didChange(manualOnboardController.manualOnboardModel.vendorPANPickedFile.value);
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
                        FormField<FilePickerResult>(
                          validator: (value) => Validators.fileValidator(manualOnboardController.manualOnboardModel.cancelledChequePickedFile.value),
                          builder: (FormFieldState<FilePickerResult> field) {
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
                                                  if (manualOnboardController.manualOnboardModel.cancelledChequePickedFile.value != null)
                                                    Text(
                                                      manualOnboardController.manualOnboardModel.cancelledChequePickedFile.value!.files.single.name,
                                                      style: const TextStyle(fontSize: 13, color: Colors.white),
                                                    ),
                                                  if (manualOnboardController.manualOnboardModel.cancelledChequePickedFile.value == null)
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
                                                  pickFunction: manualOnboardController.cancelledChequePickFile,
                                                );
                                                field.didChange(manualOnboardController.manualOnboardModel.cancelledChequePickedFile.value);
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
                                text: 'Add Details',
                                onPressed: () async {
                                  // if (clientreqController.clientReqModel.detailsformKey.value.currentState?.validate() ?? false) {
                                  widget.nextTab(context);
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
                      'Generating a client requirement is the initial step in acquiring essential data that will be reflected in subsequent processes. Therefore, please exercise caution when handling sensitive information such as phone numbers, email addresses, GST numbers, and physical addresses.',
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
