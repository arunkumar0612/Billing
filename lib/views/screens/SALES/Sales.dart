import 'package:animations/animations.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/ClientReq_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/DC_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/Debit_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/Invoice_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/Quote_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/RFQ_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/Credit_actions.dart';
import 'package:ssipl_billing/services/SALES/sales_service.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ssipl_billing/views/components/Basic_DialogBox.dart';
import 'package:ssipl_billing/views/screens/SALES/Sales_chart.dart';
import 'package:ssipl_billing/views/screens/SALES/pdfpopup.dart';
import '../../../controllers/SALEScontrollers/Sales_actions.dart';
// import 'package:cool_dropdown/models/cool_dropdown_item.dart';

class Sales_Client extends StatefulWidget with SalesServices, Pdfpopup {
  Sales_Client({super.key});

  @override
  _Sales_ClientState createState() => _Sales_ClientState();
}

// enum Menu { preview, share, getLink, remove, download }

class _Sales_ClientState extends State<Sales_Client> {
  final SalesController salesController = Get.find<SalesController>();
  final ClientreqController clientreqController = Get.find<ClientreqController>();
  final DcController dcController = Get.find<DcController>();
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  final QuoteController quoteController = Get.find<QuoteController>();
  final RFQController rfqController = Get.find<RFQController>();
  final CreditController creditController = Get.find<CreditController>();
  final DebitController debitController = Get.find<DebitController>();
  @override
  void dispose() {
    clientreqController.clientReqModel.cntMulti.value.dispose();
    super.dispose();
  }

