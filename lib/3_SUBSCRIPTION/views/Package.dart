// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/controllers/Subscription_actions.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/services/subscription_service.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/THEMES/style.dart';

class Packagepage extends StatefulWidget with SubscriptionServices {
  Packagepage({super.key});

  @override
  State<Packagepage> createState() => _PackagepageState();
}

// SubscriptionCard widget
class _PackagepageState extends State<Packagepage> {
  final SubscriptionController subscriptionController = Get.find<SubscriptionController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(
      () {
        final selectedCount = subscriptionController.subscriptionModel.selectedPackagessubscriptionID.length;
        final totalCount = subscriptionController.subscriptionModel.GlobalPackage.value.globalPackageList.length;
        final allSelected = selectedCount == totalCount && totalCount > 0;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
          ),
          child: Stack(
            children: [
              // Background gradient
              // This container creates a gradient background for the entire page
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 15, 22, 46),
                      Color.fromARGB(255, 31, 45, 95),
                      Color.fromARGB(255, 56, 66, 103),
                    ],
                  ),
                ),
              ),

              // Content
              SafeArea(
                child: Column(
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Global Packages',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Primary_font_size.Heading,
                              letterSpacing: 1.2,
                            ),
                          ), // In your Packagepage build method, add this below the header Row:// Add this after the header Row
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                height: 40,
                                width: 600,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(0, 255, 255, 255).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                child: TextField(
                                  controller: subscriptionController.subscriptionModel.packageSearchController.value,
                                  onChanged: (value) => subscriptionController.filterPackages(value),
                                  style: const TextStyle(color: Colors.white, fontSize: Primary_font_size.Text8),
                                  decoration: InputDecoration(
                                    hintText: 'Search packages...',
                                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: Primary_font_size.Text8, letterSpacing: 1),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          // Action buttons
                          Row(
                            children: [
                              if (selectedCount > 0)
                                SizedBox(
                                  height: 33,
                                  child: FloatingActionButton.extended(
                                    onPressed: () {
                                      Warning_dialog(
                                        context: context,
                                        title: 'Confirmation',
                                        content: 'Are you sure you want to delete this package?',
                                        onOk: () {
                                          widget.DeleteGlobalPackage(context, subscriptionController.subscriptionModel.selectedPackagessubscriptionID).then((_) {
                                            // Clear selection after deletion
                                            subscriptionController.subscriptionModel.selectedPackagessubscriptionID.clear();
                                            // Reset search if needed
                                            if (subscriptionController.subscriptionModel.isSearchingPackages.value) {
                                              subscriptionController.subscriptionModel.packageSearchController.value.clear();
                                              subscriptionController.filterPackages('');
                                            }
                                          });
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 15,
                                    ),
                                    label: const Text(
                                      'Delete',
                                      style: TextStyle(fontSize: Primary_font_size.Text6),
                                    ),
                                    backgroundColor: const Color.fromARGB(255, 251, 90, 78),
                                    elevation: 4,
                                  ),
                                ),
                              if (selectedCount > 0) const SizedBox(width: 30),
                              // Add new package button
                              SizedBox(
                                height: 33,
                                child: FloatingActionButton.extended(
                                  onPressed: () {
                                    _showAddSubscriptionDialog();
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    size: 15,
                                  ),
                                  label: const Text(
                                    'New Package',
                                    style: TextStyle(fontSize: Primary_font_size.Text6),
                                  ),
                                  backgroundColor: Colors.blueAccent,
                                  elevation: 4,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Main content
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Subscription list (left panel)
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Column(
                              children: [
                                // Select all checkbox
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      // color: Colors.white.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Select all checkbox and count display
                                        Row(
                                          children: [
                                            Transform.scale(
                                              scale: 1.2,
                                              child: Checkbox(
                                                value: allSelected,
                                                onChanged: (value) {
                                                  final select = value ?? false;
                                                  if (subscriptionController.subscriptionModel.isSearchingPackages.value) {
                                                    // Handle select all for search results
                                                    if (select) {
                                                      subscriptionController.subscriptionModel.selectedPackagessubscriptionID.addAll(
                                                        subscriptionController.subscriptionModel.filteredPackages.map((p) => p.subscriptionId).whereType<int>(),
                                                      );
                                                    } else {
                                                      // Only remove items that are in the current search results
                                                      subscriptionController.subscriptionModel.selectedPackagessubscriptionID.removeWhere(
                                                        (id) => subscriptionController.subscriptionModel.filteredPackages.any((p) => p.subscriptionId == id),
                                                      );
                                                    }
                                                  } else {
                                                    _toggleSelectAll(select);
                                                  }
                                                },
                                                activeColor: Colors.blueAccent,
                                                fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                                                  if (states.contains(MaterialState.selected)) {
                                                    return Colors.blueAccent; // Color when checked
                                                  }
                                                  return Colors.white; // Transparent when unchecked
                                                }),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                // ... rest of your checkbox properties
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              'Select All Packages',
                                              style: theme.textTheme.bodyLarge?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Count display
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              subscriptionController.subscriptionModel.isSearchingPackages.value
                                                  ? 'Found: ${subscriptionController.subscriptionModel.filteredPackages.length} Packages | Selected: $selectedCount'
                                                  : 'Total: $totalCount Packages | Selected: $selectedCount',
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: Primary_font_size.Text8, letterSpacing: 1.0, overflow: TextOverflow.ellipsis),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // Subscription list
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 24.0, right: 24.0, bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: subscriptionController.subscriptionModel.GlobalPackage.value.globalPackageList.isEmpty
                                        ? Center(
                                            child: Stack(
                                              alignment: Alignment.topCenter,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 0),
                                                  child: Lottie.asset(
                                                    'assets/animations/JSON/emptysubscriptionlist.json',
                                                    // width: 264,
                                                    height: 250,
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(top: 194),
                                                  child: Text(
                                                    'No packages available',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color.fromARGB(255, 101, 110, 114),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 234),
                                                  child: Text(
                                                    'When you add a packages, it will appear here',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.blueGrey[400],
                                                      height: 1.4,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : ListView.builder(
                                            itemCount: subscriptionController.subscriptionModel.isSearchingPackages.value
                                                ? subscriptionController.subscriptionModel.filteredPackages.length
                                                : subscriptionController.subscriptionModel.GlobalPackage.value.globalPackageList.length,
                                            itemBuilder: (context, index) {
                                              final package = subscriptionController.subscriptionModel.isSearchingPackages.value
                                                  ? subscriptionController.subscriptionModel.filteredPackages[index]
                                                  : subscriptionController.subscriptionModel.GlobalPackage.value.globalPackageList[index];

                                              final isChecked = subscriptionController.subscriptionModel.selectedPackagessubscriptionID.contains(package.subscriptionId);
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                child: _SubscriptionCard(
                                                  package: package,
                                                  isSelected: subscriptionController.subscriptionModel.packageselectedID.value == package.subscriptionId,
                                                  isChecked: isChecked,
                                                  onChecked: (value) {
                                                    _handlePackageSelection(package.subscriptionId, value);
                                                  },
                                                  onTap: () {
                                                    subscriptionController.subscriptionModel.packageselectedID.value = package.subscriptionId;
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          // Vertical divider
                          Container(
                            width: 1,
                            margin: const EdgeInsets.symmetric(vertical: 24),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.white.withOpacity(0.2),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                          // Details panel (right panel)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              child: subscriptionController.subscriptionModel.packageselectedID.value != null &&
                                      subscriptionController.subscriptionModel.GlobalPackage.value.globalPackageList
                                          .any((p) => p.subscriptionId == subscriptionController.subscriptionModel.packageselectedID.value)
                                  ? _buildDetailsPanel(subscriptionController.subscriptionModel.GlobalPackage.value.globalPackageList
                                      .firstWhere((p) => p.subscriptionId == subscriptionController.subscriptionModel.packageselectedID.value))
                                  : Center(
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 50),
                                            child: Lottie.asset(
                                              'assets/animations/JSON/packageview.json',
                                              height: 250,
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(top: 244),
                                            child: Text(
                                              'Select a package to view',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromARGB(255, 101, 110, 114),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 274),
                                            child: Text(
                                              'Once selected, package details will appear here.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.blueGrey[400],
                                                height: 1.4,
                                              ),
                                            ),
                                          ),
                                        ],
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
            ],
          ),
        );
      },
    );
  }

// SubscriptionCard widget
  void _toggleSelectAll(bool select) {
    final controller = subscriptionController.subscriptionModel;
    if (select) {
      controller.selectedPackagessubscriptionID.addAll(
        controller.GlobalPackage.value.globalPackageList.map((p) => p.subscriptionId).whereType<int>(),
      );
    } else {
      controller.selectedPackagessubscriptionID.clear();
    }
  }

// SubscriptionCard widget
  void _handlePackageSelection(int? packageID, bool isSelected) {
    if (packageID == null) return;

    final currentList = subscriptionController.subscriptionModel.GlobalPackage.value.globalPackageList;
    if (currentList.isEmpty) return;

    final controller = subscriptionController.subscriptionModel;
    if (isSelected) {
      controller.selectedPackagessubscriptionID.add(packageID);
    } else {
      controller.selectedPackagessubscriptionID.remove(packageID);
    }
  }

// In your SubscriptionController

  void _showAddSubscriptionDialog() {
    // Create local error state trackers
    final errorState = {
      'name': false,
      'amount': false,
      'devices': false,
      'cameras': false,
      'additionalCameras': false,
      'description': false,
    }.obs;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Obx(() => Dialog(
                  backgroundColor: Colors.transparent,
                  insetPadding: const EdgeInsets.all(20),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    constraints: const BoxConstraints(maxWidth: 600),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 31, 45, 95),
                          Color.fromARGB(255, 15, 22, 46),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Create New Package',
                                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Heading),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close, color: Colors.white70, size: 28),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Package Name
                            buildInputField(
                              'Package Name',
                              1,
                              'Enter package name',
                              subscriptionController.subscriptionModel.packagenameController.value,
                              hasError: errorState['name']!,
                              onChanged: (value) {
                                errorState['name'] = value.isEmpty;
                                errorState.refresh();
                              },
                            ),

                            // Amount
                            buildInputField(
                              'Amount',
                              1,
                              'Enter amount',
                              subscriptionController.subscriptionModel.packageamountController.value,
                              keyboardType: TextInputType.number,
                              hasError: errorState['amount']!,
                              onChanged: (value) {
                                final amount = double.tryParse(value) ?? 0;
                                errorState['amount'] = value.isEmpty || amount <= 0;
                                errorState.refresh();
                              },
                            ),

                            // Number of Devices
                            buildInputField(
                              'Number of Devices',
                              1,
                              'Enter number of devices',
                              subscriptionController.subscriptionModel.packagedevicesController.value,
                              keyboardType: TextInputType.number,
                              hasError: errorState['devices']!,
                              onChanged: (value) {
                                final devices = int.tryParse(value) ?? 0;
                                errorState['devices'] = value.isEmpty || devices <= 0;
                                errorState.refresh();
                              },
                            ),

                            // Number of Cameras
                            buildInputField(
                              'Number of Cameras',
                              1,
                              'Enter number of cameras',
                              subscriptionController.subscriptionModel.packagecamerasController.value,
                              keyboardType: TextInputType.number,
                              hasError: errorState['cameras']!,
                              onChanged: (value) {
                                final cameras = int.tryParse(value) ?? 0;
                                errorState['cameras'] = value.isEmpty || cameras <= 0;
                                errorState.refresh();
                              },
                            ),

                            // Additional Cameras
                            buildInputField(
                              'Additional Cameras',
                              1,
                              'Additional Cameras',
                              subscriptionController.subscriptionModel.packageadditionalcamerasController.value,
                              keyboardType: TextInputType.number,
                              hasError: errorState['additionalCameras']!,
                              onChanged: (value) {
                                final additionalCameras = int.tryParse(value) ?? 0;
                                errorState['additionalCameras'] = value.isEmpty || additionalCameras <= 0;
                                errorState.refresh();
                              },
                            ),

                            // Description
                            buildInputField(
                              'Description',
                              3,
                              'Enter Description',
                              subscriptionController.subscriptionModel.packagedescController.value,
                              hasError: errorState['description']!,
                              onChanged: (value) {
                                errorState['description'] = value.isEmpty;
                                errorState.refresh();
                              },
                            ),
                            const SizedBox(height: 32),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                  elevation: 5,
                                ),
                                onPressed: () {
                                  // Validate fields
                                  final name = subscriptionController.subscriptionModel.packagenameController.value.text;
                                  final amount = double.tryParse(subscriptionController.subscriptionModel.packageamountController.value.text) ?? 0;
                                  final devices = int.tryParse(subscriptionController.subscriptionModel.packagedevicesController.value.text) ?? 0;
                                  final cameras = int.tryParse(subscriptionController.subscriptionModel.packagecamerasController.value.text) ?? 0;
                                  final additionalCameras = int.tryParse(subscriptionController.subscriptionModel.packageadditionalcamerasController.value.text) ?? 0;
                                  final desc = subscriptionController.subscriptionModel.packagedescController.value.text;

                                  // Update error states
                                  errorState['name'] = name.isEmpty;
                                  errorState['amount'] = amount <= 0;
                                  errorState['devices'] = devices <= 0;
                                  errorState['cameras'] = cameras <= 0;
                                  errorState['additionalCameras'] = additionalCameras <= 0;
                                  errorState['description'] = desc.isEmpty;
                                  errorState.refresh();

                                  // Check if any errors exist
                                  final hasErrors = errorState.values.any((error) => error);

                                  if (hasErrors) {
                                    return; // Don't proceed if there are errors
                                  }
                                  widget.CreateGlobalPackage(
                                    context,
                                    subscriptionController.subscriptionModel.packagenameController.value.text,
                                    int.tryParse(subscriptionController.subscriptionModel.packagedevicesController.value.text) ?? 0,
                                    int.tryParse(subscriptionController.subscriptionModel.packagecamerasController.value.text) ?? 0,
                                    int.tryParse(subscriptionController.subscriptionModel.packageadditionalcamerasController.value.text) ?? 0,
                                    int.tryParse(subscriptionController.subscriptionModel.packageamountController.value.text) ?? 0,
                                    subscriptionController.subscriptionModel.packagedescController.value.text,
                                    null,
                                    null,
                                  );
                                  // Save logic here
                                  // Navigator.pop(context);

                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   SnackBar(
                                  //     content: Text('"$name" package created successfully!'),
                                  //     backgroundColor: Colors.green,
                                  //   ),
                                  // );
                                },
                                child: const Text(
                                  'CREATE PACKAGE',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          },
        );
      },
    );
  }

// Helper method to build input fields
  Widget buildInputField(
    String label,
    int line,
    String hint,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    bool hasError = false,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Primary_font_size.Text8,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: hasError ? Border.all(color: Colors.red, width: 1.5) : null,
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(color: Colors.white, fontSize: Primary_font_size.Text8),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white54, fontSize: Primary_font_size.Text8),
              errorStyle: const TextStyle(height: 0), // Hide default error text
            ),
            maxLines: line,
            onChanged: onChanged,
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 4),
          Text(
            'This field is required',
            style: TextStyle(
              color: Colors.red[300],
              fontSize: 12,
            ),
          ),
        ],
        const SizedBox(height: 16),
      ],
    );
  }

