import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/account_ledger_action.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/view_ledger_action.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/account_ledger_entities.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/view_ledger_entities.dart';
// import 'package:ssipl_billing/2.BILLING/Account_Ledgers/controllers/account_Ledger_action.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

mixin Account_LedgerService {
  final Account_LedgerController account_LedgerController = Get.find<Account_LedgerController>();
  final View_LedgerController view_LedgerController = Get.find<View_LedgerController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  Future<void> get_Account_LedgerList() async {
    // final ledgerData = {
    //   "ledgertype":
    //       view_LedgerController.view_LedgerModel.selectedtransactiontype.value.toLowerCase() == 'show all' ? '' : view_LedgerController.view_LedgerModel.selectedtransactiontype.value.toLowerCase(),
    //   "paymenttype": view_LedgerController.view_LedgerModel.selectedPaymenttype.value.toLowerCase() == 'show all' ? '' : view_LedgerController.view_LedgerModel.selectedPaymenttype.value.toLowerCase(),
    //   "invoicetype": view_LedgerController.view_LedgerModel.selectedinvoiceType.value.toLowerCase() == 'show all' ? '' : view_LedgerController.view_LedgerModel.selectedinvoiceType.value.toLowerCase(),
    //   "customerid": view_LedgerController.view_LedgerModel.selectedsalescustomer.value,
    //   "startdate": view_LedgerController.view_LedgerModel.startDateController.value.text,
    //   "enddate": view_LedgerController.view_LedgerModel.endDateController.value.text,
    // };

    // print('--- Ledger Data ---');
    // ledgerData.forEach((key, value) {
    //   print('$key: $value');
    // });

    // loader.start(context);
    // await Future.delayed(const Duration(milliseconds: 1000));
    // response;
    Map<String, dynamic>? response = await apiController.GetbyQueryString(
      {
        "ledgertype": view_LedgerController.view_LedgerModel.selectedtransactiontype.value.toLowerCase() == 'show all' ? '' : view_LedgerController.view_LedgerModel.selectedtransactiontype.value.toLowerCase(),
        "paymenttype":
            view_LedgerController.view_LedgerModel.selectedPaymenttype.value.toLowerCase() == 'show all' ? '' : view_LedgerController.view_LedgerModel.selectedPaymenttype.value.toLowerCase(), //"credit"       (or) debit,
        "invoicetype": view_LedgerController.view_LedgerModel.selectedinvoiceType.value.toLowerCase() == 'show all'
            ? ''
            : view_LedgerController.view_LedgerModel.selectedinvoiceType.value.toLowerCase(), //sales   (or) subscription (or) vendor,
        "customerid": view_LedgerController.view_LedgerModel.selectedsubcustomerID.value == 'None' ? '' : view_LedgerController.view_LedgerModel.selectedsubcustomerID.value,
        // "startdate": view_LedgerController.view_LedgerModel.startDateController.value.text,
        // "enddate": view_LedgerController.view_LedgerModel.endDateController.value.text,
      },
      API.getaccount_Ledgerlist,
    );
    if (response?['statusCode'] == 200) {
      CMDmResponse value = CMDmResponse.fromJson(response ?? {});
      if (value.code) {
        account_LedgerController.add_Account_Ledger(value);
        // print(account_LedgerController.account_LedgerModel.account_Ledger_list[0].billDetails);
        account_LedgerController.update();
      } else {
        // await Error_dialog(context: context, title: 'ERROR', content: value.message ?? "", onOk: () {});
      }
    } else {
      // Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
    }
    // loader.stop();
  }

  Future<PDF_AccountLedgerSummary> parsePDF_AccountLedger(bool Sub_clientOrNot, bool Sales_clientOrNot) async {
    final ClientDetails? clientDetails;

    if (Sub_clientOrNot) {
      String? clientID = view_LedgerController.view_LedgerModel.selectedsubcustomerID.value;

      CustomerInfo clientData = view_LedgerController.view_LedgerModel.subCustomerList.firstWhere((element) => element.customerId == clientID);
      clientDetails = ClientDetails(
        clientName: clientData.customerName,
        clientAddress: clientData.customerName,
        GSTIN: clientData.customerGstNo == '' ? '-' : clientData.customerGstNo,
        PAN: extractPanFromGst(clientData.customerGstNo),
        // fromDate: DateTime.parse(account_LedgerController
        //     .account_LedgerModel.account_Ledger_list.value.startdate!),
        // toDate: DateTime.parse(account_LedgerController
        //     .account_LedgerModel.account_Ledger_list.value.enddate!),
      );
    } else if (Sales_clientOrNot) {
      String? clientID = view_LedgerController.view_LedgerModel.selectedsalescustomerID.value;

      CustomerInfo clientData = view_LedgerController.view_LedgerModel.salesCustomerList.firstWhere((element) => element.customerId == clientID);
      clientDetails = ClientDetails(
        clientName: clientData.customerName,
        clientAddress: clientData.customerName,
        GSTIN: clientData.customerGstNo == '' ? '-' : clientData.customerGstNo,
        PAN: extractPanFromGst(clientData.customerGstNo),
      );
    } else {
      clientDetails = null;
    }

    PDF_AccountLedgerSummary value = PDF_AccountLedgerSummary.fromJson(
        clientDetails: clientDetails,
        ledgerDetails: account_LedgerController.account_LedgerModel.account_Ledger_list.value,
        fromDate: DateTime.parse(account_LedgerController.account_LedgerModel.account_Ledger_list.value.startdate!),
        toDate: DateTime.parse(account_LedgerController.account_LedgerModel.account_Ledger_list.value.enddate!));

    return value;
  }

  Future<void> account_Ledger_refresh() async {
    await get_Account_LedgerList();
    account_LedgerController.update();
  }

  void resetFilters() {
    account_LedgerController.account_LedgerModel.account_Ledger_list.value = account_LedgerController.account_LedgerModel.Secondaryaccount_Ledger_list.value;
  }
}
// void applySearchFilter(String query) {
//     try {
//       if (query.isEmpty) {
//         voucherController.voucherModel.filteredVouchers.assignAll(voucherController.voucherModel.voucher_list);
//       } else {
//         final filtered = voucherController.voucherModel.voucher_list.where((voucher) {
//           return voucher.clientName.toLowerCase().contains(query.toLowerCase()) || voucher.voucherNumber.toLowerCase().contains(query.toLowerCase());
//         }).toList();
//         voucherController.voucherModel.filteredVouchers.assignAll(filtered);
//       }

//       // Update selectedItems to match the new filtered list length
//       voucherController.voucherModel.selectedItems.value = List<bool>.filled(voucherController.voucherModel.filteredVouchers.length, false);
//       voucherController.voucherModel.selectAll.value = false;
//       voucherController.voucherModel.showDeleteButton.value = false;
//     } catch (e) {
//       debugPrint('Error in applySearchFilter: $e');
//     }
//   }
