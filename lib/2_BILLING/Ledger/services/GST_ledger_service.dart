import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/controller/GST_ledger_action.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/controller/view_ledger_action.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/THEMES/style.dart';

mixin GST_LedgerService {
  final GST_LedgerController gst_LedgerController = Get.find<GST_LedgerController>();
  final View_LedgerController view_LedgerController = Get.find<View_LedgerController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  Future<void> get_GST_LedgerList() async {
    // loader.start(context);
    // await Future.delayed(const Duration(milliseconds: 1000));
    // response;
    Map<String, dynamic>? response = await apiController.GetbyQueryString(
      {
        "gsttype": gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.GSTtype.value.toLowerCase() == 'consolidate'
            ? ''
            : gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.GSTtype.value.toLowerCase(),

        "invoicetype": gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.invoicetype.value.toLowerCase() == 'show all'
            ? ''
            : gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.invoicetype.value.toLowerCase(),
        // "customerid": "SB_1",
        "customerid": gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedcustomerid.value == 'None'
            ? ''
            : gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedcustomerid.value,
        "startdate": gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.fromdate.value.toString(),
        "enddate": gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.todate.value.toString(),
      },
      API.getgst_Ledgerlist,
    );
    if (response?['statusCode'] == 200) {
      CMDmResponse value = CMDmResponse.fromJson(response ?? {});
      if (value.code) {
        gst_LedgerController.add_GST_Ledger(value);
        gst_LedgerController.update();
      } else {
        // await Error_dialog(context: context, title: 'ERROR', content: value.message ?? "", onOk: () {});
      }
    } else {
      // Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
    }
    // loader.stop();
  }

  Future<void> gst_Ledger_refresh() async {
    await get_GST_LedgerList();
    gst_LedgerController.update();
  }

  void resetFilters() {
    gst_LedgerController.gst_LedgerModel.gst_Ledger_list.value = gst_LedgerController.gst_LedgerModel.ParentGST_Ledgers.value;
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

  void resetgst_LedgerFilters() {
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.GSTtype.value = 'Consolidate';
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.invoicetype.value = 'Show All';
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedsalescustomername.value = 'None';
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedcustomerid.value = '';
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value = 'None';

    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.fromdate.value = '';
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.todate.value = '';

    // gst_LedgerController.gst_LedgerModel.filteredgst_Ledgers.value = gst_LedgerController.gst_LedgerModel.gst_Ledger_list;
  }

  void assigngst_LedgerFilters() {
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.GSTtype.value = gst_LedgerController.gst_LedgerModel.selectedGSTtype.value;
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.invoicetype.value = gst_LedgerController.gst_LedgerModel.selectedInvoiceType.value;
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedsalescustomername.value = gst_LedgerController.gst_LedgerModel.selectedsalescustomer.value;
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value = gst_LedgerController.gst_LedgerModel.selectedsubcustomer.value;
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedcustomerid.value = gst_LedgerController.gst_LedgerModel.selectedcustomerID.value;
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.fromdate.value = gst_LedgerController.gst_LedgerModel.startDateController.value.text;
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.todate.value = gst_LedgerController.gst_LedgerModel.endDateController.value.text;
  }

  void reassigngst_LedgerFilters() {
    gst_LedgerController.gst_LedgerModel.selectedGSTtype.value = gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.GSTtype.value;
    gst_LedgerController.gst_LedgerModel.selectedInvoiceType.value = gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.invoicetype.value;
    gst_LedgerController.gst_LedgerModel.selectedsalescustomer.value = gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedsalescustomername.value;
    gst_LedgerController.gst_LedgerModel.selectedsubcustomer.value = gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value;
    gst_LedgerController.gst_LedgerModel.selectedcustomerID.value = gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedcustomerid.value;

    gst_LedgerController.gst_LedgerModel.startDateController.value.text = gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.fromdate.toString();
    gst_LedgerController.gst_LedgerModel.endDateController.value.text = gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.todate.toString();
    gst_LedgerController.gst_LedgerModel.selectedMonth.value = gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedmonth.value.toString();
  }
}
