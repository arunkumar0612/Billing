import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/controller/TDS_ledger_action.dart';
// import 'package:ssipl_billing/2_BILLING/TDS_Ledgers/controllers/tds_Ledger_action.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/THEMES/style.dart';

mixin TDS_LedgerService {
  final TDS_LedgerController tds_LedgerController = Get.find<TDS_LedgerController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  Future<void> get_TDS_LedgerList() async {
    // loader.start(context);
    // await Future.delayed(const Duration(milliseconds: 1000));
    // response;
    Map<String, dynamic>? response = await apiController.GetbyQueryString(
      {
        "tdstype": tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.TDStype.value.toLowerCase() == 'show all'
            ? ''
            : tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.TDStype.value.toLowerCase(),

        "invoicetype": tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.invoicetype.value.toLowerCase() == 'show all'
            ? ''
            : tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.invoicetype.value.toLowerCase(),
        // "customerid": "SB_1",
        "customerid": tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedcustomerid.value == 'None'
            ? ''
            : tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedcustomerid.value,
        "startdate": tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.fromdate.value.toString(),
        "enddate": tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.todate.value.toString(),
      },
      API.gettds_Ledgerlist,
    );
    if (response?['statusCode'] == 200) {
      CMDmResponse value = CMDmResponse.fromJson(response ?? {});
      if (value.code) {
        tds_LedgerController.add_TDS_Ledger(value);
        tds_LedgerController.update();
      } else {
        // await Error_dialog(context: context, title: 'ERROR', content: value.message ?? "", onOk: () {});
      }
    } else {
      // Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
    }
    // loader.stop();
  }

  Future<void> tds_Ledger_refresh() async {
    await get_TDS_LedgerList();
    tds_LedgerController.update();
  }

  void resetFilters() {
    tds_LedgerController.tds_LedgerModel.tds_Ledger_list.value = tds_LedgerController.tds_LedgerModel.ParentTDS_Ledgers.value;
  }

  Future<void> selectfilterDate(BuildContext context, TextEditingController controller) async {
    final DateTime now = DateTime.now();
    final DateTime nextYear = now.add(const Duration(days: 365)); // Limit to next year

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now, // Start from today
      lastDate: nextYear, // Allow dates up to 1 year from today
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Primary_colors.Color3,
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Primary_colors.Color3,
              ),
            ),
            dialogTheme: const DialogThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final formatted = "${pickedDate.year.toString().padLeft(4, '0')}-"
          "${pickedDate.month.toString().padLeft(2, '0')}-"
          "${pickedDate.day.toString().padLeft(2, '0')}";

      controller.text = formatted;
    }
  }

  void resettds_LedgerFilters() {
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.TDStype.value = 'Show All';
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.invoicetype.value = 'Show All';
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedsalescustomername.value = 'None';
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedcustomerid.value = '';
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value = 'None';

    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.fromdate.value = '';
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.todate.value = '';

    // tds_LedgerController.tds_LedgerModel.filteredtds_Ledgers.value = tds_LedgerController.tds_LedgerModel.tds_Ledger_list;
  }

  void assigntds_LedgerFilters() {
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.TDStype.value = tds_LedgerController.tds_LedgerModel.selectedTDStype.value;
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.invoicetype.value = tds_LedgerController.tds_LedgerModel.selectedInvoiceType.value;
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedsalescustomername.value = tds_LedgerController.tds_LedgerModel.selectedsalescustomer.value;
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value = tds_LedgerController.tds_LedgerModel.selectedsubcustomer.value;
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedcustomerid.value = tds_LedgerController.tds_LedgerModel.selectedcustomerID.value;
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.fromdate.value = tds_LedgerController.tds_LedgerModel.startDateController.value.text;
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.todate.value = tds_LedgerController.tds_LedgerModel.endDateController.value.text;
  }

  void reassigntds_LedgerFilters() {
    tds_LedgerController.tds_LedgerModel.selectedTDStype.value = tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.TDStype.value;
    tds_LedgerController.tds_LedgerModel.selectedInvoiceType.value = tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.invoicetype.value;
    tds_LedgerController.tds_LedgerModel.selectedsalescustomer.value = tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedsalescustomername.value;
    tds_LedgerController.tds_LedgerModel.selectedsubcustomer.value = tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value;
    tds_LedgerController.tds_LedgerModel.selectedcustomerID.value = tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedcustomerid.value;

    tds_LedgerController.tds_LedgerModel.startDateController.value.text = tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.fromdate.toString();
    tds_LedgerController.tds_LedgerModel.endDateController.value.text = tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.todate.toString();
    tds_LedgerController.tds_LedgerModel.selectedMonth.value = tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedmonth.value.toString();
  }
}
