import 'package:get/get.dart';
import 'package:ssipl_billing/models/constants/SALES_constants/Sales_constants.dart';

import '../../models/entities/Response_entities.dart';
import '../../models/entities/SALES/Sales_entities.dart';

class SalesController extends GetxController {
  var salesModel = SalesModel();

  void addToCustomerList(CMDlResponse value) {
    for (int i = 0; i < value.data.length; i++) {
      salesModel.customerList.add(Customer.fromJson(value, i));
    }
  }
}