// Build the details panel for the selected package
  Widget _buildDetailsPanel(dynamic package) {
    final theme = Theme.of(context);

    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(tabs: [
              Tab(text: 'Details'),
              Tab(text: 'Clients'),
            ]),
            const SizedBox(height: 25),
            Expanded(
              child: TabBarView(
                children: [
                  subscriptionController.subscriptionModel.packageisEditing.value && subscriptionController.subscriptionModel.editingPackage.value == package
                      ? _buildEditPanel(package)
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                package.subscriptionName ?? 'No Name',
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Primary_font_size.Heading,
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Price and duration
                              Text(
                                '₹ ${package.amount?.toStringAsFixed(2)} / 1 Month',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                  fontWeight: FontWeight.bold,
                                  fontSize: Primary_font_size.Text10,
                                ),
                              ),
                              const SizedBox(height: 34),

                              // Features
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PLAN BENEFITS',
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 1.5,
                                      fontSize: Primary_font_size.Text8,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  _buildFeatureItem('Enjoy full access and control from ${package.noOfDevices} devices.'),
                                  _buildFeatureItem('Monitor ${package.noOfCameras} cameras simultaneously with HD streaming and smart alerts.'),
                                  if (package.addlCameras != null && package.addlCameras! > 0)
                                    _buildFeatureItem('Expand your coverage with support for ${package.addlCameras} cameras for large-scale surveillance.'),
                                  _buildFeatureItem('Early access to new releases.'),
                                  _buildFeatureItem('Cancel anytime with no fees.'),
                                  const SizedBox(height: 25),
                                  Text(
                                    'DESCRIPTION',
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  if (package.productDesc != null && package.productDesc!.isNotEmpty)
                                    Text(
                                      package.productDesc!,
                                      style: theme.textTheme.bodyLarge?.copyWith(
                                        color: Colors.white70,
                                        height: 1.6,
                                        fontSize: Primary_font_size.Text8,
                                      ),
                                    ),
                                  const SizedBox(height: 25),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(vertical: 18),
                                        backgroundColor: Primary_colors.Color3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        elevation: 5,
                                        shadowColor: Primary_colors.Color3.withOpacity(0.5),
                                      ),
                                      onPressed: () {
                                        subscriptionController.subscriptionModel.packageisEditing.value = true;
                                        subscriptionController.subscriptionModel.editingPackage.value = package;
                                        subscriptionController.subscriptionModel.editpackagenameController.value.clear();
                                        subscriptionController.subscriptionModel.editpackageamountController.value.clear();
                                        subscriptionController.subscriptionModel.editpackagedevicesController.value.clear();
                                        subscriptionController.subscriptionModel.editpackagecamerasController.value.clear();
                                        subscriptionController.subscriptionModel.editpackageadditionalcamerasController.value.clear();
                                        subscriptionController.subscriptionModel.editpackagedescController.value.clear();
                                        // Clear controllers to prepare for new values
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.edit, color: Colors.white),
                                          const SizedBox(width: 8),
                                          Text(
                                            'EDIT SUBSCRIPTION',
                                            style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.2, fontSize: Primary_font_size.Text8),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  // Changes notice
                                  Center(
                                    child: Text(
                                      subscriptionController.subscriptionModel.packageisEditing.value ? 'Edit the subscription details' : 'Changes will be applied immediately',
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: Colors.white54,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Sites
                              // In your _buildDetailsPanel method, update the sites section to:
                            ],
                          ),
                        ),
                  package.siteDetails != null && package.siteDetails!.isNotEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: package.siteDetails!.length,
                                    itemBuilder: (context, index) {
                                      final site = package.siteDetails![index];
                                      return Container(
                                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.05),
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.2),
                                              blurRadius: 6,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: ListTile(
                                          contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                                          leading: const Icon(
                                            Icons.person,
                                            color: Colors.blueAccent,
                                            size: 24,
                                          ),
                                          title: Text(
                                            '${site.siteName}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: Primary_font_size.Text9,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          // Optionally you can add a subtitle or trailing icon here
                                          // subtitle: Text('Additional info', style: TextStyle(color: Colors.white70)),
                                          // trailing: Icon(Icons.chevron_right, color: Colors.white54),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.group_off, // People icon with "empty" style
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Looks like you don’t have any clients yet",
                                style: TextStyle(
                                  fontSize: Primary_font_size.Text12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        )
                ],
              ),
            )
          ],
        ));
  }

