import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
// import 'package:dropdown_textfield/dropdown_textfield.dart';d
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/CustomPDF_Controllers/SUBSCRIPTION_CustomPDF_Invoice_actions.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/SUBSCRIPTION_Quote_actions.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/services/CustomPDF_services/SUBSCRIPTION_CustomPDF_Invoice_services.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/services/subscription_service.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/views/CustomPDF/Subscription_CustomPDF_invoicePDF.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/views/Package.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/views/Recurring_Invoice/recurringInvoice.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/views/Subscription_chart.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/importXL.dart';
import 'package:ssipl_billing/THEMES-/style.dart';
import 'package:ssipl_billing/UTILS-/helpers/support_functions.dart';
import 'package:ssipl_billing/UTILS-/validators/minimal_validators.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../controllers/Subscription_actions.dart';

class Subscription_Client extends StatefulWidget with SubscriptionServices {
  Subscription_Client({super.key});

  @override
  _Subscription_ClientState createState() => _Subscription_ClientState();
}

class _Subscription_ClientState extends State<Subscription_Client> with TickerProviderStateMixin {
  final SubscriptionController subscriptionController = Get.find<SubscriptionController>();
  var inst_CustomPDF_Services = SUBSCRIPTION_CustomPDF_Services();
  final SUBSCRIPTION_CustomPDF_InvoiceController pdfpopup_controller = Get.find<SUBSCRIPTION_CustomPDF_InvoiceController>();
  final SUBSCRIPTION_QuoteController quoteController = Get.find<SUBSCRIPTION_QuoteController>();
  var inst = Subscription_CustomPDF_InvoicePDF();

