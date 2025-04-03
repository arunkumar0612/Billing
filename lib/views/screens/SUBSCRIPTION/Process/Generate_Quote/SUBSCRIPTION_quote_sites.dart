// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:ssipl_billing/controllers/SUBSCRIPTIONcontrollers/SUBSCRIPTION_Quote_actions.dart';
import 'package:ssipl_billing/models/entities/SUBSCRIPTION/SUBSCRIPTION_Sites_entities.dart';
import 'package:ssipl_billing/services/SUBSCRIPTION/Quotation_services/SUBSCRIPTION_QuoteSite_services.dart';
import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/textfield.dart';

class SUBSCRIPTION_QuoteSites extends StatefulWidget with SUBSCRIPTION_QuotesiteService {
  SUBSCRIPTION_QuoteSites({super.key});

  @override
  State<SUBSCRIPTION_QuoteSites> createState() => _SUBSCRIPTION_QuoteSitesState();
}

class _SUBSCRIPTION_QuoteSitesState extends State<SUBSCRIPTION_QuoteSites> {
  final SUBSCRIPTION_QuoteController quoteController = Get.find<SUBSCRIPTION_QuoteController>();
  final List<String> packages = ['Basic', 'Standard', 'Premium', 'Enterprise', 'Custom'];

  // Controllers for custom package
  late final TextEditingController customCameraCountController;
  late final TextEditingController customPackageAmountController;
  late final TextEditingController customAdditionalChargesController;
  late final TextEditingController customDescriptionController;

  // Package details map

  @override
  void initState() {
    super.initState();
    customCameraCountController = TextEditingController();
    customPackageAmountController = TextEditingController();
    customAdditionalChargesController = TextEditingController();
    customDescriptionController = TextEditingController();
  }

  @override
  void dispose() {
    customCameraCountController.dispose();
    customPackageAmountController.dispose();
    customAdditionalChargesController.dispose();
    customDescriptionController.dispose();
    super.dispose();
  }

  bool get isCustomPackageSelected => quoteController.quoteModel.selectedPackageController.value.text == 'Custom';