// Build the edit panel for the selected package
  // Build the edit panel for the selected package
  Widget _buildEditPanel(dynamic package) {
    final theme = Theme.of(context);
    final _formKey = GlobalKey<FormState>();
    subscriptionController.subscriptionModel.editpackagenameController.value.text = package.subscriptionName ?? '';
    subscriptionController.subscriptionModel.editpackageamountController.value.text = package.amount?.toString() ?? '';
    subscriptionController.subscriptionModel.editpackagedevicesController.value.text = package.noOfDevices?.toString() ?? '';
    subscriptionController.subscriptionModel.editpackagecamerasController.value.text = package.noOfCameras?.toString() ?? '';
    subscriptionController.subscriptionModel.editpackageadditionalcamerasController.value.text = package.addlCameras?.toString() ?? '';
    subscriptionController.subscriptionModel.editpackagedescController.value.text = package.productDesc ?? '';
    subscriptionController.subscriptionModel.editpackagesubscriptionID.value = package.subscriptionId ?? 0;

    return Obx(() {
      return SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Package Name
              _buildEditField(
                'Package Name',
                subscriptionController.subscriptionModel.editpackagenameController.value,
              ),

              // Price
              _buildEditField(
                'Amount (₹)',
                subscriptionController.subscriptionModel.editpackageamountController.value,
                isNumber: true,
                isDouble: true, // 👈 New flag
              ),

              // Devices
              _buildEditField(
                'Number of Devices',
                subscriptionController.subscriptionModel.editpackagedevicesController.value,
                isNumber: true,
              ),
              _buildEditField(
                'Number of Cameras',
                subscriptionController.subscriptionModel.editpackagecamerasController.value,
                isNumber: true,
              ),
              // Cameras
              _buildEditField(
                'Additional Cameras',
                subscriptionController.subscriptionModel.editpackageadditionalcamerasController.value,
                isNumber: true,
              ),

              // Description
              _buildEditField(
                'Description',
                subscriptionController.subscriptionModel.editpackagedescController.value,
                maxLines: 5,
              ),

              const SizedBox(height: 24),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        subscriptionController.subscriptionModel.packageisEditing.value = false;
                      },
                      child: Text(
                        'CANCEL',
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Primary_colors.Dark,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Primary_colors.Color3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      // onPressed: () => _updateSubscription(package),

                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // All fields are valid
                          widget.UpdateGlobalPackage(
                            context,
                            subscriptionController.subscriptionModel.editpackagenameController.value.text,
                            int.tryParse(subscriptionController.subscriptionModel.editpackagedevicesController.value.text) ?? 0,
                            int.tryParse(subscriptionController.subscriptionModel.editpackagecamerasController.value.text) ?? 0,
                            int.tryParse(subscriptionController.subscriptionModel.editpackageadditionalcamerasController.value.text) ?? 0,
                            double.tryParse(subscriptionController.subscriptionModel.editpackageamountController.value.text) ?? 0.0,
                            subscriptionController.subscriptionModel.editpackagedescController.value.text,
                            package.subscriptionId,
                          );
                          if (kDebugMode) {
                            print('Updated successfully');
                          }
                          // Add saving logic here
                        } else {
                          // Validation failed
                          if (kDebugMode) {
                            print('Validation failed');
                          }
                        }
                      },

                      child: Text(
                        'SAVE CHANGES',
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } // End of Obx
        );
  }

