// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:dashed_rect/dashed_rect.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/2.BILLING/Vouchers/controllers/voucher_action.dart';
import 'package:ssipl_billing/2.BILLING/Vouchers/models/entities/voucher_entities.dart';
import 'package:ssipl_billing/2.BILLING/Vouchers/services/voucher_service.dart';
import 'package:ssipl_billing/2.BILLING/Vouchers/views/club_voucher_receipt.dart';
import 'package:ssipl_billing/2.BILLING/Vouchers/views/receipt_pdf_template.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/controllers/Billing_actions.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/services/billing_services.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/PDF_methods/showPDF.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

class EditableTransactionRow {
  RxBool isEditing;
  TextEditingController controller;

  EditableTransactionRow(String initialText)
      : isEditing = false.obs,
        controller = TextEditingController(text: initialText);
}

class Voucher extends StatefulWidget with VoucherService, main_BillingService {
  Voucher({super.key});

  @override
  State<Voucher> createState() => _VoucherState();
}

class _VoucherState extends State<Voucher> {
  final VoucherController voucherController = Get.find<VoucherController>();
  final MainBilling_Controller mainBilling_Controller = Get.find<MainBilling_Controller>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RxList<EditableTransactionRow> editableRows = <EditableTransactionRow>[].obs;

  final loader = LoadingOverlay();
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _startInitialization();
  }

  bool _initialized = false;

  void _startInitialization() async {
    if (_initialized) return;
    _initialized = true;
    await Future.delayed(const Duration(milliseconds: 100));
    loader.start(context); // Now safe to use
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      widget.resetvoucherFilters();
      await widget.get_VoucherList();
      await widget.Get_SUBcustomerList();
      await widget.Get_SALEScustomerList();

      // Initialize checkboxValues after data is loaded
      // voucherController.voucherModel.checkboxValues = List<bool>.filled(voucherController.voucherModel.voucher_list.length, false).obs;
    });
    await Future.delayed(const Duration(seconds: 1));
    loader.stop();
  }

  final GlobalKey _invoiceCopyKey = GlobalKey();
  final GlobalKey _voucherCopyKey = GlobalKey();
  final GlobalKey _GSTcopyKey = GlobalKey();

  void _showCloseVoucherPopup(int index) {
    // final TextEditingController _closedDateController = TextEditingController(
    //   text: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    // );
    // final TextEditingController _referenceIdController = TextEditingController();
    // final TextEditingController _amountController = TextEditingController();
    // final TextEditingController _feedbackController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: Obx(
            () => Container(
              width: 850,
              decoration: BoxDecoration(
                color: Primary_colors.Light,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10))],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header with gradient
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Primary_colors.Color3, Primary_colors.Color3.withOpacity(0.8)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                            child: const Icon(Icons.receipt_long, color: Colors.white, size: 20),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'UPDATE VOUCHER PAYMENT',
                            style: TextStyle(color: Colors.white, fontSize: Primary_font_size.Text10, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                          ),
                          const Spacer(),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     color: Colors.white.withOpacity(0.2),
                          //     shape: BoxShape.circle,
                          //   ),
                          //   child: IconButton(
                          //     icon: const Icon(Icons.close, color: Colors.white),
                          //     onPressed: () => Navigator.of(context).pop(),
                          //   ),
                          // ),
                        ],
                      ),
                    ),

                    // Form Content
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Warning banner
                          voucherController.voucherModel.voucher_list[index].tdsCalculation == 1
                              ? Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Primary_colors.Dark,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: const Color.fromARGB(55, 243, 208, 96), width: 1),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.warning_amber_rounded, color: Color.fromARGB(255, 236, 190, 64), size: 20),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          "The cummulative invoice value exceeded Rs.One Lakh for this client!",
                                          style: TextStyle(color: Color.fromARGB(255, 236, 190, 64), fontWeight: FontWeight.w500, fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Primary_colors.Dark,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: const Color.fromARGB(55, 96, 243, 96), width: 1),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.warning_amber_rounded, color: Color.fromARGB(255, 64, 236, 87), size: 20),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          "The client hasn't exceeded transaction of 1 Lakh rupees, So this invoice is not Taxable!",
                                          style: TextStyle(color: Color.fromARGB(255, 133, 236, 64), fontWeight: FontWeight.w500, fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          const SizedBox(height: 20),

                          // Client and Invoice Info
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Primary_colors.Dark,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Primary_colors.Dark, width: 1),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Client Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(color: Primary_colors.Color3.withOpacity(0.1), shape: BoxShape.circle),
                                            child: const CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Primary_colors.Color3,
                                              child: Icon(Icons.person, color: Colors.white, size: 20),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Tooltip(
                                                  message: voucherController.voucherModel.voucher_list[index].clientName,
                                                  child: Text(
                                                    voucherController.voucherModel.voucher_list[index].clientName,
                                                    style: const TextStyle(overflow: TextOverflow.ellipsis, color: Colors.white, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text9),
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text("Client ID: ${voucherController.voucherModel.voucher_list[index].customerId}", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      _infoRow(Icons.location_on_outlined, voucherController.voucherModel.voucher_list[index].clientAddress),
                                      const SizedBox(height: 6),
                                      _infoRow(Icons.phone_android, voucherController.voucherModel.voucher_list[index].phoneNumber),
                                    ],
                                  ),
                                ),

                                // Vertical divider
                                Container(height: 120, width: 0.5, color: Colors.grey[500], margin: const EdgeInsets.symmetric(horizontal: 16)),

                                // Invoice Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Invoice Number",
                                            style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500),
                                          ),
                                          // Define a GlobalKey in your widget's state  // Inside your Row widget
                                          Row(
                                            children: [
                                              Text(
                                                voucherController.voucherModel.voucher_list[index].invoiceNumber,
                                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8),
                                              ),
                                              const SizedBox(width: 8),
                                              MouseRegion(
                                                cursor: SystemMouseCursors.click,
                                                child: GestureDetector(
                                                  key: _invoiceCopyKey, // Attach the key here
                                                  onTap: () async {
                                                    await Clipboard.setData(ClipboardData(text: voucherController.voucherModel.voucher_list[index].invoiceNumber));

                                                    final renderBox = _invoiceCopyKey.currentContext?.findRenderObject() as RenderBox?;
                                                    if (renderBox == null || !mounted) return; // Early exit if not rendered

                                                    final overlay = Overlay.of(context);
                                                    final overlayEntry = OverlayEntry(
                                                      builder: (context) => Positioned(
                                                        left: renderBox.localToGlobal(Offset.zero).dx + renderBox.size.width,
                                                        top: renderBox.localToGlobal(Offset.zero).dy,
                                                        child: Material(
                                                          color: Colors.transparent,
                                                          child: Container(
                                                            padding: const EdgeInsets.all(6),
                                                            decoration: BoxDecoration(color: const Color.fromARGB(119, 33, 149, 243).withOpacity(0.8), borderRadius: BorderRadius.circular(8)),
                                                            child: const Text(
                                                              "Copied!",
                                                              style: TextStyle(color: Colors.white, fontSize: Primary_font_size.Text5),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );

                                                    overlay.insert(overlayEntry);
                                                    Future.delayed(const Duration(seconds: 1), overlayEntry.remove);
                                                  },
                                                  child: const Icon(Icons.copy, color: Colors.grey, size: 18),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      _amountRow(
                                        "Invoice Amount",
                                        "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucherController.voucherModel.voucher_list[index].totalAmount)}",
                                        Colors.green,
                                      ),

                                      // const SizedBox(height: 12),
                                      // _amountRow(
                                      //   "Pending Amount:",
                                      //   "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format((voucherController.voucherModel.voucher_list[index].pendingAmount).roundToDouble())}",
                                      //   voucherController.voucherModel.voucher_list[index].pendingAmount > 0 ? const Color.fromARGB(255, 253, 206, 64) : Colors.grey,
                                      // ),
                                      const SizedBox(height: 12),
                                      Obx(() {
                                        return Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            _amountRow(
                                              "Receivable Amount",
                                              "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucherController.voucherModel.recievableAmount.value)}",
                                              Colors.amber,
                                            ),
                                            if (voucherController.voucherModel.voucher_list[index].pendingAmount != voucherController.voucherModel.recievableAmount.value)
                                              const Text(
                                                "- incl TDS",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(color: Colors.grey, fontSize: 8),
                                              ),
                                          ],
                                        );
                                      }),
                                      if (voucherController.voucherModel.voucher_list[index].paymentDetails != null)
                                        if (voucherController.voucherModel.voucher_list[index].paymentDetails!.isNotEmpty) const SizedBox(height: 12),
                                      if (voucherController.voucherModel.voucher_list[index].paymentDetails != null)
                                        if (voucherController.voucherModel.voucher_list[index].paymentDetails!.isNotEmpty) _buildLastPaymentInfo(index),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Form Fields and Payment Breakdown
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Form Fields
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Primary_colors.Dark,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Primary_colors.Dark, width: 1),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          if (voucherController.voucherModel.voucher_list[index].pendingAmount !=
                                              voucherController.voucherModel.voucher_list[index].tdsCalculationAmount.roundToDouble())
                                            _buildRadioTile(value: 'Partial', label: 'Partial', color: Colors.amber, index: index),
                                          if (voucherController.voucherModel.voucher_list[index].pendingAmount !=
                                              voucherController.voucherModel.voucher_list[index].tdsCalculationAmount.roundToDouble())
                                            const SizedBox(width: 12),
                                          _buildRadioTile(value: 'Full', label: 'Full', color: Colors.green, index: index),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      _buildEditableField(
                                        controller: voucherController.voucherModel.closedDateController,
                                        label: 'Payment received Date',
                                        hint: 'Select Payment received date',
                                        icon: Icons.calendar_today,
                                        onTap: () => select_nextDates(context, voucherController.voucherModel.closedDateController),
                                      ),
                                      const SizedBox(height: 16),
                                      _buildEditableField(
                                        controller: voucherController.voucherModel.amountCleared_controller.value,
                                        onChanged: (value) {
                                          voucherController.is_fullclear_Valid(index);
                                          voucherController.is_amountExceeds(index, voucherController.voucherModel.selectedValue.value);
                                          voucherController.update();
                                        },
                                        label: 'Amount Received',
                                        hint: 'Enter received amount',
                                        icon: Icons.attach_money,
                                        keyboardType: TextInputType.number,
                                        isNumber: true,
                                      ),
                                      const SizedBox(height: 5),
                                      if (voucherController.voucherModel.selectedValue.value == "Partial")
                                        Text(
                                          style: const TextStyle(color: Colors.amber, fontSize: 10),
                                          "    can clear upto  -  Rs.${((voucherController.voucherModel.voucher_list[index].pendingAmount - 1) - (voucherController.voucherModel.voucher_list[index].tdsCalculation == 1 ? voucherController.voucherModel.voucher_list[index].tdsCalculationAmount : 0.0)).roundToDouble()}",
                                        ),
                                      if (voucherController.voucherModel.voucher_list[index].tdsCalculation == 1 && voucherController.voucherModel.selectedValue.value == "Full")
                                        const SizedBox(height: 16),
                                      if (voucherController.voucherModel.voucher_list[index].tdsCalculation == 1 && voucherController.voucherModel.selectedValue.value == "Full")
                                        _buildDropdownField(
                                          label: 'TDS Status',
                                          hint: 'Select TDS status',
                                          icon: Icons.percent,
                                          items: ['Deducted', 'Not Deducted'],
                                          value: voucherController.voucherModel.is_Deducted.value ? 'Deducted' : 'Not Deducted',
                                          onChanged: (value) {
                                            if (value == "Deducted") {
                                              voucherController.set_isDeducted(true);
                                              voucherController.calculate_recievable(true, index, voucherController.voucherModel.selectedValue.value);
                                            } else {
                                              voucherController.set_isDeducted(false);
                                              voucherController.calculate_recievable(false, index, voucherController.voucherModel.selectedValue.value);
                                            }
                                            voucherController.is_fullclear_Valid(index);
                                            voucherController.is_amountExceeds(index, voucherController.voucherModel.selectedValue.value);
                                            voucherController.update();
                                          },
                                        ),
                                      const SizedBox(height: 16),
                                      _buildDropdownField(
                                        label: 'Payment Mode',
                                        hint: 'Select Payment Mode',
                                        icon: Icons.account_balance_wallet,
                                        items: ['Bank Transfer', 'UPI Payment', 'Cash Payment', 'Cheque'],
                                        value: voucherController.voucherModel.Selectedpaymentmode.value,
                                        onChanged: (value) {
                                          voucherController.voucherModel.Selectedpaymentmode.value = value!;
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      _buildEditableField(
                                        controller: voucherController.voucherModel.transactionDetails_controller.value,
                                        label: 'Transaction Reference',
                                        hint: 'Enter transaction ID/bank reference',
                                        icon: Icons.credit_card,
                                      ),
                                      const SizedBox(height: 16),
                                      _buildEditableField(
                                        controller: voucherController.voucherModel.feedback_controller.value,
                                        label: 'Payment Notes',
                                        hint: 'Any additional notes about this payment',
                                        icon: Icons.note,
                                        maxLines: 3,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),

                              // Payment Breakdown
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Primary_colors.Dark,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Primary_colors.Dark, width: 1),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "PAYMENT BREAKUP",
                                            style: TextStyle(color: Primary_colors.Color3, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 0.5),
                                          ),
                                          const SizedBox(height: 16),
                                          _buildBreakupLine("Net Amount", "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucherController.voucherModel.voucher_list[index].subTotal)}"),
                                          _buildBreakupDivider(),
                                          _buildBreakupLine("CGST (9%)", "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucherController.voucherModel.voucher_list[index].cgst)}"),
                                          _buildBreakupDivider(),
                                          _buildBreakupLine("SGST (9%)", "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucherController.voucherModel.voucher_list[index].sgst)}"),
                                          _buildBreakupDivider(),
                                          _buildBreakupLine("IGST", "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucherController.voucherModel.voucher_list[index].igst)}"),
                                          _buildBreakupDivider(),
                                          if (voucherController.voucherModel.voucher_list[index].tdsCalculation == 1)
                                            _buildBreakupLine(
                                              "TDS (2%)",
                                              "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucherController.voucherModel.voucher_list[index].tdsCalculationAmount)}",
                                            ),
                                          const SizedBox(height: 16),
                                          Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(color: Primary_colors.Color3.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Text(
                                                  "Total Amount",
                                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                                                ),
                                                Text(
                                                  "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucherController.voucherModel.voucher_list[index].totalAmount)}",
                                                  style: const TextStyle(color: Primary_colors.Color3, fontWeight: FontWeight.bold, fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 24),

                                    // Receipt Upload
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "UPLOAD PAYMENT DETAILS",
                                          style: TextStyle(color: Primary_colors.Color3, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5),
                                        ),
                                        const SizedBox(height: 8),
                                        SizedBox(
                                          height: 148,
                                          child: MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: GestureDetector(
                                              onTap: widget.pickFile,
                                              child: DashedRect(
                                                color: Primary_colors.Color3.withOpacity(0.5),
                                                strokeWidth: 1.5,
                                                gap: 3.0,
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Primary_colors.Dark),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.cloud_upload, size: 40, color: Primary_colors.Color3.withOpacity(0.7)),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        voucherController.voucherModel.fileName.value ?? 'Click to upload receipt',
                                                        style: TextStyle(
                                                          overflow: TextOverflow.ellipsis,
                                                          color: voucherController.voucherModel.fileName.value != null ? Primary_colors.Color3 : Colors.grey[600],
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      if (voucherController.voucherModel.fileName.value != null) ...[
                                                        const SizedBox(height: 4),
                                                        Text(
                                                          '${(voucherController.voucherModel.selectedFile.value?.lengthSync() ?? 0) / 1024} KB',
                                                          style: const TextStyle(overflow: TextOverflow.ellipsis, fontSize: 12, color: Colors.grey),
                                                        ),
                                                      ],
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 24),

                                        // Action Buttons
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                                side: const BorderSide(color: Colors.grey),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                              ),
                                              onPressed: () => Navigator.of(context).pop(),
                                              child: const Text(
                                                'CANCEL',
                                                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            if (voucherController.voucherModel.selectedValue.value == "Full") const SizedBox(width: 16),
                                            if (voucherController.voucherModel.selectedValue.value == "Full")
                                              voucherController.voucherModel.is_fullClear.value && voucherController.voucherModel.is_amountExceeds.value == false
                                                  ? ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Primary_colors.Color3,
                                                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                        elevation: 2,
                                                        shadowColor: Primary_colors.Color3.withOpacity(0.3),
                                                      ),
                                                      onPressed: () async {
                                                        // Start loader
                                                        loader.start(context);

                                                        // await Future.delayed(const Duration(milliseconds: 300));

                                                        // Generate PDF bytes using original code (unchanged)
                                                        final pdfBytes = await ReceiptPDFtemplate(
                                                            PdfPageFormat.a4,
                                                            ClearVoucher(
                                                              date: DateTime.parse(voucherController.voucherModel.closedDate.value),
                                                              voucherId: voucherController.voucherModel.voucher_list[index].voucher_id,
                                                              voucherNumber: voucherController.voucherModel.voucher_list[index].voucherNumber,
                                                              paymentStatus: voucherController.voucherModel.voucher_list[index].voucherType,
                                                              igst: voucherController.voucherModel.voucher_list[index].igst,
                                                              sgst: voucherController.voucherModel.voucher_list[index].sgst,
                                                              cgst: voucherController.voucherModel.voucher_list[index].cgst,
                                                              tds: voucherController.voucherModel.voucher_list[index].tdsCalculationAmount,
                                                              grossAmount: voucherController.voucherModel.voucher_list[index].totalAmount,
                                                              subtotal: voucherController.voucherModel.voucher_list[index].subTotal,
                                                              paidAmount: double.parse(voucherController.voucherModel.amountCleared_controller.value.text),
                                                              clientAddressName: voucherController.voucherModel.voucher_list[index].clientName,
                                                              clientAddress: voucherController.voucherModel.voucher_list[index].clientAddress,
                                                              invoiceNumber: voucherController.voucherModel.voucher_list[index].invoiceNumber,
                                                              emailId: voucherController.voucherModel.voucher_list[index].emailId,
                                                              phoneNo: voucherController.voucherModel.voucher_list[index].phoneNumber,
                                                              tdsStatus: voucherController.voucherModel.is_Deducted.value,
                                                              invoiceType: voucherController.voucherModel.voucher_list[index].invoiceType,
                                                              gstNumber: voucherController.voucherModel.voucher_list[index].gstNumber,
                                                              feedback: voucherController.voucherModel.feedback_controller.value.text,
                                                              transactionDetails: voucherController.voucherModel.transactionDetails_controller.value.text,
                                                              invoiceDate: voucherController.voucherModel.voucher_list[index].date ?? DateTime.now(),
                                                              paymentmode: voucherController.voucherModel.Selectedpaymentmode.value,
                                                            ));

                                                        // Get the system temp directory
                                                        Directory tempDir = await getTemporaryDirectory();
                                                        String safeInvoiceNo = voucherController.voucherModel.voucher_list[index].invoiceNumber.replaceAll('/', '-');
                                                        // Create folder path
                                                        String folderPath = '${tempDir.path}/$safeInvoiceNo';
                                                        Directory folder = Directory(folderPath);

                                                        // Ensure the folder exists
                                                        if (!await folder.exists()) {
                                                          await folder.create(recursive: true);
                                                        }
                                                        String tempFilePath = '$folderPath/Receipt_$safeInvoiceNo.pdf';
                                                        // Save the PDF
                                                        final receipt = File(tempFilePath);
                                                        await receipt.writeAsBytes(pdfBytes);

                                                        // Complete the voucher

                                                        // Optional success notification
                                                        // ScaffoldMessenger.of(context).showSnackBar(
                                                        //   SnackBar(
                                                        //     content: const Text('Voucher cleared and PDF saved successfully.'),
                                                        //     behavior: SnackBarBehavior.floating,
                                                        //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                        //     backgroundColor: Colors.green,
                                                        //   ),
                                                        // );

                                                        await widget.clearVoucher(context, index, voucherController.voucherModel.selectedFile.value, 'complete', receipt);
                                                        loader.stop();
                                                        // Generate unique filename with timestamp
                                                      },
                                                      child: const Text(
                                                        'CLEAR VOUCHER',
                                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                      ),
                                                    )
                                                  : voucherController.voucherModel.is_amountExceeds.value == true || voucherController.voucherModel.is_amountExceeds.value == null
                                                      ? Expanded(
                                                          child: const SizedBox(
                                                            width: 250,
                                                            child: Text("The recieved amount is either empty or exceeds the recievable amount",
                                                                style: TextStyle(color: Colors.amber, fontSize: Primary_font_size.Text5)),
                                                          ),
                                                        )
                                                      : MouseRegion(
                                                          cursor: SystemMouseCursors.forbidden,
                                                          child: Container(
                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.grey),
                                                            child: const Padding(
                                                              padding: EdgeInsets.all(8.0),
                                                              child: Text("CLEAR VOUCHER", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                                            ),
                                                          ),
                                                        ),

                                            // if (voucherController.voucherModel.selectedValue.value == "Full")
                                            //   voucherController.voucherModel.is_amountExceeds.value == false
                                            //       ? ElevatedButton(
                                            //           style: ElevatedButton.styleFrom(
                                            //             backgroundColor: Primary_colors.Color3,
                                            //             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                            //             shape: RoundedRectangleBorder(
                                            //               borderRadius: BorderRadius.circular(8),
                                            //             ),
                                            //             elevation: 2,
                                            //             shadowColor: Primary_colors.Color3.withOpacity(0.3),
                                            //           ),
                                            //           onPressed: () async {
                                            //             await widget.clearVoucher(context, index, voucherController.voucherModel.selectedFile.value, 'complete');
                                            //           },
                                            //           child: const Text(
                                            //             'CLEAR VOUCHER',
                                            //             style: TextStyle(
                                            //               color: Colors.white,
                                            //               fontWeight: FontWeight.bold,
                                            //             ),
                                            //           ),
                                            //         )
                                            //       : const SizedBox(
                                            //           width: 250,
                                            //           child: Text(
                                            //             "The recieved amount is either empty or exceeds the recievable amount",
                                            //             style: TextStyle(color: Colors.amber, fontSize: 12),
                                            //           )),
                                            if (voucherController.voucherModel.selectedValue.value == "Partial") const SizedBox(width: 16),
                                            if (voucherController.voucherModel.selectedValue.value == "Partial")
                                              (voucherController.voucherModel.is_amountExceeds.value == false)
                                                  ? ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.orange,
                                                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                        elevation: 2,
                                                      ),
                                                      onPressed: () async {
                                                        loader.start(context);
                                                        bool type = voucherController.voucherModel.voucher_list[index].pendingAmount ==
                                                            double.parse(voucherController.voucherModel.amountCleared_controller.value.text);
                                                        await Future.delayed(const Duration(milliseconds: 300));

                                                        // Generate PDF bytes using original code (unchanged)
                                                        final pdfBytes = await ReceiptPDFtemplate(
                                                          PdfPageFormat.a4,
                                                          ClearVoucher(
                                                            date: DateTime.parse(voucherController.voucherModel.closedDate.value),
                                                            voucherId: voucherController.voucherModel.voucher_list[index].voucher_id,
                                                            voucherNumber: voucherController.voucherModel.voucher_list[index].voucherNumber,
                                                            paymentStatus: voucherController.voucherModel.voucher_list[index].voucherType,
                                                            igst: voucherController.voucherModel.voucher_list[index].igst,
                                                            sgst: voucherController.voucherModel.voucher_list[index].sgst,
                                                            cgst: voucherController.voucherModel.voucher_list[index].cgst,
                                                            tds: voucherController.voucherModel.voucher_list[index].tdsCalculationAmount,
                                                            grossAmount: voucherController.voucherModel.voucher_list[index].totalAmount,
                                                            subtotal: voucherController.voucherModel.voucher_list[index].subTotal,
                                                            paidAmount: double.parse(voucherController.voucherModel.amountCleared_controller.value.text),
                                                            clientAddressName: voucherController.voucherModel.voucher_list[index].clientName,
                                                            clientAddress: voucherController.voucherModel.voucher_list[index].clientAddress,
                                                            invoiceNumber: voucherController.voucherModel.voucher_list[index].invoiceNumber,
                                                            emailId: voucherController.voucherModel.voucher_list[index].emailId,
                                                            phoneNo: voucherController.voucherModel.voucher_list[index].phoneNumber,
                                                            tdsStatus: voucherController.voucherModel.is_Deducted.value,
                                                            invoiceType: voucherController.voucherModel.voucher_list[index].invoiceType,
                                                            gstNumber: voucherController.voucherModel.voucher_list[index].gstNumber,
                                                            feedback: voucherController.voucherModel.feedback_controller.value.text,
                                                            transactionDetails: voucherController.voucherModel.transactionDetails_controller.value.text,
                                                            invoiceDate: voucherController.voucherModel.voucher_list[index].date ?? DateTime.now(),
                                                            paymentmode: voucherController.voucherModel.Selectedpaymentmode.value,
                                                          ),
                                                        );
                                                        // Get the system temp directory
                                                        Directory tempDir = await getTemporaryDirectory();
                                                        String safeInvoiceNo = voucherController.voucherModel.voucher_list[index].invoiceNumber.replaceAll('/', '-');
                                                        // Create folder path
                                                        String folderPath = '${tempDir.path}/$safeInvoiceNo';
                                                        Directory folder = Directory(folderPath);

                                                        // Ensure the folder exists
                                                        if (!await folder.exists()) {
                                                          await folder.create(recursive: true);
                                                        }
                                                        String tempFilePath = '$folderPath/Receipt_$safeInvoiceNo.pdf';
                                                        // Save the PDF
                                                        final receipt = File(tempFilePath);
                                                        await receipt.writeAsBytes(pdfBytes);

                                                        // Complete the voucher

                                                        // Optional success notification
                                                        // ScaffoldMessenger.of(context).showSnackBar(
                                                        //   SnackBar(
                                                        //     content: const Text('Voucher cleared and PDF saved successfully.'),
                                                        //     behavior: SnackBarBehavior.floating,
                                                        //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                        //     backgroundColor: Colors.green,
                                                        //   ),
                                                        // );
                                                        await widget.clearVoucher(context, index, voucherController.voucherModel.selectedFile.value, type ? 'complete' : 'partial', receipt);
                                                        // Navigator.of(context).pop();
                                                        // ScaffoldMessenger.of(context).showSnackBar(
                                                        //   SnackBar(
                                                        //     content: const Text('Voucher partially cleared'),
                                                        //     behavior: SnackBarBehavior.floating,
                                                        //     shape: RoundedRectangleBorder(
                                                        //       borderRadius: BorderRadius.circular(8),
                                                        //     ),
                                                        //     backgroundColor: Colors.blue,
                                                        //   ),
                                                        // );
                                                        loader.stop();
                                                      },
                                                      child: const Text(
                                                        'PARTIALLY CLEAR',
                                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                      ),
                                                    )
                                                  : Expanded(
                                                      child: const SizedBox(
                                                        width: 250,
                                                        child: Text(
                                                          "1. The recieved amount is either empty\n2. Partial payment is limited to 98% of the Gross amount",
                                                          style: TextStyle(color: Colors.amber, fontSize: Primary_font_size.Text6),
                                                        ),
                                                      ),
                                                    ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _show_MultipleCloseVoucherPopup(SelectedInvoiceVoucherGroup selectedVouchers) {
    // final TextEditingController _closedDateController = TextEditingController(
    //   text: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    // );
    // final TextEditingController _referenceIdController = TextEditingController();
    // final TextEditingController _amountController = TextEditingController();
    // final TextEditingController _feedbackController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: Obx(
            () => Container(
              width: 850,
              decoration: BoxDecoration(
                color: Primary_colors.Light,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10))],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header with gradient
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Primary_colors.Color3, Primary_colors.Color3.withOpacity(0.8)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                            child: const Icon(Icons.receipt_long, color: Colors.white, size: 20),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'UPDATE CONSOLIDATE VOUCHER PAYMENT',
                            style: TextStyle(color: Colors.white, fontSize: Primary_font_size.Text10, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                          ),
                          const Spacer(),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     color: Colors.white.withOpacity(0.2),
                          //     shape: BoxShape.circle,
                          //   ),
                          //   child: IconButton(
                          //     icon: const Icon(Icons.close, color: Colors.white),
                          //     onPressed: () => Navigator.of(context).pop(),
                          //   ),
                          // ),
                        ],
                      ),
                    ),

                    // Form Content
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Warning banner
                          // voucherController.voucherModel.voucher_list[index].tdsCalculation == 1
                          //     ? Container(
                          //         width: double.infinity,
                          //         padding: const EdgeInsets.all(12),
                          //         decoration: BoxDecoration(
                          //           color: Primary_colors.Dark,
                          //           borderRadius: BorderRadius.circular(8),
                          //           border: Border.all(
                          //             color: const Color.fromARGB(55, 243, 208, 96),
                          //             width: 1,
                          //           ),
                          //         ),
                          //         child: const Row(
                          //           children: [
                          //             Icon(Icons.warning_amber_rounded, color: Color.fromARGB(255, 236, 190, 64), size: 20),
                          //             SizedBox(width: 8),
                          //             Expanded(
                          //               child: Text(
                          //                 "Client have exceeded the transaction of 1 Lakh, so this invoice is TDS Deductable!",
                          //                 style: TextStyle(
                          //                   color: Color.fromARGB(255, 236, 190, 64),
                          //                   fontWeight: FontWeight.w500,
                          //                   fontSize: 12,
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       )
                          // :
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Primary_colors.Dark,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color.fromARGB(55, 96, 243, 96), width: 1),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.warning_amber_rounded, color: Color.fromARGB(255, 64, 236, 87), size: 20),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "The cummulative invoice value exceeded Rs.One Lakh for this client!",
                                    style: TextStyle(color: Color.fromARGB(255, 133, 236, 64), fontWeight: FontWeight.w500, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Client and Invoice Info
                          Container(
                            height: 200,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Primary_colors.Dark,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Primary_colors.Dark, width: 1),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Client Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total amount  :   Rs.${formatCurrency(voucherController.voucherModel.is_Deducted.value ? selectedVouchers.totalPendingAmount_withTDS : selectedVouchers.totalPendingAmount_withoutTDS)}",
                                        style: const TextStyle(fontSize: 20, color: Colors.lightGreenAccent),
                                      ),
                                      // Row(
                                      //   children: [
                                      //     Container(
                                      //       padding: const EdgeInsets.all(4),
                                      //       decoration: BoxDecoration(
                                      //         color: Primary_colors.Color3.withOpacity(0.1),
                                      //         shape: BoxShape.circle,
                                      //       ),
                                      //       child: const CircleAvatar(
                                      //         radius: 20,
                                      //         backgroundColor: Primary_colors.Color3,
                                      //         child: Icon(Icons.person, color: Colors.white, size: 20),
                                      //       ),
                                      //     ),
                                      //     const SizedBox(width: 12),
                                      //     Expanded(
                                      //       child: Column(
                                      //         crossAxisAlignment: CrossAxisAlignment.start,
                                      //         children: [
                                      //           Tooltip(
                                      //             message: voucherController.voucherModel.voucher_list[index].clientName,
                                      //             child: Text(
                                      //               voucherController.voucherModel.voucher_list[index].clientName,
                                      //               style: const TextStyle(overflow: TextOverflow.ellipsis, color: Colors.white, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text9),
                                      //             ),
                                      //           ),
                                      //           const SizedBox(height: 4),
                                      //           Text(
                                      //             "Client ID: ${voucherController.voucherModel.voucher_list[index].customerId}",
                                      //             style: const TextStyle(color: Colors.grey, fontSize: 11),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      const SizedBox(height: 12),
                                      Expanded(
                                        child: ListView.separated(
                                          itemCount: selectedVouchers.selectedVoucherList.length,
                                          separatorBuilder: (context, index) => const Divider(color: Color.fromARGB(255, 94, 94, 94), thickness: 1, indent: 20, endIndent: 20),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "${(index + 1).toString()}. ", // Placeholder for extra details
                                                    style: const TextStyle(letterSpacing: 1, color: Primary_colors.Color7, fontSize: Primary_font_size.Text6),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          selectedVouchers.selectedVoucherList[index].voucherNumber,
                                                          style: const TextStyle(letterSpacing: 1, color: Primary_colors.Color1, fontSize: Primary_font_size.Text7, fontWeight: FontWeight.w600),
                                                        ),
                                                        Container(height: 20, width: 0.5, color: Colors.grey[500], margin: const EdgeInsets.symmetric(horizontal: 10)),
                                                        // Text(
                                                        //   selectedVouchers.selectedVoucherList[index].totalAmount.toString(), // Placeholder for extra details
                                                        //   style: const TextStyle(
                                                        //     // letterSpacing: 1,
                                                        //     color: Primary_colors.Color7,
                                                        //     fontSize: Primary_font_size.Text6,
                                                        //   ),
                                                        // ),
                                                        // Container(
                                                        //   height: 20,
                                                        //   width: 0.5,
                                                        //   color: Colors.grey[500],
                                                        //   margin: const EdgeInsets.symmetric(horizontal: 16),
                                                        // ),
                                                        Text(
                                                          "CGST : Rs.${formatCurrency(selectedVouchers.selectedVoucherList[index].cgst)}", // Placeholder for extra details
                                                          style: const TextStyle(
                                                            // letterSpacing: 1,
                                                            color: Primary_colors.Color7,
                                                            fontSize: Primary_font_size.Text6,
                                                          ),
                                                        ),
                                                        Container(height: 20, width: 0.5, color: Colors.grey[500], margin: const EdgeInsets.symmetric(horizontal: 10)),
                                                        Text(
                                                          "SGST : Rs.${formatCurrency(selectedVouchers.selectedVoucherList[index].sgst)}", // Placeholder for extra details
                                                          style: const TextStyle(
                                                            // letterSpacing: 1,
                                                            color: Primary_colors.Color7,
                                                            fontSize: Primary_font_size.Text6,
                                                          ),
                                                        ),
                                                        Container(height: 20, width: 0.5, color: Colors.grey[500], margin: const EdgeInsets.symmetric(horizontal: 10)),
                                                        Text(
                                                          "IGST : Rs.${formatCurrency(selectedVouchers.selectedVoucherList[index].igst)}", // Placeholder for extra details
                                                          style: const TextStyle(
                                                            // letterSpacing: 1,
                                                            color: Primary_colors.Color7,
                                                            fontSize: Primary_font_size.Text6,
                                                          ),
                                                        ),
                                                        Container(height: 20, width: 0.5, color: Colors.grey[500], margin: const EdgeInsets.symmetric(horizontal: 10)),
                                                        Text(
                                                          "TDS : Rs.${formatCurrency(selectedVouchers.selectedVoucherList[index].tdsCalculationAmount)}", // Placeholder for extra details
                                                          style: const TextStyle(
                                                            // letterSpacing: 1,
                                                            color: Primary_colors.Color7,
                                                            fontSize: Primary_font_size.Text6,
                                                          ),
                                                        ),
                                                        Container(height: 20, width: 0.5, color: Colors.grey[500], margin: const EdgeInsets.symmetric(horizontal: 10)),
                                                        Text(
                                                          "Total : Rs.${formatCurrency(selectedVouchers.selectedVoucherList[index].totalAmount)}", // Placeholder for extra details
                                                          style: const TextStyle(
                                                            // letterSpacing: 1,
                                                            color: Primary_colors.Color7,
                                                            fontSize: Primary_font_size.Text6,
                                                          ),
                                                        ),
                                                        // Container(
                                                        //   height: 20,
                                                        //   width: 0.5,
                                                        //   color: Colors.grey[500],
                                                        //   margin: const EdgeInsets.symmetric(horizontal: 16),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                  // ShaderMask(
                                                  //   shaderCallback: (bounds) => const LinearGradient(
                                                  //     colors: [Primary_colors.Color3, Primary_colors.Color3],
                                                  //     begin: Alignment.topLeft,
                                                  //     end: Alignment.bottomRight,
                                                  //   ).createShader(bounds),
                                                  //   child: const Icon(
                                                  //     Icons.arrow_forward_ios,
                                                  //     size: 16,
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Vertical divider
                                // Container(
                                //   height: 120,
                                //   width: 0.5,
                                //   color: Colors.grey[500],
                                //   margin: const EdgeInsets.symmetric(horizontal: 16),
                                // ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Form Fields and Payment Breakdown
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Form Fields
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Primary_colors.Dark,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Primary_colors.Dark, width: 1),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Row(
                                      //   children: [
                                      //     _buildRadioTile(value: 'Partial', label: 'Partial', color: Colors.amber, index: index),
                                      //     const SizedBox(width: 12),
                                      //     _buildRadioTile(value: 'Full', label: 'Full', color: Colors.green, index: index),
                                      //   ],
                                      // ),
                                      const SizedBox(height: 16),
                                      _buildEditableField(
                                        controller: voucherController.voucherModel.closedDateController,
                                        label: 'Payment received Date',
                                        hint: 'Select Payment received date',
                                        icon: Icons.calendar_today,
                                        onTap: () => select_nextDates(context, voucherController.voucherModel.closedDateController),
                                      ),
                                      const SizedBox(height: 16),
                                      _buildEditableField(
                                        controller: voucherController.voucherModel.amountCleared_controller.value,
                                        onChanged: (value) {
                                          voucherController.is_Club_fullclear_Valid(
                                            voucherController.voucherModel.is_Deducted.value ? selectedVouchers.totalPendingAmount_withTDS : selectedVouchers.totalPendingAmount_withoutTDS,
                                          );
                                          // voucherController.is_amountExceeds(index);
                                          voucherController.update();
                                          // setState(() {});
                                        },
                                        label: 'Amount Received',
                                        hint: 'Enter received amount',
                                        icon: Icons.attach_money,
                                        keyboardType: TextInputType.number,
                                        isNumber: true,
                                      ),
                                      const SizedBox(height: 5),
                                      // if (voucherController.voucherModel.selectedValue.value == "Partial")
                                      //   Text(
                                      //       style: const TextStyle(color: Colors.amber, fontSize: 10),
                                      //       "    can clear upto  -  Rs.${(voucherController.voucherModel.voucher_list[index].pendingAmount - (voucherController.voucherModel.voucher_list[index].tdsCalculation == 1 ? voucherController.voucherModel.voucher_list[index].tdsCalculationAmount : 0.0)).roundToDouble()}"),
                                      // if (voucherController.voucherModel.voucher_list[index].tdsCalculation == 1 && voucherController.voucherModel.selectedValue.value == "Full")
                                      const SizedBox(height: 16),
                                      // if (voucherController.voucherModel.voucher_list[index].tdsCalculation == 1 && voucherController.voucherModel.selectedValue.value == "Full")
                                      _buildDropdownField(
                                        label: 'TDS Status',
                                        hint: 'Select TDS status',
                                        icon: Icons.percent,
                                        items: ['Deducted', 'Not Deducted'],
                                        value: voucherController.voucherModel.is_Deducted.value ? 'Deducted' : 'Not Deducted',
                                        onChanged: (value) {
                                          if (value == "Deducted") {
                                            voucherController.set_isDeducted(true);
                                            voucherController.is_Club_fullclear_Valid(
                                              voucherController.voucherModel.is_Deducted.value ? selectedVouchers.totalPendingAmount_withTDS : selectedVouchers.totalPendingAmount_withoutTDS,
                                            );
                                            // voucherController.calculate_recievable(true, index);
                                          } else {
                                            voucherController.set_isDeducted(false);
                                            voucherController.is_Club_fullclear_Valid(
                                              voucherController.voucherModel.is_Deducted.value ? selectedVouchers.totalPendingAmount_withTDS : selectedVouchers.totalPendingAmount_withoutTDS,
                                            );
                                            // voucherController.calculate_recievable(false, index);
                                          }
                                          // voucherController.is_fullclear_Valid(index);
                                          // voucherController.is_amountExceeds(index);
                                          voucherController.update();
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      _buildDropdownField(
                                        label: 'Payment Mode',
                                        hint: 'Select Payment Mode',
                                        icon: Icons.account_balance_wallet,
                                        items: ['Bank Transfer', 'UPI Payment', 'Cash Payment', 'Cheque'],
                                        value: voucherController.voucherModel.Selectedpaymentmode.value,
                                        onChanged: (value) {
                                          voucherController.voucherModel.Selectedpaymentmode.value = value!;
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      _buildEditableField(
                                        controller: voucherController.voucherModel.transactionDetails_controller.value,
                                        label: 'Transaction Reference',
                                        hint: 'Enter transaction ID/bank reference',
                                        icon: Icons.credit_card,
                                      ),
                                      const SizedBox(height: 16),
                                      _buildEditableField(
                                        controller: voucherController.voucherModel.feedback_controller.value,
                                        label: 'Payment Notes',
                                        hint: 'Any additional notes about this payment',
                                        icon: Icons.note,
                                        maxLines: 3,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),

                              // Payment Breakdown
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Primary_colors.Dark,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Primary_colors.Dark, width: 1),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "PAYMENT BREAKUP",
                                            style: TextStyle(color: Primary_colors.Color3, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 0.5),
                                          ),
                                          const SizedBox(height: 16),
                                          _buildBreakupLine("Net Amount", "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(selectedVouchers.netAmount)}"),
                                          _buildBreakupDivider(),
                                          _buildBreakupLine("CGST (9%)", "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(selectedVouchers.totalCGST)}"),
                                          _buildBreakupDivider(),
                                          _buildBreakupLine("SGST (9%)", "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(selectedVouchers.totalSGST)}"),
                                          _buildBreakupDivider(),
                                          _buildBreakupLine("IGST", "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(selectedVouchers.totalIGST)}"),
                                          _buildBreakupDivider(),
                                          // if (voucherController.voucherModel.voucher_list[index].tdsCalculation == 1)
                                          _buildBreakupLine("TDS (2%)", "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(selectedVouchers.totalTDS)}"),
                                          const SizedBox(height: 16),
                                          Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(color: Primary_colors.Color3.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Text(
                                                  "Total Amount",
                                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                                                ),
                                                Text(
                                                  "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(selectedVouchers.totalPendingAmount_withoutTDS)}",
                                                  style: const TextStyle(color: Primary_colors.Color3, fontWeight: FontWeight.bold, fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 24),

                                    // Receipt Upload
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "UPLOAD PAYMENT DETAILS",
                                          style: TextStyle(color: Primary_colors.Color3, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5),
                                        ),
                                        const SizedBox(height: 8),
                                        SizedBox(
                                          height: 118,
                                          child: MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: GestureDetector(
                                              onTap: widget.pickFile,
                                              child: DashedRect(
                                                color: Primary_colors.Color3.withOpacity(0.5),
                                                strokeWidth: 1.5,
                                                gap: 3.0,
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Primary_colors.Dark),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.cloud_upload, size: 40, color: Primary_colors.Color3.withOpacity(0.7)),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        voucherController.voucherModel.fileName.value ?? 'Click to upload receipt',
                                                        style: TextStyle(
                                                          overflow: TextOverflow.ellipsis,
                                                          color: voucherController.voucherModel.fileName.value != null ? Primary_colors.Color3 : Colors.grey[600],
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      if (voucherController.voucherModel.fileName.value != null) ...[
                                                        const SizedBox(height: 4),
                                                        Text(
                                                          '${(voucherController.voucherModel.selectedFile.value?.lengthSync() ?? 0) / 1024} KB',
                                                          style: const TextStyle(overflow: TextOverflow.ellipsis, fontSize: 12, color: Colors.grey),
                                                        ),
                                                      ],
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),

                                    // Action Buttons
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                            side: const BorderSide(color: Colors.grey),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                          ),
                                          onPressed: () => Navigator.of(context).pop(),
                                          child: const Text(
                                            'CANCEL',
                                            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        voucherController.voucherModel.is_fullClear.value
                                            ? ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Primary_colors.Color3,
                                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                  elevation: 2,
                                                  shadowColor: Primary_colors.Color3.withOpacity(0.3),
                                                ),
                                                onPressed: () async {
                                                  List<Map<String, dynamic>> consolidateJSON = [];
                                                  List<int> voucherIds = [];
                                                  List<String> voucherNumbers = [];
                                                  List<String> invoiceNumbers = [];
                                                  List<InvoiceDetails> invoiceDetails = [];
                                                  List<double> grossamount = [];
                                                  List<String> customerids = [];
                                                  for (int i = 0; i < selectedVouchers.selectedVoucherList.length; i++) {
                                                    voucherIds.add(selectedVouchers.selectedVoucherList[i].voucher_id);
                                                    voucherNumbers.add(selectedVouchers.selectedVoucherList[i].voucherNumber);
                                                    invoiceNumbers.add(selectedVouchers.selectedVoucherList[i].invoiceNumber);
                                                    customerids.add(selectedVouchers.selectedVoucherList[i].customerId);
                                                    invoiceDetails.add(InvoiceDetails(
                                                      invoiceDate: selectedVouchers.selectedVoucherList[i].date!,
                                                      invoiceNumber: selectedVouchers.selectedVoucherList[i].invoiceNumber,
                                                    ));
                                                    grossamount.add(selectedVouchers.selectedVoucherList[i].totalAmount);
                                                  }
                                                  final pdfBytes = await ClubVoucherReceiptPDf(
                                                    PdfPageFormat.a4,
                                                    ClubVoucher_data(
                                                      date: DateTime.parse(voucherController.voucherModel.closedDate.value),
                                                      totalPaidAmount: voucherController.voucherModel.is_Deducted.value
                                                          ? selectedVouchers.totalPendingAmount_withTDS
                                                          : selectedVouchers.totalPendingAmount_withoutTDS,
                                                      tdsStatus: voucherController.voucherModel.is_Deducted.value,
                                                      paymentStatus: 'complete',
                                                      feedback: voucherController.voucherModel.feedback_controller.value.text,
                                                      transactionDetails: voucherController.voucherModel.transactionDetails_controller.value.text,
                                                      voucherIds: voucherIds,
                                                      voucherNumbers: voucherNumbers,
                                                      voucherList: consolidateJSON,
                                                      invoiceNumbers: invoiceNumbers,
                                                      clientAddressName: selectedVouchers.selectedVoucherList[0].clientName,
                                                      clientAddress: selectedVouchers.selectedVoucherList[0].clientAddress,
                                                      invoiceDate: voucherController.voucherModel.voucher_list[0].date!,
                                                      invoicedetails: invoiceDetails,
                                                      grossAmount: grossamount.fold(0.0, (sum, item) => sum + item),
                                                      selectedInvoiceGroup: selectedVouchers,
                                                      paymentmode: voucherController.voucherModel.Selectedpaymentmode.value,
                                                      customerids: customerids,
                                                    ),
                                                  );

                                                  // Get the system temp directory
                                                  Directory tempDir = await getTemporaryDirectory();
                                                  String safeInvoiceNo = 'club';
                                                  // Create folder path
                                                  String folderPath = '${tempDir.path}/$safeInvoiceNo';
                                                  Directory folder = Directory(folderPath);

                                                  // Ensure the folder exists
                                                  if (!await folder.exists()) {
                                                    await folder.create(recursive: true);
                                                  }
                                                  String tempFilePath = '$folderPath/Receipt_$safeInvoiceNo.pdf';
                                                  // Save the PDF
                                                  final receipt = File(tempFilePath);
                                                  await receipt.writeAsBytes(pdfBytes);

                                                  await widget.clear_ClubVoucher(context, selectedVouchers, voucherController.voucherModel.selectedFile.value, receipt);
                                                },
                                                child: const Text(
                                                  'CLEAR VOUCHER',
                                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                ),
                                              )
                                            : voucherController.voucherModel.is_amountExceeds.value == true || voucherController.voucherModel.is_amountExceeds.value == null
                                                ? Expanded(
                                                    child: const SizedBox(
                                                      width: 250,
                                                      child: Text("The recieved amount is either empty or exceeds the recievable amount",
                                                          style: TextStyle(color: Colors.amber, fontSize: Primary_font_size.Text6)),
                                                    ),
                                                  )
                                                : MouseRegion(
                                                    cursor: SystemMouseCursors.forbidden,
                                                    child: Container(
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.grey),
                                                      child: const Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Text("CLEAR VOUCHER", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                                      ),
                                                    ),
                                                  ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.grey, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ),
      ],
    );
  }

  Widget _buildEditableField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isNumber = false,
    VoidCallback? onTap,
    ValueChanged<String>? onChanged,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500, letterSpacing: 0.5),
        ),
        const SizedBox(height: 3),
        TextFormField(
          onChanged: onChanged,
          controller: controller,
          readOnly: onTap != null,
          onTap: onTap,
          inputFormatters: isNumber ? [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))] : null,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Primary_colors.Light,
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: Primary_font_size.Text8),
            prefixIcon: Icon(icon, color: Primary_colors.Color3, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Primary_colors.Color3, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          ),
          style: const TextStyle(fontSize: Primary_font_size.Text8, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required IconData icon,
    required List<String> items,
    required String? value, // Add this
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey, letterSpacing: 0.5)),
        const SizedBox(height: 3),
        DropdownButtonFormField<String>(
          value: value ?? (items.isNotEmpty ? items[0] : null), // Default to first item
          hint: Text(
            hint,
            style: TextStyle(fontSize: Primary_font_size.Text8, color: Colors.grey[400], letterSpacing: 0.5),
          ),
          dropdownColor: Primary_colors.Light,
          decoration: InputDecoration(
            filled: true,
            fillColor: Primary_colors.Light,
            prefixIcon: Icon(icon, color: Primary_colors.Color3, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Primary_colors.Color3, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          ),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(color: Colors.white)),
            );
          }).toList(),
          onChanged: onChanged,
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
      ],
    );
  }

  Widget _amountRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }

  Widget _buildLastPaymentInfo(int index) {
    OverlayEntry? overlayEntry;
    bool isOverlayVisible = false;

    void removePopup() {
      if (!isOverlayVisible) return;
      overlayEntry?.remove();
      overlayEntry = null;
      isOverlayVisible = false;
    }

    void showPopup(BuildContext context) {
      if (isOverlayVisible) return;
      isOverlayVisible = true;

      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final Offset offset = renderBox.localToGlobal(Offset.zero);

      overlayEntry = OverlayEntry(
        builder: (_) => GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            removePopup();
          },
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: offset.dy + 30,
                child: Material(
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: () {}, // Prevent tap from bubbling up
                    child: Container(
                      width: 220,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "PAYMENT HISTORY",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87),
                          ),
                          const SizedBox(height: 8),
                          ...voucherController.voucherModel.voucher_list[index].paymentDetails!.asMap().entries.map((entry) {
                            final paymentIndex = entry.key;
                            final payment = entry.value;
                            return _buildPaymentHistoryItem(formatDate(payment.date), "₹${payment.amount}", index, paymentIndex);
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      Overlay.of(context).insert(overlayEntry!);
    }

    return Builder(
      builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Last payment: ",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
            ),
            const SizedBox(width: 4),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => showPopup(context),
              child: GestureDetector(
                onTap: () {
                  if (isOverlayVisible) {
                    removePopup();
                  } else {
                    showPopup(context);
                  }
                },
                child: Row(
                  children: [
                    Text(
                      "${formatDate(voucherController.voucherModel.voucher_list[index].paymentDetails![0].date)} - ₹${formatCurrency(double.parse(voucherController.voucherModel.voucher_list[index].paymentDetails![0].amount.toString()))}",
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Primary_colors.Color3),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.info_outline, color: Primary_colors.Color3, size: 14),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPaymentHistoryItem(String date, String amount, int voucherIndex, int transactionIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Row(
            children: [
              Text(
                amount,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              IconButton(
                onPressed: () async {
                  bool success = await widget.Get_transactionPDFfile(
                    context: context,
                    transactionID: voucherController.voucherModel.voucher_list[voucherIndex].paymentDetails![transactionIndex].transactionId,
                  );
                  if (success) {
                    showPDF(context, "TRANSACTION_${voucherController.voucherModel.voucher_list[voucherIndex].paymentDetails?[transactionIndex].transactionId}",
                        mainBilling_Controller.billingModel.pdfFile.value);
                  }
                },
                icon: Image.asset(height: 30, 'assets/images/pdfdownload.png'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBreakupLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 12),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakupDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Divider(height: 1, color: Colors.grey, thickness: 0.2),
    );
  }

  Widget _buildRadioTile({
    required String value,
    required String label,
    required Color color,
    required int index,
  }) {
    return Expanded(
      child: Obx(() {
        final isSelected = voucherController.voucherModel.selectedValue.value == value;

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              voucherController.voucherModel.selectedValue.value = value;
              if (value == 'Partial') {
                voucherController.resetAmountCleared();
                voucherController.set_isDeducted(false);
                voucherController.calculate_recievable(true, index, value);
              } else {
                voucherController.resetAmountCleared();
                voucherController.set_isDeducted(true);
                voucherController.calculate_recievable(true, index, value);
              }
              voucherController.is_fullclear_Valid(index);
              voucherController.is_amountExceeds(index, 'partial');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 0),
              decoration: BoxDecoration(
                color: isSelected ? color.withOpacity(0.15) : Colors.grey.shade900,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: isSelected ? color : Colors.grey.shade700, width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<String>(
                    value: value,
                    groupValue: voucherController.voucherModel.selectedValue.value,
                    activeColor: color,
                    onChanged: (val) {
                      voucherController.voucherModel.selectedValue.value = val!;
                      if (val == 'Partial') {
                        voucherController.resetAmountCleared();
                        voucherController.set_isDeducted(false);
                        voucherController.calculate_recievable(true, index, val);
                      } else {
                        voucherController.resetAmountCleared();
                        voucherController.set_isDeducted(true);
                        voucherController.calculate_recievable(true, index, val);
                      }
                      voucherController.is_fullclear_Valid(index);
                      voucherController.is_amountExceeds(index, 'partial');
                    },
                  ),
                  const SizedBox(width: 4),
                  Text(
                    label,
                    style: TextStyle(
                      color: isSelected ? color : Colors.grey[300],
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(voucherController.voucherModel.voucher_list.length);
    // loader.stop();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      endDrawer: _buildFilterDrawer(),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const SizedBox(width: 3),
                          const Text(
                            'Vouchers',
                            style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text12),
                          ),
                          Expanded(
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              child: Obx(
                                () => SizedBox(
                                  height: 20,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        if (voucherController.voucherModel.voucherSelectedFilter.value.vouchertype.value != 'Show All')
                                          _buildselectedFiltersChip(
                                            voucherController.voucherModel.voucherSelectedFilter.value.vouchertype.value,
                                            onRemove: () {
                                              voucherController.voucherModel.voucherSelectedFilter.value.vouchertype.value = 'Show All';
                                            },
                                          ),
                                        if (voucherController.voucherModel.voucherSelectedFilter.value.invoicetype.value != 'Show All')
                                          Row(
                                            children: [
                                              const SizedBox(width: 5),
                                              _buildselectedFiltersChip(
                                                voucherController.voucherModel.voucherSelectedFilter.value.invoicetype.value,
                                                onRemove: () {
                                                  voucherController.voucherModel.voucherSelectedFilter.value.invoicetype.value = 'Show All';
                                                  voucherController.voucherModel.voucherSelectedFilter.value.selectedsalescustomername.value = 'None';
                                                  voucherController.voucherModel.voucherSelectedFilter.value.selectedsubscriptioncustomername.value = 'None';
                                                  voucherController.voucherModel.voucherSelectedFilter.value.selectedcustomerid.value = 'None';
                                                },
                                              ),
                                            ],
                                          ),
                                        if (voucherController.voucherModel.voucherSelectedFilter.value.invoicetype.value != 'Show All')
                                          Row(
                                            children: [
                                              if (voucherController.voucherModel.voucherSelectedFilter.value.invoicetype.value == 'Sales' &&
                                                  voucherController.voucherModel.voucherSelectedFilter.value.selectedsalescustomername.value != 'None')
                                                Row(
                                                  children: [
                                                    const SizedBox(width: 5),
                                                    _buildselectedFiltersChip(
                                                      voucherController.voucherModel.voucherSelectedFilter.value.selectedsalescustomername.value,
                                                      onRemove: () {
                                                        voucherController.voucherModel.voucherSelectedFilter.value.selectedsalescustomername.value = 'None';
                                                        voucherController.voucherModel.voucherSelectedFilter.value.selectedcustomerid.value = '';
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              if (voucherController.voucherModel.voucherSelectedFilter.value.invoicetype.value == 'Subscription' &&
                                                  voucherController.voucherModel.voucherSelectedFilter.value.selectedsubscriptioncustomername.value != 'None')
                                                Row(
                                                  children: [
                                                    const SizedBox(width: 5),
                                                    _buildselectedFiltersChip(
                                                      voucherController.voucherModel.voucherSelectedFilter.value.selectedsubscriptioncustomername.value,
                                                      onRemove: () {
                                                        voucherController.voucherModel.voucherSelectedFilter.value.selectedsubscriptioncustomername.value = 'None';
                                                        voucherController.voucherModel.voucherSelectedFilter.value.selectedcustomerid.value = '';
                                                      },
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        if (voucherController.voucherModel.voucherSelectedFilter.value.paymentstatus.value != 'Show All')
                                          Row(
                                            children: [
                                              const SizedBox(width: 5),
                                              _buildselectedFiltersChip(
                                                voucherController.voucherModel.voucherSelectedFilter.value.paymentstatus.value,
                                                onRemove: () {
                                                  voucherController.voucherModel.voucherSelectedFilter.value.paymentstatus.value = 'Show All';
                                                },
                                              ),
                                            ],
                                          ),
                                        const SizedBox(width: 5),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 400,
                          height: 40,
                          child: TextFormField(
                            controller: voucherController.voucherModel.searchController.value,
                            onChanged: (value) => widget.search(value),
                            style: const TextStyle(fontSize: 13, color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(1),
                              filled: true,
                              fillColor: Primary_colors.Light,
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                              hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 167, 165, 165)),
                              hintText: 'Search customer',
                              prefixIcon: const Icon(Icons.search, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Obx(
                          () => Row(
                            children: [
                              const SizedBox(width: 20),
                              Tooltip(
                                message: voucherController.voucherModel.showDeleteButton.value
                                    ? '' // No tooltip when enabled
                                    : 'Please select the pending vouchers',
                                child: ElevatedButton(
                                  onPressed: voucherController.voucherModel.showDeleteButton.value
                                      ? () async {
                                          voucherController.reset_voucherClear_popup();
                                          var selectedVouchers = await widget.calculate_SelectedVouchers();
                                          _show_MultipleCloseVoucherPopup(selectedVouchers);
                                        }
                                      : null, // Disabled when false
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: voucherController.voucherModel.showDeleteButton.value ? Colors.blueAccent : Colors.grey,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    foregroundColor: Colors.white,
                                    disabledBackgroundColor: Colors.grey,
                                    disabledForegroundColor: Colors.white70,
                                  ),
                                  child: const Text('Club Vouchers', style: TextStyle(fontSize: Primary_font_size.Text6)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     showModalBottomSheet(
                        //       backgroundColor: Colors.transparent,
                        //       context: context,
                        //       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                        //       builder: (BuildContext context) => CreateVoucherBottomSheet(),
                        //     );
                        //   },
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor: Colors.blueAccent,
                        //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        //   ),
                        //   child: const Text('Create Voucher', style: TextStyle(fontSize: Primary_font_size.Text6)),
                        // ),
                        // const SizedBox(width: 20),
                        IconButton(
                          onPressed: () {
                            widget.reassignvoucherFilters();
                            _scaffoldKey.currentState?.openEndDrawer();
                          },
                          icon: const Icon(Icons.filter_alt_outlined, color: Primary_colors.Color1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Expanded(
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Primary_colors.Light),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Primary_colors.Color3, Primary_colors.Color3], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                            child: Obx(
                              () => Checkbox(
                                value: voucherController.voucherModel.selectAll.value,
                                onChanged: (bool? value) {
                                  voucherController.voucherModel.selectAll.value = value ?? false;
                                  // Update all selected items
                                  for (int i = 0; i < voucherController.voucherModel.checkboxValues.length; i++) {
                                    voucherController.voucherModel.checkboxValues[i] = voucherController.voucherModel.selectAll.value;
                                  }
                                  voucherController.voucherModel.showDeleteButton.value = voucherController.voucherModel.selectAll.value;
                                },
                                activeColor: Colors.blueAccent,
                                fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                                  if (states.contains(WidgetState.selected)) {
                                    return Colors.green;
                                  }
                                  return Colors.white;
                                }),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 3),
                          const Expanded(
                            flex: 1,
                            child: Text(
                              'Date',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                            ),
                          ),
                          const SizedBox(width: 3),
                          const Expanded(
                            flex: 2,
                            child: Text(
                              'Voucher Number',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                            ),
                          ),
                          const SizedBox(width: 3),
                          const Expanded(
                            flex: 2,
                            child: Text(
                              'Invoice Number',
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                            ),
                          ),
                          const SizedBox(width: 3),
                          const Expanded(
                            flex: 2,
                            child: Text(
                              'Voucher Type',
                              style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                            ),
                          ),
                          const SizedBox(width: 3),
                          const Expanded(
                            flex: 3,
                            child: Text(
                              'Client',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                            ),
                          ),
                          // const SizedBox(width: 3),
                          const SizedBox(width: 3),
                          const Expanded(
                            flex: 2,
                            child: Text(
                              'GSTIN',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                            ),
                          ),
                          const SizedBox(width: 3),
                          const Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Text(
                                'Amount',
                                textAlign: TextAlign.end,
                                style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                          ),
                          const SizedBox(width: 3),
                          const Expanded(
                            flex: 1,
                            child: Text(
                              textAlign: TextAlign.right,
                              'Due Date',
                              style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                            ),
                          ),
                          const SizedBox(width: 3),
                          const Expanded(
                            flex: 1,
                            child: Text(
                              textAlign: TextAlign.right,
                              'OverDue days',
                              style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                            ),
                          ),
                          const SizedBox(width: 3),
                          const Expanded(
                            flex: 1,
                            child: Text(
                              textAlign: TextAlign.center,
                              'Status',
                              style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                            ),
                          ),
                          const SizedBox(width: 3),
                          SizedBox(width: 125),
                          // SizedBox(width: 35),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: Obx(
                      () => voucherController.voucherModel.voucher_list.isNotEmpty
                          ? ListView.separated(
                              separatorBuilder: (context, index) => Container(height: 1, color: const Color.fromARGB(94, 125, 125, 125)),
                              itemCount: voucherController.voucherModel.voucher_list.length,
                              itemBuilder: (context, index) {
                                List<GlobalKey> gstKeys = List.generate(voucherController.voucherModel.voucher_list.length, (_) => GlobalKey());

                                print(voucherController.voucherModel.voucher_list.length);
                                final voucher = voucherController.voucherModel.voucher_list[index];
                                // if (voucherController.voucherModel.checkboxValues.length != voucherController.voucherModel.voucher_list.length) {
                                //   voucherController.voucherModel.checkboxValues.value = List<bool>.filled(voucherController.voucherModel.voucher_list.length, false);
                                // }
                                // ignore: unrelated_type_equality_checks
                                return (voucher.overdueDays != null && voucher.overdueDays! > 0) || voucher.overdueHistory != null
                                    ? Container(
                                        color: Primary_colors.Light,
                                        child: ExpansionTile(
                                          // leading: Icon(Icons.import_contacts),
                                          collapsedIconColor: Colors.red,
                                          iconColor: Colors.white,
                                          showTrailingIcon: true,
                                          tilePadding: EdgeInsets.all(0),
                                          initiallyExpanded: false,
                                          collapsedBackgroundColor: Primary_colors.Light,
                                          backgroundColor: Primary_colors.Light,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                          collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                          title: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 30,
                                                  child: voucher.fullyCleared == 0
                                                      ? Obx(
                                                          () => Checkbox(
                                                            value: voucherController.voucherModel.checkboxValues.isNotEmpty ? voucherController.voucherModel.checkboxValues[index] : false,
                                                            onChanged: (bool? value) {
                                                              widget.update_checkboxValues(index, value!);
                                                            },
                                                            activeColor: Colors.blueAccent,
                                                            fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                                                              if (states.contains(WidgetState.selected)) {
                                                                return Colors.blueAccent;
                                                              }
                                                              return Colors.white;
                                                            }),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(4),
                                                            ),
                                                          ),
                                                        )
                                                      : Icon(Icons.check_rounded, color: Colors.green),
                                                ),
                                                const SizedBox(width: 3),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    voucher.date != null ? formatDate(voucher.date!) : '-',
                                                    style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                  ),
                                                ),
                                                const SizedBox(width: 3),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    voucher.voucherNumber,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                  ),
                                                ),
                                                const SizedBox(width: 3),
                                                Expanded(
                                                  flex: 2,
                                                  child: MouseRegion(
                                                    cursor: SystemMouseCursors.click,
                                                    child: GestureDetector(
                                                      behavior: HitTestBehavior.deferToChild,
                                                      onTap: () async {
                                                        if (voucher.invoiceType == 'subscription') {
                                                          bool success = await widget.GetSubscriptionPDFfile(context: context, invoiceNo: voucher.invoiceNumber);
                                                          if (success) {
                                                            showPDF(context, voucher.invoiceNumber, mainBilling_Controller.billingModel.pdfFile.value);
                                                          }
                                                        } else if (voucher.invoiceType == 'sales') {
                                                          bool success = await widget.Get_SalesPDFfile(context: context, invoiceNo: voucher.invoiceNumber);
                                                          if (success) {
                                                            showPDF(context, voucher.invoiceNumber, mainBilling_Controller.billingModel.pdfFile.value);
                                                          }
                                                        }
                                                      },
                                                      child: Text(
                                                        voucher.invoiceNumber,
                                                        style: const TextStyle(color: Colors.blue, fontSize: Primary_font_size.Text7),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 3),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    voucher.voucherType,
                                                    style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                  ),
                                                ),
                                                const SizedBox(width: 3),
                                                Expanded(
                                                  flex: 3,
                                                  child: Builder(
                                                    builder: (context) {
                                                      OverlayEntry? overlayEntry;

                                                      void showPopup() {
                                                        if (overlayEntry != null) return;
                                                        final RenderBox renderBox = context.findRenderObject() as RenderBox;
                                                        final Offset offset = renderBox.localToGlobal(Offset.zero);
                                                        final Size size = renderBox.size;

                                                        // Calculate position dynamically based on available space
                                                        double top;
                                                        double left = offset.dx - 80;

                                                        // If there's enough space above the widget, show popup above it
                                                        if (offset.dy > 320) {
                                                          top = offset.dy - 320; // Show above
                                                        } else {
                                                          // Otherwise show below the widget
                                                          top = offset.dy + size.height + 5;
                                                        }
                                                        overlayEntry = OverlayEntry(
                                                          builder: (_) => Positioned(
                                                            left: left,
                                                            top: top,
                                                            child: TweenAnimationBuilder(
                                                              duration: const Duration(milliseconds: 200),
                                                              tween: Tween<double>(begin: 0.9, end: 1.0),
                                                              builder: (_, double scale, __) => Transform.scale(
                                                                scale: scale,
                                                                child: MouseRegion(
                                                                  onExit: (_) {
                                                                    overlayEntry?.remove();
                                                                    overlayEntry = null;
                                                                  },
                                                                  child: Material(
                                                                    elevation: 8,
                                                                    borderRadius: BorderRadius.circular(16),
                                                                    color: Colors.transparent,
                                                                    child: Container(
                                                                      width: 340,
                                                                      padding: const EdgeInsets.all(16),
                                                                      decoration: BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.circular(16),
                                                                        gradient: LinearGradient(colors: [Colors.white, Colors.grey[50]!], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                                                                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, spreadRadius: 2)],
                                                                      ),
                                                                      child: Column(
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            decoration: BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              border: Border.all(color: Colors.blue.shade100, width: 2),
                                                                              boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.2), blurRadius: 10, spreadRadius: 2)],
                                                                            ),
                                                                            child: const CircleAvatar(
                                                                              radius: 15,
                                                                              backgroundColor: Colors.blue,
                                                                              child: Icon(Icons.person, color: Colors.white, size: 24),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(height: 12),
                                                                          _buildInfoItem(Icons.credit_card, "Customer ID", voucher.customerId),
                                                                          const Divider(height: 16, thickness: 0.5),
                                                                          _buildInfoItem(Icons.email, "Email", voucher.emailId),
                                                                          const Divider(height: 16, thickness: 0.5),
                                                                          _buildInfoItem(Icons.phone, "Phone", voucher.phoneNumber),
                                                                          const Divider(height: 16, thickness: 0.5),
                                                                          _buildInfoItem(Icons.location_on, "Address", voucher.clientAddress),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );

                                                        Overlay.of(context).insert(overlayEntry!);
                                                      }

                                                      void removePopup() {
                                                        overlayEntry?.remove();
                                                        overlayEntry = null;
                                                      }

                                                      return Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          MouseRegion(
                                                            cursor: SystemMouseCursors.click,
                                                            onEnter: (_) => showPopup(),
                                                            onExit: (_) => removePopup(),
                                                            child: const Icon(Icons.info_outline, size: 20, color: Colors.blue),
                                                          ),
                                                          const SizedBox(width: 3),
                                                          Expanded(
                                                            child: Text(
                                                              maxLines: 5,
                                                              voucher.clientName,
                                                              style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(width: 3),
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 15),
                                                    child: GestureDetector(
                                                      key: gstKeys[index],
                                                      onTap: () async {
                                                        if (voucher.gstNumber.isNotEmpty) {
                                                          await Clipboard.setData(ClipboardData(text: voucher.gstNumber));

                                                          final renderBox = gstKeys[index].currentContext?.findRenderObject() as RenderBox?;
                                                          if (renderBox == null || !gstKeys[index].currentContext!.mounted) return;

                                                          final overlay = Overlay.of(gstKeys[index].currentContext!);
                                                          final overlayEntry = OverlayEntry(
                                                            builder: (context) => Positioned(
                                                              left: renderBox.localToGlobal(Offset.zero).dx,
                                                              top: renderBox.localToGlobal(Offset.zero).dy,
                                                              child: Material(
                                                                color: Colors.transparent,
                                                                child: Container(
                                                                  padding: const EdgeInsets.all(6),
                                                                  decoration: BoxDecoration(
                                                                    color: const Color.fromARGB(200, 33, 149, 243),
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                  child: const Text(
                                                                    "Copied!",
                                                                    style: TextStyle(color: Colors.white, fontSize: Primary_font_size.Text5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );

                                                          overlay.insert(overlayEntry);
                                                          Future.delayed(const Duration(seconds: 1), overlayEntry.remove);
                                                        }
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                Text(
                                                                  voucher.gstNumber.isEmpty ? '-' : voucher.gstNumber,
                                                                  style: const TextStyle(
                                                                    color: Primary_colors.Color1,
                                                                    fontSize: Primary_font_size.Text7,
                                                                  ),
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                                const SizedBox(width: 4),
                                                                const Icon(Icons.copy, size: 16, color: Colors.grey),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 3),
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 15),
                                                    child: Text(
                                                      textAlign: TextAlign.end,
                                                      'Rs. ${formatCurrency(voucher.totalAmount)}',
                                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 3),
                                                Expanded(
                                                  flex: 1,
                                                  child: MouseRegion(
                                                    cursor: SystemMouseCursors.click,
                                                    child: GestureDetector(
                                                      onTap: () {},
                                                      child: Text(
                                                        textAlign: TextAlign.center,
                                                        voucher.dueDate == null ? '-' : formatDate(voucher.dueDate!),
                                                        style: const TextStyle(color: Colors.white, fontSize: Primary_font_size.Text7),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 3),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    textAlign: TextAlign.center,
                                                    (voucher.overdueDays ?? '-').toString(),
                                                    style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                  ),
                                                ),
                                                const SizedBox(width: 3),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    textAlign: TextAlign.center,
                                                    (voucher.fullyCleared == 0 && voucher.partiallyCleared == 0)
                                                        ? 'pending'
                                                        : voucher.fullyCleared == 1
                                                            ? 'paid'
                                                            : voucher.partiallyCleared == 1
                                                                ? 'partially cleared'
                                                                : '',
                                                    style: TextStyle(
                                                      color: (voucher.fullyCleared == 0 && voucher.partiallyCleared == 0)
                                                          ? const Color.fromARGB(255, 248, 71, 59)
                                                          : voucher.fullyCleared == 1
                                                              ? const Color.fromARGB(255, 105, 240, 112)
                                                              : voucher.partiallyCleared == 1
                                                                  ? Colors.amber
                                                                  : Colors.black,
                                                      fontSize: Primary_font_size.Text7,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 3),
                                                SizedBox(
                                                  width: 125,
                                                  child: (voucher.fullyCleared == 0)
                                                      ? ElevatedButton(
                                                          onPressed: () {
                                                            voucherController.reset_voucherClear_popup();

                                                            final voucher = voucherController.voucherModel.voucher_list[index];
                                                            final isPendingEqualsTds = voucher.pendingAmount == voucher.tdsCalculationAmount;

                                                            if (isPendingEqualsTds) {
                                                              voucherController.calculate_recievable(true, index, voucherController.voucherModel.selectedValue.value);
                                                              voucherController.set_isDeducted(true);
                                                            }

                                                            if (voucher.tdsCalculation == 1 || isPendingEqualsTds) {
                                                              voucherController.calculate_recievable(true, index, voucherController.voucherModel.selectedValue.value);
                                                            } else {
                                                              voucherController.calculate_recievable(false, index, voucherController.voucherModel.selectedValue.value);
                                                            }

                                                            voucherController.is_amountExceeds(index, null);
                                                            voucherController.is_fullclear_Valid(index);

                                                            _showCloseVoucherPopup(index);
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: const Color.fromARGB(255, 240, 193, 52),
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                          ),
                                                          child: const Text(
                                                            'Update Payment',
                                                            style: TextStyle(color: Colors.black, fontSize: Primary_font_size.Text6),
                                                          ),
                                                        )
                                                      : ElevatedButton(
                                                          onPressed: () {
                                                            final paymentList = voucherController.voucherModel.voucher_list[index].paymentDetails ?? [];
                                                            editableRows.assignAll(paymentList.map((payment) {
                                                              final detail = payment.transanctionDetails.isEmpty ? 'N/A' : payment.transanctionDetails;
                                                              return EditableTransactionRow(detail);
                                                            }).toList());
                                                            showVoucherClearedDialog(context, index);
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: const Color.fromARGB(255, 107, 183, 109),
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                          ),
                                                          child: const Text(
                                                            'View Details',
                                                            style: TextStyle(color: Colors.black, fontSize: Primary_font_size.Text6),
                                                          ),
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: voucher.overdueHistory != null
                                                        ? Align(
                                                            alignment: Alignment.centerRight,
                                                            child: ListView.builder(
                                                              shrinkWrap: true,
                                                              physics: NeverScrollableScrollPhysics(), // Remove if you want scrolling
                                                              itemCount: voucher.overdueHistory!.length,
                                                              itemBuilder: (context, index) {
                                                                return IntrinsicHeight(
                                                                  child: Row(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      // Timeline dot and line
                                                                      Column(
                                                                        children: [
                                                                          Container(
                                                                            width: 10,
                                                                            height: 10,
                                                                            decoration: const BoxDecoration(color: Primary_colors.Color3, shape: BoxShape.circle),
                                                                          ),
                                                                          if (index < voucher.overdueHistory!.length - 1) Expanded(child: Container(width: 2, color: Primary_colors.Color3)),
                                                                        ],
                                                                      ),

                                                                      const SizedBox(width: 12),

                                                                      // Timeline content
                                                                      Expanded(
                                                                        child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              voucher.overdueHistory![index].date,
                                                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8),
                                                                            ),
                                                                            const SizedBox(height: 6),
                                                                            Text(voucher.overdueHistory![index].feedback, maxLines: 3, style: TextStyle(color: Colors.grey[700], fontSize: 12)),
                                                                            const SizedBox(height: 16),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  if (voucherController.voucherModel.voucher_list[index].fullyCleared != 1)
                                                    Expanded(
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          SizedBox(
                                                            width: 380,
                                                            // height: 100,
                                                            child: TextFormField(
                                                              onChanged: (value) {
                                                                widget.isExtendButton_visibile(index);
                                                              },
                                                              maxLines: 4,
                                                              controller: voucherController.voucherModel.extendDueFeedbackControllers[index],
                                                              style: const TextStyle(fontSize: 13, color: Colors.white),
                                                              decoration: InputDecoration(
                                                                contentPadding: const EdgeInsets.all(10),
                                                                filled: true,
                                                                fillColor: Primary_colors.Dark,
                                                                enabledBorder: OutlineInputBorder(
                                                                  borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                                                                  borderRadius: BorderRadius.circular(8),
                                                                ),
                                                                focusedBorder: OutlineInputBorder(
                                                                  borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                                                                  borderRadius: BorderRadius.circular(8),
                                                                ),
                                                                hintStyle: const TextStyle(
                                                                  fontSize: Primary_font_size.Text7,
                                                                  color: Color.fromARGB(255, 167, 165, 165),
                                                                ),
                                                                hintText: 'Enter Feedback...',

                                                                // prefixIcon: const Icon(
                                                                //   Icons.feedback_outlined,s
                                                                //   color: Colors.white,
                                                                // ),
                                                                // suffixIcon: Padding(
                                                                //   padding: const EdgeInsets.only(top: 50),
                                                                //   child: IconButton(
                                                                //     onPressed: () {},
                                                                //     icon: const Icon(
                                                                //       Icons.send,
                                                                //       color: Primary_colors.Color3,
                                                                //     ),
                                                                //   ),
                                                                // ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Column(
                                                            children: [
                                                              SizedBox(
                                                                width: 200,
                                                                height: 40,
                                                                child: TextFormField(
                                                                  style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: Primary_font_size.Text7),
                                                                  controller: voucherController.voucherModel.extendDueDateControllers[index],
                                                                  readOnly: true,
                                                                  onTap: () async {
                                                                    await select_previousDates(context, voucherController.voucherModel.extendDueDateControllers[index]);
                                                                    widget.isExtendButton_visibile(index);
                                                                  },
                                                                  decoration: InputDecoration(
                                                                    filled: true,
                                                                    fillColor: Primary_colors.Dark,
                                                                    labelText: 'Extend Due Date',
                                                                    labelStyle: const TextStyle(color: Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
                                                                    suffixIcon: const Icon(Icons.calendar_today, size: 20, color: Color.fromARGB(255, 85, 84, 84)),
                                                                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                                                    enabledBorder: OutlineInputBorder(
                                                                      borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                                                                      borderRadius: BorderRadius.circular(8),
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                      borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                                                                      borderRadius: BorderRadius.circular(8),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(height: 10),
                                                              Obx(
                                                                () {
                                                                  return Tooltip(
                                                                    message: voucherController.voucherModel.isExtendButton_visible[index]
                                                                        ? '' // No tooltip when enabled
                                                                        : 'Ensure feedback and date input',
                                                                    child: SizedBox(
                                                                      width: 200,
                                                                      child: ElevatedButton(
                                                                        onPressed: voucherController.voucherModel.isExtendButton_visible[index]
                                                                            ? () async {
                                                                                widget.add_Overdue(context, voucher.voucher_id, index);
                                                                              }
                                                                            : null, // Disabled when false
                                                                        style: ElevatedButton.styleFrom(
                                                                          backgroundColor: voucherController.voucherModel.isExtendButton_visible[index] ? Colors.blueAccent : Colors.grey,
                                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                          foregroundColor: Colors.white,
                                                                          disabledBackgroundColor: Colors.grey,
                                                                          disabledForegroundColor: Colors.white70,
                                                                        ),
                                                                        child: const Text('Extend Due', style: TextStyle(fontSize: Primary_font_size.Text6)),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                              // SizedBox(
                                                              //   width: 200,
                                                              //   child: ElevatedButton(
                                                              //     onPressed: () {
                                                              //       widget.add_Overdue(context, voucher.voucher_id);
                                                              //     },
                                                              //     child: Text('Submit'),
                                                              //   ),
                                                              // )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(5),
                                          child: Container(
                                            decoration: BoxDecoration(color: Primary_colors.Light, borderRadius: BorderRadius.circular(5)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 30,
                                                    child: voucher.fullyCleared == 0
                                                        ? Obx(
                                                            () => Checkbox(
                                                              value: voucherController.voucherModel.checkboxValues.isNotEmpty ? voucherController.voucherModel.checkboxValues[index] : false,
                                                              onChanged: (bool? value) {
                                                                widget.update_checkboxValues(index, value!);
                                                              },
                                                              activeColor: Colors.blueAccent,
                                                              fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                                                                if (states.contains(WidgetState.selected)) {
                                                                  return Colors.blueAccent;
                                                                }
                                                                return Colors.white;
                                                              }),
                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                                            ),
                                                          )
                                                        : Icon(Icons.check_rounded, color: Colors.green),
                                                  ),
                                                  const SizedBox(width: 3),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      voucher.date != null ? formatDate(voucher.date!) : '-',
                                                      textAlign: TextAlign.center,
                                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 3),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      voucher.voucherNumber,
                                                      textAlign: TextAlign.center,
                                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 3),
                                                  Expanded(
                                                    flex: 2,
                                                    child: MouseRegion(
                                                      cursor: SystemMouseCursors.click,
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          if (voucher.invoiceType == 'subscription') {
                                                            bool success = await widget.GetSubscriptionPDFfile(context: context, invoiceNo: voucher.invoiceNumber);
                                                            if (success) {
                                                              showPDF(context, voucher.invoiceNumber, mainBilling_Controller.billingModel.pdfFile.value);
                                                            }
                                                          }
                                                        },
                                                        child: Text(
                                                          voucher.invoiceNumber,
                                                          textAlign: TextAlign.left,
                                                          style: const TextStyle(color: Colors.blue, fontSize: Primary_font_size.Text7),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 3),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      voucher.voucherType,
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 3),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Builder(
                                                      builder: (context) {
                                                        OverlayEntry? overlayEntry;

                                                        void showPopup() {
                                                          if (overlayEntry != null) return;
                                                          final RenderBox renderBox = context.findRenderObject() as RenderBox;
                                                          final Offset offset = renderBox.localToGlobal(Offset.zero);
                                                          final Size size = renderBox.size;

                                                          // Calculate position dynamically based on available space
                                                          double top;
                                                          double left = offset.dx - 80;

                                                          // If there's enough space above the widget, show popup above it
                                                          if (offset.dy > 320) {
                                                            top = offset.dy - 320; // Show above
                                                          } else {
                                                            // Otherwise show below the widget
                                                            top = offset.dy + size.height + 5;
                                                          }
                                                          overlayEntry = OverlayEntry(
                                                            builder: (_) => Positioned(
                                                              left: left,
                                                              top: top,
                                                              child: TweenAnimationBuilder(
                                                                duration: const Duration(milliseconds: 200),
                                                                tween: Tween<double>(begin: 0.9, end: 1.0),
                                                                builder: (_, double scale, __) => Transform.scale(
                                                                  scale: scale,
                                                                  child: MouseRegion(
                                                                    onExit: (_) {
                                                                      overlayEntry?.remove();
                                                                      overlayEntry = null;
                                                                    },
                                                                    child: Material(
                                                                      elevation: 8,
                                                                      borderRadius: BorderRadius.circular(16),
                                                                      color: Colors.transparent,
                                                                      child: Container(
                                                                        width: 340,
                                                                        padding: const EdgeInsets.all(16),
                                                                        decoration: BoxDecoration(
                                                                          color: Colors.white,
                                                                          borderRadius: BorderRadius.circular(16),
                                                                          gradient: LinearGradient(colors: [Colors.white, Colors.grey[50]!], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                                                                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, spreadRadius: 2)],
                                                                        ),
                                                                        child: Column(
                                                                          mainAxisSize: MainAxisSize.min,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                                border: Border.all(color: Colors.blue.shade100, width: 2),
                                                                                boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.2), blurRadius: 10, spreadRadius: 2)],
                                                                              ),
                                                                              child: const CircleAvatar(
                                                                                radius: 15,
                                                                                backgroundColor: Colors.blue,
                                                                                child: Icon(Icons.person, color: Colors.white, size: 24),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(height: 12),
                                                                            _buildInfoItem(Icons.credit_card, "Customer ID", voucher.customerId),
                                                                            const Divider(height: 16, thickness: 0.5),
                                                                            _buildInfoItem(Icons.email, "Email", voucher.emailId),
                                                                            const Divider(height: 16, thickness: 0.5),
                                                                            _buildInfoItem(Icons.phone, "Phone", voucher.phoneNumber),
                                                                            const Divider(height: 16, thickness: 0.5),
                                                                            _buildInfoItem(Icons.location_on, "Address", voucher.clientAddress),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );

                                                          Overlay.of(context).insert(overlayEntry!);
                                                        }

                                                        void removePopup() {
                                                          overlayEntry?.remove();
                                                          overlayEntry = null;
                                                        }

                                                        return Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            MouseRegion(
                                                              cursor: SystemMouseCursors.click,
                                                              onEnter: (_) => showPopup(),
                                                              onExit: (_) => removePopup(),
                                                              child: const Icon(Icons.info_outline, size: 20, color: Colors.blue),
                                                            ),
                                                            const SizedBox(width: 3),
                                                            Expanded(
                                                              child: Text(
                                                                maxLines: 5,
                                                                voucher.clientName,
                                                                textAlign: TextAlign.left,
                                                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(width: 3),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(right: 15),
                                                      child: GestureDetector(
                                                        key: gstKeys[index],
                                                        onTap: () async {
                                                          if (voucher.gstNumber.isNotEmpty) {
                                                            await Clipboard.setData(ClipboardData(text: voucher.gstNumber));

                                                            final renderBox = gstKeys[index].currentContext?.findRenderObject() as RenderBox?;
                                                            if (renderBox == null || !gstKeys[index].currentContext!.mounted) return;

                                                            final overlay = Overlay.of(gstKeys[index].currentContext!);
                                                            final overlayEntry = OverlayEntry(
                                                              builder: (context) => Positioned(
                                                                left: renderBox.localToGlobal(Offset.zero).dx,
                                                                top: renderBox.localToGlobal(Offset.zero).dy,
                                                                child: Material(
                                                                  color: Colors.transparent,
                                                                  child: Container(
                                                                    padding: const EdgeInsets.all(6),
                                                                    decoration: BoxDecoration(
                                                                      color: const Color.fromARGB(200, 33, 149, 243),
                                                                      borderRadius: BorderRadius.circular(8),
                                                                    ),
                                                                    child: const Text(
                                                                      "Copied!",
                                                                      style: TextStyle(color: Colors.white, fontSize: Primary_font_size.Text5),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );

                                                            overlay.insert(overlayEntry);
                                                            Future.delayed(const Duration(seconds: 1), overlayEntry.remove);
                                                          }
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: [
                                                                  Text(
                                                                    voucher.gstNumber.isEmpty ? '-' : voucher.gstNumber,
                                                                    style: const TextStyle(
                                                                      color: Primary_colors.Color1,
                                                                      fontSize: Primary_font_size.Text7,
                                                                    ),
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                  const SizedBox(width: 4),
                                                                  const Icon(Icons.copy, size: 16, color: Colors.grey),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 3),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(right: 15),
                                                      child: Text(
                                                        textAlign: TextAlign.end,
                                                        'Rs. ${formatCurrency(voucher.totalAmount)}',
                                                        style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 3),
                                                  Expanded(
                                                    flex: 1,
                                                    child: MouseRegion(
                                                      cursor: SystemMouseCursors.click,
                                                      child: GestureDetector(
                                                        onTap: () {},
                                                        child: Text(
                                                          textAlign: TextAlign.center,
                                                          voucher.dueDate == null ? '-' : formatDate(voucher.dueDate!),
                                                          style: const TextStyle(color: Colors.white, fontSize: Primary_font_size.Text7),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 3),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      textAlign: TextAlign.center,
                                                      (voucher.overdueDays ?? '-').toString(),
                                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 3),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      textAlign: TextAlign.center,
                                                      (voucher.fullyCleared == 0 && voucher.partiallyCleared == 0)
                                                          ? 'pending'
                                                          : voucher.fullyCleared == 1
                                                              ? 'paid'
                                                              : voucher.partiallyCleared == 1
                                                                  ? 'partially cleared'
                                                                  : '',
                                                      style: TextStyle(
                                                        color: (voucher.fullyCleared == 0 && voucher.partiallyCleared == 0)
                                                            ? const Color.fromARGB(255, 248, 71, 59)
                                                            : voucher.fullyCleared == 1
                                                                ? const Color.fromARGB(255, 105, 240, 112)
                                                                : voucher.partiallyCleared == 1
                                                                    ? Colors.amber
                                                                    : Colors.black,
                                                        fontSize: Primary_font_size.Text7,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 3),
                                                  Align(
                                                    alignment: Alignment.centerRight,
                                                    child: SizedBox(
                                                      width: 125,
                                                      child: (voucher.fullyCleared == 0)
                                                          ? ElevatedButton(
                                                              onPressed: () {
                                                                voucherController.reset_voucherClear_popup();

                                                                final voucher = voucherController.voucherModel.voucher_list[index];
                                                                final isPendingEqualsTds = voucher.pendingAmount == voucher.tdsCalculationAmount;

                                                                if (isPendingEqualsTds) {
                                                                  voucherController.calculate_recievable(true, index, voucherController.voucherModel.selectedValue.value);
                                                                  voucherController.set_isDeducted(true);
                                                                }

                                                                if (voucher.tdsCalculation == 1 || isPendingEqualsTds) {
                                                                  voucherController.calculate_recievable(true, index, voucherController.voucherModel.selectedValue.value);
                                                                } else {
                                                                  voucherController.calculate_recievable(false, index, voucherController.voucherModel.selectedValue.value);
                                                                }

                                                                voucherController.is_amountExceeds(index, null);
                                                                voucherController.is_fullclear_Valid(index);

                                                                _showCloseVoucherPopup(index);
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                backgroundColor: const Color.fromARGB(255, 240, 193, 52),
                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                              ),
                                                              child: const Text(
                                                                'Update Payment',
                                                                style: TextStyle(color: Colors.black, fontSize: Primary_font_size.Text6),
                                                              ),
                                                            )
                                                          : ElevatedButton(
                                                              onPressed: () {
                                                                final paymentList = voucherController.voucherModel.voucher_list[index].paymentDetails ?? [];
                                                                editableRows.assignAll(paymentList.map((payment) {
                                                                  final detail = payment.transanctionDetails.isEmpty ? 'N/A' : payment.transanctionDetails;
                                                                  return EditableTransactionRow(detail);
                                                                }).toList());
                                                                showVoucherClearedDialog(context, index);
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                backgroundColor: const Color.fromARGB(255, 107, 183, 109),
                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                              ),
                                                              child: const Text(
                                                                'View Details',
                                                                style: TextStyle(color: Colors.black, fontSize: Primary_font_size.Text6),
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                  // SizedBox(width: 35),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                              },
                            )
                          : Center(
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Lottie.asset(
                                      'assets/animations/JSON/emptyprocesslist.json',
                                      // width: 264,
                                      height: 150,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 164),
                                    child: Text(
                                      'No Voucher Found',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.blueGrey[800]),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 204),
                                    child: Text(
                                      'Generate a invoice to see it listed here.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14, color: Colors.blueGrey[400], height: 1.4),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showVoucherClearedDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: EdgeInsets.all(20),
          child: Obx(() {
            return Container(
              width: 1200,
              // padding: EdgeInsets.all(16),
              // constraints: BoxConstraints(minWidth: 300, maxWidth: 500),
              decoration: BoxDecoration(
                color: Primary_colors.Light,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10))],
              ),
              // child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Primary_colors.Color3, Primary_colors.Color3.withOpacity(0.8)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            // color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check_circle, color: Colors.green, size: 34),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'Voucher Cleared',
                          style: TextStyle(color: Colors.white, fontSize: Primary_font_size.Text10, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.only(right: 16, left: 16),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Primary_colors.Dark,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Primary_colors.Dark, width: 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          // ✅ use Flexible inside scroll views
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(color: Primary_colors.Color3.withOpacity(0.1), shape: BoxShape.circle),
                                    child: const CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Primary_colors.Color3,
                                      child: Icon(Icons.person, color: Colors.white, size: 20),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          voucherController.voucherModel.voucher_list[index].clientName,
                                          maxLines: 1,
                                          style: const TextStyle(overflow: TextOverflow.ellipsis, color: Colors.white, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text9),
                                        ),
                                        const SizedBox(height: 4),
                                        Text("Client ID: ${voucherController.voucherModel.voucher_list[index].customerId}", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                                        const SizedBox(height: 8),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              _infoRow(Icons.location_on_outlined, voucherController.voucherModel.voucher_list[index].clientAddress),
                              const SizedBox(height: 8),
                              _infoRow(Icons.phone_android, voucherController.voucherModel.voucher_list[index].phoneNumber),
                              const SizedBox(height: 8),
                              _infoRow(Icons.email_sharp, voucherController.voucherModel.voucher_list[index].emailId),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Invoice Number',
                                    // textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        voucherController.voucherModel.voucher_list[index].invoiceNumber,
                                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8),
                                      ),
                                      const SizedBox(width: 8),
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          key: _invoiceCopyKey, // Attach the key here
                                          onTap: () async {
                                            await Clipboard.setData(ClipboardData(text: voucherController.voucherModel.voucher_list[index].invoiceNumber));

                                            final renderBox = _invoiceCopyKey.currentContext?.findRenderObject() as RenderBox?;
                                            if (renderBox == null || !mounted) return; // Early exit if not rendered

                                            final overlay = Overlay.of(context);
                                            final overlayEntry = OverlayEntry(
                                              builder: (context) => Positioned(
                                                left: renderBox.localToGlobal(Offset.zero).dx + renderBox.size.width,
                                                top: renderBox.localToGlobal(Offset.zero).dy,
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: Container(
                                                    padding: const EdgeInsets.all(6),
                                                    decoration: BoxDecoration(color: const Color.fromARGB(119, 33, 149, 243).withOpacity(0.8), borderRadius: BorderRadius.circular(8)),
                                                    child: const Text(
                                                      "Copied!",
                                                      style: TextStyle(color: Colors.white, fontSize: Primary_font_size.Text5),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );

                                            overlay.insert(overlayEntry);
                                            Future.delayed(const Duration(seconds: 1), overlayEntry.remove);
                                          },
                                          child: const Icon(Icons.copy, color: Colors.grey, size: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Voucher Number',
                                    style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        voucherController.voucherModel.voucher_list[index].voucherNumber,
                                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8),
                                      ),
                                      const SizedBox(width: 8),
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          key: _voucherCopyKey, // Attach the key here
                                          onTap: () async {
                                            await Clipboard.setData(ClipboardData(text: voucherController.voucherModel.voucher_list[index].voucherNumber));

                                            final renderBox = _voucherCopyKey.currentContext?.findRenderObject() as RenderBox?;
                                            if (renderBox == null || !mounted) return; // Early exit if not rendered

                                            final overlay = Overlay.of(context);
                                            final overlayEntry = OverlayEntry(
                                              builder: (context) => Positioned(
                                                left: renderBox.localToGlobal(Offset.zero).dx + renderBox.size.width,
                                                top: renderBox.localToGlobal(Offset.zero).dy,
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: Container(
                                                    padding: const EdgeInsets.all(6),
                                                    decoration: BoxDecoration(color: const Color.fromARGB(119, 33, 149, 243).withOpacity(0.8), borderRadius: BorderRadius.circular(8)),
                                                    child: const Text(
                                                      "Copied!",
                                                      style: TextStyle(color: Colors.white, fontSize: Primary_font_size.Text5),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );

                                            overlay.insert(overlayEntry);
                                            Future.delayed(const Duration(seconds: 1), overlayEntry.remove);
                                          },
                                          child: const Icon(Icons.copy, color: Colors.grey, size: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'GST Number',
                                    style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        voucherController.voucherModel.voucher_list[index].gstNumber,
                                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8),
                                      ),
                                      const SizedBox(width: 8),
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          key: _GSTcopyKey, // Attach the key here
                                          onTap: () async {
                                            await Clipboard.setData(ClipboardData(text: voucherController.voucherModel.voucher_list[index].gstNumber));

                                            final renderBox = _GSTcopyKey.currentContext?.findRenderObject() as RenderBox?;
                                            if (renderBox == null || !mounted) return; // Early exit if not rendered

                                            final overlay = Overlay.of(context);
                                            final overlayEntry = OverlayEntry(
                                              builder: (context) => Positioned(
                                                left: renderBox.localToGlobal(Offset.zero).dx + renderBox.size.width,
                                                top: renderBox.localToGlobal(Offset.zero).dy,
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: Container(
                                                    padding: const EdgeInsets.all(6),
                                                    decoration: BoxDecoration(color: const Color.fromARGB(119, 33, 149, 243).withOpacity(0.8), borderRadius: BorderRadius.circular(8)),
                                                    child: const Text(
                                                      "Copied!",
                                                      style: TextStyle(color: Colors.white, fontSize: Primary_font_size.Text5),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );

                                            overlay.insert(overlayEntry);
                                            Future.delayed(const Duration(seconds: 1), overlayEntry.remove);
                                          },
                                          child: const Icon(Icons.copy, color: Colors.grey, size: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Container(height: 250, width: 0.5, color: Colors.grey[500], margin: const EdgeInsets.all(20)),
                        // const SizedBox(height: 15,),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "PAYMENT BREAKUP",
                                style: TextStyle(color: Primary_colors.Color3, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 0.5),
                              ),
                              const SizedBox(height: 16),
                              _buildBreakupLine("Net Amount", "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucherController.voucherModel.voucher_list[index].subTotal)}"),
                              _buildBreakupDivider(),
                              _buildBreakupLine("CGST (9%)", "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucherController.voucherModel.voucher_list[index].cgst)}"),
                              _buildBreakupDivider(),
                              _buildBreakupLine("SGST (9%)", "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucherController.voucherModel.voucher_list[index].sgst)}"),
                              _buildBreakupDivider(),
                              _buildBreakupLine("IGST", "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucherController.voucherModel.voucher_list[index].igst)}"),
                              _buildBreakupDivider(),
                              if (voucherController.voucherModel.voucher_list[index].tdsCalculation == 1)
                                _buildBreakupLine("TDS (2%)", "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucherController.voucherModel.voucher_list[index].tdsCalculationAmount)}"),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(color: Primary_colors.Color3.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Total Amount",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                                    ),
                                    Text(
                                      "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucherController.voucherModel.voucher_list[index].totalAmount)}",
                                      style: const TextStyle(color: Primary_colors.Color3, fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //  Expanded(
                  Container(
                    margin: const EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Primary_colors.Dark,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Primary_colors.Dark, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Payment Details',
                          style: TextStyle(color: Primary_colors.Color3, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 0.5),
                        ),
                        const SizedBox(height: 10),

                        // Header Row (non-scrollable)
                        ClipRRect(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                          child: Container(
                            color: const Color(0xFFE0E0E0),
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(1.5),
                                1: FlexColumnWidth(2),
                                2: FlexColumnWidth(2),
                                3: FlexColumnWidth(4),
                                4: FlexColumnWidth(1.2),
                                5: FlexColumnWidth(1.2),
                                6: FlexColumnWidth(1.2),
                              },
                              border: TableBorder(bottom: BorderSide(color: Colors.grey.shade400)),
                              children: const [
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Date',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Amount Paid',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Payment Mode',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Transaction Details',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'View ref',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Receipt',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        '',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Scrollable Rows (only this part scrolls)
                        // Expanded(
                        ClipRRect(
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
                          child: Container(
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400)),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxHeight: 200),
                              child: SingleChildScrollView(
                                child: Obx(() => Table(
                                      columnWidths: const {
                                        0: FlexColumnWidth(1.5),
                                        1: FlexColumnWidth(2),
                                        2: FlexColumnWidth(2),
                                        3: FlexColumnWidth(4),
                                        4: FlexColumnWidth(1.2),
                                        5: FlexColumnWidth(1.2),
                                        6: FlexColumnWidth(1.2),
                                      },
                                      border: TableBorder(horizontalInside: BorderSide(color: Colors.grey.shade400)),
                                      children: List<TableRow>.generate(
                                        editableRows.length,
                                        (i) {
                                          final payment = voucherController.voucherModel.voucher_list[index].paymentDetails![i];
                                          final rowState = editableRows[i];
                                          final date = formatDate(payment.date);
                                          final amount = '₹ ${formatCurrency(payment.amount)}';
                                          final transID = payment.transactionId;
                                          final paymentMode = payment.paymentmode;

                                          return TableRow(
                                            children: [
                                              // Date
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  date,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(color: Colors.grey),
                                                ),
                                              ),

                                              // Amount Paid
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  amount,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(color: Colors.grey),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  paymentMode,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(color: Colors.grey),
                                                ),
                                              ),
                                              // Transaction Details Editable
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Obx(() => rowState.isEditing.value
                                                        ? Expanded(
                                                            child: TextFormField(
                                                              autofocus: true,
                                                              controller: rowState.controller,
                                                              style: const TextStyle(color: Colors.white, fontSize: 12),
                                                              maxLines: 2,
                                                              decoration: const InputDecoration(
                                                                hintText: "Enter feedback details",
                                                                hintStyle: TextStyle(color: Colors.grey),
                                                                border: OutlineInputBorder(borderSide: BorderSide.none),
                                                                isDense: true,
                                                                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                              ),
                                                            ),
                                                          )
                                                        : Expanded(
                                                            child: Text(
                                                              rowState.controller.text,
                                                              textAlign: TextAlign.start,
                                                              style: const TextStyle(color: Colors.grey),
                                                            ),
                                                          )),
                                                  ],
                                                ),
                                              ),
                                              // Actions
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    // PDF View
                                                    MouseRegion(
                                                      cursor: SystemMouseCursors.click,
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          bool success = await widget.Get_transactionPDFfile(context: context, transactionID: transID);
                                                          if (success) {
                                                            showPDF(context, "TRANSACTION_$transID", mainBilling_Controller.billingModel.pdfFile.value);
                                                          }
                                                        },
                                                        child: Image.asset('assets/images/pdfdownload.png', width: 24, height: 24),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),

                                                    // Edit / Save Button
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    // PDF View
                                                    MouseRegion(
                                                      cursor: SystemMouseCursors.click,
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          bool success = await widget.Get_receiptPDFfile(context: context, transactionID: transID);
                                                          if (success) {
                                                            showPDF(context, "RECEIPT_$transID", mainBilling_Controller.billingModel.pdfFile.value);
                                                          }
                                                        },
                                                        child: Image.asset('assets/images/order.png', width: 24, height: 24),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),

                                                    // Edit / Save Button
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Obx(() => IconButton(
                                                          icon: Icon(rowState.isEditing.value ? Icons.save : Icons.edit, size: 20),
                                                          tooltip: rowState.isEditing.value ? "Save" : "Edit",
                                                          onPressed: () {
                                                            if (rowState.isEditing.value) {
                                                              widget.update_paymentDetails(context, index, i);
                                                            }
                                                            rowState.isEditing.value = !rowState.isEditing.value;

                                                            if (!rowState.isEditing.value) {
                                                              payment.transanctionDetails = rowState.controller.text;
                                                              // Add save logic here if needed
                                                            }
                                                          },
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ),

                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  // Widget _buildInfoRow(String label, String value) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 4),
  //     child: Row(
  //       children: [
  //         Expanded(
  //             flex: 2,
  //             child: Text(
  //               label,
  //               style: TextStyle(color: Colors.grey[700], fontSize: 14),
  //             )),
  //         Expanded(
  //             flex: 3,
  //             child: Text(
  //               value,
  //               style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
  //             )),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.blue),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDrawer() {
    return Drawer(
      backgroundColor: Primary_colors.Light,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(16))),
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter Vouchers',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Primary_colors.Color3),
            ),
            const Divider(height: 30, thickness: 1, color: Color.fromARGB(255, 97, 97, 97)),
            const SizedBox(height: 35),
            // Quick Date Filters
            const Text(
              'Voucher type',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [Obx(() => _buildVouchertypeFilterChip('Show All')), Obx(() => _buildVouchertypeFilterChip('Payment')), Obx(() => _buildVouchertypeFilterChip('Receipt'))],
            ),
            const SizedBox(height: 35),

            // Product Type Filter
            const Text(
              'Invoice Type',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
            ),
            const SizedBox(height: 8),
            Obx(
              () => Wrap(
                spacing: 8,
                children: [
                  FilterChip(
                    showCheckmark: false,
                    label: const Text('Show All'),
                    selected: voucherController.voucherModel.selectedInvoiceType.value == 'Show All',
                    onSelected: (_) {
                      voucherController.voucherModel.selectedInvoiceType.value = 'Show All';
                      voucherController.voucherModel.selectedsalescustomer.value = 'None';
                      voucherController.voucherModel.selectedsubcustomer.value = 'None';
                      // widget.get_VoucherList();
                    },
                    backgroundColor: Primary_colors.Dark,
                    selectedColor: Primary_colors.Dark,
                    labelStyle: TextStyle(
                      fontSize: Primary_font_size.Text7,
                      color: voucherController.voucherModel.selectedInvoiceType.value == 'Show All' ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: voucherController.voucherModel.selectedInvoiceType.value == 'Show All' ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84)),
                    ),
                  ),
                  FilterChip(
                    label: const Text('Sales'),
                    selected: voucherController.voucherModel.selectedInvoiceType.value == 'Sales',
                    onSelected: (_) {
                      voucherController.voucherModel.selectedInvoiceType.value = 'Sales';
                      voucherController.voucherModel.selectedsalescustomer.value = 'None';
                      voucherController.voucherModel.selectedsubcustomer.value = 'None';
                      // widget.get_VoucherList();
                    },
                    backgroundColor: Primary_colors.Dark,
                    showCheckmark: false,
                    selectedColor: Primary_colors.Dark,
                    labelStyle: TextStyle(
                      fontSize: Primary_font_size.Text7,
                      color: voucherController.voucherModel.selectedInvoiceType.value == 'Sales' ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: voucherController.voucherModel.selectedInvoiceType.value == 'Sales' ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84)),
                    ),
                  ),
                  FilterChip(
                    label: const Text('Subscription'),
                    selected: voucherController.voucherModel.selectedInvoiceType.value == 'Subscription',
                    onSelected: (_) {
                      voucherController.voucherModel.selectedInvoiceType.value = 'Subscription';
                      voucherController.voucherModel.selectedsalescustomer.value = 'None';
                      voucherController.voucherModel.selectedsubcustomer.value = 'None';
                      // widget.get_VoucherList();
                    },
                    backgroundColor: Primary_colors.Dark,
                    showCheckmark: false,
                    selectedColor: Primary_colors.Dark,
                    labelStyle: TextStyle(
                      fontSize: Primary_font_size.Text7,
                      color: voucherController.voucherModel.selectedInvoiceType.value == 'Subscription' ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: voucherController.voucherModel.selectedInvoiceType.value == 'Subscription' ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84)),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => SizedBox(
                child: voucherController.voucherModel.selectedInvoiceType.value == 'Sales'
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 35),
                          const Text(
                            'Select sales client',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
                          ),
                          const SizedBox(height: 10),
                          Obx(() {
                            return SizedBox(
                              height: 35,
                              // width: 250,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color.fromARGB(255, 91, 90, 90), width: 1.0),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: DropdownSearch<String>(
                                        popupProps: PopupProps.menu(
                                          showSearchBox: true,
                                          searchFieldProps: TextFieldProps(
                                            decoration: InputDecoration(
                                              hintText: 'Search...',
                                              hintStyle: const TextStyle(fontSize: 12),
                                              prefixIcon: const Icon(Icons.search, size: 18),
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(6.0),
                                                borderSide: BorderSide(color: Colors.grey.shade300),
                                              ),
                                              isDense: true,
                                            ),
                                          ),
                                          menuProps: MenuProps(borderRadius: BorderRadius.circular(6.0), elevation: 3),
                                          constraints: const BoxConstraints.tightFor(height: 250), // Reduced popup height
                                        ),
                                        dropdownDecoratorProps: DropDownDecoratorProps(
                                          dropdownSearchDecoration: InputDecoration(
                                            iconColor: const Color.fromARGB(252, 162, 158, 158),
                                            // labelText: "Client",
                                            // labelStyle: TextStyle(
                                            //   color: Colors.grey.shade600,
                                            //   fontSize: 12,
                                            // ),
                                            floatingLabelStyle: TextStyle(color: Colors.blue.shade700, fontSize: 12),
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                            border: InputBorder.none,
                                            isDense: true,
                                          ),
                                          baseStyle: const TextStyle(
                                            fontSize: 12, // Smaller font size
                                            color: Color.fromARGB(255, 138, 137, 137),
                                          ),
                                        ),
                                        items: voucherController.voucherModel.salesCustomerList.map((customer) {
                                          return customer.customerName;
                                        }).toList(),
                                        selectedItem: voucherController.voucherModel.selectedsalescustomer.value,
                                        onChanged: (value) {
                                          if (value != null) {
                                            voucherController.voucherModel.selectedsalescustomer.value = value;
                                            final customerList = voucherController.voucherModel.salesCustomerList;

                                            // Find the index of the selected customer
                                            final index = customerList.indexWhere((customer) => customer.customerName == value);
                                            voucherController.voucherModel.selectedcustomerID.value = voucherController.voucherModel.salesCustomerList[index].customerId;
                                            if (kDebugMode) {
                                              print('Selected customer ID: ${voucherController.voucherModel.selectedcustomerID.value}');
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                    Obx(
                                      () => SizedBox(
                                        child: voucherController.voucherModel.selectedsalescustomer.value != 'None'
                                            ? IconButton(
                                                onPressed: () {
                                                  voucherController.voucherModel.selectedsalescustomer.value = 'None';
                                                },
                                                icon: const Icon(Icons.close, color: Colors.red, size: 18),
                                              )
                                            : const SizedBox(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      )
                    : const SizedBox(),
              ),
            ),
            Obx(
              () => SizedBox(
                child: voucherController.voucherModel.selectedInvoiceType.value == 'Subscription'
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 35),
                          const Text(
                            'Select subscription customer',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
                          ),
                          const SizedBox(height: 10),
                          Obx(() {
                            return SizedBox(
                              height: 35,
                              // width: 250,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color.fromARGB(255, 91, 90, 90), width: 1.0),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: DropdownSearch<String>(
                                        popupProps: PopupProps.menu(
                                          showSearchBox: true,
                                          searchFieldProps: TextFieldProps(
                                            decoration: InputDecoration(
                                              hintText: 'Search...',
                                              hintStyle: const TextStyle(fontSize: 12),
                                              prefixIcon: const Icon(Icons.search, size: 18),
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(6.0),
                                                borderSide: BorderSide(color: Colors.grey.shade300),
                                              ),
                                              isDense: true,
                                            ),
                                          ),
                                          menuProps: MenuProps(borderRadius: BorderRadius.circular(6.0), elevation: 3),
                                          constraints: const BoxConstraints.tightFor(height: 250), // Reduced popup height
                                        ),
                                        dropdownDecoratorProps: DropDownDecoratorProps(
                                          dropdownSearchDecoration: InputDecoration(
                                            iconColor: const Color.fromARGB(252, 162, 158, 158),
                                            // labelText: "Client",
                                            // labelStyle: TextStyle(
                                            //   color: Colors.grey.shade600,
                                            //   fontSize: 12,
                                            // ),
                                            floatingLabelStyle: TextStyle(color: Colors.blue.shade700, fontSize: 12),
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                            border: InputBorder.none,
                                            isDense: true,
                                          ),
                                          baseStyle: const TextStyle(
                                            fontSize: 12, // Smaller font size
                                            color: Color.fromARGB(255, 138, 137, 137),
                                          ),
                                        ),
                                        items: voucherController.voucherModel.subCustomerList.map((customer) {
                                          return customer.customerName;
                                        }).toList(),
                                        selectedItem: voucherController.voucherModel.selectedsubcustomer.value,
                                        onChanged: (value) {
                                          if (value != null) {
                                            voucherController.voucherModel.selectedsubcustomer.value = value;
                                            final customerList = voucherController.voucherModel.subCustomerList;

                                            // Find the index of the selected customer
                                            final index = customerList.indexWhere((customer) => customer.customerName == value);
                                            voucherController.voucherModel.selectedcustomerID.value = voucherController.voucherModel.subCustomerList[index].customerId;

                                            // print('Selected customer ID: ${view_LedgerController.view_LedgerModel.selectedsubcustomerID.value}');
                                            // widget.get_VoucherList();
                                          }
                                        },
                                      ),
                                    ),
                                    Obx(
                                      () => SizedBox(
                                        child: voucherController.voucherModel.selectedsubcustomer.value != 'None'
                                            ? IconButton(
                                                onPressed: () {
                                                  voucherController.voucherModel.selectedsubcustomer.value = 'None';
                                                  voucherController.voucherModel.selectedcustomerID.value = 'None';
                                                  widget.get_VoucherList();
                                                },
                                                icon: const Icon(Icons.close, color: Colors.red, size: 18),
                                              )
                                            : const SizedBox(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      )
                    : const SizedBox(),
              ),
            ),
            const SizedBox(height: 35),

            // Status Filter
            const Text(
              'Payment Status',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
            ),
            const SizedBox(height: 8),
            Obx(
              () => Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromARGB(255, 85, 84, 84)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonFormField<String>(
                  value: voucherController.voucherModel.selectedpaymentStatus.value,
                  isDense: true, // Reduces the vertical height
                  items: voucherController.voucherModel.paymentstatusList.map((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) {
                    voucherController.voucherModel.selectedpaymentStatus.value = value!;
                    // widget.get_VoucherList();
                  },
                  decoration: const InputDecoration(
                    isDense: true, // Makes the field more compact
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Smaller padding
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 154, 152, 152)),
                  dropdownColor: Primary_colors.Dark,
                ),
              ),
            ),

            const SizedBox(height: 35),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Select date',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
                    ),
                    // const SizedBox(width: 8),
                    Obx(
                      () => SizedBox(
                        child: voucherController.voucherModel.startDateController.value.text.isNotEmpty || voucherController.voucherModel.endDateController.value.text.isNotEmpty
                            ? TextButton(
                                onPressed: () {
                                  voucherController.voucherModel.selectedMonth.value = 'None';
                                  voucherController.voucherModel.startDateController.value.clear();
                                  voucherController.voucherModel.endDateController.value.clear();
                                  voucherController.voucherModel.selectedMonth.refresh();
                                  voucherController.voucherModel.startDateController.refresh();
                                  voucherController.voucherModel.endDateController.refresh();
                                  // widget.get_VoucherList();
                                },
                                child: const Text('Clear', style: TextStyle(fontSize: Primary_font_size.Text7)),
                              )
                            : const SizedBox(),
                      ),
                    ),
                    const Spacer(),
                    Obx(
                      () {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          width: 100, // Adjust width as needed
                          height: 30, // Adjust height as needed
                          child: DropdownButtonFormField<String>(
                            menuMaxHeight: 300,
                            value: voucherController.voucherModel.selectedMonth.value,
                            items: ['None', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'].map((String value) {
                              return DropdownMenuItem<String>(value: value, child: Text(value));
                            }).toList(),
                            onChanged: (value) {
                              voucherController.voucherModel.selectedMonth.value = value!;
                              if (value != 'None') {
                                final monthIndex = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'].indexOf(value) + 1;

                                final now = DateTime.now();
                                final year = now.year;
                                final firstDay = DateTime(year, monthIndex, 1);
                                final lastDay = monthIndex < 12 ? DateTime(year, monthIndex + 1, 0) : DateTime(year + 1, 1, 0);

                                String formatDate(DateTime date) {
                                  return "${date.year.toString().padLeft(4, '0')}-"
                                      "${date.month.toString().padLeft(2, '0')}-"
                                      "${date.day.toString().padLeft(2, '0')}";
                                }

                                voucherController.voucherModel.startDateController.value.text = formatDate(firstDay);
                                voucherController.voucherModel.endDateController.value.text = formatDate(lastDay);
                                voucherController.voucherModel.startDateController.refresh();
                                voucherController.voucherModel.endDateController.refresh();
                                // widget.get_VoucherList();
                              } else {
                                voucherController.voucherModel.startDateController.value.clear();
                                voucherController.voucherModel.endDateController.value.clear();
                                voucherController.voucherModel.startDateController.refresh();
                                voucherController.voucherModel.endDateController.refresh();
                                // widget.get_VoucherList();
                              }
                            },
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 8),
                              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                            ),
                            style: const TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 154, 152, 152)),
                            dropdownColor: Primary_colors.Dark,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 35,
                          child: TextFormField(
                            style: const TextStyle(color: Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
                            controller: voucherController.voucherModel.startDateController.value,
                            readOnly: true,
                            onTap: () async {
                              await select_previousDates(context, voucherController.voucherModel.startDateController.value);
                              // await widget.get_VoucherList();
                              voucherController.voucherModel.startDateController.refresh();
                            },
                            decoration: InputDecoration(
                              labelText: 'From',
                              labelStyle: const TextStyle(color: Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
                              suffixIcon: const Icon(Icons.calendar_today, size: 20, color: Color.fromARGB(255, 85, 84, 84)),
                              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 35,
                          child: TextFormField(
                            style: const TextStyle(color: Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
                            controller: voucherController.voucherModel.endDateController.value,
                            readOnly: true,
                            onTap: () async {
                              await select_previousDates(context, voucherController.voucherModel.endDateController.value);
                              voucherController.voucherModel.endDateController.refresh();
                              // await widget.get_VoucherList();
                            },
                            decoration: InputDecoration(
                              labelText: 'To',
                              labelStyle: const TextStyle(color: Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
                              suffixIcon: const Icon(Icons.calendar_today, size: 20, color: Color.fromARGB(255, 85, 84, 84)),
                              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {
                    widget.resetvoucherFilters();
                    widget.get_VoucherList();
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Primary_colors.Color3),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('RESET', style: TextStyle(color: Primary_colors.Color3)),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    widget.assignvoucherFilters();
                    await widget.get_VoucherList();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Primary_colors.Color3,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'APPLY',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildVouchertypeFilterChip(String label, VoidCallback onSelected) {
  //   final isSelected = voucherController.voucherModel.selectedQuickFilter.value == label;

  //   return ChoiceChip(
  //     label: Text(
  //       label,
  //       style: TextStyle(color: isSelected ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152)),
  //     ),
  //     selected: isSelected,
  //     onSelected: (_) {
  //       voucherController.voucherModel.selectedQuickFilter.value = label;
  //       onSelected();
  //     },
  //     backgroundColor: Primary_colors.Dark,
  //     selectedColor: Primary_colors.Color3.withOpacity(0.2),
  //     labelStyle: TextStyle(
  //       color: isSelected ? Primary_colors.Color3 : Colors.black,
  //     ),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(8),
  //       side: BorderSide(
  //         color: isSelected ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84)!,
  //       ),
  //     ),
  //   );
  // }
  Widget _buildselectedFiltersChip(String label, {required VoidCallback onRemove}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 203, 207, 252),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Primary_colors.Color3),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(color: Color.fromARGB(255, 15, 20, 88), fontSize: Primary_font_size.Text8),
          ),
          const SizedBox(width: 4),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () async {
                onRemove();
                await widget.get_VoucherList();
                voucherController.voucherModel.voucherSelectedFilter.refresh();
              },
              child: const Icon(Icons.cancel_sharp, size: 16, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVouchertypeFilterChip(String label) {
    final isSelected = voucherController.voucherModel.selectedvouchertype.value == label;

    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(color: isSelected ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
      ),
      selected: isSelected,
      onSelected: (_) {
        voucherController.voucherModel.selectedvouchertype.value = label;
        // widget.get_VoucherList();
      },
      backgroundColor: Primary_colors.Dark,
      selectedColor: Primary_colors.Dark,
      labelStyle: TextStyle(color: isSelected ? Primary_colors.Color3 : Colors.black),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: isSelected ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84)),
      ),
    );
  }
}

class CreateVoucherBottomSheet extends StatelessWidget with VoucherService {
  CreateVoucherBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final VoucherController voucherController = Get.find<VoucherController>();

    return Obx(() {
      final String? extension = voucherController.voucherModel.fileName.value?.split('.').last.toLowerCase();

      return Container(
        height: 500,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 117, 66, 245), Color.fromARGB(255, 33, 94, 248), Color.fromARGB(255, 100, 42, 247)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Create Sales Voucher',
                        style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text15),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Wrap(
                              spacing: 30,
                              runSpacing: 50,
                              children: [
                                // Client Name Field
                                SizedBox(
                                  width: 400,
                                  height: 50,
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(1),
                                      filled: true,
                                      fillColor: const Color.fromARGB(37, 255, 255, 255),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(color: Colors.transparent),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(color: Colors.transparent),
                                      ),
                                      hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                      hintText: 'Enter Client Name',
                                      border: const OutlineInputBorder(),
                                      prefixIcon: const Icon(Icons.people, color: Primary_colors.Color1),
                                    ),
                                  ),
                                ),
                                // Date Field
                                SizedBox(
                                  width: 400,
                                  height: 50,
                                  child: TextFormField(
                                    controller: voucherController.voucherModel.dateController.value,
                                    readOnly: true,
                                    onTap: () => selectfilterDate(context, voucherController.voucherModel.dateController.value),
                                    style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(1),
                                      filled: true,
                                      fillColor: const Color.fromARGB(37, 255, 255, 255),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(color: Colors.transparent),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(color: Colors.transparent),
                                      ),
                                      hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                      hintText: 'Enter Date',
                                      border: const OutlineInputBorder(),
                                      prefixIcon: const Icon(Icons.calendar_today, color: Primary_colors.Color1),
                                    ),
                                  ),
                                ),
                                // Reference Number Field
                                SizedBox(
                                  width: 400,
                                  height: 50,
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(1),
                                      filled: true,
                                      fillColor: const Color.fromARGB(37, 255, 255, 255),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(color: Colors.transparent),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(color: Colors.transparent),
                                      ),
                                      hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                      hintText: 'Enter Reference No',
                                      border: const OutlineInputBorder(),
                                      prefixIcon: const Icon(Icons.receipt, color: Primary_colors.Color1),
                                    ),
                                  ),
                                ),
                                // Particulars Field
                                SizedBox(
                                  width: 400,
                                  height: 50,
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(1),
                                      filled: true,
                                      fillColor: const Color.fromARGB(37, 255, 255, 255),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(color: Colors.transparent),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(color: Colors.transparent),
                                      ),
                                      hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                      hintText: 'Enter Particulars',
                                      border: const OutlineInputBorder(),
                                      prefixIcon: const Icon(Icons.description, color: Primary_colors.Color1),
                                    ),
                                  ),
                                ),
                                // Notes Field
                                SizedBox(
                                  width: 400,
                                  height: 50,
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(1),
                                      filled: true,
                                      fillColor: const Color.fromARGB(37, 255, 255, 255),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(color: Colors.transparent),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(color: Colors.transparent),
                                      ),
                                      hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                      hintText: 'Enter Notes',
                                      border: const OutlineInputBorder(),
                                      prefixIcon: const Icon(Icons.note, color: Primary_colors.Color1),
                                    ),
                                  ),
                                ),
                                // Total, Net, and GST Fields
                                SizedBox(
                                  width: 400,
                                  height: 50,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.all(1),
                                            filled: true,
                                            fillColor: const Color.fromARGB(37, 255, 255, 255),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: const BorderSide(color: Colors.black),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: const BorderSide(color: Colors.transparent),
                                            ),
                                            hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                            hintText: 'Net',
                                            border: const OutlineInputBorder(),
                                            prefixIcon: const Icon(Icons.calculate, color: Primary_colors.Color1),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: TextFormField(
                                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.all(1),
                                            filled: true,
                                            fillColor: const Color.fromARGB(37, 255, 255, 255),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: const BorderSide(color: Colors.transparent),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: const BorderSide(color: Colors.transparent),
                                            ),
                                            hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                            hintText: 'GST',
                                            border: const OutlineInputBorder(),
                                            prefixIcon: const Icon(Icons.percent, color: Primary_colors.Color1),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: TextFormField(
                                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.all(1),
                                            filled: true,
                                            fillColor: const Color.fromARGB(37, 255, 255, 255),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: const BorderSide(color: Colors.transparent),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: const BorderSide(color: Colors.transparent),
                                            ),
                                            hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                            hintText: 'Total',
                                            border: const OutlineInputBorder(),
                                            prefixIcon: const Icon(Icons.attach_money, color: Primary_colors.Color1),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Upload invoice',
                                  style: TextStyle(fontSize: Primary_font_size.Text10, fontWeight: FontWeight.bold, color: Primary_colors.Color1),
                                ),
                                const SizedBox(height: 24),
                                GestureDetector(
                                  onTap: pickFile,
                                  child: SizedBox(
                                    width: 300,
                                    height: 250,
                                    child: DashedRect(
                                      color: Primary_colors.Color1,
                                      strokeWidth: 2.0,
                                      gap: 5.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: voucherController.voucherModel.selectedFile.value != null
                                              ? SizedBox(
                                                  height: 150,
                                                  width: 150,
                                                  child: extension == 'pdf'
                                                      ? Image.asset('assets/images/pdfdownload.png', fit: BoxFit.cover)
                                                      : extension == 'docx' || extension == 'doc'
                                                          ? Image.asset('assets/images/word.png', fit: BoxFit.cover)
                                                          : extension == 'png' || extension == 'jpg' || extension == 'jpeg'
                                                              ? Image.file(voucherController.voucherModel.selectedFile.value!, fit: BoxFit.cover)
                                                              : const Center(
                                                                  child: Text('File type not supported', style: TextStyle(color: Colors.white)),
                                                                ),
                                                )
                                              : const Center(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.cloud_upload_outlined, size: 100, color: Color.fromARGB(255, 184, 184, 184)),
                                                      SizedBox(height: 10),
                                                      Text('Click here to pick file', style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 182, 181, 181))),
                                                    ],
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  voucherController.voucherModel.fileName.value ?? 'No file selected',
                                  style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 180, 179, 179)),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 35,
                            decoration: BoxDecoration(color: Primary_colors.Color1, borderRadius: BorderRadius.circular(10)),
                            child: TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                'Close',
                                style: TextStyle(color: Colors.red, fontSize: Primary_font_size.Text10),
                              ),
                            ),
                          ),
                          const SizedBox(width: 50),
                          Container(
                            width: 120,
                            height: 35,
                            decoration: BoxDecoration(color: Primary_colors.Color1, borderRadius: BorderRadius.circular(10)),
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Submit',
                                style: TextStyle(color: Colors.green, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notes on Sales Voucher',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 207, 207, 207)),
                      ),
                      SizedBox(height: 10),
                      Text('1. Purpose: A sales voucher records details of sales transactions.', style: TextStyle(color: Color.fromARGB(255, 169, 168, 168))),
                      SizedBox(height: 10),
                      Text('2. Date: Represents the date of the transaction; ensure accuracy.', style: TextStyle(color: Color.fromARGB(255, 169, 168, 168))),
                      SizedBox(height: 10),
                      Text('3. Reference Number: Unique identifier for tracking and auditing.', style: TextStyle(color: Color.fromARGB(255, 169, 168, 168))),
                      SizedBox(height: 10),
                      Text('4. Particulars: Describes items, product, or services sold.', style: TextStyle(color: Color.fromARGB(255, 169, 168, 168))),
                      SizedBox(height: 10),
                      Text('5. Notes Section: Includes additional remarks or instructions.', style: TextStyle(color: Color.fromARGB(255, 169, 168, 168))),
                      SizedBox(height: 10),
                      Text('6. Total Amount: Gross amount before deductions or taxes.', style: TextStyle(color: Color.fromARGB(255, 169, 168, 168))),
                      SizedBox(height: 10),
                      Text('7. Net Amount: Final amount after deductions or discounts.', style: TextStyle(color: Color.fromARGB(255, 169, 168, 168))),
                      SizedBox(height: 10),
                      Text('8. GST: Tax amount based on the transaction value; ensure accuracy.', style: TextStyle(color: Color.fromARGB(255, 169, 168, 168))),
                      SizedBox(height: 10),
                      Text('9. Accuracy: Verify all details before finalizing the voucher.', style: TextStyle(color: Color.fromARGB(255, 169, 168, 168))),
                      SizedBox(height: 10),
                      Text('10. Retention: Maintain sales vouchers securely for records and audits.', style: TextStyle(color: Color.fromARGB(255, 169, 168, 168))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

String formatDateVoucher(DateTime date) {
  return DateFormat('dd-MM-yyyy').format(date);
}

class ClientInfoIcon extends StatefulWidget {
  final String clientName;
  final String clientDetails; // Add more detail to show in pop-up

  const ClientInfoIcon({super.key, required this.clientName, required this.clientDetails});

  @override
  State<ClientInfoIcon> createState() => _ClientInfoIconState();
}

class _ClientInfoIconState extends State<ClientInfoIcon> {
  OverlayEntry? _overlayEntry;

  void _showPopup(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // To detect tap outside
          GestureDetector(
            onTap: _removePopup,
            child: Container(color: Colors.transparent),
          ),
          Positioned(
            left: offset.dx,
            top: offset.dy + renderBox.size.height + 8,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 200,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(widget.clientDetails, style: const TextStyle(fontSize: 14), textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removePopup() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Row(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                if (_overlayEntry == null) {
                  _showPopup(context);
                } else {
                  _removePopup();
                }
              },
              child: const Icon(Icons.info_outline),
            ),
          ),
          const SizedBox(width: 3),
          Text(
            widget.clientName,
            style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
          ),
        ],
      ),
    );
  }
}
