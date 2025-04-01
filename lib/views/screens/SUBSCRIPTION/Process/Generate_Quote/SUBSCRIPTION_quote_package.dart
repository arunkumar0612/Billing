// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:ssipl_billing/views/components/button.dart';

// import 'package:flutter_animate/flutter_animate.dart';
class SubscriptionQuotePackage extends StatefulWidget {
  const SubscriptionQuotePackage({super.key});

  @override
  State<SubscriptionQuotePackage> createState() => _SubscriptionQuotePackageState();
}

class _SubscriptionQuotePackageState extends State<SubscriptionQuotePackage> with SingleTickerProviderStateMixin {
  final List<String> packageList = ['Basic Plan', 'Standard Plan', 'Premium Plan', 'Custom Package'];
  String? selectedPackage;
  bool customPackageCreated = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final Map<String, Map<String, String>> packageDetails = {
    'Basic Plan': {
      'name': 'Basic Plan',
      'description': 'Includes 5 cameras, ideal for small homes or small businesses.',
      'camera_count': '5',
      'amount': '\$50/month',
      'additional_charges': '\$10 per extra camera',
      'icon': '🏠',
    },
    'Standard Plan': {
      'name': 'Standard Plan',
      'description': 'Includes 10 cameras, perfect for medium offices and retail spaces.',
      'camera_count': '10',
      'amount': '\$100/month',
      'additional_charges': '\$8 per extra camera',
      'icon': '🏢',
    },
    'Premium Plan': {
      'name': 'Premium Plan',
      'description': 'Includes 20 cameras, designed for large buildings and enterprises.',
      'camera_count': '20',
      'amount': '\$200/month',
      'additional_charges': '\$5 per extra camera',
      'icon': '🏭',
    },
  };

  final TextEditingController customNameController = TextEditingController();
  final TextEditingController customDescController = TextEditingController();
  final TextEditingController customCameraCountController = TextEditingController();
  final TextEditingController customAmountController = TextEditingController();
  final TextEditingController customChargesController = TextEditingController();

  Map<String, String>? customPackage;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    customNameController.dispose();
    customDescController.dispose();
    customCameraCountController.dispose();
    customAmountController.dispose();
    customChargesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Your Package',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Primary_colors.Color1,
                  fontWeight: FontWeight.bold,
                  fontSize: Primary_font_size.SubHeading,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose the plan that fits your needs or create a custom package',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600, fontSize: Primary_font_size.Text8),
          ),
          const SizedBox(height: 10),
          Container(
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
                value: selectedPackage,
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
                items: packageList.map((String package) {
                  return DropdownMenuItem<String>(
                    value: package,
                    child: Text(
                      package,
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPackage = newValue;
                    _animationController.reset();
                    _animationController.forward();

                    // If selecting "Custom Package" option and we have a saved custom package
                    if (newValue == 'Custom Package' && customPackage != null) {
                      // Load the saved data into the form
                      customNameController.text = customPackage!['name']!;
                      customDescController.text = customPackage!['description']!;
                      customCameraCountController.text = customPackage!['camera_count']!;
                      customAmountController.text = customPackage!['amount']!;
                      customChargesController.text = customPackage!['additional_charges']!;
                    }
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
              child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: selectedPackage == null
                ? _buildPlaceholder()
                : selectedPackage == 'Custom Package'
                    ? buildCustomPackageForm()
                    : packageDetails.containsKey(selectedPackage)
                        ? FadeTransition(
                            opacity: _fadeAnimation,
                            child: buildPackageDetails(packageDetails[selectedPackage!]!),
                          )
                        : _buildPlaceholder(),
          ))
        ],
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
          const SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BasicButton(
                colors: Colors.red,
                text: 'Back',
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCustomPackageForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Custom Package',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Primary_colors.Color3, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8),
          ),
          const SizedBox(height: 8),
          Text(
            customPackageCreated ? 'Edit your custom package' : 'Tailor a package to your specific requirements',
            style: TextStyle(color: Colors.grey.shade600, fontSize: Primary_font_size.Text8),
          ),
          const SizedBox(height: 10),
          buildTextField(
            controller: customNameController,
            label: 'Package Name',
            icon: Icons.badge_outlined,
          ),
          buildTextField(
            controller: customCameraCountController,
            label: 'Camera Count',
            icon: Icons.videocam_outlined,
            isNumber: true,
          ),
          buildTextField(
            controller: customAmountController,
            label: 'Package Amount',
            icon: Icons.attach_money_outlined,
            isNumber: true,
          ),
          buildTextField(
            controller: customChargesController,
            label: 'Additional Charges',
            icon: Icons.money_off_csred_outlined,
            isNumber: true,
          ),
          buildTextField(
            controller: customDescController,
            label: 'Package Description . . .',
            maxLines: 3,
          ),
          const SizedBox(height: 5),
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
                colors: Primary_colors.Color3,
                text: customPackageCreated ? 'Update Package' : 'Save Custom Package',
                onPressed: _saveCustomPackage,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _saveCustomPackage() {
    if (_validateCustomPackage()) {
      setState(() {
        customPackage = {
          'name': customNameController.text,
          'description': customDescController.text,
          'camera_count': customCameraCountController.text,
          'amount': customAmountController.text,
          'additional_charges': customChargesController.text,
          'icon': '🛠️',
        };

        // Add to packageDetails map
        packageDetails[customNameController.text] = customPackage!;

        // Add to packageList if not already there
        if (!packageList.contains(customNameController.text)) {
          packageList.add(customNameController.text);
        }

        // Set as selected
        selectedPackage = customNameController.text;
        customPackageCreated = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Custom package saved successfully!'),
          backgroundColor: Colors.blue.shade400,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }

  bool _validateCustomPackage() {
    if (customNameController.text.isEmpty ||
        customDescController.text.isEmpty ||
        customCameraCountController.text.isEmpty ||
        customAmountController.text.isEmpty ||
        customChargesController.text.isEmpty) {
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
          // labelText: label,
          prefixIcon: icon != null ? Icon(icon, color: Primary_colors.Color1) : null,
          hintText: label,
          hintStyle: TextStyle(color: const Color.fromARGB(255, 192, 187, 187)),
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
    return Column(
      children: [
        GlassmorphicContainer(
            width: double.infinity,
            height: 320,
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
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        details['icon'] ?? '📷',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        details['name']!,
                        style: const TextStyle(
                          fontSize: Primary_font_size.SubHeading,
                          fontWeight: FontWeight.bold,
                          color: Primary_colors.Color1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: 0.5,
                  ),
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
                    value: details['additional_charges']!,
                  ),
                  const SizedBox(height: 12),
                  _buildDetailRow(
                    icon: Icons.description_outlined,
                    title: 'Description',
                    value: details['description']!,
                  ),
                ],
              ),
            ))),
        const SizedBox(height: 20),
        if (selectedPackage != 'Custom Package')
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
    );
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: Primary_font_size.Text10,
                  color: Primary_colors.Color3,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 198, 197, 197)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
