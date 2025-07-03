// ignore_for_file: depend_on_referenced_packages


import 'package:get/get.dart';


import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';


// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


import '../../API/invoker.dart';

import '../controllers/Vendor_actions.dart';



mixin VendorServices {
  final Invoker apiController = Get.find<Invoker>();

  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final VendorController vendorController = Get.find<VendorController>();

  final loader = LoadingOverlay();
  

 

 

  

  

 

 
  

  

  

  

  
 

 


  


  



// // ##################################################################################################################################################################################################################################################################################################################################################################

  

  String formatNumber(int number) {
    if (number >= 10000000) {
      return "₹ ${(number / 10000000).toStringAsFixed(1)}Cr";
    } else if (number >= 100000) {
      return "₹ ${(number / 100000).toStringAsFixed(1)}L";
    } else if (number >= 1000) {
      return "₹ ${(number / 1000).toStringAsFixed(1)}K";
    } else {
      return "₹ $number";
    }
  }

  Future<void> vendor_refresh() async {
    // vendorController.resetData();
    vendorController.updateshowvendorprocess(null);
    vendorController.updatevendorId(0);
  


    vendorController.update();
  }

}
