import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/controllers/SUBSCRIPTION_Quote_actions.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/models/entities/SUBSCRIPTION_Quote_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';

mixin SUBSCRIPTION_QuotepackageService {
  final SUBSCRIPTION_QuoteController quoteController = Get.find<SUBSCRIPTION_QuoteController>();

  /// Removes a selected package from the package list and updates the selected package state.
  ///
  /// Functionality:
  /// - Removes the given [packageToRemove] from `selectedPackagesList`.
  /// - If the list becomes empty, clears the `selectedPackage`.
  /// - If the removed package was the currently selected one, sets the first available package as the new selected package.
  /// - Displays a snack bar message notifying that the package has been removed.
  void removePackage(Package packageToRemove, BuildContext context) {
    // setState(() {
    quoteController.quoteModel.selectedPackagesList.remove(packageToRemove);

    if (quoteController.quoteModel.selectedPackagesList.isEmpty) {
      quoteController.quoteModel.selectedPackage.value = null;
    } else if (quoteController.quoteModel.selectedPackage.value == packageToRemove.name) {
      // Select the first available package if we removed the currently selected one
      quoteController.quoteModel.selectedPackage.value = quoteController.quoteModel.selectedPackagesList.first.name;
    }
    Error_SnackBar(context, '${packageToRemove.name} removed from packages');

    // });
  }

  /// Saves a custom package after validating user input and updates the package lists accordingly.
  ///
  /// Logic:
  /// - Creates a `Package` object using values from custom package controllers.
  /// - Updates the `customPackage` observable with the newly created package.
  /// - Adds the custom package to `packageDetails` if it doesn't already exist.
  /// - Adds the package name to `packageList` if not already present.
  /// - Sets the custom package as the currently selected one.
  /// - Checks if any previously selected packages have no assigned sites:
  ///   - Prompts the user to optionally replace such empty packages with the new custom package.
  /// - Adds or updates the custom package in `selectedPackagesList`.
  /// - Resets all related form fields after successful save.
  Future<void> saveCustomPackage(BuildContext context) async {
    if (validateCustomPackage(context)) {
      final customPackage = Package(
        name: quoteController.quoteModel.customNameControllers.value.text,
        subscriptionid: 0,
        description: quoteController.quoteModel.customDescControllers.value.text,
        cameracount: quoteController.quoteModel.customCameraCountControllers.value.text,
        amount: quoteController.quoteModel.customAmountControllers.value.text,
        // additionalCameras: quoteController.quoteModel.customChargesControllers.value.text,
        subscriptiontype: quoteController.quoteModel.subscriptiontype.value,
        sites: [],
      );

      // Update or create the custom package
      quoteController.quoteModel.customPackage.value = customPackage;

      // Add to package details if not already present
      if (!quoteController.quoteModel.packageDetails.any((p) => p.name == customPackage.name)) {
        quoteController.quoteModel.packageDetails.add(customPackage);
      }

      // Add to package list if not already present
      if (!quoteController.quoteModel.packageList.contains(customPackage.name)) {
        quoteController.quoteModel.packageList.add(customPackage.name);
      }

      // Select the custom package
      quoteController.quoteModel.selectedPackage.value = customPackage.name;
      quoteController.quoteModel.customPackageCreated.value = true;

      // Check for empty packages
      final emptyPackages = quoteController.quoteModel.selectedPackagesList.where((pkg) => pkg.sites.isEmpty).toList();

      if (emptyPackages.isNotEmpty) {
        final shouldReplace = await Warning_dialog(
              context: context,
              title: 'Replace Empty Packages?',
              content: 'The following packages have no sites assigned:\n'
                  '${emptyPackages.map((p) => p.name).join(', ')}\n'
                  'Would you like to replace them with "${customPackage.name}"?',
              // showCancel: true
            ) ??
            false;

        if (shouldReplace) {
          quoteController.quoteModel.selectedPackagesList.removeWhere((pkg) => pkg.sites.isEmpty);
        }
      }

      // Add or update the package
      final existingIndex = quoteController.quoteModel.selectedPackagesList.indexWhere((p) => p.name == customPackage.name);

      if (existingIndex == -1) {
        quoteController.quoteModel.selectedPackagesList.add(customPackage);
        // Success_SnackBar(context, '${customPackage.name} added to packages');
      } else {
        quoteController.quoteModel.selectedPackagesList[existingIndex] = customPackage.copyWith(
          sites: quoteController.quoteModel.selectedPackagesList[existingIndex].sites,
        );
        // Success_SnackBar(context, '${customPackage.name} updated in packages');
      }

      // Clear all fields after saving
      resetCustomPackageFields();
    }
  }

  /// Clears all input fields related to custom package creation.
  ///
  /// Resets:
  /// - Custom package name, description, camera count, and amount fields.
  /// - Subscription type is reset to the default value ('company').
  void resetCustomPackageFields() {
    quoteController.quoteModel.customNameControllers.value.clear();
    quoteController.quoteModel.customDescControllers.value.clear();
    quoteController.quoteModel.customCameraCountControllers.value.clear();
    quoteController.quoteModel.customAmountControllers.value.clear();
    // quoteController.quoteModel.customChargesControllers.value.clear();
    quoteController.quoteModel.subscriptiontype.value = 'company';
  }

  /// Validates the custom package input fields.
  ///
  /// Returns `false` and shows an error snackbar if any of the following fields are empty:
  /// - Custom package name
  /// - Description
  /// - Camera count
  /// - Amount
  ///
  /// Returns `true` if all required fields are filled.
  bool validateCustomPackage(BuildContext context) {
    if (quoteController.quoteModel.customNameControllers.value.text.isEmpty ||
        quoteController.quoteModel.customDescControllers.value.text.isEmpty ||
        quoteController.quoteModel.customCameraCountControllers.value.text.isEmpty ||
        quoteController.quoteModel.customAmountControllers.value.text.isEmpty) {
      Error_SnackBar(context, 'Please fill all fields');

      return false;
    }
    return true;
  }
}
