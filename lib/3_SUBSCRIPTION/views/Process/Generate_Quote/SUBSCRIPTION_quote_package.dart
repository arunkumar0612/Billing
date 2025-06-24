// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/controllers/SUBSCRIPTION_Quote_actions.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/models/entities/SUBSCRIPTION_Quote_entities.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/services/Quotation_services/SUBSCRIPTION_QuotePackage_services.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/THEMES/style.dart';

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
  Widget build(BuildContext context) {
    return Obx(() {
      final pendingSites = quoteController.quoteModel.QuoteSiteDetails.where((site) {
        return !quoteController.quoteModel.selectedPackagesList.any((pkg) => pkg.sites.any((pkgSite) => pkgSite.sitename == site.sitename));
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
                color: Primary_colors.Light,
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
              final emptyPackages = quoteController.quoteModel.selectedPackagesList.where((pkg) => pkg.sites.isEmpty).toList();

              // 2. Show replacement dialog if empty packages exist
              if (emptyPackages.isNotEmpty) {
                final shouldReplace = await Warning_dialog(
                      context: context,
                      title: 'Replace Empty Packages?',
                      content: 'The following packages have no sites assigned:\n'
                          '${emptyPackages.map((p) => p.name).join(', ')}\n'
                          'Would you like to replace them with "$newValue"?',
                      // showCancel: true,
                    ) ??
                    false;

                if (shouldReplace) {
                  // Remove only empty packages
                  quoteController.quoteModel.selectedPackagesList.removeWhere((pkg) => pkg.sites.isEmpty);
                } else {
                  return; // User chose to keep empty packages
                }
              }

              // 3. Check for duplicate packages
              final existingIndex = quoteController.quoteModel.selectedPackagesList.indexWhere((p) => p.name == package.name);

              if (existingIndex != -1) {
                Error_SnackBar(
                  context,
                  '${package.name} package already exists',
                );

                return;
              }

              // 4. Add the new package
              quoteController.quoteModel.selectedPackagesList.add(
                Package(
                  name: package.name,
                  subscriptionid: package.subscriptionid,
                  description: package.description,
                  cameracount: package.cameracount,
                  amount: package.amount,
                  // additionalCameras: package.additionalCameras,
                  subscriptiontype: package.subscriptiontype,
                  sites: [], // Start with empty sites
                ),
              );

              // 5. Show success feedback
              // Error_SnackBar(
              //   context,
              //   '${package.name} added to packages',
              // );
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
              itemCount: quoteController.quoteModel.selectedPackagesList.length,
              itemBuilder: (context, index) {
                return buildPackageDetails(quoteController.quoteModel.selectedPackagesList[index], index);
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
        return !quoteController.quoteModel.selectedPackagesList.any((pkg) => pkg.sites.any((pkgSite) => pkgSite.sitename == site.sitename));
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
                                        '${index + 1} . ${pendingSites[index].sitename}',
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
                quoteController.quoteModel.selectedPackagesList.clear();
                quoteController.quoteModel.selectedPackage.value = null;
                quoteController.backTab();
              },
            ),
            const SizedBox(width: 30),
            Obx(() {
              final pendingSites = quoteController.quoteModel.QuoteSiteDetails.where((site) {
                return !quoteController.quoteModel.selectedPackagesList.any((pkg) => pkg.sites.any((pkgSite) => pkgSite.sitename == site.sitename));
              }).toList();
              final hasPackages = quoteController.quoteModel.selectedPackagesList.isNotEmpty && pendingSites.isEmpty;
              return BasicButton(
                  colors: hasPackages ? Colors.green : Colors.grey,
                  text: 'Submit',
                  onPressed: () {
                    if (hasPackages) {
                      quoteController.nextTab();
                    } else {
                      Get.snackbar("WARNING", "Please ensure the all sites have mapped to packages!");
                    }

                    // print(quoteController.quoteModel.selectedPackagesList[0].sites[0].mailType);
                  }
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
            // _buildCustomTextField(
            //   controller: quoteController.quoteModel.customChargesControllers.value,
            //   label: 'Additional Camera',
            //   icon: Icons.money_off_csred_outlined,
            //   isNumber: true,
            // ),

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
                    value: 'company',
                    groupValue: quoteController.quoteModel.subscriptiontype.value,
                  ),
                  const SizedBox(width: 16),
                  _buildCustomRadio(
                    context,
                    title: 'No',
                    value: 'current',
                    groupValue: quoteController.quoteModel.subscriptiontype.value,
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
        inputFormatters: isNumber ? [FilteringTextInputFormatter.digitsOnly] : null,
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
        quoteController.quoteModel.subscriptiontype.value = value;
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

  Widget buildPackageDetails(Package package, int index) {
    // Get gradient based on index (cycles through available gradients)
    final gradient = packageGradients[index % packageGradients.length];

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
          border: 2,
          linearGradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 78, 77, 77).withOpacity(0.1),
              const Color.fromARGB(255, 105, 104, 104).withOpacity(0.05),
            ],
          ),
          borderGradient: gradient, // Apply the selected gradient
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
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildPackageDetailsTab(package),
                    _buildPackageSitesTab(package),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPackageDetailsTab(Package details) {
    final isCustomPackage = quoteController.quoteModel.customPackage.value?.name == details.name;
    final packageIndex = quoteController.quoteModel.selectedPackagesList.indexWhere((p) => p.name == details.name);
    final package = quoteController.quoteModel.selectedPackagesList[packageIndex];

    return Column(
      children: [
        // Edit button - only for custom packages not in edit mode
        if (isCustomPackage)
          Obx(() {
            if (!package.editingMode.value) {
              return Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: OutlinedButton(
                    onPressed: () {
                      package.editingMode.value = true;
                      // package.nameController?.text = details.name;
                      // package.cameraCountController?.text = details.cameracount;
                      // package.amountController?.text = details.amount;
                      // package.descriptionController?.text = details.description;
                    },
                    child: const Text(
                      'Edit',
                      style: TextStyle(fontSize: Primary_font_size.Text10),
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          }),

        // Main content
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
              ),
              child: Obx(() {
                return Column(
                  children: [
                    // Package Name Row
                    // Row(
                    //   children: [
                    //     const Text('📷', style: TextStyle(fontSize: 15)),
                    //     const SizedBox(width: 10),
                    //     const SizedBox(
                    //       width: 150,
                    //       child: Text(
                    //         'Package Name',
                    //         style: TextStyle(
                    //           fontSize: Primary_font_size.Text8,
                    //           color: Primary_colors.Color3,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //     ),
                    //     if (package.editingMode.value)
                    //       Expanded(
                    //         child: TextField(
                    //           controller: package.nameController,
                    //           decoration: const InputDecoration(
                    //             isDense: true,
                    //             contentPadding: EdgeInsets.zero,
                    //             border: InputBorder.none,
                    //           ),
                    //           style: const TextStyle(
                    //             fontSize: Primary_font_size.Text8,
                    //             fontWeight: FontWeight.bold,
                    //             color: Primary_colors.Color1,
                    //           ),
                    //         ),
                    //       )
                    //     else
                    //       Text(
                    //         details.name,
                    //         style: const TextStyle(
                    //           fontSize: Primary_font_size.Text8,
                    //           fontWeight: FontWeight.bold,
                    //           color: Primary_colors.Color1,
                    //         ),
                    //       ),
                    //   ],
                    // ),
                    _buildDetailRow(
                      icon: Icons.camera_alt_outlined,
                      title: 'Package Name',
                      controller: package.nameController!,
                      isEditable: package.editingMode.value,
                    ),
                    const SizedBox(height: 12),

                    // Other fields
                    _buildDetailRow(
                      icon: Icons.videocam_outlined,
                      title: 'Camera Count',
                      controller: package.cameraCountController!,
                      isEditable: package.editingMode.value,
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      icon: Icons.attach_money_outlined,
                      title: 'Package Amount',
                      controller: package.amountController!,
                      isEditable: package.editingMode.value,
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      icon: Icons.description_outlined,
                      title: 'Description',
                      controller: package.descriptionController!,
                      isEditable: package.editingMode.value,
                    ),
                    if (package.editingMode.value)
                      Column(
                        children: [
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  package.cancelEditing();
                                  package.editingMode.value = false;
                                },
                                child: const Text('Cancel'),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                onPressed: () {
                                  package.saveChanges();
                                  if (quoteController.quoteModel.customPackage.value != null) {
                                    quoteController.quoteModel.customPackage.value = package;
                                  }
                                  Error_SnackBar(
                                    context,
                                    'Package updated successfully',
                                  );
                                  package.editingMode.value = false;
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                  ],
                );
              }),
            ),
          ),
        ),

        // Save/Cancel buttons
        // if (isCustomPackage)
        //   Obx(() {
        //     return const SizedBox.shrink();
        //   }),
      ],
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required TextEditingController controller,
    bool isEditable = false,
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
              Expanded(
                  child: isEditable
                      ? TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: Primary_font_size.Text8,
                            color: Color.fromARGB(255, 198, 197, 197),
                          ),
                        )
                      : Text(
                          controller.text,
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

  Widget _buildPackageSitesTab(Package details) {
    final packageIndex = quoteController.quoteModel.selectedPackagesList.indexWhere((p) => p.name == details.name);
    final package = quoteController.quoteModel.selectedPackagesList[packageIndex];

    return Obx(() {
      // Get all available sites that aren't already assigned to other packages
      final availableSites = quoteController.quoteModel.QuoteSiteDetails.where((site) {
        final isAssignedToAnyPackage = quoteController.quoteModel.selectedPackagesList.any((p) => p.sites.any((s) => s.sitename == site.sitename));
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
                                package.selectedIndices.value = package.sites.map((site) => availableSites.indexWhere((s) => s.sitename == site.sitename)).where((index) => index != -1).toList();
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
                                          site.sitename,
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
                                      site.sitename,
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
                                    if (package.selectedIndices.isNotEmpty) {
                                      // Get the newly selected sites
                                      final newSites = package.selectedIndices.map((index) => availableSites[index]).toList();

                                      // Combine with existing sites, avoiding duplicates
                                      final updatedSites = {...package.sites, ...newSites}.toList();

                                      // Update the package
                                      package.sites = updatedSites;
                                      package.selectedIndices.clear(); // Clear selection
                                      package.showSiteList.value = false;

                                      setState(() {});
                                      Success_SnackBar(context, 'Sites added successfully');
                                    } else {
                                      Error_SnackBar(context, 'Please select at least one site');
                                    }
                                  },
                                  child: const Text(
                                    'Add Selected Sites',
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