  Widget _buildSiteListItem(int index) {
    final site = quoteController.quoteModel.QuoteSiteDetails[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => widget.editsite(index),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Primary_colors.Light,
            ),
            height: 40,
            width: 300,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 230,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        '${index + 1}. ${site.siteName} (${site.selectedPackage})',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Primary_colors.Color1,
                          fontSize: Primary_font_size.Text7,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => quoteController.removeFromsiteList(index),
                    icon: const Icon(Icons.close, size: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (site.packageDetails != null)
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: Text(
              'Cameras: ${site.packageDetails?.cameraCount} | '
              'Amount: \$${site.packageDetails?.packageAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildPackageFormFields() {
    return Column(
      children: [
        // const SizedBox(height: 20),
        BasicTextfield(
          digitsOnly: false,
          width: 400,
          readonly: false,
          text: 'Site Name',
          controller: quoteController.quoteModel.siteNameController.value,
          icon: Icons.home,
          validator: (value) => value?.isEmpty ?? true ? 'Please enter Site name' : null,
        ),
        const SizedBox(height: 15),
        BasicTextfield(
          digitsOnly: false,
          width: 400,
          readonly: false,
          text: 'Address',
          controller: quoteController.quoteModel.addressController.value,
          icon: Icons.location_on,
          validator: (value) => value?.isEmpty ?? true ? 'Please enter Address' : null,
        ),
        const SizedBox(height: 15),
        BasicTextfield(
          digitsOnly: true,
          width: 400,
          readonly: false,
          text: 'Cameras',
          controller: quoteController.quoteModel.cameraquantityController.value,
          icon: Icons.location_on,
          validator: (value) => value?.isEmpty ?? true ? 'Please enter the camera count' : null,
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: DropdownButtonFormField<String>(
                  value: quoteController.quoteModel.selectedPackageController.value.text.isEmpty ? null : quoteController.quoteModel.selectedPackageController.value.text,
                  hint: const Text(
                    'Select Package',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: Primary_font_size.Text7,
                    ),
                  ),
                  onChanged: (value) {
                    quoteController.updateSelectedPackage(value);
                    setState(() {
                      if (!isCustomPackageSelected) {
                        customCameraCountController.clear();
                        customPackageAmountController.clear();
                        customAdditionalChargesController.clear();
                        customDescriptionController.clear();
                      }
                    });
                  },
                  items: [
                    const DropdownMenuItem<String>(
                      value: null, // This represents the unselected state
                      child: Text(
                        'Select Package',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: Primary_font_size.Text7,
                        ),
                      ),
                    ),
                    ...packages.map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: Primary_font_size.Text7,
                            ),
                          ),
                        )),
                  ],
                  decoration: const InputDecoration(
                    label: Text(
                      'Select Package',
                      style: TextStyle(
                        fontSize: Primary_font_size.Text7,
                        color: Color.fromARGB(255, 167, 165, 165),
                      ),
                    ),
                    filled: true,
                    fillColor: Primary_colors.Dark,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.work_outline, color: Colors.white),
                  ),
                  validator: (value) => value?.isEmpty ?? true ? 'Please select a package' : null,
                  dropdownColor: Primary_colors.Dark,
                ),
              ),
              if (widget.packageDetailsMap[quoteController.quoteModel.selectedPackageController.value.text] != null) const SizedBox(height: 20),
              if (widget.packageDetailsMap[quoteController.quoteModel.selectedPackageController.value.text] != null)
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    quoteController.quoteModel.selectedPackageController.value.text == 'Custom' ? 'Custom Package Details' : 'Package Details:',
                    style: const TextStyle(
                      fontSize: Primary_font_size.Text8,
                      color: Primary_colors.Color1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const SizedBox(height: 5),
              _buildPackageDetails(quoteController.quoteModel.selectedPackageController.value.text),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Obx(() {
          final isEditing = quoteController.quoteModel.site_editIndex.value != null;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BasicButton(
                colors: Colors.red,
                text: isEditing ? 'Cancel' : 'Back',
                onPressed: isEditing ? widget.resetEditingState : quoteController.backTab,
              ),
              const SizedBox(width: 30),
              BasicButton(
                colors: isEditing ? Colors.orange : Colors.blue,
                text: isEditing ? 'Update' : 'Add site',
                onPressed: _handleAddOrUpdateSite,
              ),
            ],
          );
        }),
        // const SizedBox(height: 20),
        // _buildInstructionText(),
      ],
    );
  }

  void _handleAddOrUpdateSite() {
    if (isCustomPackageSelected) {
      if (!_validateCustomPackageFields()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all custom package details')),
        );
        return;
      }
      _saveCustomPackageDetails();
    } else {
      quoteController.quoteModel.customPackageDetails.value = null;
    }

    if (quoteController.quoteModel.site_editIndex.value == null) {
      widget.addsite(context);
    } else {
      widget.updatesite(context);
    }
  }

  bool _validateCustomPackageFields() {
    return customCameraCountController.text.isNotEmpty &&
        customPackageAmountController.text.isNotEmpty &&
        customAdditionalChargesController.text.isNotEmpty &&
        customDescriptionController.text.isNotEmpty;
  }

  void _saveCustomPackageDetails() {
    quoteController.quoteModel.customPackageDetails.value = PackageDetails(
      name: 'Custom',
      cameraCount: int.tryParse(customCameraCountController.text) ?? 0,
      packageAmount: double.tryParse(customPackageAmountController.text) ?? 0.0,
      additionalCharges: customAdditionalChargesController.text,
      description: customDescriptionController.text,
    );
  }

  // Widget _buildInstructionText() {
  //   return const SizedBox(
  //     child: Text(
  //       "The Quotation site details play a crucial role in the procurement process. "
  //       "Please ensure accuracy when entering site names, packages, HSN codes, GST% and quantities, "
  //       "as these details directly impact order processing, inventory management, and subsequent workflows.",
  //       textAlign: TextAlign.center,
  //       style: TextStyle(
  //         color: Color.fromARGB(255, 124, 124, 124),
  //         fontSize: Primary_font_size.Text7,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildSiteListPanel() {
    return Obx(() {
      if (quoteController.quoteModel.QuoteSiteDetails.isEmpty) {
        return const SizedBox.shrink();
      }
      return Expanded(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Primary_colors.Dark,
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                child: Column(
                  children: [
                    const Text(
                      'Site List',
                      style: TextStyle(
                        fontSize: Primary_font_size.Text10,
                        color: Primary_colors.Color1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: widget.packageDetailsMap[quoteController.quoteModel.selectedPackageController.value.text] == null ? 135 : 460,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: List.generate(
                                quoteController.quoteModel.QuoteSiteDetails.length,
                                (index) => _buildSiteListItem(index),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            BasicButton(
              colors: Colors.green,
              text: 'Submit',
              onPressed: () {
                // widget.onSubmit();
                quoteController.nextTab();
              },
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: quoteController.quoteModel.siteFormkey.value,
            child: Column(
              children: [
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildPackageFormFields()),
                      _buildSiteListPanel(),
                    ],
                  ),
                ),
                if (widget.packageDetailsMap[quoteController.quoteModel.selectedPackageController.value.text] == null) const SizedBox(height: 100),
                if (widget.packageDetailsMap[quoteController.quoteModel.selectedPackageController.value.text] == null)
                  const Text(
                    "The Quotation site details play a crucial role in the procurement process. "
                    "Please ensure accuracy when entering site names, packages, HSN codes, GST% and quantities, "
                    "as these details directly impact order processing, inventory management, and subsequent workflows.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 124, 124, 124),
                      fontSize: Primary_font_size.Text7,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPackageDetails(String? packageName) {
    if (packageName == null || packageName.isEmpty) return const SizedBox.shrink();
    if (packageName == 'Custom') return _buildCustomPackageForm();

    final package = widget.packageDetailsMap[packageName];
    if (package == null) return const SizedBox.shrink();

    return GlassmorphicContainer(
      width: double.infinity,
      height: 220,
      borderRadius: 20,
      blur: 10,
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        colors: [
          const Color.fromARGB(255, 78, 77, 77).withOpacity(0.1),
          const Color.fromARGB(255, 105, 104, 104).withOpacity(0.05),
        ],
      ),
      borderGradient: LinearGradient(
        colors: [
          Primary_colors.Color3.withOpacity(0.9),
          Primary_colors.Color3.withOpacity(0.10),
        ],
      ),
      child: Container(
        // margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Package Name:', package.name),
                  const SizedBox(height: 5),
                  _buildDetailRow('Camera Count:', '${package.cameraCount}'),
                  const SizedBox(height: 5),
                  _buildDetailRow('Package Amount:', '\$${package.packageAmount.toStringAsFixed(2)}'),
                  const SizedBox(height: 5),
                  _buildDetailRow('Additional Charges:', package.additionalCharges),
                  const SizedBox(height: 10),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: Primary_font_size.Text7,
                      color: Primary_colors.Color1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    package.description,
                    style: const TextStyle(
                      fontSize: Primary_font_size.Text6,
                      color: Color.fromARGB(255, 171, 171, 171),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomPackageForm() {
    if (!isCustomPackageSelected) return const SizedBox.shrink();

    return GlassmorphicContainer(
        width: double.infinity,
        height: 220,
        borderRadius: 20,
        blur: 10,
        alignment: Alignment.center,
        border: 1,
        linearGradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 78, 77, 77).withOpacity(0.1),
            const Color.fromARGB(255, 105, 104, 104).withOpacity(0.05),
          ],
        ),
        borderGradient: LinearGradient(
          colors: [
            Primary_colors.Color3.withOpacity(0.9),
            Primary_colors.Color3.withOpacity(0.10),
          ],
        ),
        child: Container(
          // margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.all(10),
          // decoration: BoxDecoration(
          //   color: Primary_colors.Dark.withOpacity(0.7),
          //   borderRadius: BorderRadius.circular(8),
          // ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 15),
                _buildtextfieldRow(
                  'Camera Count',
                  customCameraCountController,
                  (value) => value?.isEmpty ?? true ? 'Please enter camera count' : null,
                ),
                const SizedBox(height: 5),
                _buildtextfieldRow(
                  'Package Amount',
                  customPackageAmountController,
                  (value) => value?.isEmpty ?? true ? 'Please enter package amount' : null,
                ),
                const SizedBox(height: 5),
                _buildtextfieldRow(
                  'Additional Charges',
                  customAdditionalChargesController,
                  (value) => value?.isEmpty ?? true ? 'Please enter additional charges' : null,
                ),
                const SizedBox(height: 5),
                _buildtextfieldRow(
                  'Description',
                  customDescriptionController,
                  (value) => value?.isEmpty ?? true ? 'Please enter description' : null,
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ));
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: const TextStyle(fontSize: Primary_font_size.Text6, color: Primary_colors.Color1
                  // fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Text(
            '   :   ',
            style: TextStyle(fontSize: Primary_font_size.Text6, color: Primary_colors.Color1
                // fontWeight: FontWeight.bold,
                ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: const TextStyle(fontSize: Primary_font_size.Text6, color: Primary_colors.Color4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildtextfieldRow(String label, TextEditingController controller, String? Function(String?)? validator) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: const TextStyle(fontSize: Primary_font_size.Text6, color: Primary_colors.Color1
                  // fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Text(
            '   :   ',
            style: TextStyle(fontSize: Primary_font_size.Text6, color: Primary_colors.Color1
                // fontWeight: FontWeight.bold,
                ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 30,
              child: TextFormField(
                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Color.fromARGB(255, 177, 177, 176)),
                  hintText: '',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 143, 140, 140)), // Change color as needed
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Primary_colors.Color3, width: 2.0), // Focused color
                  ),
                ),
                controller: controller,
                validator: validator,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