  @override
  void dispose() {
    subscriptionController.subscriptionModel.animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // widget.Get_RecurringInvoiceList(context, null);
    // widget.get_CompanyList(context);
    // subscriptionController.updateshowcustomerprocess(null);
    // subscriptionController.updatecustomerId(0);
    // widget.GetProcesscustomerList(context);
    // widget.GetProcessList(context, 0);
    // widget.GetSubscriptionData(context, subscriptionController.subscriptionModel.subscriptionperiod.value);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.Get_RecurringInvoiceList(context, null);
      widget.get_CompanyList(context);
      widget.get_GlobalPackageList(context);
      subscriptionController.updateshowcustomerprocess(null);
      subscriptionController.updatecustomerId(0);
      widget.GetProcesscustomerList(context);
      widget.GetProcessList(context, 0);
      widget.GetSubscriptionData(context, subscriptionController.subscriptionModel.subscriptionperiod.value);
    });
    subscriptionController.subscriptionModel.animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _startAnimation() {
    if (!subscriptionController.subscriptionModel.animationController.isAnimating) {
      subscriptionController.subscriptionModel.animationController.forward(from: 0).then((_) {
        widget.subscription_refresh(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    // print("$screenHeight,             $screenWidth");

    return DefaultTabController(
        length: 2,
        child: Scaffold(
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
                              Icons.subscriptions,
                              size: 25.0,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Subscription',
                            style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text13),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: _startAnimation,
                            child: AnimatedBuilder(
                              animation: subscriptionController.subscriptionModel.animationController,
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle: -subscriptionController.subscriptionModel.animationController.value * 2 * pi, // Counterclockwise rotation
                                  child: Transform.scale(
                                    scale: TweenSequence([
                                      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.2), weight: 50),
                                      TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 1.0), weight: 50),
                                    ]).animate(CurvedAnimation(parent: subscriptionController.subscriptionModel.animationController, curve: Curves.easeInOut)).value, // Zoom in and return to normal
                                    child: Opacity(
                                      opacity: TweenSequence([
                                        TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.5), weight: 50),
                                        TweenSequenceItem(tween: Tween<double>(begin: 0.5, end: 1.0), weight: 50),
                                      ]).animate(CurvedAnimation(parent: subscriptionController.subscriptionModel.animationController, curve: Curves.easeInOut)).value, // Fade and return to normal
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/reload.png',
                                          fit: BoxFit.cover,
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Obx(
                            () => SizedBox(
                              width: 400,
                              height: 40,
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  TextFormField(
                                    controller: TextEditingController(text: subscriptionController.subscriptionModel.searchQuery.value)
                                      ..selection = TextSelection.fromPosition(
                                        TextPosition(offset: subscriptionController.subscriptionModel.searchQuery.value.length),
                                      ),
                                    onChanged: (value) => subscriptionController.subscriptionModel.searchQuery.value = value, // ✅ Updates GetX state
                                    style: const TextStyle(fontSize: 13, color: Colors.white),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      filled: true,
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Color.fromARGB(226, 89, 147, 255)),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Color.fromARGB(255, 104, 93, 255)),
                                      ),
                                      hintText: "", // Hide default hintText
                                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Color.fromARGB(255, 151, 151, 151),
                                      ),
                                    ),
                                  ),
                                  if (subscriptionController.subscriptionModel.searchQuery.value.isEmpty)
                                    Positioned(
                                      left: 40,
                                      child: IgnorePointer(
                                        child: AnimatedTextKit(
                                          repeatForever: true,
                                          animatedTexts: [
                                            TypewriterAnimatedText(
                                              "Search from the list...",
                                              textStyle: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 185, 183, 183), letterSpacing: 1),
                                              speed: const Duration(milliseconds: 100),
                                            ),
                                            TypewriterAnimatedText(
                                              "Enter customer name...",
                                              textStyle: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 185, 183, 183), letterSpacing: 1),
                                              speed: const Duration(milliseconds: 100),
                                            ),
                                            TypewriterAnimatedText(
                                              "Find an invoice...",
                                              textStyle: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 185, 183, 183), letterSpacing: 1),
                                              speed: const Duration(milliseconds: 100),
                                            ),
                                            TypewriterAnimatedText(
                                              "Find a Quotation...",
                                              textStyle: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 185, 183, 183), letterSpacing: 1),
                                              speed: const Duration(milliseconds: 100),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
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
                                                'SUBSCRIPTION DATA',
                                                style: TextStyle(letterSpacing: 1, wordSpacing: 3, color: Primary_colors.Color3, fontSize: Primary_font_size.Text10, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 10),
                                              child: SizedBox(
                                                width: 200,
                                                height: 35,
                                                child: Obx(
                                                  () => DropdownButtonFormField<String>(
                                                    value: subscriptionController.subscriptionModel.subscriptionperiod.value == 'monthly'
                                                        ? "Monthly view"
                                                        : "Yearly view", // Use the state variable for the selected value
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
                                                        subscriptionController.updatesubscriptionperiod(newValue == "Monthly view" ? 'monthly' : 'yearly');

                                                        if (newValue == "Monthly view") {
                                                          widget.GetSubscriptionData(context, 'monthly');
                                                        } else if (newValue == "Yearly view") {
                                                          widget.GetSubscriptionData(context, 'yearly');
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
                                                        Obx(
                                                          () => Text(
                                                            widget.formatNumber(int.tryParse(subscriptionController.subscriptionModel.subscriptiondata.value?.totalamount ?? "0") ?? 0),
                                                            style: const TextStyle(
                                                              color: Primary_colors.Color1,
                                                              fontSize: 28,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: const Color.fromARGB(255, 202, 227, 253),
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(4),
                                                            child: Obx(
                                                              () => Text(
                                                                // '210 invoices',

                                                                "${subscriptionController.subscriptionModel.subscriptiondata.value?.totalinvoices.toString() ?? "0"} ${((subscriptionController.subscriptionModel.subscriptiondata.value?.totalinvoices ?? 0) < 2) ? 'invoice' : 'invoices'}",
                                                                style: const TextStyle(
                                                                    fontSize: Primary_font_size.Text5, color: Color.fromARGB(255, 1, 53, 92), letterSpacing: 1, fontWeight: FontWeight.bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
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
                                                      Obx(
                                                        () => Text(
                                                          // "₹ 18,6232",
                                                          widget.formatNumber(int.tryParse(subscriptionController.subscriptionModel.subscriptiondata.value?.paidamount ?? "0") ?? 0),

                                                          style: const TextStyle(
                                                            color: Primary_colors.Color1,
                                                            fontSize: 28,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: const Color.fromARGB(255, 202, 253, 223),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(4),
                                                          child: Obx(
                                                            () => Text(
                                                              // '210 invoices',
                                                              "${subscriptionController.subscriptionModel.subscriptiondata.value?.paidinvoices.toString() ?? "0"} ${((subscriptionController.subscriptionModel.subscriptiondata.value?.paidinvoices ?? 0) < 2) ? 'invoice' : 'invoices'}",
                                                              style: const TextStyle(
                                                                  fontSize: Primary_font_size.Text5, color: Color.fromARGB(255, 2, 87, 4), letterSpacing: 1, fontWeight: FontWeight.bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
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
                                                        Obx(
                                                          () => Text(
                                                            // "₹ 6,232",
                                                            widget.formatNumber(int.tryParse(subscriptionController.subscriptionModel.subscriptiondata.value?.unpaidamount ?? "0") ?? 0),

                                                            style: const TextStyle(
                                                              color: Primary_colors.Color1,
                                                              fontSize: 28,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: const Color.fromARGB(255, 253, 206, 202),
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(4),
                                                            child: Obx(
                                                              () => Text(
                                                                // '110 invoices',
                                                                "${subscriptionController.subscriptionModel.subscriptiondata.value?.unpaidinvoices.toString() ?? "0"} ${((subscriptionController.subscriptionModel.subscriptiondata.value?.unpaidinvoices ?? 0) < 2) ? 'invoice' : 'invoices'}",
                                                                style: const TextStyle(
                                                                    fontSize: Primary_font_size.Text5, color: Color.fromARGB(255, 118, 9, 1), fontWeight: FontWeight.bold, letterSpacing: 1),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
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
                                              child: MouseRegion(
                                                cursor: SystemMouseCursors.click,
                                                child: _buildIconWithLabel(
                                                    image: 'assets/images/addprocess.png',
                                                    label: 'Add Process',
                                                    color: Primary_colors.Color5,
                                                    onPressed: () {
                                                      widget.Generate_client_reqirement_dialougebox('Enquiry', context);
                                                    }),
                                              ),
                                            ),
                                            Expanded(
                                              child: MouseRegion(
                                                cursor: SystemMouseCursors.click,
                                                child: _buildIconWithLabel(
                                                  image: 'assets/images/subscription.png',
                                                  label: 'Package',
                                                  color: Primary_colors.Color4,
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      isScrollControlled: true, // This allows the bottom sheet to take full screen height
                                                      barrierColor: const Color.fromARGB(244, 11, 15, 26),
                                                      enableDrag: true,
                                                      backgroundColor: Colors.transparent,
                                                      shape: const RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.vertical(
                                                          top: Radius.circular(20),
                                                        ),
                                                      ),
                                                      builder: (BuildContext context) {
                                                        return Container(
                                                          height: screenHeight - 100, // Full screen height
                                                          padding: const EdgeInsets.symmetric(horizontal: 70),
                                                          child: Packagepage(),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
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
                                                  child: MouseRegion(
                                                    cursor: SystemMouseCursors.click,
                                                    child: _buildIconWithLabel(
                                                      // key: ValueKey(subscriptionController.subscriptionModel.type.value), // Ensures re-build
                                                      image: subscriptionController.subscriptionModel.type.value == 0 ? 'assets/images/viewarchivelist.png' : 'assets/images/mainlist.png',
                                                      label: subscriptionController.subscriptionModel.type.value == 0 ? 'Archive List' : 'Main List',
                                                      color: Primary_colors.Color8,
                                                      onPressed: () {
                                                        subscriptionController.subscriptionModel.selectedIndices.clear();
                                                        subscriptionController.updatetype(subscriptionController.subscriptionModel.type.value == 0 ? 1 : 0);
                                                        widget.GetProcessList(context, subscriptionController.subscriptionModel.customerId.value!);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Expanded(
                                            //   child: _buildIconWithLabel(
                                            //     image: 'assets/images/article.png',
                                            //     label: 'Options',
                                            //     color: Primary_colors.Dark,
                                            //     onPressed: () {
                                            //       widget.pdfpopup_controller.initializeTextControllers();
                                            //       widget.pdfpopup_controller.initializeCheckboxes();
                                            //       widget.showA4StyledPopup(context);
                                            //     },
                                            //   ),
                                            // ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  MouseRegion(
                                                      cursor: SystemMouseCursors.click,
                                                      child: PopupMenuButton<String>(
                                                        splashRadius: 20,
                                                        padding: const EdgeInsets.all(0),
                                                        icon: Image.asset(
                                                          'assets/images/options.png',
                                                        ),
                                                        iconSize: 50,
                                                        shape: const RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                                          // side: const BorderSide(color: Primary_colors.Color3, width: 2),
                                                        ),
                                                        color: Colors.white,
                                                        elevation: 6,
                                                        offset: const Offset(170, 20),
                                                        onSelected: (String item) async {
                                                          // Handle menu item selection

                                                          switch (item) {
                                                            case 'Invoice':
                                                              pdfpopup_controller.intAll();
                                                              // inst_CustomPDF_Services.assign_GSTtotals();
                                                              inst.showA4StyledPopup(context);
                                                              break;
                                                            case 'Custom List':
                                                              () async {
                                                                // Show Bottom Sheet with a loading message initially
                                                                showModalBottomSheet(
                                                                  barrierColor: const Color.fromARGB(244, 11, 15, 26),
                                                                  enableDrag: true,
                                                                  backgroundColor: Colors.transparent,
                                                                  context: context,
                                                                  shape: const RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.vertical(
                                                                      top: Radius.circular(20),
                                                                    ),
                                                                  ),
                                                                  builder: (BuildContext context) {
                                                                    return const SizedBox(
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(left: 70, right: 70),
                                                                        child: Center(child: CircularProgressIndicator()), // Show loader initially
                                                                      ),
                                                                    );
                                                                  },
                                                                );

                                                                // Call the API after showing the bottom sheet
                                                                bool success = await widget.GetCustomPDFLsit(context);

                                                                // Close the previous bottom sheet
                                                                Navigator.pop(context);

                                                                // Show a new bottom sheet based on API response
                                                                showModalBottomSheet(
                                                                  barrierColor: const Color.fromARGB(244, 11, 15, 26),
                                                                  enableDrag: true,
                                                                  backgroundColor: Colors.transparent,
                                                                  context: context,
                                                                  shape: const RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.vertical(
                                                                      top: Radius.circular(20),
                                                                    ),
                                                                  ),
                                                                  builder: (BuildContext context) {
                                                                    return SizedBox(
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.only(left: 70, right: 70),
                                                                        child: success ? _manualcreation_list() : const Text('No Data available!'),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              }();
                                                              break;
                                                            case 'Import':
                                                              import_excel obj = import_excel(); // Remove const
                                                              import_excel.excelData.clear();
                                                              await obj.pickExcelFile(context);
                                                              print(import_excel.excelData);

                                                              break;
                                                          }
                                                        },
                                                        itemBuilder: (BuildContext context) {
                                                          // Determine the label for the archive/unarchive action

                                                          return [
                                                            PopupMenuItem<String>(
                                                              value: "Invoice",
                                                              child: ListTile(
                                                                leading: Obx(
                                                                  () => Icon(
                                                                    subscriptionController.subscriptionModel.type.value != 0 ? Icons.unarchive_outlined : Icons.archive_outlined,
                                                                    color: Colors.blueAccent,
                                                                  ),
                                                                ),
                                                                title: const Text(
                                                                  'Invoice',
                                                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: Primary_font_size.Text10),
                                                                ),
                                                              ),
                                                            ),
                                                            const PopupMenuItem<String>(
                                                              value: 'Custom List',
                                                              child: ListTile(
                                                                leading: Icon(Icons.edit_outlined, color: Colors.green),
                                                                title: Text('Custom List', style: TextStyle(fontWeight: FontWeight.w500, fontSize: Primary_font_size.Text10)),
                                                              ),
                                                            ),
                                                            const PopupMenuItem<String>(
                                                              value: 'Import',
                                                              child: ListTile(
                                                                leading: Icon(Icons.delete_outline, color: Colors.redAccent),
                                                                title: Text('Import', style: TextStyle(fontWeight: FontWeight.w500, fontSize: Primary_font_size.Text10)),
                                                              ),
                                                            ),
                                                          ];
                                                        },
                                                      )),
                                                  const SizedBox(height: 8),
                                                  const Text(
                                                    "Options",
                                                    style: TextStyle(
                                                      letterSpacing: 1,
                                                      fontSize: Primary_font_size.Text5,
                                                      color: Primary_colors.Color1,
                                                      fontWeight: FontWeight.w600,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                            // Expanded(
                                            //   child: MouseRegion(
                                            //     cursor: SystemMouseCursors.click,
                                            //     child: _buildIconWithLabel(
                                            //       image: 'assets/images/quotation.png',
                                            //       label: 'Create Quotation',
                                            //       color: Primary_colors.Color4,
                                            //       onPressed: () {
                                            //         // widget.Generate_client_reqirement_dialougebox('Customer', context);
                                            //       },
                                            //     ),
                                            //   ),
                                            // ),
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
                                    child: const Padding(padding: EdgeInsets.all(16), child: SubscriptionChart()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 250,
                      child: TabBar(
                        indicatorColor: Primary_colors.Color5,
                        tabs: [
                          Text('Invoice'),
                          Text('Process'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(child: TabBarView(children: [Recurringinvoice(), SubscriptionProcess()]))
                ],
              ),
            ),
          ),
        ));
  }

  Widget SubscriptionProcess() {
    return Row(
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
                        child: Obx(
                          () => Text(
                            subscriptionController.subscriptionModel.type.value == 0 ? 'ACTIVE PROCESS LIST' : "ARCHIVED PROCESS LIST",
                            style: TextStyle(
                                letterSpacing: 1,
                                wordSpacing: 3,
                                color: subscriptionController.subscriptionModel.type.value == 0 ? Primary_colors.Color3 : const Color.fromARGB(255, 254, 113, 113),
                                fontSize: Primary_font_size.Text10,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Obx(() => Row(
                            children: [
                              if (subscriptionController.subscriptionModel.selectedIndices.isNotEmpty)
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
                                              subscriptionController.subscriptionModel.selectedIndices.map((index) => subscriptionController.subscriptionModel.processList[index].processid).toList(),
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
                                              subscriptionController.subscriptionModel.selectedIndices.map((index) => subscriptionController.subscriptionModel.processList[index].processid).toList(),
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
                                              subscriptionController.subscriptionModel.selectedIndices.map((index) => subscriptionController.subscriptionModel.processList[index].processid).toList(),
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
                                        value: subscriptionController.subscriptionModel.type.value != 0 ? 'Unarchive' : 'Archive',
                                        child: ListTile(
                                          leading: Icon(
                                            subscriptionController.subscriptionModel.type.value != 0 ? Icons.unarchive_outlined : Icons.archive_outlined,
                                            color: Colors.blueAccent,
                                          ),
                                          title: Text(
                                            subscriptionController.subscriptionModel.type.value != 0 ? 'Unarchive' : 'Archive',
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
                          )),
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
                        Obx(
                          () => Checkbox(
                            value: subscriptionController.subscriptionModel.isAllSelected.value,
                            onChanged: (bool? value) {
                              subscriptionController.subscriptionModel.isAllSelected.value = value ?? false;
                              if (subscriptionController.subscriptionModel.isAllSelected.value) {
                                subscriptionController.updateselectedIndices(List.generate(subscriptionController.subscriptionModel.processList.length, (index) => index));
                              } else {
                                subscriptionController.subscriptionModel.selectedIndices.clear();
                              }
                            },
                            activeColor: Colors.white, // More vibrant color
                            checkColor: Primary_colors.Color3, // White checkmark for contrast
                            side: const BorderSide(color: Primary_colors.Color1, width: 2), // Styled border
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4), // Soft rounded corners
                            ),
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
                Obx(
                  () => Expanded(
                    // child: Container(),
                    child: ListView.builder(
                      itemCount: subscriptionController.subscriptionModel.processList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
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
                                        value: subscriptionController.subscriptionModel.selectedIndices.contains(index),
                                        onChanged: (bool? value) {
                                          if (value == true) {
                                            subscriptionController.subscriptionModel.selectedIndices.add(index);
                                          } else {
                                            subscriptionController.subscriptionModel.selectedIndices.remove(index);
                                            subscriptionController
                                                .updateisAllSelected(subscriptionController.subscriptionModel.selectedIndices.length == subscriptionController.subscriptionModel.processList.length);
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
                                          message: subscriptionController.subscriptionModel.processList[index].customer_name, // Show client name
                                          textStyle: const TextStyle(color: Colors.white, fontSize: Primary_font_size.Text6),
                                          decoration: BoxDecoration(
                                            color: Colors.black87,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            subscriptionController.subscriptionModel.processList[index].processid.toString(),
                                            style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 15,
                                        child: Text(
                                          subscriptionController.subscriptionModel.processList[index].title,
                                          // items[showcustomerprocess]['name'],
                                          style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 4,
                                          child: Text(
                                            DateFormat("dd MMM yyyy").format(DateTime.parse(subscriptionController.subscriptionModel.processList[index].Process_date)),
                                            style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                          )),
                                      Expanded(
                                        flex: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 5),
                                          child: Text(
                                            subscriptionController.subscriptionModel.processList[index].age_in_days.toString(),
                                            // items[showcustomerprocess]['process'][index]['daycounts'],
                                            style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                children: [
                                  SizedBox(
                                    height: ((subscriptionController.subscriptionModel.processList[index].TimelineEvents.length * 80) + 20).toDouble(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: ListView.builder(
                                        itemCount: subscriptionController.subscriptionModel.processList[index].TimelineEvents.length, // +1 for "Add Event" button
                                        itemBuilder: (context, childIndex) {
                                          final Rx<Color> textColor = const Color.fromARGB(255, 199, 198, 198).obs;
                                          return Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  MouseRegion(
                                                    cursor: SystemMouseCursors.click,
                                                    child: GestureDetector(
                                                      child: Container(
                                                        height: 40,
                                                        width: 40,
                                                        padding: const EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                            begin: Alignment.topLeft,
                                                            end: Alignment.bottomRight,
                                                            colors: subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventname == "Client Requirement"
                                                                ? [
                                                                    const Color.fromARGB(78, 0, 0, 0),
                                                                    const Color.fromARGB(36, 231, 139, 33),
                                                                  ]
                                                                : subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventname == "Quotation"
                                                                    ? [
                                                                        const Color.fromARGB(78, 0, 0, 0),
                                                                        const Color.fromARGB(24, 118, 253, 129),
                                                                      ]
                                                                    : subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventname == "Revised Quotation"
                                                                        ? [
                                                                            const Color.fromARGB(78, 0, 0, 0),
                                                                            const Color.fromARGB(43, 0, 76, 240),
                                                                          ]
                                                                        : [Colors.white],
                                                          ),
                                                          border: Border.all(
                                                            color: subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventname == "Client Requirement"
                                                                ? const Color.fromARGB(255, 243, 131, 56)
                                                                : subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventname == "Quotation"
                                                                    ? Colors.green
                                                                    : subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventname == "Revised Quotation"
                                                                        ? Colors.blue
                                                                        : Colors.white,
                                                            width: 2,
                                                          ),
                                                          shape: BoxShape.circle,
                                                          // color: subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventname == "Client requirement"
                                                          //     ? const Color.fromARGB(36, 231, 139, 33)
                                                          //     : subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventname == "Invoice"
                                                          //         ? const Color.fromARGB(24, 118, 253, 129)
                                                          //         : subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventname == "Delivery Challan"
                                                          //             ? const Color.fromARGB(38, 223, 55, 55)
                                                          //             : subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventname == "Quotation"
                                                          //                 ? const Color.fromARGB(24, 118, 253, 129)
                                                          //                 : subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventname == "Revised Quotation"
                                                          //                     ? const Color.fromARGB(43, 0, 76, 240)
                                                          //                     : Colors.white,
                                                        ),
                                                        // child: const Icon(
                                                        //   Icons.event,
                                                        //   color: Colors.white,
                                                        // ),
                                                        child: Center(
                                                          child: Image.asset(
                                                            subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventname == "Client Requirement"
                                                                ? 'assets/images/request.png'
                                                                : subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventname == "Quotation"
                                                                    ? 'assets/images/Estimate.png'
                                                                    : subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventname == "Revised Quotation"
                                                                        ? 'assets/images/revision.png'
                                                                        : 'assets/images/Estimate.png',
                                                            fit: BoxFit.fill,
                                                            width: 30,
                                                            height: 30,
                                                          ),

                                                          // Text(
                                                          //   (childIndex + 1).toString(),
                                                          //   // (subscriptionController.subscriptionModel.processList[index].TimelineEvents.length - 1 - childIndex + 1).toString(),
                                                          //   style: const TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold),
                                                          // ),
                                                        ),
                                                      ),
                                                      onTap: () async {
                                                        bool success = await widget.GetPDFfile(context, subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventid);
                                                        if (success) {
                                                          widget.showPDF(context,
                                                              "${subscriptionController.subscriptionModel.processList[index].customer_name}${subscriptionController.subscriptionModel.processList[index].title}${subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventname}");
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  if (childIndex != subscriptionController.subscriptionModel.processList[index].TimelineEvents.length - 1)
                                                    Container(
                                                      width: 2,
                                                      height: 40,
                                                      color: subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventname == "Client requirement"
                                                          ? const Color.fromARGB(255, 243, 131, 56)
                                                          : subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventname == "Quotation"
                                                              ? Colors.green
                                                              : subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventname == "Revised Quotation"
                                                                  ? Colors.blue
                                                                  : Colors.white,
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
                                                            padding: const EdgeInsets.only(top: 0, left: 10),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventname,
                                                                  // items[showcustomerprocess]['process'][index]['child'][childIndex]["name"],
                                                                  style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                                                ),
                                                                if (subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].apporvedstatus == 1)
                                                                  Image.asset(
                                                                    'assets/images/verified.png',
                                                                    // fit: BoxFit.cover, // Ensures the image covers the container
                                                                    width: 20, // Makes the image fill the container's width
                                                                    height: 20, // Makes the image fill the container's height
                                                                  ),
                                                                if (subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].apporvedstatus == 2)
                                                                  Image.asset(
                                                                    'assets/images/pending.png',
                                                                    // fit: BoxFit.cover, // Ensures the image covers the container
                                                                    width: 20, // Makes the image fill the container's width
                                                                    height: 20, // Makes the image fill the container's height
                                                                  ),
                                                                if (subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].apporvedstatus == 3)
                                                                  Image.asset(
                                                                    'assets/images/reject.png',
                                                                    // fit: BoxFit.cover, // Ensures the image covers the container
                                                                    width: 20, // Makes the image fill the container's width
                                                                    height: 20, // Makes the image fill the container's height
                                                                  ),
                                                                if ((subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Allowed_process.get_approval == true) &&
                                                                    (subscriptionController.subscriptionModel.processList[index].TimelineEvents.length == childIndex + 1) &&
                                                                    (subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].apporvedstatus == 0))
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(left: 5),
                                                                    child: Container(
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
                                                                          widget.GetApproval(context, subscriptionController.subscriptionModel.customerId.value!,
                                                                              subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventid);
                                                                        },
                                                                      ),
                                                                    ),
                                                                  )
                                                              ],
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              if ((subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Allowed_process.quotation == true)
                                                                  // &&(subscriptionController.subscriptionModel.processList[index].TimelineEvents.length == childIndex + 1)
                                                                  )
                                                                TextButton(
                                                                  onPressed: () async {
                                                                    bool success = await widget.GetPDFfile(
                                                                        context, subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventid);

                                                                    if (success) {
                                                                      widget.GenerateQuote_dialougebox(
                                                                          context, "quotation", subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventid);
                                                                      quoteController.setProcessID(subscriptionController.subscriptionModel.processList[index].processid);
                                                                    }
                                                                  },
                                                                  child: const Text(
                                                                    "Quotation",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                  ),
                                                                ),
                                                              if ((subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Allowed_process.revised_quatation == true)
                                                                  //  &&                                                                              (subscriptionController.subscriptionModel.processList[index].TimelineEvents.length == childIndex + 1)
                                                                  )
                                                                TextButton(
                                                                  onPressed: () async {
                                                                    bool success = await widget.GetPDFfile(
                                                                        context, subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventid);

                                                                    if (success) {
                                                                      // widget.GenerateQuote_dialougebox(cont`ext, "revisedquotation",
                                                                      //     subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventid);
                                                                      // quoteController.setProcessID(subscriptionController.subscriptionModel.processList[index].processid);
                                                                    }
                                                                  },
                                                                  child: const Text(
                                                                    "RevisedQuotation",
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
                                                            controller: subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].feedback,

                                                            onChanged: (value) {
                                                              textColor.value = Colors.white;
                                                            },
                                                            onFieldSubmitted: (newValue) {
                                                              // textColor = Colors.green;
                                                              widget.UpdateFeedback(
                                                                  context,
                                                                  subscriptionController.subscriptionModel.customerId.value!,
                                                                  subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].Eventid,
                                                                  subscriptionController.subscriptionModel.processList[index].TimelineEvents[childIndex].feedback.text);
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
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 1,
          child: Obx(
            () => PageTransitionSwitcher(
              duration: const Duration(milliseconds: 300),
              reverse: !subscriptionController.subscriptionModel.isprofilepage.value, // Reverse animation when toggling back
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
              child: !subscriptionController.subscriptionModel.isprofilepage.value
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
                                  itemCount: subscriptionController.subscriptionModel.processcustomerList.length,
                                  itemBuilder: (context, index) {
                                    final customername = subscriptionController.subscriptionModel.processcustomerList[index].customerName;
                                    final customerid = subscriptionController.subscriptionModel.processcustomerList[index].customerId;
                                    return _buildSubscription_ClientCard(customername, customerid, index);
                                  },
                                ),
                              ),
                            ),
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
                                        subscriptionController.updateprofilepage(false);
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
                    ),
            ),
          ),
        ),
      ],
    );
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
                          (subscriptionController.subscriptionModel.Clientprofile.value?.customername ?? "0").trim().isEmpty
                              ? ''
                              : (subscriptionController.subscriptionModel.Clientprofile.value?.customername ?? "0").contains(' ') // If there's a space, take first letter of both words
                                  ? ((subscriptionController.subscriptionModel.Clientprofile.value?.customername ?? "0")[0].toUpperCase() +
                                      (subscriptionController.subscriptionModel.Clientprofile.value?.customername ??
                                              "0")[(subscriptionController.subscriptionModel.Clientprofile.value?.customername ?? "0").indexOf(' ') + 1]
                                          .toUpperCase())
                                  : (subscriptionController.subscriptionModel.Clientprofile.value?.customername ?? "0")[0].toUpperCase(), // If no space, take only the first letter
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
                          subscriptionController.subscriptionModel.Clientprofile.value?.customername ?? "0",
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
                          subscriptionController.subscriptionModel.Clientprofile.value?.mailid ?? "0",
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
                          subscriptionController.subscriptionModel.Clientprofile.value?.Phonenumber ?? "0",
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
                            subscriptionController.subscriptionModel.Clientprofile.value?.gstnumber ?? "0",
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
                            subscriptionController.subscriptionModel.Clientprofile.value?.clientaddress ?? "0",
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
                            subscriptionController.subscriptionModel.Clientprofile.value?.clientaddressname ?? "0",
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
                            subscriptionController.subscriptionModel.Clientprofile.value?.billingaddress ?? "0",
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
                            subscriptionController.subscriptionModel.Clientprofile.value?.billingaddressname ?? "0",
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
                                  subscriptionController.subscriptionModel.Clientprofile.value?.clienttype ?? "0",
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
                                  subscriptionController.subscriptionModel.Clientprofile.value?.companycount.toString() ?? "0",
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
                                  subscriptionController.subscriptionModel.Clientprofile.value?.sitecount.toString() ?? "0",
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
                                  subscriptionController.subscriptionModel.Clientprofile.value?.totalprocess.toString() ?? "0",
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
                                  subscriptionController.subscriptionModel.Clientprofile.value?.inactive_process.toString() ?? "0",
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
                                  subscriptionController.subscriptionModel.Clientprofile.value?.activeprocess.toString() ?? "0",
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

  Widget _buildSubscription_ClientCard(String customername, int customerid, int index) {
    return Obx(
      () {
        return Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Card(
            color: (subscriptionController.subscriptionModel.showcustomerprocess.value != null && subscriptionController.subscriptionModel.showcustomerprocess.value == index)
                ? Primary_colors.Color3
                : Primary_colors.Dark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 10,
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            // colors: (subscriptionController.subscriptionModel.showcustomerprocess.value != null && subscriptionController.subscriptionModel.showcustomerprocess.value == index)
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
                  backgroundColor: subscriptionController.subscriptionModel.showcustomerprocess.value == index ? const Color.fromARGB(118, 18, 22, 33) : const Color.fromARGB(99, 100, 110, 255),
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
              //     color: subscriptionController.subscriptionModel.showcustomerprocess.value == index ? Colors.red : Colors.amber,
              //   ),
              // ),
              trailing: GestureDetector(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(0, 233, 4, 4),
                    // shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.info_rounded,
                    color: subscriptionController.subscriptionModel.showcustomerprocess.value == index ? Primary_colors.Dark : Primary_colors.Color3,
                  ),
                ),
                onTap: () {
                  widget.Getclientprofile(context, customerid);
                },
              ),
              onTap: subscriptionController.subscriptionModel.showcustomerprocess.value != index
                  ? () {
                      subscriptionController.updateshowcustomerprocess(index);
                      subscriptionController.updatecustomerId(customerid);

                      widget.GetProcessList(context, customerid);
                    }
                  : () {
                      subscriptionController.updateshowcustomerprocess(null);
                      subscriptionController.updatecustomerId(0);
                      widget.GetProcessList(context, subscriptionController.subscriptionModel.customerId.value!);
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

  Widget _manualcreation_list() {
    subscriptionController.clear_sharedata();
    return Obx(() {
      return Container(
          decoration: const BoxDecoration(
            // color: Primary_colors.Color3,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "CUSTOM PDF's",
                        style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text12),
                      ),
                      SizedBox(
                        width: 400,
                        height: 40,
                        child: TextFormField(
                          style: const TextStyle(fontSize: 13, color: Colors.white),
                          onChanged: subscriptionController.search_CustomPDF,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(1),
                            filled: true,
                            fillColor: const Color.fromARGB(0, 255, 255, 255),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Color.fromARGB(123, 255, 255, 255))),
                            // enabledBorder: InputBorder.none, // Removes the enabled border
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Color.fromARGB(104, 255, 255, 255))),
                            hintStyle: const TextStyle(
                              fontSize: Primary_font_size.Text7,
                              color: Primary_colors.Color1,
                            ),
                            hintText: 'Search',
                            prefixIcon: const Icon(Icons.search, color: Primary_colors.Color1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 30,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Primary_colors.Color3),
                  child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        // Checkbox(
                        //   value: select,
                        //   onChanged: (bool? value) {
                        //     setState(() {
                        //       value = value == true ? false : true;
                        //     });
                        //   },
                        //   activeColor: Primary_colors.Color4, // More vibrant color
                        //   checkColor: Colors.white, // White checkmark for contrast
                        //   side: const BorderSide(color: Primary_colors.Color1, width: 2), // Styled border
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(4), // Soft rounded corners
                        //   ),
                        // ),
                        // const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Date',
                            style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text8, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Client Name',
                            style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text8, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Reference no',
                            style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text8, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            'path',
                            style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text8, fontWeight: FontWeight.bold),
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: Text(
                            'Download',
                            style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text8, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Share',
                            style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text8, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'View',
                            style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text8, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Container(
                //   height: 2,
                //   color: Primary_colors.Color1,
                // ),
                Expanded(
                  child: ListView.builder(
                    itemCount: subscriptionController.subscriptionModel.customPdfList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: Color.fromARGB(255, 195, 193, 193)))),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  formatDate(subscriptionController.subscriptionModel.customPdfList[index].date),
                                  // documentlist[index]['date'],
                                  style: const TextStyle(
                                    color: Primary_colors.Color1,
                                    fontSize: Primary_font_size.Text8,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  subscriptionController.subscriptionModel.customPdfList[index].customerAddressName,
                                  // documentlist[index]['clientname'],
                                  style: const TextStyle(
                                    color: Primary_colors.Color1,
                                    fontSize: Primary_font_size.Text8,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  subscriptionController.subscriptionModel.customPdfList[index].genId,
                                  // documentlist[index]['title'],
                                  style: const TextStyle(
                                    color: Primary_colors.Color1,
                                    fontSize: Primary_font_size.Text8,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  subscriptionController.subscriptionModel.customPdfList[index].filePath,
                                  // documentlist[index]['type'],
                                  style: const TextStyle(
                                    color: Primary_colors.Color1,
                                    fontSize: Primary_font_size.Text8,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                    onPressed: () async {
                                      widget.downloadPdf(
                                          context,
                                          subscriptionController.subscriptionModel.customPdfList[index].filePath
                                              .replaceAll(RegExp(r'[\/\\:*?"<>|.]'), '') // Removes invalid symbols
                                              .replaceAll(" ", ""),
                                          await widget.savePdfToTemp(subscriptionController.subscriptionModel.customPdfList[index].pdfData));
                                    },
                                    icon: const Icon(
                                      Icons.download,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                    onPressed: () async {
                                      subscriptionController.clear_sharedata();
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Obx(
                                            () {
                                              return AlertDialog(
                                                // shadowColor: Primary_colors.Color3,
                                                titlePadding: const EdgeInsets.all(5),
                                                backgroundColor: const Color.fromARGB(255, 194, 198, 253), // Matching background color
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10), // Consistent with Snackbar
                                                ),
                                                title: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(7),
                                                    color: Primary_colors.Color3,
                                                  ),
                                                  child: const Padding(
                                                    padding: EdgeInsets.all(7),
                                                    child: Text(
                                                      "Share",
                                                      style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                content: IntrinsicHeight(
                                                  child: SizedBox(
                                                    // height: 200,
                                                    width: 500,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Text("File name"),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            const Text(":"),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                subscriptionController.subscriptionModel.customPdfList[index].filePath,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        if (subscriptionController.subscriptionModel.whatsapp_selectionStatus.value)
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                        if (subscriptionController.subscriptionModel.whatsapp_selectionStatus.value)
                                                          Row(
                                                            children: [
                                                              const Text("whatsapp"),
                                                              const SizedBox(
                                                                width: 20,
                                                              ),
                                                              const Text(":"),
                                                              const SizedBox(
                                                                width: 20,
                                                              ),
                                                              Expanded(
                                                                child: TextFormField(
                                                                  // maxLines: 5,
                                                                  controller: subscriptionController.subscriptionModel.phoneController.value,
                                                                  style: const TextStyle(fontSize: 13, color: Colors.black),
                                                                  decoration: const InputDecoration(
                                                                      // contentPadding: const EdgeInsets.all(10),
                                                                      // filled: true,
                                                                      // fillColor: Primary_colors.Dark,
                                                                      // focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.transparent)),
                                                                      // // enabledBorder: InputBorder.none, // Removes the enabled border
                                                                      // enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.transparent)),
                                                                      // hintStyle: const TextStyle(
                                                                      //   fontSize: Primary_font_size.Text7,
                                                                      //   color: Color.fromARGB(255, 167, 165, 165),
                                                                      // ),
                                                                      // hintText: 'Enter Feedback...',
                                                                      // prefixIcon: const Icon(
                                                                      //   Icons.feedback_outlined,
                                                                      //   color: Colors.white,
                                                                      // ),
                                                                      // suffixIcon: Padding(
                                                                      //   padding: const EdgeInsets.only(top: 50),
                                                                      //   child: IconButton(
                                                                      //     onPressed: () {},
                                                                      //     icon: const Icon(
                                                                      //       Icons.send,
                                                                      //       color: Colors.red,
                                                                      //     ),
                                                                      //   ),
                                                                      // ),
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        if (subscriptionController.subscriptionModel.gmail_selectionStatus.value)
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                        if (subscriptionController.subscriptionModel.gmail_selectionStatus.value)
                                                          Row(
                                                            children: [
                                                              const Text("E-mail"),
                                                              const SizedBox(
                                                                width: 50,
                                                              ),
                                                              const Text(":"),
                                                              const SizedBox(
                                                                width: 20,
                                                              ),

                                                              Expanded(
                                                                child: SizedBox(
                                                                  // width: 400,
                                                                  child: TextFormField(
                                                                    readOnly: false,
                                                                    style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black),
                                                                    controller: subscriptionController.subscriptionModel.emailController.value,
                                                                    decoration: InputDecoration(
                                                                      // filled: true,
                                                                      fillColor: Primary_colors.Dark,
                                                                      // focusedBorder: const OutlineInputBorder(
                                                                      //   borderSide: BorderSide(
                                                                      //     color: Colors.black,
                                                                      //   ),
                                                                      // ),
                                                                      // enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                                                      // labelStyle: const TextStyle(
                                                                      //   fontSize: Primary_font_size.Text7,
                                                                      //   color: Color.fromARGB(255, 167, 165, 165),
                                                                      // ),
                                                                      // border: const OutlineInputBorder(),
                                                                      suffixIcon: MouseRegion(
                                                                        cursor: SystemMouseCursors.click, // Change cursor to hand
                                                                        child: GestureDetector(
                                                                          onTap: () {
                                                                            subscriptionController.toggleCCemailvisibility(!subscriptionController.subscriptionModel.CCemailToggle.value);
                                                                          },
                                                                          child: SizedBox(
                                                                            height: 20,
                                                                            width: 20,
                                                                            child: Stack(
                                                                              children: [
                                                                                Align(
                                                                                  alignment: Alignment.center,
                                                                                  child: Icon(
                                                                                    subscriptionController.subscriptionModel.CCemailToggle.value
                                                                                        ? Icons.closed_caption_outlined
                                                                                        : Icons.closed_caption_disabled_outlined,
                                                                                    color: Primary_colors.Dark,
                                                                                  ),
                                                                                ),
                                                                                const Align(
                                                                                  alignment: Alignment.bottomRight,
                                                                                  child: Icon(
                                                                                    size: 15,
                                                                                    Icons.add,
                                                                                    color: Primary_colors.Dark,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    validator: (value) {
                                                                      Validators.email_validator(value);

                                                                      return null;
                                                                    },
                                                                  ),
                                                                ),
                                                              ),

                                                              // Expanded(
                                                              //   child: TextFormField(
                                                              //     // maxLines: 5,
                                                              //     controller: subscriptionController.subscriptionModel.emailController.value,
                                                              //     style: const TextStyle(fontSize: 13, color: Colors.black),
                                                              //     decoration: const InputDecoration(
                                                              //         // contentPadding: const EdgeInsets.all(10),
                                                              //         // filled: true,
                                                              //         // fillColor: Primary_colors.Dark,
                                                              //         // focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.transparent)),
                                                              //         // // enabledBorder: InputBorder.none, // Removes the enabled border
                                                              //         // enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.transparent)),
                                                              //         // hintStyle: const TextStyle(
                                                              //         //   fontSize: Primary_font_size.Text7,
                                                              //         //   color: Color.fromARGB(255, 167, 165, 165),
                                                              //         // ),
                                                              //         // hintText: 'Enter Feedback...',
                                                              //         // prefixIcon: const Icon(
                                                              //         //   Icons.feedback_outlined,
                                                              //         //   color: Colors.white,
                                                              //         // ),
                                                              //         // suffixIcon: Padding(
                                                              //         //   padding: const EdgeInsets.only(top: 50),
                                                              //         //   child: IconButton(
                                                              //         //     onPressed: () {},
                                                              //         //     icon: const Icon(
                                                              //         //       Icons.send,
                                                              //         //       color: Colors.red,
                                                              //         //     ),
                                                              //         //   ),
                                                              //         // ),
                                                              //         ),
                                                              //   ),
                                                              // ),
                                                            ],
                                                          ),
                                                        if (subscriptionController.subscriptionModel.CCemailToggle.value && subscriptionController.subscriptionModel.gmail_selectionStatus.value)
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                        if (subscriptionController.subscriptionModel.CCemailToggle.value && subscriptionController.subscriptionModel.gmail_selectionStatus.value)
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children: [
                                                              const Text(
                                                                '                                      Cc :',
                                                                style: TextStyle(fontSize: 13, color: Primary_colors.Dark, fontWeight: FontWeight.bold),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Expanded(
                                                                child: SizedBox(
                                                                  // height: 30,
                                                                  // width: 400,
                                                                  child: TextFormField(
                                                                    scrollPadding: const EdgeInsets.only(top: 10),
                                                                    style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black),
                                                                    controller: subscriptionController.subscriptionModel.CCemailController.value,
                                                                    // decoration: const InputDecoration(
                                                                    //   filled: true,
                                                                    //   fillColor: Color.fromARGB(255, 38, 39, 44),
                                                                    //   focusedBorder: OutlineInputBorder(
                                                                    //     borderSide: BorderSide(
                                                                    //       color: Colors.black,
                                                                    //     ),
                                                                    //   ),
                                                                    //   enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                                                    //   labelStyle: TextStyle(
                                                                    //     fontSize: Primary_font_size.Text7,
                                                                    //     color: Color.fromARGB(255, 167, 165, 165),
                                                                    //   ),
                                                                    //   border: OutlineInputBorder(),
                                                                    // ),
                                                                    validator: (value) {
                                                                      Validators.email_validator(value);

                                                                      return null;
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Text("Select"),
                                                            const SizedBox(
                                                              width: 50,
                                                            ),
                                                            const Text(":"),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            Stack(
                                                              alignment: FractionalOffset.topRight,
                                                              children: [
                                                                IconButton(
                                                                  iconSize: 30,
                                                                  onPressed: () {
                                                                    subscriptionController.subscriptionModel.whatsapp_selectionStatus.value =
                                                                        subscriptionController.subscriptionModel.whatsapp_selectionStatus.value == false ? true : false;
                                                                  },
                                                                  icon: Image.asset(
                                                                    'assets/images/whatsapp.png',
                                                                  ),
                                                                ),
                                                                if (subscriptionController.subscriptionModel.whatsapp_selectionStatus.value)
                                                                  Align(
                                                                    // alignment: Alignment.topLeft,
                                                                    child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(50),
                                                                          color: Colors.blue,
                                                                        ),
                                                                        child: const Padding(
                                                                          padding: EdgeInsets.all(2),
                                                                          child: Icon(
                                                                            Icons.check,
                                                                            color: Color.fromARGB(255, 255, 255, 255),
                                                                            size: 12,
                                                                          ),
                                                                        )),
                                                                  )
                                                              ],
                                                            ),
                                                            const SizedBox(width: 20),
                                                            Stack(
                                                              alignment: FractionalOffset.topRight,
                                                              children: [
                                                                IconButton(
                                                                  iconSize: 35,
                                                                  onPressed: () {
                                                                    subscriptionController.subscriptionModel.gmail_selectionStatus.value =
                                                                        subscriptionController.subscriptionModel.gmail_selectionStatus.value == false ? true : false;
                                                                  },
                                                                  icon: Image.asset('assets/images/gmail.png'),
                                                                ),
                                                                if (subscriptionController.subscriptionModel.gmail_selectionStatus.value)
                                                                  Align(
                                                                    // alignment: Alignment.topLeft,
                                                                    child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(50),
                                                                          color: Colors.blue,
                                                                        ),
                                                                        child: const Padding(
                                                                          padding: EdgeInsets.all(2),
                                                                          child: Icon(
                                                                            Icons.check,
                                                                            color: Color.fromARGB(255, 255, 255, 255),
                                                                            size: 12,
                                                                          ),
                                                                        )),
                                                                  )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Align(
                                                              alignment: Alignment.bottomLeft,
                                                              child: SizedBox(
                                                                width: 380,
                                                                // height: 100,
                                                                child: TextFormField(
                                                                  maxLines: 5,
                                                                  controller: subscriptionController.subscriptionModel.feedbackController.value,
                                                                  style: const TextStyle(fontSize: 13, color: Colors.white),
                                                                  decoration: InputDecoration(
                                                                    contentPadding: const EdgeInsets.all(10),
                                                                    filled: true,
                                                                    fillColor: Primary_colors.Dark,
                                                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.transparent)),
                                                                    // enabledBorder: InputBorder.none, // Removes the enabled border
                                                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.transparent)),
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
                                                            ),
                                                            // const SizedBox(
                                                            //   width: 20,
                                                            // ),
                                                            // Container(
                                                            //   // width: 400,
                                                            //   height: 50,
                                                            //   color: Primary_colors.Light,
                                                            //   child:
                                                            // )
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            MouseRegion(
                                                              cursor: subscriptionController.subscriptionModel.whatsapp_selectionStatus.value ||
                                                                      subscriptionController.subscriptionModel.gmail_selectionStatus.value
                                                                  ? SystemMouseCursors.click
                                                                  : SystemMouseCursors.forbidden,
                                                              child: GestureDetector(
                                                                onTap: () async {
                                                                  widget.postData_sendPDF(context, widget.fetch_messageType(),
                                                                      await widget.savePdfToTemp(subscriptionController.subscriptionModel.customPdfList[index].pdfData));
                                                                },
                                                                child: Container(
                                                                  width: 105,
                                                                  // height: 40,
                                                                  decoration: BoxDecoration(
                                                                    color: subscriptionController.subscriptionModel.whatsapp_selectionStatus.value ||
                                                                            subscriptionController.subscriptionModel.gmail_selectionStatus.value
                                                                        ? const Color.fromARGB(255, 81, 89, 212)
                                                                        : const Color.fromARGB(255, 39, 41, 73),
                                                                    borderRadius: BorderRadius.circular(5),
                                                                  ),

                                                                  child: const Padding(
                                                                    padding: EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 8),
                                                                    child: Center(
                                                                      child: Text(
                                                                        "Send",
                                                                        style: TextStyle(color: Colors.white, fontSize: Primary_font_size.Text7),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    // actions: [
                                                    //   if (showCancel)
                                                    //     TextButton(
                                                    //       onPressed: () => Navigator.of(context).pop(false), // Cancel returns `false`
                                                    //       child: const Text('Cancel', style: TextStyle(color: Primary_colors.Light, fontSize: 14, fontWeight: FontWeight.bold)),
                                                    //     ),
                                                    //   TextButton(
                                                    //     onPressed: () {
                                                    //       Navigator.of(context).pop(true); // OK returns `true`
                                                    //       if (onOk != null) {
                                                    //         onOk(); // Call onOk only if it's provided
                                                    //       }
                                                    //     },
                                                    //     child: const Text('OK', style: TextStyle(color: Primary_colors.Light, fontSize: 14, fontWeight: FontWeight.bold)),
                                                    //   ),
                                                    // ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.share,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                            insetPadding: const EdgeInsets.all(20), // Adjust padding to keep it from being full screen
                                            child: SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.35, // 85% of screen width
                                              height: MediaQuery.of(context).size.height * 0.95, // 80% of screen height
                                              child: SfPdfViewer.memory(subscriptionController.subscriptionModel.customPdfList[index].pdfData),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Image.asset(height: 40, 'assets/images/pdfdownload.png'),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ));
    });
  }
}