// Build the edit field widget
  Widget _buildEditField(
    String label,
    TextEditingController controller, {
    bool isNumber = false,
    bool isDouble = false, // 👈 New flag
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: Primary_font_size.Text6,
            ),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            keyboardType: isNumber || isDouble ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
            maxLines: maxLines,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter $label';
              }
              if (isDouble) {
                final parsed = double.tryParse(value);
                if (parsed == null) {
                  return 'Enter a valid number for $label';
                }
              }
              return null;
            },
            inputFormatters: isDouble
                ? [
                    // Optional: restrict characters to digits and dot
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                  ]
                : null,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  height: 1.6,
                  fontSize: Primary_font_size.Text8,
                ),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(255, 56, 66, 103),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  // void _updateSubscription(dynamic originalPackage) async {
  //   try {
  //     final updatedPackage = {
  //       ...originalPackage.toJson(),
  //       'subscriptionName': nameController.text,
  //       'amount': double.tryParse(amountController.text) ?? originalPackage.amount,
  //       'noOfDevices': int.tryParse(devicesController.text) ?? originalPackage.noOfDevices,
  //       'addlCameras': int.tryParse(camerasController.text) ?? originalPackage.addlCameras,
  //       'productDesc': descController.text,
  //     };

  //     // await subscriptionController.updateSubscription(updatedPackage);

  //     Get.snackbar(
  //       'Success',
  //       'Subscription updated successfully',
  //       backgroundColor: Colors.green,
  //       colorText: Colors.white,
  //     );

  //     setState(() {
  //       isEditing = false;
  //     });
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       'Failed to update subscription: $e',
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }
  // }
