// ignore_for_file: deprecated_member_use

import 'package:dashed_rect/dashed_rect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ssipl_billing/2.BILLING/Vouchers/controllers/voucher_action.dart';
import 'package:ssipl_billing/2.BILLING/Vouchers/services/voucher_service.dart';
import 'package:ssipl_billing/THEMES-/style.dart';
import 'package:ssipl_billing/UTILS-/helpers/support_functions.dart';

class Voucher extends StatefulWidget with VoucherService {
  Voucher({super.key});

  @override
  State<Voucher> createState() => _VoucherState();
}

class _VoucherState extends State<Voucher> {
  final VoucherController voucherController = Get.find<VoucherController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    widget.get_VoucherList(context);
    // Ensure data is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      voucherController.voucherModel.selectedItems = List<bool>.filled(voucherController.voucherModel.filteredVouchers.length, false).obs;
    });
  }

  final GlobalKey _copyIconKey = GlobalKey();
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header with gradient
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Primary_colors.Color3,
                            Primary_colors.Color3.withOpacity(0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.receipt_long, color: Colors.white, size: 20),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'UPDATE VOUCHER PAYMENT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Primary_font_size.Text10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
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
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Primary_colors.Dark,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color.fromARGB(55, 243, 208, 96),
                                width: 1,
                              ),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.warning_amber_rounded, color: Color.fromARGB(255, 236, 190, 64), size: 20),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "Client have exceeded the transaction of 1 Lakh, so this invoice is TDS Deductable!",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 236, 190, 64),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
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
                              border: Border.all(
                                color: Primary_colors.Dark,
                                width: 1,
                              ),
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
                                            decoration: BoxDecoration(
                                              color: Primary_colors.Color3.withOpacity(0.1),
                                              shape: BoxShape.circle,
                                            ),
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
                                                Text(
                                                  "Client ID: ${voucherController.voucherModel.voucher_list[index].customerId}",
                                                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                                                ),
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
                                Container(
                                  height: 120,
                                  width: 0.5,
                                  color: Colors.grey[500],
                                  margin: const EdgeInsets.symmetric(horizontal: 16),
                                ),

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
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          // Define a GlobalKey in your widget's state

