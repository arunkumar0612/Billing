// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/SUBSCRIPTION_Quote_actions.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/THEMES-/style.dart';
import 'package:glassmorphism/glassmorphism.dart';

class SubscriptionQuotePackage extends StatefulWidget {
  const SubscriptionQuotePackage({super.key});

  @override
  State<SubscriptionQuotePackage> createState() => _SubscriptionQuotePackageState();
}

class _SubscriptionQuotePackageState extends State<SubscriptionQuotePackage> with SingleTickerProviderStateMixin {
  final SUBSCRIPTION_QuoteController quoteController = Get.find<SUBSCRIPTION_QuoteController>();

  @override
  void initState() {
    super.initState();
    quoteController.quoteModel.animationControllers = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    quoteController.quoteModel.fadeAnimations = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: quoteController.quoteModel.animationControllers, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    quoteController.quoteModel.animationControllers.dispose();
    // quoteController.quoteModel.customNameControllers.value.dispose();
    // quoteController.quoteModel.customDescControllers.value.dispose();
    // quoteController.quoteModel.customCameraCountControllers.value.dispose();
    // quoteController.quoteModel.customAmountControllers.value.dispose();
    // quoteController.quoteModel.customChargesControllers.value.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
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
                        style: const TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.w500, fontSize: Primary_font_size.Text10),
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
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          labelText: 'Choose the Package',
                          labelStyle: const TextStyle(color: Color.fromARGB(255, 179, 178, 178), fontSize: Primary_font_size.Text8),
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
                        onChanged: (String? newValue) {
                          quoteController.quoteModel.selectedPackage.value = newValue;
                          quoteController.quoteModel.animationControllers.reset();
                          quoteController.quoteModel.animationControllers.forward();

                          // Automatically add the selected package to the list
                          if (newValue != null && newValue != 'Custom Package') {
                            final package = quoteController.quoteModel.packageDetails[newValue];
                            if (package != null && !quoteController.quoteModel.selectedPackages.any((p) => p['name'] == package['name'])) {
                              quoteController.quoteModel.selectedPackages.add(Map.from(package));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${package['name']} added to selected packages'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          }

                          if (newValue == 'Custom Package' && quoteController.quoteModel.customPackage.value != null) {
                            quoteController.quoteModel.customNameControllers.value.text = quoteController.quoteModel.customPackage.value!['name']!;
                            quoteController.quoteModel.customDescControllers.value.text = quoteController.quoteModel.customPackage.value!['description']!;
                            quoteController.quoteModel.customCameraCountControllers.value.text = quoteController.quoteModel.customPackage.value!['camera_count']!;
                            quoteController.quoteModel.customAmountControllers.value.text = quoteController.quoteModel.customPackage.value!['amount']!;
                            quoteController.quoteModel.customChargesControllers.value.text = quoteController.quoteModel.customPackage.value!['additional_cameras']!;
                            quoteController.quoteModel.showto.value = quoteController.quoteModel.customPackage.value!['show']!;
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: quoteController.quoteModel.selectedPackage.value == null
                          ? _buildPlaceholder()
                          : quoteController.quoteModel.selectedPackage.value == 'Custom Package'
                              ? buildCustomPackageForm()
                              : quoteController.quoteModel.packageDetails.containsKey(quoteController.quoteModel.selectedPackage.value)
                                  ? FadeTransition(
                                      opacity: quoteController.quoteModel.fadeAnimations,
                                      child: Column(
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
                                      ),
                                    )
                                  : _buildPlaceholder(),
                    ),
                    const SizedBox(width: 10),
                    // In the build method, modify the right column (the one showing Pending Sites and Selected Packages)
                    Expanded(
                      flex: 1,
                      child: Container(
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
                            // Pending Sites section with constrained height
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: MediaQuery.of(context).size.height * 0.3, // 30% of screen height
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
                                      // Add Expanded here
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: quoteController.quoteModel.QuoteSiteDetails.length,
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
                                                  '${index + 1} . ${quoteController.quoteModel.QuoteSiteDetails[index].siteName}',
                                                  style: const TextStyle(color: Color.fromARGB(255, 181, 181, 181), fontSize: Primary_font_size.Text8),
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (quoteController.quoteModel.selectedPackage.value != 'Custom Package')
              Text(
                'Need something different? Consider our Custom Package option',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BasicButton(
                  colors: Colors.red,
                  text: 'Back',
                  onPressed: () {},
                ),
                const SizedBox(width: 30),
                BasicButton(
                  colors: Colors.green,
                  text: 'Submit',
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  void _removePackage(int index) {
    final removed = quoteController.quoteModel.selectedPackages.removeAt(index);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removed['name']} removed from packages'),
        backgroundColor: Colors.red,
      ),
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

  // String selectedOption = 'option1';
  Widget buildCustomPackageForm() {
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

          buildTextField(
            controller: quoteController.quoteModel.customNameControllers.value,
            label: 'Package Name',
            icon: Icons.badge_outlined,
          ),
          buildTextField(
            controller: quoteController.quoteModel.customCameraCountControllers.value,
            label: 'Camera Count',
            icon: Icons.videocam_outlined,
            isNumber: true,
          ),
          buildTextField(
            controller: quoteController.quoteModel.customAmountControllers.value,
            label: 'Package Amount',
            icon: Icons.attach_money_outlined,
            isNumber: true,
          ),
          buildTextField(
            controller: quoteController.quoteModel.customChargesControllers.value,
            label: 'Additional Charges',
            icon: Icons.money_off_csred_outlined,
            isNumber: true,
          ),
          // Fixed radio buttons section

          Row(
            children: [
              const Text(
                '    Show this to all sites :  ',
                style: TextStyle(fontSize: Primary_font_size.Text9, color: Color.fromARGB(255, 202, 201, 201)),
              ),
              Expanded(
                child: _buildCustomRadio(
                  context,
                  title: 'Yes',
                  value: 'Company',
                  groupValue: quoteController.quoteModel.showto.value,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildCustomRadio(
                  context,
                  title: 'No',
                  value: 'Global',
                  groupValue: quoteController.quoteModel.showto.value,
                ),
              ),
            ],
          ),

          // Display selected value (optional)

          const SizedBox(height: 10),
          buildTextField(
            controller: quoteController.quoteModel.customDescControllers.value,
            label: 'Package Description . . .',
            maxLines: 3,
          ),
          const SizedBox(height: 5),
          BasicButton(
            colors: Primary_colors.Color3,
            text: quoteController.quoteModel.customPackageCreated.value ? 'Update Package' : 'Save Custom Package',
            onPressed: _saveCustomPackage,
          ),
        ],
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

  void _saveCustomPackage() {
    if (_validateCustomPackage()) {
      quoteController.quoteModel.customPackage.value = {
        'name': quoteController.quoteModel.customNameControllers.value.text,
        'description': quoteController.quoteModel.customDescControllers.value.text,
        'camera_count': quoteController.quoteModel.customCameraCountControllers.value.text,
        'amount': quoteController.quoteModel.customAmountControllers.value.text,
        'additional_cameras': quoteController.quoteModel.customChargesControllers.value.text,
        'show': quoteController.quoteModel.showto.value,
        'icon': '🛠️',
      };

      quoteController.quoteModel.packageDetails[quoteController.quoteModel.customNameControllers.value.text] = quoteController.quoteModel.customPackage.value!;

      if (!quoteController.quoteModel.packageList.contains(quoteController.quoteModel.customNameControllers.value.text)) {
        quoteController.quoteModel.packageList.add(quoteController.quoteModel.customNameControllers.value.text);
      }

      quoteController.quoteModel.selectedPackage.value = quoteController.quoteModel.customNameControllers.value.text;
      quoteController.quoteModel.customPackageCreated.value = true;

      // Automatically add the custom package to selected packages
      if (!quoteController.quoteModel.selectedPackages.any((p) => p['name'] == quoteController.quoteModel.customPackage.value?['name'])) {
        if (quoteController.quoteModel.customPackage.value != null) {
          quoteController.quoteModel.selectedPackages.add(Map.from(quoteController.quoteModel.customPackage.value!));

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${quoteController.quoteModel.customPackage.value!['name']} added to selected packages'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    }
  }

  bool _validateCustomPackage() {
    if (quoteController.quoteModel.customNameControllers.value.text.isEmpty ||
        quoteController.quoteModel.customDescControllers.value.text.isEmpty ||
        quoteController.quoteModel.customCameraCountControllers.value.text.isEmpty ||
        quoteController.quoteModel.customAmountControllers.value.text.isEmpty ||
        quoteController.quoteModel.customChargesControllers.value.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill all fields'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
      return false;
    }
    return true;
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    IconData? icon,
    bool isNumber = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        style: const TextStyle(fontSize: Primary_font_size.Text8, color: Primary_colors.Color1),
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

  Widget buildPackageDetails(Map<String, String> details) {
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
                    child: TabBar(indicatorColor: Primary_colors.Color4, tabs: [
                      Tab(text: 'Details'),
                      Tab(text: 'Sites'),
                    ]),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () => _removePackage(quoteController.quoteModel.selectedPackages.indexOf(details)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Expanded(
                child: TabBarView(
                  children: [_buildpackagedetails(details), _buildpackagesites()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildpackagedetails(Map<String, String> details) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  details['icon'] ?? '📷',
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
                Text(
                  details['name']!,
                  style: const TextStyle(
                    fontSize: Primary_font_size.Text8,
                    fontWeight: FontWeight.bold,
                    color: Primary_colors.Color1,
                  ),
                ),
              ],
            ),
            // const SizedBox(height: 5),
            // Divider(
            //   color: Colors.grey.shade300,
            //   thickness: 0.5,
            // ),
            const SizedBox(height: 16),
            _buildDetailRow(
              icon: Icons.videocam_outlined,
              title: 'Camera Count',
              value: details['camera_count']!,
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              icon: Icons.attach_money_outlined,
              title: 'Package Amount',
              value: details['amount']!,
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              icon: Icons.money_off_csred_outlined,
              title: 'Additional Charges',
              value: details['additional_cameras']!,
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              icon: Icons.description_outlined,
              title: 'Description',
              value: details['description']!,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildpackagesites() {
    return Obx(() {
      return Column(
        children: [
          if (!quoteController.quoteModel.showSiteList.value)
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (quoteController.quoteModel.selectedIndices.isEmpty)
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
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
                                  quoteController.quoteModel.showSiteList.value = true;
                                  quoteController.quoteModel.selectedIndices.clear();
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
                                  quoteController.quoteModel.showSiteList.value = true;
                                  quoteController.quoteModel.selectedIndices.clear();
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
                                  child: ListView.separated(
                                    padding: const EdgeInsets.all(2),
                                    itemCount: quoteController.quoteModel.selectedIndices.length,
                                    separatorBuilder: (context, index) => const Divider(
                                      height: 5,
                                      color: Color.fromARGB(19, 100, 110, 255),
                                    ),
                                    itemBuilder: (context, i) {
                                      final index = quoteController.quoteModel.selectedIndices[i];
                                      final siteName = quoteController.quoteModel.QuoteSiteDetails[index].siteName;

                                      return AnimatedContainer(
                                        duration: const Duration(milliseconds: 200),
                                        curve: Curves.easeInOut,
                                        child: ListTile(
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
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
                                            siteName,
                                            style: const TextStyle(fontWeight: FontWeight.w500, color: Primary_colors.Color1, fontSize: Primary_font_size.Text8),
                                          ),
                                          trailing: IconButton(
                                            icon: Icon(
                                              Icons.close,
                                              color: Colors.grey[500],
                                              size: 18,
                                            ),
                                            onPressed: () {
                                              quoteController.quoteModel.selectedIndices.remove(index);
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
            ),
          if (quoteController.quoteModel.showSiteList.value)
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(6, 255, 255, 255),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ListView.separated(
                            padding: const EdgeInsets.all(8),
                            itemCount: quoteController.quoteModel.QuoteSiteDetails.length,
                            separatorBuilder: (context, index) => const Divider(height: 1, indent: 56),
                            itemBuilder: (context, index) {
                              final site = quoteController.quoteModel.QuoteSiteDetails[index];

                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                decoration: BoxDecoration(
                                  color: quoteController.quoteModel.selectedIndices.contains(index) ? Primary_colors.Color1.withOpacity(0.05) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: quoteController.quoteModel.selectedIndices.contains(index),
                                      onChanged: (bool? isChecked) {
                                        if (isChecked == true) {
                                          quoteController.quoteModel.selectedIndices.add(index);
                                        } else {
                                          quoteController.quoteModel.selectedIndices.remove(index);
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6), // Slightly more rounded
                                      ),
                                      checkColor: Colors.white, // Color of the check icon
                                      activeColor: Colors.green.shade600, // Background when selected
                                      side: const BorderSide(
                                        color: Colors.grey, // Border color when not selected
                                        width: 1.5,
                                      ),
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.compact, // Reduce padding space
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            site.siteName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: Primary_font_size.Text8,
                                              color: Color.fromARGB(255, 221, 220, 220),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
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
                                quoteController.quoteModel.showSiteList.value = false;
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
                                // backgroundColor: const Color.fromARGB(12, 255, 255, 255),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                quoteController.quoteModel.showSiteList.value = false;
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
                ),
              ),
            ),
        ],
      );
    });
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String value,
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
                child: Text(
                  value,
                  style: const TextStyle(fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 198, 197, 197)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