// Build the feature item widget
  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, size: 18, color: Colors.greenAccent),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: Primary_font_size.Text8,
                    overflow: TextOverflow.ellipsis,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

// SubscriptionCard widget to display each subscription package
class _SubscriptionCard extends StatelessWidget {
  final dynamic package;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isChecked;
  final ValueChanged<bool>? onChecked;

  const _SubscriptionCard({
    required this.package,
    required this.isSelected,
    required this.onTap,
    required this.isChecked,
    // ignore: unused_element_parameter
    this.onChecked,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          margin: EdgeInsets.all(isSelected ? 0 : 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isSelected
                  ? [
                      const Color.fromARGB(255, 122, 38, 212),
                      const Color.fromARGB(255, 61, 130, 251),
                    ]
                  : [
                      const Color.fromARGB(255, 31, 40, 95).withOpacity(0.7),
                      const Color.fromARGB(255, 75, 76, 130).withOpacity(0.7),
                    ],
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFF2575FC).withOpacity(0.5),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: const Offset(0, 5),
                    )
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(0, 4),
                    )
                  ],
          ),
          child: Stack(
            children: [
              // Background gradient
              Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package.subscriptionName ?? 'No Name',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Primary_font_size.SubHeading,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '₹ ${package.amount?.toStringAsFixed(2)} / 1 Month',
                      style: theme.textTheme.titleMedium?.copyWith(color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8),
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureRow('Enjoy full access and control from ${package.noOfDevices} devices.'),
                    _buildFeatureRow('Monitor ${package.noOfCameras} cameras simultaneously with HD streaming and smart alerts.'),
                    if (package.addlCameras != null && package.addlCameras! > 0) _buildFeatureRow('Expand your coverage with support for ${package.addlCameras} cameras for large-scale surveillance.'),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        '+ 2 more features',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Checkbox for selection
              Positioned(
                top: 12,
                left: 12,
                child: Transform.scale(
                  scale: 1.2,
                  child: Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      if (onChecked != null) {
                        onChecked!(value ?? false);
                      }
                    },
                    activeColor: Colors.blueAccent,
                    fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.green; // Color when checked
                      }
                      return Colors.white; // Transparent when unchecked
                    }),
                    checkColor: Colors.white, // Tick color
                    shape: const CircleBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Build a feature row with an icon and text
  Widget _buildFeatureRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, size: 15, color: Colors.white.withOpacity(0.8)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: Primary_font_size.Text6, overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
      ),
    );
  }
}
