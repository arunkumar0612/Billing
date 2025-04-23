// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/SUBSCRIPTION_Quote_actions.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/models/entities/SUBSCRIPTION_Quote_entities.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/services/Quotation_services/SUBSCRIPTION_QuotePackage_services.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/THEMES-/style.dart';
import 'package:glassmorphism/glassmorphism.dart';

class SUBSCRIPTION_QuotePackage extends StatefulWidget with SUBSCRIPTION_QuotepackageService {
  SUBSCRIPTION_QuotePackage({super.key});

  @override
  State<SUBSCRIPTION_QuotePackage> createState() => _SUBSCRIPTION_QuotePackageState();
}

class _SUBSCRIPTION_QuotePackageState extends State<SUBSCRIPTION_QuotePackage> with SingleTickerProviderStateMixin {
  final SUBSCRIPTION_QuoteController quoteController = Get.find<SUBSCRIPTION_QuoteController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final pendingSites = quoteController.quoteModel.QuoteSiteDetails.where((site) {
        return !quoteController.quoteModel.selectedPackages.any((pkg) => pkg.sites.any((pkgSite) => pkgSite.siteName == site.siteName));
      }).toList();
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Package Selection Dropdown
            _buildPackageDropdown(),
            const SizedBox(height: 16),

            // Main Content Area
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Column - Package Details/Custom Form
                  Expanded(
                    flex: 2,
                    child: _buildPackageContent(),
                  ),
                  const SizedBox(width: 16),