// Inside your Row widget
                                          Row(
                                            children: [
                                              Text(
                                                voucherController.voucherModel.voucher_list[index].invoiceNumber,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Primary_font_size.Text8,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              MouseRegion(
                                                cursor: SystemMouseCursors.click,
                                                child: GestureDetector(
                                                  key: _copyIconKey, // Attach the key here
                                                  onTap: () async {
                                                    await Clipboard.setData(ClipboardData(
                                                      text: voucherController.voucherModel.voucher_list[index].invoiceNumber,
                                                    ));

                                                    final renderBox = _copyIconKey.currentContext?.findRenderObject() as RenderBox?;
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
                                                            decoration: BoxDecoration(
                                                              color: const Color.fromARGB(119, 33, 149, 243).withOpacity(0.8),
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
                                        "Invoice Amount:",
                                        "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucherController.voucherModel.voucher_list[index].totalAmount)}",
                                        Colors.green,
                                      ),
                                      const SizedBox(height: 12),
                                      _amountRow(
                                        "Receivable Amount:",
                                        "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucherController.voucherModel.voucher_list[index].totalAmount)}",
                                        Colors.green,
                                      ),
                                      const SizedBox(height: 12),
                                      _amountRow(
                                        "Pending Amount:",
                                        "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucherController.voucherModel.voucher_list[index].pendingAmount)}",
                                        voucherController.voucherModel.voucher_list[index].pendingAmount > 0 ? const Color.fromARGB(255, 253, 206, 64) : Colors.grey,
                                      ),
                                      const SizedBox(height: 12),
                                      _buildLastPaymentInfo(),
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
                                    border: Border.all(
                                      color: Primary_colors.Dark,
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      _buildEditableField(
                                        controller: voucherController.voucherModel.closedDateController,
                                        label: 'Closed Date',
                                        hint: 'Select closed date',
                                        icon: Icons.calendar_today,
                                        onTap: () => widget.selectDate(context, voucherController.voucherModel.closedDateController),
                                      ),
                                      const SizedBox(height: 16),
                                      _buildEditableField(
                                        controller: voucherController.voucherModel.amountCleared_controller.value,
                                        label: 'Amount Received',
                                        hint: 'Enter received amount',
                                        icon: Icons.attach_money,
                                        keyboardType: TextInputType.number,
                                      ),
                                      const SizedBox(height: 16),
                                      _buildDropdownField(
                                        label: 'TDS Status',
                                        hint: 'Select TDS status',
                                        icon: Icons.percent,
                                        items: ['Deducted', 'Not Applicable', 'Pending'],
                                        onChanged: (value) {},
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
                                        border: Border.all(
                                          color: Primary_colors.Dark,
                                          width: 1,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "PAYMENT BREAKUP",
                                            style: TextStyle(
                                              color: Primary_colors.Color3,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              letterSpacing: 0.5,
                                            ),
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
                                          _buildBreakupLine(
                                              "TDS (2%)", "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucherController.voucherModel.voucher_list[index].tdsCalculationAmount)}"),
                                          const SizedBox(height: 16),
                                          Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: Primary_colors.Color3.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Text(
                                                  "Total Amount",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucherController.voucherModel.voucher_list[index].totalAmount)}",
                                                  style: const TextStyle(
                                                    color: Primary_colors.Color3,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
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
                                          "UPLOAD PAYMENT RECEIPT",
                                          style: TextStyle(
                                            color: Primary_colors.Color3,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            letterSpacing: 0.5,
                                          ),
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
                                                      Icon(
                                                        Icons.cloud_upload,
                                                        size: 40,
                                                        color: Primary_colors.Color3.withOpacity(0.7),
                                                      ),
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
                                                          style: const TextStyle(
                                                            overflow: TextOverflow.ellipsis,
                                                            fontSize: 12,
                                                            color: Colors.grey,
                                                          ),
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
                                  ],
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
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text(
                                  'CANCEL',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Primary_colors.Color3,
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 2,
                                  shadowColor: Primary_colors.Color3.withOpacity(0.3),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Voucher closed successfully'),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                },
                                child: const Text(
                                  'MARK AS PAID',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 2,
                                ),
                                onPressed: () async {
                                  await widget.clearVoucher(context, index);
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Voucher partially cleared'),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor: Colors.blue,
                                    ),
                                  );
                                },
                                child: const Text(
                                  'PARTIALLY CLEAR',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
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
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditableField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    VoidCallback? onTap,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          readOnly: onTap != null,
          onTap: onTap,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Primary_colors.Light,
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: Primary_font_size.Text8,
            ),
            prefixIcon: Icon(
              icon,
              color: Primary_colors.Color3,
              size: 20,
            ),
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
          style: const TextStyle(
            fontSize: Primary_font_size.Text8,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required IconData icon,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.grey,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          hint: Text(
            hint,
            style: TextStyle(
              fontSize: Primary_font_size.Text8,
              color: Colors.grey[400],
              letterSpacing: 0.5,
            ),
          ),
          dropdownColor: Primary_colors.Light,
          decoration: InputDecoration(
            filled: true,
            fillColor: Primary_colors.Light,
            prefixIcon: Icon(
              icon,
              color: Primary_colors.Color3,
              size: 20,
            ),
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
              child: Text(
                value,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
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
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildLastPaymentInfo() {
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
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "PAYMENT HISTORY",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildPaymentHistoryItem("12.05.2025", "₹1,05,000"),
                          _buildPaymentHistoryItem("28.04.2025", "₹50,000"),
                          _buildPaymentHistoryItem("15.03.2025", "₹75,000"),
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
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
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
                child: const Row(
                  children: [
                    Text(
                      "12.05.2025 - ₹1,05,000",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Primary_colors.Color3,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.info_outline,
                      color: Primary_colors.Color3,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPaymentHistoryItem(String date, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          Row(
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              IconButton(onPressed: () {}, icon: Image.asset(height: 30, 'assets/images/pdfdownload.png')),
            ],
          )
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
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakupDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Divider(
        height: 1,
        color: Colors.grey,
        thickness: 0.2,
      ),
    );
  }

  // void _showCloseVoucherPopup(int index) {
  //   final TextEditingController _closedDateController = TextEditingController(text: "${DateTime.now().toLocal()}".split(' ')[0]);
  //   final TextEditingController _referenceIdController = TextEditingController();

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         backgroundColor: Colors.transparent,
  //         insetPadding: const EdgeInsets.all(20),
  //         child: Obx(
  //           () => Container(
  //             width: 600,
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(16),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.black.withOpacity(0.2),
  //                   blurRadius: 20,
  //                   offset: const Offset(0, 10),
  //                 ),
  //               ],
  //             ),
  //             child: SingleChildScrollView(
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   // Header
  //                   Container(
  //                     padding: const EdgeInsets.all(16),
  //                     decoration: const BoxDecoration(
  //                       color: Primary_colors.Color3,
  //                       borderRadius: BorderRadius.only(
  //                         topLeft: Radius.circular(16),
  //                         topRight: Radius.circular(16),
  //                       ),
  //                     ),
  //                     child: Row(
  //                       children: [
  //                         const Icon(Icons.receipt_long, color: Colors.white, size: 24),
  //                         const SizedBox(width: 12),
  //                         const Text(
  //                           'Close Voucher',
  //                           style: TextStyle(
  //                             color: Colors.white,
  //                             fontSize: Primary_font_size.SubHeading,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                         const Spacer(),
  //                         IconButton(
  //                           icon: const Icon(Icons.close, color: Colors.white),
  //                           onPressed: () => Navigator.of(context).pop(),
  //                         ),
  //                       ],
  //                     ),
  //                   ),

  //                   // Form Content
  //                   Padding(
  //                     padding: const EdgeInsets.all(14),
  //                     child: Column(
  //                       children: [
  //                         // First Row - Non-editable fields
  //                         Row(
  //                           children: [
  //                             // Voucher ID
  //                             Expanded(
  //                               child: _buildReadOnlyField(
  //                                 label: 'Voucher ID',
  //                                 value: voucherController.voucherModel.voucher_list[index].voucherNumber,
  //                                 icon: Icons.confirmation_number,
  //                               ),
  //                             ),
  //                             const SizedBox(width: 16),
  //                             // Invoice ID
  //                             Expanded(
  //                               child: _buildReadOnlyField(
  //                                 label: 'Invoice ID',
  //                                 value: voucherController.voucherModel.voucher_list[index].invoiceNumber,
  //                                 icon: Icons.receipt,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         const SizedBox(height: 16),

  //                         // Second Row - Non-editable fields
  //                         Row(
  //                           children: [
  //                             // Client Name
  //                             Expanded(
  //                               child: _buildReadOnlyField(
  //                                 label: 'Client Name',
  //                                 value: voucherController.voucherModel.voucher_list[index].clientName,
  //                                 icon: Icons.person,
  //                               ),
  //                             ),
  //                             const SizedBox(width: 16),
  //                             // Amount
  //                             Expanded(
  //                               child: _buildReadOnlyField(
  //                                 label: 'Amount',
  //                                 value: '₹${voucherController.voucherModel.voucher_list[index].totalAmount}',
  //                                 icon: Icons.attach_money,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         const SizedBox(height: 24),

  //                         // Divider
  //                         const Divider(height: 1, color: Colors.grey),
  //                         const SizedBox(height: 14),

  //                         // Editable Fields
  //                         // Closed Date
  //                         _buildEditableField(
  //                           controller: _closedDateController,
  //                           label: 'Closed Date',
  //                           hint: 'Select closed date',
  //                           icon: Icons.calendar_today,
  //                           onTap: () => widget.selectDate(context, _closedDateController),
  //                         ),
  //                         const SizedBox(height: 16),

  //                         // Reference ID
  //                         _buildEditableField(
  //                           controller: _referenceIdController,
  //                           label: 'Reference ID',
  //                           hint: 'Enter payment reference ID',
  //                           icon: Icons.credit_card,
  //                         ),
  //                         const SizedBox(height: 16),

  //                         // Upload Section
  //                         const Align(
  //                           alignment: Alignment.centerLeft,
  //                           child: Text(
  //                             'Upload Payment Receipt',
  //                             style: TextStyle(
  //                               fontSize: 14,
  //                               fontWeight: FontWeight.bold,
  //                               color: Colors.black87,
  //                             ),
  //                           ),
  //                         ),
  //                         const SizedBox(height: 8),
  //                         GestureDetector(
  //                           onTap: widget.pickFile,
  //                           child: DashedRect(
  //                             color: const Color.fromARGB(255, 173, 171, 171),
  //                             strokeWidth: 2.0,
  //                             gap: 5.0,
  //                             child: Padding(
  //                               padding: const EdgeInsets.all(8.0),
  //                               child: Column(
  //                                 mainAxisAlignment: MainAxisAlignment.center,
  //                                 children: [
  //                                   const Icon(
  //                                     Icons.cloud_upload,
  //                                     size: 40,
  //                                     color: Primary_colors.Color3,
  //                                   ),
  //                                   const SizedBox(height: 8),
  //                                   Text(
  //                                     voucherController.voucherModel.fileName.value ?? '               Click to upload               ',
  //                                     style: TextStyle(
  //                                       color: voucherController.voucherModel.fileName.value != null ? Primary_colors.Color3 : Colors.grey,
  //                                       fontWeight: voucherController.voucherModel.fileName.value != null ? FontWeight.bold : FontWeight.normal,
  //                                     ),
  //                                   ),
  //                                   if (voucherController.voucherModel.fileName.value != null) ...[
  //                                     const SizedBox(height: 4),
  //                                     Text(
  //                                       '${(voucherController.voucherModel.selectedFile.value?.lengthSync() ?? 0) / 1024} KB',
  //                                       style: const TextStyle(
  //                                         fontSize: 12,
  //                                         color: Colors.grey,
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         const SizedBox(height: 24),

  //                         // Action Buttons
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.end,
  //                           children: [
  //                             TextButton(
  //                               style: TextButton.styleFrom(
  //                                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  //                                 shape: RoundedRectangleBorder(
  //                                   borderRadius: BorderRadius.circular(8),
  //                                 ),
  //                               ),
  //                               onPressed: () => Navigator.of(context).pop(),
  //                               child: const Text(
  //                                 'CANCEL',
  //                                 style: TextStyle(
  //                                   color: Colors.red,
  //                                   fontWeight: FontWeight.bold,
  //                                 ),
  //                               ),
  //                             ),
  //                             const SizedBox(width: 16),
  //                             ElevatedButton(
  //                               style: ElevatedButton.styleFrom(
  //                                 backgroundColor: Primary_colors.Color3,
  //                                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  //                                 shape: RoundedRectangleBorder(
  //                                   borderRadius: BorderRadius.circular(8),
  //                                 ),
  //                                 elevation: 2,
  //                               ),
  //                               onPressed: () {
  //                                 Navigator.of(context).pop();
  //                                 ScaffoldMessenger.of(context).showSnackBar(
  //                                   SnackBar(
  //                                     content: const Text('Voucher closed successfully'),
  //                                     behavior: SnackBarBehavior.floating,
  //                                     shape: RoundedRectangleBorder(
  //                                       borderRadius: BorderRadius.circular(8),
  //                                     ),
  //                                     backgroundColor: Colors.green,
  //                                   ),
  //                                 );
  //                               },
  //                               child: const Text(
  //                                 'CONFIRM CLOSE',
  //                                 style: TextStyle(
  //                                   color: Colors.white,
  //                                   fontWeight: FontWeight.bold,
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // Widget _buildReadOnlyField({
  //   required String label,
  //   required String value,
  //   required IconData icon,
  // }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         maxLines: 5,
  //         label,
  //         style: const TextStyle(
  //           fontSize: 13,
  //           color: Colors.black54,
  //           fontWeight: FontWeight.w500,
  //         ),
  //       ),
  //       const SizedBox(height: 4),
  //       Container(
  //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  //         decoration: BoxDecoration(
  //           color: Colors.grey[100],
  //           borderRadius: BorderRadius.circular(8),
  //           border: Border.all(color: Colors.grey[300]!),
  //         ),
  //         child: Row(
  //           children: [
  //             Icon(icon, size: 20, color: Colors.grey[600]),
  //             const SizedBox(width: 12),
  //             Text(
  //               maxLines: 4,
  //               value,
  //               style: const TextStyle(
  //                 fontSize: 14,
  //                 color: Colors.black87,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
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
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 3),
                        const Text(
                          'Vouchers',
                          style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text12),
                        ),
                        Obx(
                          () => voucherController.voucherModel.showDeleteButton.value
                              ? Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    ElevatedButton(
                                      onPressed: () => widget.deleteSelectedItems(context),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 400,
                          height: 40,
                          child: TextFormField(
                            controller: voucherController.voucherModel.searchController,
                            onChanged: (value) => widget.applySearchFilter(value),
                            style: const TextStyle(fontSize: 13, color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(1),
                              filled: true,
                              fillColor: Primary_colors.Light,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              hintStyle: const TextStyle(
                                fontSize: Primary_font_size.Text7,
                                color: Color.fromARGB(255, 167, 165, 165),
                              ),
                              hintText: 'Search customer',
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (BuildContext context) => CreateVoucherBottomSheet(),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            'Create Voucher',
                            style: TextStyle(fontSize: Primary_font_size.Text6),
                          ),
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          onPressed: () {
                            _scaffoldKey.currentState?.openEndDrawer();
                          },
                          icon: const Icon(
                            Icons.filter_alt_outlined,
                            color: Primary_colors.Color1,
                          ),
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Primary_colors.Light,
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Primary_colors.Color3, Primary_colors.Color3],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
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
                                  for (int i = 0; i < voucherController.voucherModel.selectedItems.length; i++) {
                                    voucherController.voucherModel.selectedItems[i] = voucherController.voucherModel.selectAll.value;
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
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 3),
                          const Expanded(
                            flex: 2,
                            child: Text(
                              'Date',
                              style: TextStyle(
                                color: Primary_colors.Color1,
                                fontWeight: FontWeight.bold,
                                fontSize: Primary_font_size.Text7,
                              ),
                            ),
                          ),
                          const SizedBox(width: 3),
                          const Expanded(
                            flex: 2,
                            child: Text(
                              'Voucher Number',
                              style: TextStyle(
                                color: Primary_colors.Color1,
                                fontWeight: FontWeight.bold,
                                fontSize: Primary_font_size.Text7,
                              ),
                            ),
                          ),
                          const SizedBox(width: 3),
                          const Expanded(
                            flex: 2,
                            child: Text(
                              'Invoice Number',
                              style: TextStyle(
                                color: Primary_colors.Color1,
                                fontWeight: FontWeight.bold,
                                fontSize: Primary_font_size.Text7,
                              ),
                            ),
                          ),
                          const SizedBox(width: 3),
                          const Expanded(
                            flex: 2,
                            child: Text(
                              'Voucher Type',
                              style: TextStyle(
                                color: Primary_colors.Color1,
                                fontWeight: FontWeight.bold,
                                fontSize: Primary_font_size.Text7,
                              ),
                            ),
                          ),
                          const SizedBox(width: 3),
                          const Expanded(
                            flex: 3,
                            child: Text(
                              'Client',
                              style: TextStyle(
                                color: Primary_colors.Color1,
                                fontWeight: FontWeight.bold,
                                fontSize: Primary_font_size.Text7,
                              ),
                            ),
                          ),
                          const SizedBox(width: 3),
                          const SizedBox(width: 3),
                          const Expanded(
                            flex: 2,
                            child: Text(
                              'GSTIN',
                              style: TextStyle(
                                color: Primary_colors.Color1,
                                fontWeight: FontWeight.bold,
                                fontSize: Primary_font_size.Text7,
                              ),
                            ),
                          ),
                          const SizedBox(width: 3),
                          const Expanded(
                            flex: 2,
                            child: Text(
                              'Amount',
                              style: TextStyle(
                                color: Primary_colors.Color1,
                                fontWeight: FontWeight.bold,
                                fontSize: Primary_font_size.Text7,
                              ),
                            ),
                          ),
                          const SizedBox(width: 3),
                          const SizedBox(width: 125),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: Obx(
                      () => ListView.separated(
                        separatorBuilder: (context, index) => Container(
                          height: 1,
                          color: const Color.fromARGB(94, 125, 125, 125),
                        ),
                        itemCount: voucherController.voucherModel.filteredVouchers.length,
                        itemBuilder: (context, index) {
                          final voucher = voucherController.voucherModel.filteredVouchers[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Primary_colors.Light,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 30,
                                        child: Obx(
                                          () {
                                            // Ensure selectedItems has the correct length
                                            if (voucherController.voucherModel.selectedItems.length != voucherController.voucherModel.filteredVouchers.length) {
                                              voucherController.voucherModel.selectedItems.value = List<bool>.filled(voucherController.voucherModel.filteredVouchers.length, false);
                                            }

                                            return Checkbox(
                                              value: index < voucherController.voucherModel.selectedItems.length ? voucherController.voucherModel.selectedItems[index] : false,
                                              onChanged: (bool? value) {
                                                if (index < voucherController.voucherModel.selectedItems.length) {
                                                  voucherController.voucherModel.selectedItems[index] = value ?? false;
                                                  widget.updateDeleteButtonVisibility();
                                                }
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
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 3),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          formatDate(voucher.date),
                                          style: const TextStyle(
                                            color: Primary_colors.Color1,
                                            fontSize: Primary_font_size.Text7,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 3),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          voucher.voucherNumber,
                                          style: const TextStyle(
                                            color: Primary_colors.Color1,
                                            fontSize: Primary_font_size.Text7,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 3),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          voucher.invoiceNumber,
                                          style: const TextStyle(
                                            color: Primary_colors.Color1,
                                            fontSize: Primary_font_size.Text7,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 3),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          voucher.voucherType,
                                          style: const TextStyle(
                                            color: Primary_colors.Color1,
                                            fontSize: Primary_font_size.Text7,
                                          ),
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

                                              overlayEntry = OverlayEntry(
                                                builder: (_) => Positioned(
                                                  left: offset.dx - 80,
                                                  top: offset.dy - 320,
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
                                                              gradient: LinearGradient(
                                                                colors: [Colors.white, Colors.grey[50]!],
                                                                begin: Alignment.topCenter,
                                                                end: Alignment.bottomCenter,
                                                              ),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors.black.withOpacity(0.1),
                                                                  blurRadius: 20,
                                                                  spreadRadius: 2,
                                                                ),
                                                              ],
                                                            ),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    border: Border.all(
                                                                      color: Colors.blue.shade100,
                                                                      width: 2,
                                                                    ),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors.blue.withOpacity(0.2),
                                                                        blurRadius: 10,
                                                                        spreadRadius: 2,
                                                                      ),
                                                                    ],
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
                                                    style: const TextStyle(
                                                      color: Primary_colors.Color1,
                                                      fontSize: Primary_font_size.Text7,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 3),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          voucher.gstNumber,
                                          style: const TextStyle(
                                            color: Primary_colors.Color1,
                                            fontSize: Primary_font_size.Text7,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 3),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          voucher.totalAmount.toString(),
                                          style: const TextStyle(
                                            color: Primary_colors.Color1,
                                            fontSize: Primary_font_size.Text7,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 3),
                                      SizedBox(
                                        width: 125,
                                        child: ElevatedButton(
                                          onPressed: () => _showCloseVoucherPopup(index),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color.fromARGB(255, 107, 183, 109),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                          ),
                                          child: const Text(
                                            'Update Payment',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: Primary_font_size.Text6,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
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
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
      ),
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter Vouchers',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Primary_colors.Color3,
              ),
            ),
            const Divider(
              height: 30,
              thickness: 1,
              color: Color.fromARGB(255, 97, 97, 97),
            ),
            const SizedBox(height: 35),
            // Quick Date Filters
            const Text('Quick Date Filters', style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192))),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Obx(
                  () => _buildDateFilterChip('Show All'),
                ),
                Obx(() => _buildDateFilterChip('Last 1 hour  ')),
                Obx(() => _buildDateFilterChip('Last 24 hours')),
                Obx(() => _buildDateFilterChip('Last week')),
                Obx(() => _buildDateFilterChip('Last month')),
                Obx(() => _buildDateFilterChip('Custom range')),
              ],
            ),
            const SizedBox(height: 35),

            // Custom Date Range (visible when custom range is selected)
            Obx(() => voucherController.voucherModel.showCustomDateRange.value
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Custom Date Range', style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192))),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 35,
                              child: TextFormField(
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 154, 152, 152),
                                  fontSize: Primary_font_size.Text7,
                                ),
                                controller: voucherController.voucherModel.startDateController,
                                readOnly: true,
                                onTap: () => widget.selectDate(context, voucherController.voucherModel.startDateController),
                                decoration: InputDecoration(
                                  labelText: 'From',
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 154, 152, 152),
                                    fontSize: Primary_font_size.Text7,
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.calendar_today,
                                    size: 20,
                                    color: const Color.fromARGB(255, 85, 84, 84),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  disabledBorder: OutlineInputBorder(
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
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 154, 152, 152),
                                  fontSize: Primary_font_size.Text7,
                                ),
                                controller: voucherController.voucherModel.endDateController,
                                readOnly: true,
                                onTap: () => widget.selectDate(context, voucherController.voucherModel.endDateController),
                                decoration: InputDecoration(
                                  labelText: 'To',
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 154, 152, 152),
                                    fontSize: Primary_font_size.Text7,
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.calendar_today,
                                    size: 20,
                                    color: const Color.fromARGB(255, 85, 84, 84),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox()),
            Obx(() => SizedBox(height: voucherController.voucherModel.showCustomDateRange.value ? 35 : 0)),
            // Product Type Filter
            const Text('Invoice Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192))),
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
                    },
                    backgroundColor: Primary_colors.Dark,
                    selectedColor: Primary_colors.Dark,
                    labelStyle: TextStyle(
                      fontSize: Primary_font_size.Text7,
                      color: voucherController.voucherModel.selectedInvoiceType.value == 'Show All' ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: voucherController.voucherModel.selectedInvoiceType.value == 'Show All' ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84),
                      ),
                    ),
                  ),
                  FilterChip(
                    label: const Text('Sales'),
                    selected: voucherController.voucherModel.selectedInvoiceType.value == 'Sales',
                    onSelected: (_) {
                      voucherController.voucherModel.selectedInvoiceType.value = 'Sales';
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
                      side: BorderSide(
                        color: voucherController.voucherModel.selectedInvoiceType.value == 'Sales' ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84),
                      ),
                    ),
                  ),
                  FilterChip(
                    label: const Text('Subscription'),
                    selected: voucherController.voucherModel.selectedInvoiceType.value == 'Subscription',
                    onSelected: (_) {
                      voucherController.voucherModel.selectedInvoiceType.value = 'Subscription';
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
                      side: BorderSide(
                        color: voucherController.voucherModel.selectedInvoiceType.value == 'Subscription' ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),

            // Status Filter
            const Text('Payment Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192))),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 85, 84, 84)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonFormField<String>(
                value: voucherController.voucherModel.selectedpaymentStatus.value,
                items: ['Show All', 'Paid', 'Pending', 'Unpaid'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  voucherController.voucherModel.selectedpaymentStatus.value = value!;
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: Primary_font_size.Text7, color: const Color.fromARGB(255, 154, 152, 152)),
                dropdownColor: Primary_colors.Dark,
              ),
            ),

            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {
                    widget.resetFilters();
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Primary_colors.Color3),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'RESET',
                    style: TextStyle(color: Primary_colors.Color3),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
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

  // Widget _buildDateFilterChip(String label, VoidCallback onSelected) {
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
  Widget _buildDateFilterChip(
    String label,
  ) {
    final isSelected = voucherController.voucherModel.selectedQuickFilter.value == label;

    return ChoiceChip(
      label: Text(
        label == 'Show All' ? 'Show All   ' : label,
        style: TextStyle(color: isSelected ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
      ),
      selected: isSelected,
      onSelected: (_) {
        voucherController.voucherModel.selectedQuickFilter.value = label;
        if (label == 'Custom range') {
          voucherController.voucherModel.showCustomDateRange.value = true;
        }
      },
      backgroundColor: Primary_colors.Dark,
      selectedColor: Primary_colors.Dark,
      labelStyle: TextStyle(
        color: isSelected ? Primary_colors.Color3 : Colors.black,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isSelected ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84),
        ),
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
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 117, 66, 245),
              Color.fromARGB(255, 33, 94, 248),
              Color.fromARGB(255, 100, 42, 247),
            ],
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
                        style: TextStyle(
                          color: Primary_colors.Color1,
                          fontSize: Primary_font_size.Text15,
                        ),
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
                                    style: const TextStyle(
                                      fontSize: Primary_font_size.Text7,
                                      color: Primary_colors.Color1,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(1),
                                      filled: true,
                                      fillColor: const Color.fromARGB(37, 255, 255, 255),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(color: Colors.transparent),
                                      ),
                                      hintStyle: const TextStyle(
                                        fontSize: Primary_font_size.Text7,
                                        color: Primary_colors.Color1,
                                      ),
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
                                    controller: voucherController.voucherModel.dateController,
                                    readOnly: true,
                                    onTap: () => selectDate(context, voucherController.voucherModel.dateController),
                                    style: const TextStyle(
                                      fontSize: Primary_font_size.Text7,
                                      color: Primary_colors.Color1,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(1),
                                      filled: true,
                                      fillColor: const Color.fromARGB(37, 255, 255, 255),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(color: Colors.transparent),
                                      ),
                                      hintStyle: const TextStyle(
                                        fontSize: Primary_font_size.Text7,
                                        color: Primary_colors.Color1,
                                      ),
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
                                    style: const TextStyle(
                                      fontSize: Primary_font_size.Text7,
                                      color: Primary_colors.Color1,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(1),
                                      filled: true,
                                      fillColor: const Color.fromARGB(37, 255, 255, 255),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(color: Colors.transparent),
                                      ),
                                      hintStyle: const TextStyle(
                                        fontSize: Primary_font_size.Text7,
                                        color: Primary_colors.Color1,
                                      ),
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
                                    style: const TextStyle(
                                      fontSize: Primary_font_size.Text7,
                                      color: Primary_colors.Color1,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(1),
                                      filled: true,
                                      fillColor: const Color.fromARGB(37, 255, 255, 255),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(color: Colors.transparent),
                                      ),
                                      hintStyle: const TextStyle(
                                        fontSize: Primary_font_size.Text7,
                                        color: Primary_colors.Color1,
                                      ),
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
                                    style: const TextStyle(
                                      fontSize: Primary_font_size.Text7,
                                      color: Primary_colors.Color1,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(1),
                                      filled: true,
                                      fillColor: const Color.fromARGB(37, 255, 255, 255),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(color: Colors.transparent),
                                      ),
                                      hintStyle: const TextStyle(
                                        fontSize: Primary_font_size.Text7,
                                        color: Primary_colors.Color1,
                                      ),
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
                                          style: const TextStyle(
                                            fontSize: Primary_font_size.Text7,
                                            color: Primary_colors.Color1,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.all(1),
                                            filled: true,
                                            fillColor: const Color.fromARGB(37, 255, 255, 255),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: const BorderSide(color: Colors.transparent),
                                            ),
                                            hintStyle: const TextStyle(
                                              fontSize: Primary_font_size.Text7,
                                              color: Primary_colors.Color1,
                                            ),
                                            hintText: 'Net',
                                            border: const OutlineInputBorder(),
                                            prefixIcon: const Icon(Icons.calculate, color: Primary_colors.Color1),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: TextFormField(
                                          style: const TextStyle(
                                            fontSize: Primary_font_size.Text7,
                                            color: Primary_colors.Color1,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.all(1),
                                            filled: true,
                                            fillColor: const Color.fromARGB(37, 255, 255, 255),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: const BorderSide(color: Colors.transparent),
                                            ),
                                            hintStyle: const TextStyle(
                                              fontSize: Primary_font_size.Text7,
                                              color: Primary_colors.Color1,
                                            ),
                                            hintText: 'GST',
                                            border: const OutlineInputBorder(),
                                            prefixIcon: const Icon(Icons.percent, color: Primary_colors.Color1),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: TextFormField(
                                          style: const TextStyle(
                                            fontSize: Primary_font_size.Text7,
                                            color: Primary_colors.Color1,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.all(1),
                                            filled: true,
                                            fillColor: const Color.fromARGB(37, 255, 255, 255),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: const BorderSide(color: Colors.transparent),
                                            ),
                                            hintStyle: const TextStyle(
                                              fontSize: Primary_font_size.Text7,
                                              color: Primary_colors.Color1,
                                            ),
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
                                  style: TextStyle(
                                    fontSize: Primary_font_size.Text10,
                                    fontWeight: FontWeight.bold,
                                    color: Primary_colors.Color1,
                                  ),
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
                                                              ? Image.file(
                                                                  voucherController.voucherModel.selectedFile.value!,
                                                                  fit: BoxFit.cover,
                                                                )
                                                              : const Center(
                                                                  child: Text(
                                                                    'File type not supported',
                                                                    style: TextStyle(color: Colors.white),
                                                                  ),
                                                                ),
                                                )
                                              : const Center(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.cloud_upload_outlined,
                                                        size: 100,
                                                        color: Color.fromARGB(255, 184, 184, 184),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        'Click here to pick file',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Color.fromARGB(255, 182, 181, 181),
                                                        ),
                                                      ),
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
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 180, 179, 179),
                                  ),
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
                            decoration: BoxDecoration(
                              color: Primary_colors.Color1,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                'Close',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: Primary_font_size.Text10,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 50),
                          Container(
                            width: 120,
                            height: 35,
                            decoration: BoxDecoration(
                              color: Primary_colors.Color1,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: Primary_font_size.Text7,
                                ),
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
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 207, 207, 207),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '1. Purpose: A sales voucher records details of sales transactions.',
                        style: TextStyle(color: Color.fromARGB(255, 169, 168, 168)),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '2. Date: Represents the date of the transaction; ensure accuracy.',
                        style: TextStyle(color: Color.fromARGB(255, 169, 168, 168)),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '3. Reference Number: Unique identifier for tracking and auditing.',
                        style: TextStyle(color: Color.fromARGB(255, 169, 168, 168)),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '4. Particulars: Describes items, product, or services sold.',
                        style: TextStyle(color: Color.fromARGB(255, 169, 168, 168)),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '5. Notes Section: Includes additional remarks or instructions.',
                        style: TextStyle(color: Color.fromARGB(255, 169, 168, 168)),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '6. Total Amount: Gross amount before deductions or taxes.',
                        style: TextStyle(color: Color.fromARGB(255, 169, 168, 168)),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '7. Net Amount: Final amount after deductions or discounts.',
                        style: TextStyle(color: Color.fromARGB(255, 169, 168, 168)),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '8. GST: Tax amount based on the transaction value; ensure accuracy.',
                        style: TextStyle(color: Color.fromARGB(255, 169, 168, 168)),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '9. Accuracy: Verify all details before finalizing the voucher.',
                        style: TextStyle(color: Color.fromARGB(255, 169, 168, 168)),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '10. Retention: Maintain sales vouchers securely for records and audits.',
                        style: TextStyle(color: Color.fromARGB(255, 169, 168, 168)),
                      ),
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

class ClientInfoIcon extends StatefulWidget {
  final String clientName;
  final String clientDetails; // Add more detail to show in pop-up

  const ClientInfoIcon({
    super.key,
    required this.clientName,
    required this.clientDetails,
  });

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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.clientDetails,
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
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
            style: const TextStyle(
              color: Primary_colors.Color1,
              fontSize: Primary_font_size.Text7,
            ),
          ),
        ],
      ),
    );
  }
}
