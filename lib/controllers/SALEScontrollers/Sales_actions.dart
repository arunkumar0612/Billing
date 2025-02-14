import 'dart:io';

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

  void addToProcesscustomerList(CMDlResponse value) {
    for (int i = 0; i < value.data.length; i++) {
      salesModel.processcustomerList.add(Processcustomer.fromJson(value, i));
    }
  }

  void addToProcessList(CMDlResponse value) {
    for (int i = 0; i < value.data.length; i++) {
      salesModel.processList.add(Process.fromJson(value, i));
    }
  }

  void updatecustomerId(int value) {
    salesModel.customerId.value = value;
  }

  void updateshowcustomerprocess(int? value) {
    salesModel.showcustomerprocess.value = value;
  }

  Future<void> PDFfileApiData(CMDmResponse value) async {
    var pdfFileData = await PDFfileData.fromJson(value); // Await async function
    var binaryData = pdfFileData.data; // Extract File object
    updatePDFfile(binaryData);
  }

  void updatePDFfile(File value) {
    salesModel.pdfFile.value = value;
  }
}
