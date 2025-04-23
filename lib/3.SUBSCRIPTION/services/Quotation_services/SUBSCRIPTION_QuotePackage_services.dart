import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/SUBSCRIPTION_Quote_actions.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/models/entities/SUBSCRIPTION_Quote_entities.dart';

mixin SUBSCRIPTION_QuotepackageService {
  final SUBSCRIPTION_QuoteController quoteController = Get.find<SUBSCRIPTION_QuoteController>();

  void removePackage(Package packageToRemove, BuildContext context) {
    // setState(() {
    quoteController.quoteModel.selectedPackages.remove(packageToRemove);

    if (quoteController.quoteModel.selectedPackages.isEmpty) {
      quoteController.quoteModel.selectedPackage.value = null;
    } else if (quoteController.quoteModel.selectedPackage.value == packageToRemove.name) {
      // Select the first available package if we removed the currently selected one
      quoteController.quoteModel.selectedPackage.value = quoteController.quoteModel.selectedPackages.first.name;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${packageToRemove.name} removed from packages'),
        backgroundColor: Colors.red,
      ),
    );
    // });
  }

  void saveCustomPackage(BuildContext context) {
    if (validateCustomPackage(context)) {
      final customPackage = {
        'name': quoteController.quoteModel.customNameControllers.value.text,
        'description': quoteController.quoteModel.customDescControllers.value.text,
        'camera_count': quoteController.quoteModel.customCameraCountControllers.value.text,
        'amount': quoteController.quoteModel.customAmountControllers.value.text,
        'additional_cameras': quoteController.quoteModel.customChargesControllers.value.text,
        'show': quoteController.quoteModel.showto.value,
        'icon': '🛠️',
      };

      // Update or create the custom package
      quoteController.quoteModel.customPackage.value = customPackage;
      quoteController.quoteModel.packageDetails[customPackage['name']!] = customPackage;

      // Add to package list if not already present
      if (!quoteController.quoteModel.packageList.contains(customPackage['name'])) {
        quoteController.quoteModel.packageList.add(customPackage['name']!);
      }

      // Select the custom package
      quoteController.quoteModel.selectedPackage.value = customPackage['name'];
      quoteController.quoteModel.customPackageCreated.value = true;

      // Add to selected packages if not already present
      if (!quoteController.quoteModel.selectedPackages.any((p) => p.name == customPackage['name'])) {
        quoteController.quoteModel.selectedPackages.add(Package(
          name: customPackage['name']!,
          description: customPackage['description']!,
          cameraCount: customPackage['camera_count']!,
          amount: customPackage['amount']!,
          additionalCameras: customPackage['additional_cameras']!,
          show: customPackage['show']!,
          sites: [],
        ));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${customPackage['name']} added to selected packages'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  bool validateCustomPackage(BuildContext context) {
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
}