                  // Right Column - Pending Sites
                  pendingSites.isNotEmpty
                      ? Expanded(
                          flex: 1,
                          child: _buildPendingSitesSection(),
                        )
                      : const SizedBox.shrink(), // Add spacing only if there are pending sites
                ],
              ),
            ),

            // Bottom Section
            _buildBottomSection(),
          ],
        ),
      );
    });
  }

  Widget _buildPackageDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Primary_colors.Dark,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: DropdownButtonFormField<String>(
          menuMaxHeight: 400,
          style: const TextStyle(
            color: Primary_colors.Color1,
            fontWeight: FontWeight.w500,
            fontSize: Primary_font_size.Text10,
          ),
          value: quoteController.quoteModel.selectedPackage.value,
          decoration: InputDecoration(
            filled: true,
            fillColor: Primary_colors.Light,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Primary_colors.Color1,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            labelText: 'Choose the Package',
            labelStyle: const TextStyle(
              color: Color.fromARGB(255, 179, 178, 178),
              fontSize: Primary_font_size.Text8,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            prefixIcon: const Icon(
              Icons.subscriptions,
              color: Primary_colors.Color1,
            ),
          ),
          dropdownColor: Primary_colors.Dark,
          borderRadius: BorderRadius.circular(12),
          icon: const Icon(Icons.arrow_drop_down, color: Primary_colors.Color1),
          items: quoteController.quoteModel.packageList.map((String package) {
            return DropdownMenuItem<String>(
              value: package,
              child: Text(
                package,
                style: const TextStyle(fontSize: 16),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) async {
            if (newValue == null) return;

            // Update selected package value
            quoteController.quoteModel.selectedPackage.value = newValue;

            if (newValue != 'Custom Package') {
              final package = quoteController.quoteModel.packageDetails.firstWhere(
                (p) => p.name == newValue,
                // orElse: () => Package(), // Fallback empty package
              );

              // 1. Check for empty packages (packages with no sites)
              final emptyPackages = quoteController.quoteModel.selectedPackages.where((pkg) => pkg.sites.isEmpty).toList();

              // 2. Show replacement dialog if empty packages exist
              if (emptyPackages.isNotEmpty) {
                final shouldReplace = await Basic_dialog(
                      context: context,
                      title: 'Replace Empty Packages?',
                      content: 'The following packages have no sites assigned:\n'
                          '${emptyPackages.map((p) => p.name).join(', ')}\n'
                          'Would you like to replace them with "$newValue"?',
                      showCancel: true,
                    ) ??
                    false;

                if (shouldReplace) {
                  // Remove only empty packages
                  quoteController.quoteModel.selectedPackages.removeWhere((pkg) => pkg.sites.isEmpty);
                } else {
                  return; // User chose to keep empty packages
                }
              }

              // 3. Check for duplicate packages
              final existingIndex = quoteController.quoteModel.selectedPackages.indexWhere((p) => p.name == package.name);

              if (existingIndex != -1) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${package.name} package already exists'),
                    backgroundColor: Colors.blue,
                  ),
                );
                return;
              }

              // 4. Add the new package
              quoteController.quoteModel.selectedPackages.add(
                Package(
                  name: package.name,
                  description: package.description,
                  cameraCount: package.cameraCount,
                  amount: package.amount,
                  additionalCameras: package.additionalCameras,
                  show: package.show,
                  sites: [], // Start with empty sites
                ),
              );

              // 5. Show success feedback
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${package.name} added to packages'),
                  backgroundColor: Colors.green,
                ),
              );
            } else {
              // Handle Custom Package selection
              quoteController.quoteModel.customPackageCreated.value = false;
              widget.resetCustomPackageFields();
            }
          },
        ),
      ),
    );
  }

  Widget _buildPackageContent() {
    if (quoteController.quoteModel.selectedPackage.value == null) {
      return _buildPlaceholder();
    } else if (quoteController.quoteModel.selectedPackage.value == 'Custom Package') {
      return buildCustomPackageForm();
    } else {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: quoteController.quoteModel.selectedPackages.length,
              itemBuilder: (context, index) {
                return buildPackageDetails(quoteController.quoteModel.selectedPackages[index]);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget _buildPendingSitesSection() {
    return Obx(() {
      // Get all sites that aren't assigned to any package
      final pendingSites = quoteController.quoteModel.QuoteSiteDetails.where((site) {
        return !quoteController.quoteModel.selectedPackages.any((pkg) => pkg.sites.any((pkgSite) => pkgSite.siteName == site.siteName));
      }).toList();

      // Check if all sites are assigned
      // final allSitesAssigned = pendingSites.isEmpty;

      return Container(
        decoration: BoxDecoration(
          color: Primary_colors.Dark,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.3,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      'Pending Sites',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Primary_colors.Color1,
                            fontWeight: FontWeight.bold,
                            fontSize: Primary_font_size.Text10,
                          ),
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: pendingSites.isEmpty
                          ? Center(
                              child: Text(
                                'No pending sites',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: pendingSites.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Primary_colors.Light,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${index + 1} . ${pendingSites[index].siteName}',
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 181, 181, 181),
                                          fontSize: Primary_font_size.Text8,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildBottomSection() {
    return Column(
      children: [
        if (quoteController.quoteModel.selectedPackage.value != 'Custom Package')
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Need something different? Consider our Custom Package option',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BasicButton(
              colors: Colors.red,
              text: 'Back',
              onPressed: () {
                // quoteController.previousTab();
              },
            ),
            const SizedBox(width: 30),
            Obx(() {
              final hasPackages = quoteController.quoteModel.selectedPackages.isNotEmpty;
              return BasicButton(colors: hasPackages ? Colors.green : Colors.grey, text: 'Submit', onPressed: () {}
                  //  hasPackages
                  //     ? () {
                  //         quoteController.submitPackages();
                  //       }
                  //     : null,
                  );
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.subscriptions_outlined,
            size: 64,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'Select a package to view details',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Compare our plans or create your own custom solution',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildCustomPackageForm() {
    return Obx(() {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create Custom Package',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Primary_colors.Color3,
                    fontWeight: FontWeight.bold,
                    fontSize: Primary_font_size.Text8,
                  ),
            ),
            const SizedBox(height: 8),

            _buildCustomTextField(
              controller: quoteController.quoteModel.customNameControllers.value,
              label: 'Package Name',
              icon: Icons.badge_outlined,
            ),
            _buildCustomTextField(
              controller: quoteController.quoteModel.customCameraCountControllers.value,
              label: 'Camera Count',
              icon: Icons.videocam_outlined,
              isNumber: true,
            ),
            _buildCustomTextField(
              controller: quoteController.quoteModel.customAmountControllers.value,
              label: 'Package Amount',
              icon: Icons.attach_money_outlined,
              isNumber: true,
            ),
            _buildCustomTextField(
              controller: quoteController.quoteModel.customChargesControllers.value,
              label: 'Additional Camera',
              icon: Icons.money_off_csred_outlined,
              isNumber: true,
            ),

            // Show to all sites radio buttons
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  const Text(
                    'Show this to all sites:',
                    style: TextStyle(
                      fontSize: Primary_font_size.Text9,
                      color: Color.fromARGB(255, 202, 201, 201),
                    ),
                  ),
                  const SizedBox(width: 16),
                  _buildCustomRadio(
                    context,
                    title: 'Yes',
                    value: 'Company',
                    groupValue: quoteController.quoteModel.showto.value,
                  ),
                  const SizedBox(width: 16),
                  _buildCustomRadio(
                    context,
                    title: 'No',
                    value: 'Global',
                    groupValue: quoteController.quoteModel.showto.value,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            _buildCustomTextField(
              controller: quoteController.quoteModel.customDescControllers.value,
              label: 'Package Description',
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            BasicButton(
              colors: Primary_colors.Color3,
              text: 'Save Custom Package',
              onPressed: () {
                setState(() {
                  widget.saveCustomPackage(context);
                });
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String label,
    IconData? icon,
    bool isNumber = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        style: const TextStyle(
          fontSize: Primary_font_size.Text8,
          color: Primary_colors.Color1,
        ),
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 192, 187, 187),
          ),
          prefixIcon: icon != null ? Icon(icon, color: Primary_colors.Color1) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color.fromARGB(0, 224, 224, 224)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Primary_colors.Color1,
              width: 0.5,
            ),
          ),
          filled: true,
          fillColor: Primary_colors.Dark,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildCustomRadio(
    BuildContext context, {
    required String title,
    required String value,
    required String groupValue,
  }) {
    final bool isSelected = value == groupValue;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        quoteController.quoteModel.showto.value = value;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20,
              height: 20,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPackageDetails(Package package) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: GlassmorphicContainer(
          width: double.infinity,
          height: 260,
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
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 10),
                  const Expanded(
                    child: TabBar(
                      indicatorColor: Primary_colors.Color4,
                      tabs: [
                        Tab(text: 'Details'),
                        Tab(text: 'Sites'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            widget.removePackage(package, context);
                          });
                        }, // Pass the package directly
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildPackageDetailsTab(package.toJson()),
                    _buildPackageSitesTab(package.toJson()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPackageDetailsTab(Map<String, dynamic> details) {
    // Check if this is a custom package
    final isCustomPackage = quoteController.quoteModel.customPackage.value?.name == details['name'];
    final packageIndex = quoteController.quoteModel.selectedPackages.indexWhere((p) => p.name == details['name']);
    final package = quoteController.quoteModel.selectedPackages[packageIndex];

    // Initialize edit mode controller if not exists
    if (!package.editingMode.value) {
      package.editingMode.value = false;
      package.tempName.value = details['name'];
      package.tempCameraCount.value = details['camera_count'];
      package.tempAmount.value = details['amount'];
      package.tempAdditionalCameras.value = details['additional_cameras'];
      package.tempDescription.value = details['description'];
    }
    return Obx(() {
      return Column(
        children: [
          if (isCustomPackage && package.editingMode.value == false)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: OutlinedButton(
                    onPressed: () {
                      if (package.editingMode.value) {
                        // Cancel editing - reset temp values
                        package.tempName.value = details['name'];
                        package.tempCameraCount.value = details['camera_count'];
                        package.tempAmount.value = details['amount'];
                        package.tempAdditionalCameras.value = details['additional_cameras'];
                        package.tempDescription.value = details['description'];
                      }
                      package.editingMode.value = !package.editingMode.value;
                    },
                    child: const Text(
                      'Edit',
                      style: TextStyle(fontSize: Primary_font_size.Text10),
                    )),
              ),
            ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: isCustomPackage && package.editingMode.value == false ? 0 : 15),
                child: Stack(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '📷',
                              style: const TextStyle(fontSize: 15),
                            ),
                            const SizedBox(width: 10),
                            const SizedBox(
                              width: 150,
                              child: Text(
                                'Package Name',
                                style: TextStyle(
                                  fontSize: Primary_font_size.Text8,
                                  color: Primary_colors.Color3,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            isCustomPackage && package.editingMode.value
                                ? Expanded(
                                    child: TextField(
                                      controller: TextEditingController(text: package.tempName.value),
                                      onChanged: (value) => package.tempName.value = value,
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none,
                                      ),
                                      style: const TextStyle(
                                        fontSize: Primary_font_size.Text8,
                                        fontWeight: FontWeight.bold,
                                        color: Primary_colors.Color1,
                                      ),
                                    ),
                                  )
                                : Text(
                                    details['name']!,
                                    style: const TextStyle(
                                      fontSize: Primary_font_size.Text8,
                                      fontWeight: FontWeight.bold,
                                      color: Primary_colors.Color1,
                                    ),
                                  ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildDetailRow(
                          icon: Icons.videocam_outlined,
                          title: 'Camera Count',
                          value: package.editingMode.value ? package.tempCameraCount.value : details['camera_count']!,
                          isEditable: isCustomPackage && package.editingMode.value,
                          onChanged: (value) => package.tempCameraCount.value = value,
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow(
                          icon: Icons.attach_money_outlined,
                          title: 'Package Amount',
                          value: package.editingMode.value ? package.tempAmount.value : details['amount']!,
                          isEditable: isCustomPackage && package.editingMode.value,
                          onChanged: (value) => package.tempAmount.value = value,
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow(
                          icon: Icons.money_off_csred_outlined,
                          title: 'Additional Camera',
                          value: package.editingMode.value ? package.tempAdditionalCameras.value : details['additional_cameras']!,
                          isEditable: isCustomPackage && package.editingMode.value,
                          onChanged: (value) => package.tempAdditionalCameras.value = value,
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow(
                          icon: Icons.description_outlined,
                          title: 'Description',
                          value: package.editingMode.value ? package.tempDescription.value : details['description']!,
                          isEditable: isCustomPackage && package.editingMode.value,
                          onChanged: (value) => package.tempDescription.value = value,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isCustomPackage && package.editingMode.value) ...[
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                    child: TextButton(
                      onPressed: () {
                        // Cancel editing
                        package.editingMode.value = false;
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    height: 20,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          package.name = package.tempName.value;
                          package.cameraCount = package.tempCameraCount.value;
                          package.amount = package.tempAmount.value;
                          package.additionalCameras = package.tempAdditionalCameras.value;
                          package.description = package.tempDescription.value;
                          package.editingMode.value = false;

                          // Update the custom package reference
                          if (quoteController.quoteModel.customPackage.value != null) {
                            quoteController.quoteModel.customPackage.value = package;
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Package updated successfully'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        });
                        // Save changes
                      },
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ],
      );
    });
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String value,
    bool isEditable = false,
    Function(String)? onChanged,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Primary_colors.Color1),
        const SizedBox(width: 12),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 150,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: Primary_font_size.Text8,
                    color: Primary_colors.Color3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              isEditable
                  ? Expanded(
                      child: TextField(
                        controller: TextEditingController(text: value),
                        onChanged: onChanged,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontSize: Primary_font_size.Text8,
                          color: Color.fromARGB(255, 198, 197, 197),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: Primary_font_size.Text8,
                        color: Color.fromARGB(255, 198, 197, 197),
                      ),
                    )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPackageSitesTab(Map<String, dynamic> details) {
    final packageIndex = quoteController.quoteModel.selectedPackages.indexWhere((p) => p.name == details['name']);
    final package = quoteController.quoteModel.selectedPackages[packageIndex];

    return Obx(() {
      // Get all available sites that aren't already assigned to other packages
      final availableSites = quoteController.quoteModel.QuoteSiteDetails.where((site) {
        final isAssignedToAnyPackage = quoteController.quoteModel.selectedPackages.any((p) => p.sites.any((s) => s.siteName == site.siteName));
        return !isAssignedToAnyPackage;
      }).toList();

      return Column(
        children: [
          if (!package.showSiteList.value)
            Expanded(
              child: Column(
                children: [
                  if (package.sites.isEmpty)
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 48,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No sites selected',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextButton.icon(
                              icon: const Icon(Icons.add, size: 18),
                              label: const Text('Add Site'),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.blue,
                              ),
                              onPressed: () {
                                package.showSiteList.value = true;
                                package.selectedIndices.value = package.sites.map((site) => availableSites.indexWhere((s) => s.siteName == site.siteName)).where((index) => index != -1).toList();
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              icon: const Icon(Icons.add, size: 18),
                              label: const Text('Add Site'),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.blue,
                              ),
                              onPressed: () {
                                package.showSiteList.value = true;
                                package.selectedIndices.clear();
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(0, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ListView.builder(
                                  itemCount: package.sites.length,
                                  itemBuilder: (context, index) {
                                    final site = package.sites[index];
                                    return AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      curve: Curves.easeInOut,
                                      child: ListTile(
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 0),
                                        leading: Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Primary_colors.Color1.withOpacity(0.1),
                                          ),
                                          child: const Icon(
                                            Icons.location_on,
                                            size: 16,
                                            color: Primary_colors.Color1,
                                          ),
                                        ),
                                        title: Text(
                                          site.siteName,
                                          style: const TextStyle(fontWeight: FontWeight.w500, color: Primary_colors.Color1, fontSize: Primary_font_size.Text8),
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.grey[500],
                                            size: 18,
                                          ),
                                          onPressed: () {
                                            setState(
                                              () {
                                                package.sites.removeAt(index);
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          if (package.showSiteList.value)
            Expanded(
              child: availableSites.isNotEmpty
                  ? Column(
                      children: [
                        // Add Select All/Deselect All button row
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Select Sites',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[300],
                                ),
                              ),
                              Obx(() {
                                final allSelected = package.selectedIndices.length == availableSites.length;
                                return TextButton(
                                  onPressed: () {
                                    if (allSelected) {
                                      package.selectedIndices.clear();
                                    } else {
                                      package.selectedIndices.value = List<int>.generate(availableSites.length, (index) => index);
                                    }
                                  },
                                  child: Text(
                                    allSelected ? 'Deselect All' : 'Select All',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: availableSites.length,
                              itemBuilder: (context, index) {
                                final site = availableSites[index];
                                return Obx(() {
                                  return CheckboxListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6), // Slightly more rounded
                                    ),
                                    checkColor: Colors.white, // Color of the check icon
                                    activeColor: Colors.green.shade600, // Backgro7und when selected
                                    side: const BorderSide(
                                      color: Colors.grey, // Border color when not selected
                                      width: 1.5,
                                    ),
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: VisualDensity.compact,
                                    title: Text(
                                      site.siteName,
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 221, 220, 220),
                                        fontSize: Primary_font_size.Text8,
                                      ),
                                    ),
                                    value: package.selectedIndices.contains(index),
                                    onChanged: (bool? selected) {
                                      if (selected == true) {
                                        package.selectedIndices.add(index);
                                      } else {
                                        package.selectedIndices.remove(index);
                                      }
                                    },
                                  );
                                });
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    package.showSiteList.value = false;
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    // Update the package with selected sites
                                    package.sites = package.selectedIndices.map((index) => availableSites[index]).toList();
                                    package.showSiteList.value = false;
                                    setState(() {});
                                  },
                                  child: const Text(
                                    'Save Selection',
                                    style: TextStyle(color: Color.fromARGB(255, 58, 162, 248)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "There is no available sites",
                          style: TextStyle(
                            color: Color.fromARGB(255, 160, 160, 160),
                            fontSize: Primary_font_size.Text8,
                          ),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            package.showSiteList.value = false;
                          },
                          child: const Text(
                            'click to go back',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
            )
        ],
      );
    });
  }
}