  // AnimationStyle? _animationStyle;
  @override
  void initState() {
    super.initState();
    clientreqController.clientReqModel.cntMulti.value = MultiValueDropDownController();
    // widget.GetCustomerList(context);
    clientreqController.clientReqModel.cntMulti.value = MultiValueDropDownController();
    salesController.updateshowcustomerprocess(null);
    salesController.updatecustomerId(0);
    widget.GetProcesscustomerList(context);
    widget.GetProcessList(context, 0);
    widget.GetSalesData(context, salesController.salesModel.salesperiod.value);
  }

// CircleAvatar(child: Text(item['name']![0])),
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Primary_colors.Dark,
        body: Center(
          child: SizedBox(
            // width: 1500,
            child: Column(
              children: [
                // const SizedBox(height: 185, child: cardview()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Primary_colors.Color3, Primary_colors.Color4], // Example gradient
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: const Icon(
                            Icons.trending_up,
                            size: 25.0,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Sales',
                          style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text13),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.refresh(context);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(0),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/reload.png',
                                fit: BoxFit.cover, // Ensures the image covers the container
                                width: 30, // Makes the image fill the container's width
                                height: 30, // Makes the image fill the container's height
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 400,
                          height: 40,
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              TextFormField(
                                onChanged: salesController.search,
                                style: const TextStyle(fontSize: 13, color: Colors.white),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  filled: true,
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(226, 89, 147, 255),
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 104, 93, 255),
                                    ),
                                  ),
                                  hintText: "", // Hide default hintText
                                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Color.fromARGB(255, 151, 151, 151),
                                  ),
                                ),
                              ),
                              if (salesController.salesModel.searchQuery.isEmpty)
                                Positioned(
                                  left: 40, // Adjust positioning as needed
                                  child: IgnorePointer(
                                    child: AnimatedTextKit(
                                      repeatForever: true,
                                      animatedTexts: [
                                        TypewriterAnimatedText(
                                          "Search from the list...",
                                          textStyle: const TextStyle(
                                            fontSize: 13,
                                            color: Color.fromARGB(255, 185, 183, 183),
                                            letterSpacing: 1,
                                          ),
                                          speed: const Duration(milliseconds: 100),
                                        ),
                                        TypewriterAnimatedText(
                                          "Enter customer name...",
                                          textStyle: const TextStyle(
                                            fontSize: 13,
                                            color: Color.fromARGB(255, 185, 183, 183),
                                            letterSpacing: 1,
                                          ),
                                          speed: const Duration(milliseconds: 100),
                                        ),
                                        TypewriterAnimatedText(
                                          "Find an invoice...",
                                          textStyle: const TextStyle(
                                            fontSize: 13,
                                            color: Color.fromARGB(255, 185, 183, 183),
                                            letterSpacing: 1,
                                          ),
                                          speed: const Duration(milliseconds: 100),
                                        ),
                                        TypewriterAnimatedText(
                                          "Find an Quotation...",
                                          textStyle: const TextStyle(
                                            fontSize: 13,
                                            color: Color.fromARGB(255, 185, 183, 183),
                                            letterSpacing: 1,
                                          ),
                                          speed: const Duration(milliseconds: 100),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 235,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 10,
                                color: Primary_colors.Light,
                                // decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Primary_colors.Light),
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 15),
                                            child: Text(
                                              'SALES DATA',
                                              style: TextStyle(letterSpacing: 1, wordSpacing: 3, color: Primary_colors.Color3, fontSize: Primary_font_size.Text10, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 10),
                                            child: SizedBox(
                                              width: 200,
                                              height: 35,
                                              child: DropdownButtonFormField<String>(
                                                value: salesController.salesModel.salesperiod.value == 'monthly' ? "Monthly view" : "Yearly view", // Use the state variable for the selected value
                                                items: [
                                                  "Monthly view",
                                                  "Yearly view",
                                                ]
                                                    .map((String value) => DropdownMenuItem<String>(
                                                          value: value,
                                                          child: Text(value, style: const TextStyle(fontSize: 13, color: Colors.white)),
                                                        ))
                                                    .toList(),
                                                onChanged: (String? newValue) {
                                                  if (newValue != null) {
                                                    salesController.updatesalesperiod(newValue == "Monthly view" ? 'monthly' : 'yearly');

                                                    if (newValue == "Monthly view") {
                                                      widget.GetSalesData(context, 'monthly');
                                                    } else if (newValue == "Yearly view") {
                                                      widget.GetSalesData(context, 'yearly');
                                                    }
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  alignLabelWithHint: false,
                                                  contentPadding: const EdgeInsets.all(10),
                                                  filled: true,
                                                  fillColor: Primary_colors.Dark,
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(30),
                                                    borderSide: const BorderSide(color: Color.fromARGB(226, 50, 50, 50)),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(30),
                                                    borderSide: const BorderSide(color: Color.fromARGB(255, 51, 50, 50)),
                                                  ),
                                                  hintText: 'Data View',
                                                  hintStyle: const TextStyle(
                                                    fontSize: Primary_font_size.Text7,
                                                    color: Primary_colors.Color1,
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                                dropdownColor: Primary_colors.Dark,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            // gradient: const LinearGradient(
                                            //   colors: [Primary_colors.Light, Color.fromARGB(255, 40, 39, 59), Primary_colors.Light],
                                            //   begin: Alignment.topLeft,
                                            //   end: Alignment.bottomRight,
                                            // ),
                                            // boxShadow: const [
                                            //   BoxShadow(
                                            //     color: Colors.black12,
                                            //     offset: Offset(0, 10),
                                            //     blurRadius: 20,
                                            //   ),
                                            // ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      const Text(
                                                        'TOTAL',
                                                        style: TextStyle(
                                                          color: Color.fromARGB(255, 186, 185, 185),
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        widget.formatNumber(int.tryParse(salesController.salesModel.salesdata.value?.totalamount ?? "0") ?? 0),
                                                        style: const TextStyle(
                                                          color: Primary_colors.Color1,
                                                          fontSize: 28,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: const Color.fromARGB(255, 202, 227, 253),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(4),
                                                          child: Text(
                                                            // '210 invoices',

                                                            "${salesController.salesModel.salesdata.value?.totalinvoices.toString() ?? "0"} ${((salesController.salesModel.salesdata.value?.totalinvoices ?? 0) < 2) ? 'invoice' : 'invoices'}",
                                                            style: const TextStyle(
                                                                fontSize: Primary_font_size.Text5, color: Color.fromARGB(255, 1, 53, 92), letterSpacing: 1, fontWeight: FontWeight.bold),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      'RECEIVED',
                                                      style: TextStyle(
                                                        color: Color.fromARGB(255, 186, 185, 185),
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    Text(
                                                      // "₹ 18,6232",
                                                      widget.formatNumber(int.tryParse(salesController.salesModel.salesdata.value?.paidamount ?? "0") ?? 0),

                                                      style: const TextStyle(
                                                        color: Primary_colors.Color1,
                                                        fontSize: 28,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: const Color.fromARGB(255, 202, 253, 223),
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(4),
                                                        child: Text(
                                                          // '210 invoices',
                                                          "${salesController.salesModel.salesdata.value?.paidinvoices.toString() ?? "0"} ${((salesController.salesModel.salesdata.value?.paidinvoices ?? 0) < 2) ? 'invoice' : 'invoices'}",
                                                          style:
                                                              const TextStyle(fontSize: Primary_font_size.Text5, color: Color.fromARGB(255, 2, 87, 4), letterSpacing: 1, fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 10),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      const Text(
                                                        'PENDING',
                                                        style: TextStyle(
                                                          color: Color.fromARGB(255, 186, 185, 185),
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        // "₹ 6,232",
                                                        widget.formatNumber(int.tryParse(salesController.salesModel.salesdata.value?.unpaidamount ?? "0") ?? 0),

                                                        style: const TextStyle(
                                                          color: Primary_colors.Color1,
                                                          fontSize: 28,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: const Color.fromARGB(255, 253, 206, 202),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(4),
                                                          child: Text(
                                                            // '110 invoices',
                                                            "${salesController.salesModel.salesdata.value?.unpaidinvoices.toString() ?? "0"} ${((salesController.salesModel.salesdata.value?.unpaidinvoices ?? 0) < 2) ? 'invoice' : 'invoices'}",
                                                            style: const TextStyle(
                                                                fontSize: Primary_font_size.Text5, color: Color.fromARGB(255, 118, 9, 1), fontWeight: FontWeight.bold, letterSpacing: 1),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 10,
                                color: Primary_colors.Light,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // First row of icons and labels

                                      Row(
                                        children: [
                                          Expanded(
                                            child: _buildIconWithLabel(
                                              image: 'assets/images/addcustomer.png',
                                              label: 'Add Customer',
                                              color: Primary_colors.Color4,
                                              onPressed: () {
                                                widget.Generate_client_reqirement_dialougebox('Customer', context);
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: _buildIconWithLabel(
                                                image: 'assets/images/addenquiry.png',
                                                label: 'Add Enquiry',
                                                color: Primary_colors.Color5,
                                                onPressed: () {
                                                  widget.Generate_client_reqirement_dialougebox('Enquiry', context);
                                                }),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      // Second row of icons and labels
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Obx(
                                              () => AnimatedSwitcher(
                                                duration: const Duration(milliseconds: 300), // Animation duration
                                                transitionBuilder: (Widget child, Animation<double> animation) {
                                                  return FadeTransition(
                                                    opacity: animation,
                                                    child: SlideTransition(
                                                      position: animation.drive(
                                                        Tween<Offset>(
                                                          begin: const Offset(1.0, 0.0), // Slide in from right
                                                          end: Offset.zero,
                                                        ).chain(CurveTween(curve: Curves.easeInOut)),
                                                      ),
                                                      child: child,
                                                    ),
                                                  );
                                                },
                                                child: _buildIconWithLabel(
                                                  // key: ValueKey(salesController.salesModel.type.value), // Ensures re-build
                                                  image: salesController.salesModel.type.value == 0 ? 'assets/images/viewarchivelist.png' : 'assets/images/mainlist.png',
                                                  label: salesController.salesModel.type.value == 0 ? 'Archive List' : 'Main List',
                                                  color: Primary_colors.Color8,
                                                  onPressed: () {
                                                    salesController.salesModel.selectedIndices.clear();
                                                    salesController.updatetype(salesController.salesModel.type.value == 0 ? 1 : 0);
                                                    widget.GetProcessList(context, salesController.salesModel.customerId.value!);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: _buildIconWithLabel(
                                              image: 'assets/images/settings.png',
                                              label: 'Settings',
                                              color: Primary_colors.Dark,
                                              onPressed: () {
                                                widget.pdfpopup_controller.initializeTextControllers();
                                                widget.pdfpopup_controller.initializeCheckboxes();
                                                widget.showA4StyledPopup(context);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Reusable function to build icon with label for consistency
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            children: [
                              Expanded(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 10,
                                  color: Primary_colors.Light,
                                  child: const Padding(padding: EdgeInsets.all(16), child: SalesChart()),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Primary_colors.Light),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const SizedBox(height: 5),
                              SizedBox(
                                height: 25,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        salesController.salesModel.type.value == 0 ? 'ACTIVE PROCESS LIST' : "ARCHIVED PROCESS LIST",
                                        style: TextStyle(
                                            letterSpacing: 1,
                                            wordSpacing: 3,
                                            color: salesController.salesModel.type.value == 0 ? Primary_colors.Color3 : const Color.fromARGB(255, 254, 113, 113),
                                            fontSize: Primary_font_size.Text10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        if (salesController.salesModel.selectedIndices.isNotEmpty)
                                          PopupMenuButton<String>(
                                            splashRadius: 20,
                                            padding: const EdgeInsets.all(0),
                                            icon: const Icon(Icons.menu),
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                              // side: const BorderSide(color: Primary_colors.Color3, width: 2),
                                            ),
                                            color: Colors.white,
                                            elevation: 6,
                                            offset: const Offset(-10, 30),
                                            onSelected: (String item) {
                                              // Handle menu item selection

                                              switch (item) {
                                                case 'Archive':
                                                  Basic_dialog(
                                                    context: context,
                                                    title: 'Confirmation',
                                                    content: 'Are you sure you want to Archive this process?',
                                                    showCancel: true,
                                                    onOk: () {
                                                      widget.ArchiveProcesscontrol(
                                                        context,
                                                        salesController.salesModel.selectedIndices.map((index) => salesController.salesModel.processList[index].processid).toList(),
                                                        1, // 1 for Archive, 0 for Unarchive
                                                      );
                                                    },
                                                  );
                                                  break;
                                                case 'Unarchive':
                                                  Basic_dialog(
                                                    context: context,
                                                    title: 'Confirmation',
                                                    content: 'Are you sure you want to Unarchive this process?',
                                                    showCancel: true,
                                                    onOk: () {
                                                      widget.ArchiveProcesscontrol(
                                                        context,
                                                        salesController.salesModel.selectedIndices.map((index) => salesController.salesModel.processList[index].processid).toList(),
                                                        0, // 1 for Archive, 0 for Unarchive
                                                      );
                                                    },
                                                  );
                                                  break;
                                                case 'Modify':
                                                  Basic_dialog(
                                                    context: context,
                                                    title: 'Error',
                                                    content: 'Unable to modify the process',
                                                    showCancel: true,
                                                  );
                                                  break;
                                                case 'Delete':
                                                  Basic_dialog(
                                                    context: context,
                                                    title: 'Confirmation',
                                                    content: 'Are you sure you want to delete this process?',
                                                    showCancel: true,
                                                    onOk: () {
                                                      widget.DeleteProcess(
                                                        context,
                                                        salesController.salesModel.selectedIndices.map((index) => salesController.salesModel.processList[index].processid).toList(),
                                                      );
                                                    },
                                                  );
                                                  break;
                                              }
                                            },
                                            itemBuilder: (BuildContext context) {
                                              // Determine the label for the archive/unarchive action

                                              return [
                                                PopupMenuItem<String>(
                                                  value: salesController.salesModel.type.value != 0 ? 'Unarchive' : 'Archive',
                                                  child: ListTile(
                                                    leading: Icon(
                                                      salesController.salesModel.type.value != 0 ? Icons.unarchive_outlined : Icons.archive_outlined,
                                                      color: Colors.blueAccent,
                                                    ),
                                                    title: Text(
                                                      salesController.salesModel.type.value != 0 ? 'Unarchive' : 'Archive',
                                                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: Primary_font_size.Text10),
                                                    ),
                                                  ),
                                                ),
                                                const PopupMenuItem<String>(
                                                  value: 'Modify',
                                                  child: ListTile(
                                                    leading: Icon(Icons.edit_outlined, color: Colors.green),
                                                    title: Text('Modify', style: TextStyle(fontWeight: FontWeight.w500, fontSize: Primary_font_size.Text10)),
                                                  ),
                                                ),
                                                const PopupMenuItem<String>(
                                                  value: 'Delete',
                                                  child: ListTile(
                                                    leading: Icon(Icons.delete_outline, color: Colors.redAccent),
                                                    title: Text('Delete', style: TextStyle(fontWeight: FontWeight.w500, fontSize: Primary_font_size.Text10)),
                                                  ),
                                                ),
                                              ];
                                            },
                                          ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Primary_colors.Color3, Primary_colors.Color3], // Example gradient colors
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(15), // Ensure border radius for smooth corners
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 47),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: salesController.salesModel.isAllSelected.value,
                                        onChanged: (bool? value) {
                                          salesController.salesModel.isAllSelected.value = value ?? false;
                                          if (salesController.salesModel.isAllSelected.value) {
                                            salesController.updateselectedIndices(List.generate(salesController.salesModel.processList.length, (index) => index));
                                          } else {
                                            salesController.salesModel.selectedIndices.clear();
                                          }
                                        },
                                        activeColor: Colors.white, // More vibrant color
                                        checkColor: Primary_colors.Color3, // White checkmark for contrast
                                        side: const BorderSide(color: Primary_colors.Color1, width: 2), // Styled border
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4), // Soft rounded corners
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      const Expanded(
                                        flex: 4,
                                        child: Text(
                                          'Process ID',
                                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                                        ),
                                      ),
                                      const Expanded(
                                        flex: 15,
                                        child: Text(
                                          'Process Title',
                                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                                        ),
                                      ),
                                      const Expanded(
                                        flex: 4,
                                        child: Text(
                                          'Date',
                                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                                        ),
                                      ),
                                      const Expanded(
                                        flex: 4,
                                        child: Text(
                                          'Days',
                                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                // child: Container(),
                                child: ListView.builder(
                                  itemCount: salesController.salesModel.processList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Primary_colors.Dark,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: ExpansionTile(
                                            collapsedIconColor: const Color.fromARGB(255, 135, 132, 132),
                                            iconColor: Colors.red,
                                            collapsedBackgroundColor: Primary_colors.Dark,
                                            backgroundColor: Primary_colors.Dark,
                                            title: Obx(
                                              () => Row(
                                                children: [
                                                  Checkbox(
                                                    value: salesController.salesModel.selectedIndices.contains(index),
                                                    onChanged: (bool? value) {
                                                      if (value == true) {
                                                        salesController.salesModel.selectedIndices.add(index);
                                                      } else {
                                                        salesController.salesModel.selectedIndices.remove(index);
                                                        salesController.updateisAllSelected(salesController.salesModel.selectedIndices.length == salesController.salesModel.processList.length);
                                                      }
                                                    },
                                                    activeColor: Primary_colors.Color3, // More vibrant color
                                                    checkColor: Colors.white, // White checkmark for contrast
                                                    side: const BorderSide(color: Primary_colors.Color3, width: 2), // Styled border
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(4), // Soft rounded corners
                                                    ),
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Tooltip(
                                                      message: salesController.salesModel.processList[index].customer_name, // Show client name
                                                      textStyle: const TextStyle(color: Colors.white, fontSize: Primary_font_size.Text6),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black87,
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                      child: Text(
                                                        salesController.salesModel.processList[index].processid.toString(),
                                                        style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 15,
                                                    child: Text(
                                                      salesController.salesModel.processList[index].title,
                                                      // items[showcustomerprocess]['name'],
                                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      flex: 4,
                                                      child: Text(
                                                        DateFormat("dd MMM yyyy").format(DateTime.parse(salesController.salesModel.processList[index].Process_date)),
                                                        style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                      )),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text(
                                                      salesController.salesModel.processList[index].age_in_days.toString(),
                                                      // items[showcustomerprocess]['process'][index]['daycounts'],
                                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            children: [
                                              SizedBox(
                                                height: ((salesController.salesModel.processList[index].TimelineEvents.length * 80) + 20).toDouble(),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: ListView.builder(
                                                    itemCount: salesController.salesModel.processList[index].TimelineEvents.length, // +1 for "Add Event" button
                                                    itemBuilder: (context, childIndex) {
                                                      final Rx<Color> textColor = const Color.fromARGB(255, 199, 198, 198).obs;
                                                      return Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              GestureDetector(
                                                                child: Container(
                                                                  height: 40,
                                                                  width: 40,
                                                                  padding: const EdgeInsets.all(8),
                                                                  decoration: const BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    color: Color.fromARGB(107, 199, 202, 249),
                                                                  ),
                                                                  // child: const Icon(
                                                                  //   Icons.event,
                                                                  //   color: Colors.white,
                                                                  // ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      (childIndex + 1).toString(),
                                                                      // (salesController.salesModel.processList[index].TimelineEvents.length - 1 - childIndex + 1).toString(),
                                                                      style: const TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ),
                                                                onTap: () async {
                                                                  bool success = await widget.GetPDFfile(context, salesController.salesModel.processList[index].TimelineEvents[childIndex].Eventid);
                                                                  if (success) widget.showPDF(context);
                                                                },
                                                              ),
                                                              if (childIndex != salesController.salesModel.processList[index].TimelineEvents.length - 1)
                                                                Container(
                                                                  width: 2,
                                                                  height: 40,
                                                                  color: const Color.fromARGB(107, 199, 202, 249),
                                                                ),
                                                            ],
                                                          ),
                                                          Expanded(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(top: 2.0, left: 10),
                                                                        child: Row(
                                                                          children: [
                                                                            Text(
                                                                              salesController.salesModel.processList[index].TimelineEvents[childIndex].Eventname,
                                                                              // items[showcustomerprocess]['process'][index]['child'][childIndex]["name"],
                                                                              style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                                                            ),
                                                                            if (salesController.salesModel.processList[index].TimelineEvents[childIndex].apporvedstatus == 1)
                                                                              Image.asset(
                                                                                'assets/images/verified.png',
                                                                                // fit: BoxFit.cover, // Ensures the image covers the container
                                                                                width: 20, // Makes the image fill the container's width
                                                                                height: 20, // Makes the image fill the container's height
                                                                              ),
                                                                            if (salesController.salesModel.processList[index].TimelineEvents[childIndex].apporvedstatus == 2)
                                                                              Image.asset(
                                                                                'assets/images/pending.png',
                                                                                // fit: BoxFit.cover, // Ensures the image covers the container
                                                                                width: 20, // Makes the image fill the container's width
                                                                                height: 20, // Makes the image fill the container's height
                                                                              ),
                                                                            if (salesController.salesModel.processList[index].TimelineEvents[childIndex].apporvedstatus == 3)
                                                                              Image.asset(
                                                                                'assets/images/reject.png',
                                                                                // fit: BoxFit.cover, // Ensures the image covers the container
                                                                                width: 20, // Makes the image fill the container's width
                                                                                height: 20, // Makes the image fill the container's height
                                                                              ),
                                                                            if (salesController.salesModel.processList[index].TimelineEvents[childIndex].Allowed_process.get_approval == true)
                                                                              const SizedBox(width: 5),
                                                                            if (salesController.salesModel.processList[index].TimelineEvents[childIndex].Allowed_process.get_approval == true)
                                                                              Container(
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color.fromARGB(255, 2, 128, 231)),
                                                                                child: GestureDetector(
                                                                                  child: const Padding(
                                                                                    padding: EdgeInsets.only(left: 4, right: 4),
                                                                                    child: Text(
                                                                                      'Get Approval',
                                                                                      style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text5),
                                                                                    ),
                                                                                  ),
                                                                                  onTap: () {
                                                                                    widget.GetApproval(context, salesController.salesModel.customerId.value!,
                                                                                        salesController.salesModel.processList[index].TimelineEvents[childIndex].Eventid);
                                                                                  },
                                                                                ),
                                                                              ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        children: [
                                                                          if (salesController.salesModel.processList[index].TimelineEvents[childIndex].Allowed_process.quotation == true)
                                                                            TextButton(
                                                                              onPressed: () async {
                                                                                bool success =
                                                                                    await widget.GetPDFfile(context, salesController.salesModel.processList[index].TimelineEvents[childIndex].Eventid);

                                                                                if (success) {
                                                                                  widget.GenerateQuote_dialougebox(
                                                                                      context, "quotation", salesController.salesModel.processList[index].TimelineEvents[childIndex].Eventid);
                                                                                  quoteController.setProcessID(salesController.salesModel.processList[index].processid);
                                                                                }
                                                                              },
                                                                              child: const Text(
                                                                                "Quotation",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                          if (salesController.salesModel.processList[index].TimelineEvents[childIndex].Allowed_process.revised_quatation == true)
                                                                            TextButton(
                                                                              onPressed: () async {
                                                                                bool success =
                                                                                    await widget.GetPDFfile(context, salesController.salesModel.processList[index].TimelineEvents[childIndex].Eventid);

                                                                                if (success) {
                                                                                  widget.GenerateQuote_dialougebox(
                                                                                      context, "revisedquotation", salesController.salesModel.processList[index].TimelineEvents[childIndex].Eventid);
                                                                                  quoteController.setProcessID(salesController.salesModel.processList[index].processid);
                                                                                }
                                                                              },
                                                                              child: const Text(
                                                                                "RevisedQuotation",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                          if (salesController.salesModel.processList[index].TimelineEvents[childIndex].Allowed_process.rfq == true)
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                widget.GenerateRFQ_dialougebox(context);
                                                                              },
                                                                              child: const Text(
                                                                                "Generate RFQ",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                          if (salesController.salesModel.processList[index].TimelineEvents[childIndex].Allowed_process.invoice == true)
                                                                            TextButton(
                                                                              onPressed: () async {
                                                                                bool success =
                                                                                    await widget.GetPDFfile(context, salesController.salesModel.processList[index].TimelineEvents[childIndex].Eventid);
                                                                                if (success) {
                                                                                  widget.GenerateInvoice_dialougebox(
                                                                                      context, salesController.salesModel.processList[index].TimelineEvents[childIndex].Eventid);
                                                                                  invoiceController.setProcessID(salesController.salesModel.processList[index].processid);
                                                                                  if (kDebugMode) {
                                                                                    print(invoiceController.invoiceModel.processID);
                                                                                  }
                                                                                }
                                                                              },
                                                                              child: const Text(
                                                                                "Invoice",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                          if (salesController.salesModel.processList[index].TimelineEvents[childIndex].Allowed_process.delivery_challan == true)
                                                                            TextButton(
                                                                              onPressed: () async {
                                                                                bool success =
                                                                                    await widget.GetPDFfile(context, salesController.salesModel.processList[index].TimelineEvents[childIndex].Eventid);
                                                                                if (success) {
                                                                                  widget.GenerateDelivery_challan_dialougebox(
                                                                                      context, salesController.salesModel.processList[index].TimelineEvents[childIndex].Eventid);
                                                                                  dcController.setProcessID(salesController.salesModel.processList[index].processid);
                                                                                  if (kDebugMode) {
                                                                                    print(dcController.dcModel.processID);
                                                                                  }
                                                                                }
                                                                              },
                                                                              child: const Text(
                                                                                "Delivery challan",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                          if (salesController.salesModel.processList[index].TimelineEvents[childIndex].Allowed_process.credit_note == true)
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                // widget.GenerateCredit_dialougebox(context);
                                                                              },
                                                                              child: const Text(
                                                                                "Credit",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                          if (salesController.salesModel.processList[index].TimelineEvents[childIndex].Allowed_process.debit_note == true)
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                // widget.GenerateDebit_dialougebox(context);
                                                                              },
                                                                              child: const Text(
                                                                                "Debit",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 40,
                                                                      width: 2,
                                                                      color: const Color.fromARGB(78, 172, 170, 170),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 200,
                                                                      child: TextFormField(
                                                                        // maxLines: 2,
                                                                        style: TextStyle(fontSize: Primary_font_size.Text7, color: textColor.value),
                                                                        decoration: const InputDecoration(
                                                                          filled: true,
                                                                          fillColor: Primary_colors.Dark,
                                                                          hintText: 'Enter Feedback',
                                                                          hintStyle: TextStyle(
                                                                            fontSize: Primary_font_size.Text7,
                                                                            color: Color.fromARGB(255, 179, 178, 178),
                                                                          ),
                                                                          border: InputBorder.none, // Remove default border
                                                                          contentPadding: EdgeInsets.all(10), // Adjust padding
                                                                        ),
                                                                        controller: salesController.salesModel.processList[index].TimelineEvents[childIndex].feedback,

                                                                        onChanged: (value) {
                                                                          textColor.value = Colors.white;
                                                                        },
                                                                        onFieldSubmitted: (newValue) {
                                                                          // textColor = Colors.green;
                                                                          widget.UpdateFeedback(
                                                                              context,
                                                                              salesController.salesModel.customerId.value!,
                                                                              salesController.salesModel.processList[index].TimelineEvents[childIndex].Eventid,
                                                                              salesController.salesModel.processList[index].TimelineEvents[childIndex].feedback.text);
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        flex: 1,
                        child: PageTransitionSwitcher(
                            duration: const Duration(milliseconds: 300),
                            reverse: !salesController.salesModel.isprofilepage.value, // Reverse animation when toggling back
                            transitionBuilder: (
                              Widget child,
                              Animation<double> primaryAnimation,
                              Animation<double> secondaryAnimation,
                            ) {
                              return SharedAxisTransition(
                                fillColor: Colors.transparent,
                                animation: primaryAnimation,
                                secondaryAnimation: secondaryAnimation,
                                transitionType: SharedAxisTransitionType.horizontal,
                                child: child,
                              );
                            },
                            child: !salesController.salesModel.isprofilepage.value
                                ? Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Primary_colors.Light),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 10, top: 5),
                                            child: Text(
                                              'ACTIVE CUSTOMER LIST',
                                              style: TextStyle(
                                                letterSpacing: 1,
                                                wordSpacing: 3,
                                                color: Primary_colors.Color3,
                                                fontSize: Primary_font_size.Text10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Expanded(
                                              child: Container(
                                            color: Colors.transparent,
                                            key: const ValueKey(1),
                                            child: ListView.builder(
                                              itemCount: salesController.salesModel.processcustomerList.length,
                                              itemBuilder: (context, index) {
                                                final customername = salesController.salesModel.processcustomerList[index].customerName;
                                                final customerid = salesController.salesModel.processcustomerList[index].customerId;
                                                return _buildSales_ClientCard(customername, customerid, index);
                                              },
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Primary_colors.Light),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10, top: 5),
                                            child: Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      salesController.updateprofilepage(false);
                                                    },
                                                    icon: const Icon(
                                                      Icons.arrow_back_outlined,
                                                      color: Primary_colors.Color9,
                                                    )),
                                                const Text(
                                                  'CLIENT PROFILE',
                                                  style: TextStyle(
                                                    letterSpacing: 1,
                                                    wordSpacing: 3,
                                                    color: Primary_colors.Color3,
                                                    fontSize: Primary_font_size.Text10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              color: Colors.transparent,
                                              key: const ValueKey(1),
                                              child: _profile_page(),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _profile_page() {
    return Container(
      // color: Colors.amber,
      key: const ValueKey(2),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // height: 100,
              decoration: BoxDecoration(color: Primary_colors.Light, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: Primary_colors.Color5.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      // child: ClipOval(
                      //   child: Image.asset(
                      //     'assets/images/download.jpg',
                      //     fit: BoxFit.cover, // Ensures the image covers the container
                      //     width: double.infinity, // Makes the image fill the container's width
                      //     height: double.infinity, // Makes the image fill the container's height
                      //   ),
                      // ),
                      child: CircleAvatar(
                        backgroundColor: const Color.fromARGB(99, 100, 110, 255),
                        child: Text(
                          (salesController.salesModel.Clientprofile.value?.customername ?? "0").trim().isEmpty
                              ? ''
                              : (salesController.salesModel.Clientprofile.value?.customername ?? "0").contains(' ') // If there's a space, take first letter of both words
                                  ? ((salesController.salesModel.Clientprofile.value?.customername ?? "0")[0].toUpperCase() +
                                      (salesController.salesModel.Clientprofile.value?.customername ?? "0")[(salesController.salesModel.Clientprofile.value?.customername ?? "0").indexOf(' ') + 1]
                                          .toUpperCase())
                                  : (salesController.salesModel.Clientprofile.value?.customername ?? "0")[0].toUpperCase(), // If no space, take only the first letter
                          style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Heading, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          // 'Khivraj Groups',
                          salesController.salesModel.Clientprofile.value?.customername ?? "0",
                          style: const TextStyle(
                            letterSpacing: 1,
                            wordSpacing: 3,
                            color: Primary_colors.Color1,
                            fontSize: Primary_font_size.Heading,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          // 'khivrajgroups@gmail.com',
                          salesController.salesModel.Clientprofile.value?.mailid ?? "0",
                          style: const TextStyle(
                            letterSpacing: 1,
                            wordSpacing: 3,
                            color: Color.fromARGB(255, 173, 172, 172),
                            fontSize: Primary_font_size.Text5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          // '8987656545',
                          salesController.salesModel.Clientprofile.value?.Phonenumber ?? "0",
                          style: const TextStyle(
                            // letterSpacing: 1,
                            wordSpacing: 3,
                            color: Color.fromARGB(255, 173, 172, 172),
                            fontSize: Primary_font_size.Text5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Divider(
              height: 0.2,
              color: Primary_colors.Color7,
            ),
            const SizedBox(height: 5),
            Container(
              // height: 100,
              decoration: BoxDecoration(color: Primary_colors.Light, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'KYC Details',
                      style: TextStyle(
                        letterSpacing: 1,
                        wordSpacing: 3,
                        color: Primary_colors.Color6,
                        fontSize: Primary_font_size.Text9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'GST Number',
                            style: TextStyle(
                              letterSpacing: 1,
                              wordSpacing: 3,
                              color: Primary_colors.Color8,
                              fontSize: Primary_font_size.Text6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            // '8987654545454345',
                            salesController.salesModel.Clientprofile.value?.gstnumber ?? "0",
                            style: const TextStyle(
                              letterSpacing: 1,
                              wordSpacing: 3,
                              color: Color.fromARGB(255, 173, 172, 172),
                              fontSize: Primary_font_size.Text6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'Client Address',
                            style: TextStyle(
                              letterSpacing: 1,
                              wordSpacing: 3,
                              color: Primary_colors.Color8,
                              fontSize: Primary_font_size.Text6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            // '1234 MG Road,Madhya Pradesh India -452001',
                            salesController.salesModel.Clientprofile.value?.clientaddress ?? "0",
                            style: const TextStyle(
                              letterSpacing: 1,
                              wordSpacing: 3,
                              color: Color.fromARGB(255, 173, 172, 172),
                              fontSize: Primary_font_size.Text6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'Client Address name',
                            style: TextStyle(
                              letterSpacing: 1,
                              wordSpacing: 3,
                              color: Primary_colors.Color8,
                              fontSize: Primary_font_size.Text6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            // 'New Almond House, 00 Xxxxx Xxxx, Xxxxxxxxxx, EH54 5AB, United Kingdom',
                            salesController.salesModel.Clientprofile.value?.clientaddressname ?? "0",
                            style: const TextStyle(
                              letterSpacing: 1,
                              wordSpacing: 3,
                              color: Color.fromARGB(255, 173, 172, 172),
                              fontSize: Primary_font_size.Text6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'Billing Address',
                            style: TextStyle(
                              letterSpacing: 1,
                              wordSpacing: 3,
                              color: Primary_colors.Color8,
                              fontSize: Primary_font_size.Text6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            // '1234 Elm StreetApt. 5BSpringfield, IL 62704 USA',
                            salesController.salesModel.Clientprofile.value?.billingaddress ?? "0",
                            style: const TextStyle(
                              letterSpacing: 1,
                              wordSpacing: 3,
                              color: Color.fromARGB(255, 173, 172, 172),
                              fontSize: Primary_font_size.Text6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'Billing Address name',
                            style: TextStyle(
                              letterSpacing: 1,
                              wordSpacing: 3,
                              color: Primary_colors.Color8,
                              fontSize: Primary_font_size.Text6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            // '123 Main St., Apartment 4B. 5BSpringfield, IL 62704 USA',
                            salesController.salesModel.Clientprofile.value?.billingaddressname ?? "0",
                            style: const TextStyle(
                              letterSpacing: 1,
                              wordSpacing: 3,
                              color: Color.fromARGB(255, 173, 172, 172),
                              fontSize: Primary_font_size.Text6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    // height: 100,
                    decoration: BoxDecoration(color: Primary_colors.Dark, borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Client Details',
                            style: TextStyle(
                              letterSpacing: 1,
                              wordSpacing: 3,
                              color: Primary_colors.Color6,
                              fontSize: Primary_font_size.Text9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  'Client Type',
                                  style: TextStyle(
                                    letterSpacing: 1,
                                    wordSpacing: 3,
                                    color: Primary_colors.Color8,
                                    fontSize: Primary_font_size.Text6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  // 'Organization',
                                  salesController.salesModel.Clientprofile.value?.clienttype ?? "0",
                                  style: const TextStyle(
                                    letterSpacing: 1,
                                    wordSpacing: 3,
                                    color: Color.fromARGB(255, 173, 172, 172),
                                    fontSize: Primary_font_size.Text6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  'Company count',
                                  style: TextStyle(
                                    letterSpacing: 1,
                                    wordSpacing: 3,
                                    color: Primary_colors.Color8,
                                    fontSize: Primary_font_size.Text6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  // '45',
                                  salesController.salesModel.Clientprofile.value?.companycount.toString() ?? "0",
                                  style: const TextStyle(
                                    letterSpacing: 1,
                                    wordSpacing: 3,
                                    color: Color.fromARGB(255, 173, 172, 172),
                                    fontSize: Primary_font_size.Text6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  'Site count',
                                  style: TextStyle(
                                    letterSpacing: 1,
                                    wordSpacing: 3,
                                    color: Primary_colors.Color8,
                                    fontSize: Primary_font_size.Text6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  // '123',
                                  salesController.salesModel.Clientprofile.value?.sitecount.toString() ?? "0",
                                  style: const TextStyle(
                                    letterSpacing: 1,
                                    wordSpacing: 3,
                                    color: Color.fromARGB(255, 173, 172, 172),
                                    fontSize: Primary_font_size.Text6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    // height: 100,
                    decoration: BoxDecoration(color: Primary_colors.Dark, borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Process Details',
                            style: TextStyle(
                              letterSpacing: 1,
                              wordSpacing: 3,
                              color: Primary_colors.Color6,
                              fontSize: Primary_font_size.Text9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Expanded(
                                flex: 2,
                                child: Text(
                                  'Total process',
                                  style: TextStyle(
                                    letterSpacing: 1,
                                    wordSpacing: 3,
                                    color: Primary_colors.Color8,
                                    fontSize: Primary_font_size.Text6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  // '200',
                                  salesController.salesModel.Clientprofile.value?.totalprocess.toString() ?? "0",
                                  style: const TextStyle(
                                    letterSpacing: 1,
                                    wordSpacing: 3,
                                    color: Color.fromARGB(255, 173, 172, 172),
                                    fontSize: Primary_font_size.Text6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                flex: 2,
                                child: Text(
                                  'Completed process',
                                  style: TextStyle(
                                    letterSpacing: 1,
                                    wordSpacing: 3,
                                    color: Primary_colors.Color8,
                                    fontSize: Primary_font_size.Text6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  // '45',
                                  salesController.salesModel.Clientprofile.value?.inactive_process.toString() ?? "0",
                                  style: const TextStyle(
                                    letterSpacing: 1,
                                    wordSpacing: 3,
                                    color: Color.fromARGB(255, 173, 172, 172),
                                    fontSize: Primary_font_size.Text6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                flex: 2,
                                child: Text(
                                  'Active Process',
                                  style: TextStyle(
                                    letterSpacing: 1,
                                    wordSpacing: 3,
                                    color: Primary_colors.Color8,
                                    fontSize: Primary_font_size.Text6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  // '123',
                                  salesController.salesModel.Clientprofile.value?.activeprocess.toString() ?? "0",
                                  style: const TextStyle(
                                    letterSpacing: 1,
                                    wordSpacing: 3,
                                    color: Color.fromARGB(255, 173, 172, 172),
                                    fontSize: Primary_font_size.Text6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSales_ClientCard(String customername, int customerid, int index) {
    return Obx(
      () {
        return Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Card(
            color: (salesController.salesModel.showcustomerprocess.value != null && salesController.salesModel.showcustomerprocess.value == index) ? Primary_colors.Color3 : Primary_colors.Dark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 10,
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            // colors: (salesController.salesModel.showcustomerprocess.value != null && salesController.salesModel.showcustomerprocess.value == index)
            //     ? [Primary_colors.Color3, Primary_colors.Color3]
            //     : [Primary_colors.Dark, Primary_colors.Dark],
            //     begin: Alignment.topLeft,
            //     end: Alignment.bottomRight,
            //   ),
            //   borderRadius: BorderRadius.circular(20), // Ensure border radius for smooth corners
            // ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              splashColor: Colors.transparent,
              leading: Padding(
                padding: const EdgeInsets.all(7),
                child: CircleAvatar(
                  backgroundColor: salesController.salesModel.showcustomerprocess.value == index ? const Color.fromARGB(118, 18, 22, 33) : const Color.fromARGB(99, 100, 110, 255),
                  child: Text(
                    customername.trim().isEmpty
                        ? ''
                        : customername.contains(' ') // If there's a space, take first letter of both words
                            ? (customername[0].toUpperCase() + customername[customername.indexOf(' ') + 1].toUpperCase())
                            : customername[0].toUpperCase(), // If no space, take only the first letter
                    style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              // leading: const Icon(
              //   Icons.people,
              //   color: Colors.white,
              //   size: 25,
              // ),
              title: Text(
                customername,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7, fontWeight: FontWeight.w500),
                ),
              ),
              // trailing: IconButton(
              //   onPressed: () {},
              //   icon: Icon(
              //     size: 20,
              //     Icons.notifications,
              //     color: salesController.salesModel.showcustomerprocess.value == index ? Colors.red : Colors.amber,
              //   ),
              // ),
              trailing: GestureDetector(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.info_rounded,
                    color: salesController.salesModel.showcustomerprocess.value == index ? Primary_colors.Dark : Primary_colors.Color3,
                  ),
                ),
                onTap: () {
                  widget.Getclientprofile(context, customerid);
                },
              ),
              onTap: salesController.salesModel.showcustomerprocess.value != index
                  ? () {
                      salesController.updateshowcustomerprocess(index);
                      salesController.updatecustomerId(customerid);

                      widget.GetProcessList(context, customerid);
                    }
                  : () {
                      salesController.updateshowcustomerprocess(null);
                      salesController.updatecustomerId(0);
                      widget.GetProcessList(context, salesController.salesModel.customerId.value!);
                    },
            ),
          ),
        );
      },
    );
  }

  Widget _buildIconWithLabel({
    required String image,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300), // Animation duration
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: Container(
              key: ValueKey(image), // ✅ Key ensures animation on image change
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(0),
              child: ClipOval(
                child: Image.asset(
                  image,
                  key: ValueKey(image), // ✅ Key applied to image
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              letterSpacing: 1,
              fontSize: Primary_font_size.Text5,
              color: Primary_colors.Color1,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
