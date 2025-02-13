import 'package:get/get.dart';
import 'package:ssipl_billing/models/entities/SALES/Sales_entities.dart';

class SalesModel {
  var customerList = <Customer>[].obs;
  var processcustomerList = <Processcustomer>[].obs;
  var processList = <Process>[].obs;
  final showcustomerprocess = 0.obs;
  final customerId = Rxn<int>();
}
