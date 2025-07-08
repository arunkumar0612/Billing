// ignore_for_file: must_be_immutable
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/Quote_actions.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/Vendor_actions.dart';
import 'package:ssipl_billing/5_VENDOR/services/Quote_services/QuoteService.dart';
// import 'package:ssipl_billing/5_VENDOR/controllers/Sales_actions.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/COMPONENTS-/textfield.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/validators/minimal_validators.dart';

class UploadQuote extends StatefulWidget with Quoteservice {
  UploadQuote({
    super.key,
  });

  @override
  _UploadQuoteState createState() => _UploadQuoteState();
}

class _UploadQuoteState extends State<UploadQuote> with SingleTickerProviderStateMixin {
  final Vendor_QuoteController quoteController = Get.find<Vendor_QuoteController>();
  final VendorController vendorController = Get.find<VendorController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Primary_colors.Dark,
        body: Row(
          children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    // Primary_colors.Dark,
                    Color.fromARGB(255, 4, 6, 10), // Slightly lighter blue-grey
                    Primary_colors.Light, // Dark purple/blue
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    color: Primary_colors.Dark,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'UPLOAD QUOTE',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 160,
                  ),
                  BasicTextfield(
                    digitsOnly: false,
                    width: 390,
                    readonly: false,
                    text: 'Feedback',
                    controller: quoteController.quoteModel.feedbackController.value,
                    icon: Icons.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Feedback';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FormField<FilePickerResult>(
                    validator: (value) => Validators.fileValidator(quoteController.quoteModel.pickedFile.value),
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
                                        width: 246,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            if (quoteController.quoteModel.pickedFile.value != null)
                                              Text(
                                                overflow: TextOverflow.ellipsis,
                                                quoteController.quoteModel.pickedFile.value!.files.single.name,
                                                style: const TextStyle(fontSize: 13, color: Colors.white),
                                              ),
                                            if (quoteController.quoteModel.pickedFile.value == null)
                                              const Text(
                                                'Please Upload the Quote',
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
                                          await widget.Quote_action(context);
                                          field.didChange(quoteController.quoteModel.pickedFile.value);
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
                  SizedBox(
                    height: 20,
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400, maxHeight: 75),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BasicButton(
                          colors: Colors.green,
                          text: 'Upload Quote',
                          onPressed: () async {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ))
          ],
        ));
  }
}
