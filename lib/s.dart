void _showCloseVoucherPopup(int index) {
  final TextEditingController _closedDateController = TextEditingController(
    text: DateFormat('yyyy-MM-dd').format(DateTime.now()),
  );
  final TextEditingController _referenceIdController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

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
                    padding: const EdgeInsets.all(16),
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
                          child: const Icon(Icons.receipt_long, color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'VOUCHER CLOSURE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
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
                                  "Anaamalis agencies have exceeded the transaction of 1 Lakh, so this invoice is TDS Deductable!",
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              voucherController.voucherModel.voucher_list[index].clientName,
                                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "Client ID: ${voucherController.voucherModel.voucher_list[index].customerId}",
                                              style: const TextStyle(color: Colors.grey, fontSize: 11),
                                            ),
                                          ],
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
                                width: 1,
                                color: Colors.grey[300],
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
                                        Row(
                                          children: [
                                            Text(
                                              voucherController.voucherModel.voucher_list[index].invoiceNumber,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            IconButton(
                                              icon: const Icon(Icons.copy, color: Colors.grey, size: 18),
                                              onPressed: () {
                                                Clipboard.setData(ClipboardData(text: voucherController.voucherModel.voucher_list[index].invoiceNumber));
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text("Invoice number copied"),
                                                    duration: Duration(seconds: 1),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    _amountRow("Invoice Amount:", "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucherController.voucherModel.voucher_list[index].totalAmount)}"),
                                    const SizedBox(height: 12),
                                    _amountRow("Receivable Amount:", "₹${NumberFormat.currency(locale: 'en_IN', symbol: '').format(voucherController.voucherModel.voucher_list[index].totalAmount)}"),
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
                                      controller: _closedDateController,
                                      label: 'Closed Date',
                                      hint: 'Select closed date',
                                      icon: Icons.calendar_today,
                                      onTap: () => widget.selectDate(context, _closedDateController),
                                    ),
                                    const SizedBox(height: 16),
                                    _buildEditableField(
                                      controller: _amountController,
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
                                      controller: _referenceIdController,
                                      label: 'Transaction Reference',
                                      hint: 'Enter transaction ID/bank reference',
                                      icon: Icons.credit_card,
                                    ),
                                    const SizedBox(height: 16),
                                    _buildEditableField(
                                      controller: _feedbackController,
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
                                        height: 125,
                                        child: GestureDetector(
                                          onTap: widget.pickFile,
                                          child: DashedRect(
                                            color: Primary_colors.Color3.withOpacity(0.5),
                                            strokeWidth: 1.5,
                                            gap: 3.0,
                                            child: Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(15),
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
                              onPressed: () {
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
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(
            icon,
            color: Primary_colors.Color3,
            size: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Primary_colors.Color3, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
        style: const TextStyle(
          fontSize: 14,
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
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
      const SizedBox(height: 6),
      DropdownButtonFormField<String>(
        dropdownColor: Primary_colors.Dark,
        decoration: InputDecoration(
          filled: true,
          fillColor: Primary_colors.Light,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(
            icon,
            color: Primary_colors.Color3,
            size: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.transparent),
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
              style: TextStyle(color: Colors.white),
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

Widget _amountRow(String label, String value) {
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
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.green,
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
      return MouseRegion(
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
              Text(
                "12.05.2025 - ₹1,05,000",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Primary_colors.Color3,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.info_outline,
                color: Primary_colors.Color3,
                size: 14,
              ),
            ],
          ),
        ),
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
