// ignore_for_file: must_be_immutable
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/Process/Quote_actions.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/Vendor_actions.dart';
import 'package:ssipl_billing/5_VENDOR/services/Process/Quote_services/QuoteService.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/validators/minimal_validators.dart';

class UploadQuote extends StatefulWidget with Quoteservice {
  UploadQuote({super.key});

  @override
  _UploadQuoteState createState() => _UploadQuoteState();
}

class _UploadQuoteState extends State<UploadQuote> with SingleTickerProviderStateMixin {
  final Vendor_QuoteController quoteController = Get.find<Vendor_QuoteController>();
  final VendorController vendorController = Get.find<VendorController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Primary_colors.Light,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              const SizedBox(height: 30),
              _buildFeedbackField(),
              const SizedBox(height: 25),
              _buildFileUploadSection(),
              const SizedBox(height: 30),
              _buildUploadButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Icon(
          Icons.cloud_upload,
          size: 40,
          color: Primary_colors.Color3,
        ),
        const SizedBox(height: 10),
        Text(
          'Submit Your Quote',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Primary_colors.Color3,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Please provide feedback and upload your quote document',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFeedbackField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Feedback',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[500],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.white),
          controller: quoteController.quoteModel.feedbackController.value,
          decoration: InputDecoration(
            filled: true,
            fillColor: Primary_colors.Dark,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Primary_colors.Dark),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            prefixIcon: Icon(
              Icons.feedback,
              color: const Color.fromARGB(255, 110, 109, 109),
            ),
            hintText: 'Enter your feedback...',
            hintStyle: TextStyle(color: Colors.grey[500]),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter feedback';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildFileUploadSection() {
    return FormField<FilePickerResult>(
      validator: (value) => Validators.fileValidator(quoteController.quoteModel.pickedFile.value),
      builder: (FormFieldState<FilePickerResult> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quote Document',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () async {
                await widget.Quote_action(context);
                field.didChange(quoteController.quoteModel.pickedFile.value);
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: field.hasError ? Colors.red : const Color.fromARGB(255, 37, 37, 37),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: Primary_colors.Dark,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.insert_drive_file,
                      size: 30,
                      color: const Color.fromARGB(255, 110, 109, 109),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (quoteController.quoteModel.pickedFile.value != null)
                            Text(
                              quoteController.quoteModel.pickedFile.value!.files.single.name,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          if (quoteController.quoteModel.pickedFile.value == null)
                            Text(
                              'Select a PDF file',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          const SizedBox(height: 4),
                          Text(
                            'PDF, DOC, DOCX (Max 10MB)',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.cloud_upload,
                      color: const Color.fromARGB(255, 110, 109, 109),
                    ),
                  ],
                ),
              ),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: Text(
                  field.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildUploadButton() {
    return Obx(
      () {
        final isEnabled = quoteController.quoteModel.selectedPdf.value != null;

        return ElevatedButton(
          onPressed: isEnabled
              ? () async {
                  if (quoteController.quoteModel.selectedPdf.value != null) {
                    widget.uploadQuote(
                      context,
                      quoteController.quoteModel.selectedPdf.value!,
                    );
                  }
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 100, 110, 255),
            disabledBackgroundColor: const Color.fromARGB(52, 100, 110, 255), // Set gray color when disabled
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SUBMIT QUOTE',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isEnabled ? Primary_colors.Color1 : const Color.fromARGB(148, 238, 238, 238),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
