import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/Quote_actions.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/Vendor_actions.dart';
import 'package:ssipl_billing/5_VENDOR/services/vendor_service.dart';
import 'package:ssipl_billing/5_VENDOR/views/vendorList/vendorListPage.dart';
// import 'package:ssipl_billing/5_VENDOR/views/vendorList_page.dart';
import 'package:ssipl_billing/5_VENDOR/views/vendor_chart.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/PDF_methods/showPDF.dart';
import 'package:ssipl_billing/NOTIFICATION-/NotificationServices.dart';
import 'package:ssipl_billing/NOTIFICATION-/Notification_actions.dart';
import 'package:ssipl_billing/THEMES/style.dart';

class VendorDashboard extends StatefulWidget with VendorServices, BellIconFunction {
  VendorDashboard({super.key});
  @override
  _VendorDashboardState createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard> with TickerProviderStateMixin {
  final VendorController vendorController = Get.find<VendorController>();
  final Vendor_QuoteController quoteController = Get.find<Vendor_QuoteController>();
  final NotificationController notificationController = Get.find<NotificationController>();
  final loader = LoadingOverlay();

  @override
  void dispose() {
    vendorController.vendorModel.animationController.dispose();
    resetAll();
    super.dispose();
  }

  void resetAll() {
    vendorController.resetData();
  }

  // AnimationStyle? _animationStyle;
  @override
  void initState() {
    super.initState();
    widget.Get_vendorProcessList(0);
    vendorController.updatevendorId(0);
    vendorController.update_showVendorProcess(null);
    widget.Get_vendorProcesscustomerList();
    vendorController.vendorModel.animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  void _startAnimation() {
    if (!vendorController.vendorModel.animationController.isAnimating) {
      vendorController.vendorModel.animationController.forward(from: 0).then((_) {
        widget.vendor_refresh();
      });
    }
  }

  PageRouteBuilder _createCustomPageRoute(Widget Function() navigation) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => navigation(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeInOut;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MaterialApp(
        title: 'ERP',

        // getPages: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          iconTheme: const IconThemeData(color: Colors.white),
          primaryColor: Primary_colors.Color3,
          useMaterial3: false,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Primary_colors.Color3,
            selectionColor: Color.fromARGB(255, 103, 105, 105),
          ),
          scrollbarTheme: ScrollbarThemeData(
            trackColor: WidgetStateProperty.all(
              const Color.fromARGB(255, 229, 204, 10),
            ),
            trackBorderColor: WidgetStateProperty.all(
              Primary_colors.Color3,
            ),
            thumbColor: const WidgetStatePropertyAll(
              Color.fromARGB(255, 90, 90, 90),
            ),
          ),
          fontFamily: 'Poppins',
        ),
        home: Scaffold(
          backgroundColor: Primary_colors.Dark,
          body: Builder(
            builder: (BuildContext context) {
              return Center(
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
                                  Icons.store_outlined,
                                  size: 25.0,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Vendor',
                                style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text13),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Obx(
                                () {
                                  return Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: MouseRegion(
                                          onEnter: (_) => notificationController.notificationModel.isHovered.value = true,
                                          onExit: (_) => notificationController.notificationModel.isHovered.value = false,
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () => widget.showNotification(context),
                                            child: ShaderMask(
                                              shaderCallback: (Rect bounds) {
                                                return const LinearGradient(
                                                  colors:
                                                      // notificationController.notificationModel.notifications.isNotEmpty ?

                                                      [Colors.black, Color.fromARGB(164, 255, 191, 0), Colors.amber],
                                                  // :  [Colors.amber],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ).createShader(bounds);
                                              },
                                              blendMode: BlendMode.srcIn,
                                              child: const Icon(
                                                Icons.notifications,
                                                size: 30,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (notificationController.notificationModel.notifications.isNotEmpty)
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            height: 15,
                                            width: 15,
                                            decoration: BoxDecoration(
                                              color: notificationController.notificationModel.notifications.isNotEmpty ? Colors.red : Colors.blue,
                                              borderRadius: BorderRadius.circular(50),
                                            ),
                                            child: Center(
                                              child: Text(
                                                notificationController.notificationModel.notifications.length > 9 ? '9+' : '${notificationController.notificationModel.notifications.length}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(width: 10),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: _startAnimation,
                                  child: AnimatedBuilder(
                                    animation: vendorController.vendorModel.animationController,
                                    builder: (context, child) {
                                      return Transform.rotate(
                                        angle: -vendorController.vendorModel.animationController.value * 2 * pi, // Counterclockwise rotation
                                        child: Transform.scale(
                                          scale: TweenSequence([
                                            TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.2), weight: 50),
                                            TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 1.0), weight: 50),
                                          ]).animate(CurvedAnimation(parent: vendorController.vendorModel.animationController, curve: Curves.easeInOut)).value, // Zoom in and return to normal
                                          child: Opacity(
                                            opacity: TweenSequence([
                                              TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.5), weight: 50),
                                              TweenSequenceItem(tween: Tween<double>(begin: 0.5, end: 1.0), weight: 50),
                                            ]).animate(CurvedAnimation(parent: vendorController.vendorModel.animationController, curve: Curves.easeInOut)).value, // Fade and return to normal
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
                                        controller: TextEditingController(text: vendorController.vendorModel.searchQuery.value)
                                          ..selection = TextSelection.fromPosition(
                                            TextPosition(offset: vendorController.vendorModel.searchQuery.value.length),
                                          ),
                                        onChanged: (value) => vendorController.search(value), // ✅ Updates GetX state
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
                                      if (vendorController.vendorModel.searchQuery.value.isEmpty)
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
                                                  "Enter vendor name...",
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
                                                    'VENDOR DATA',
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
                                                        value: vendorController.vendorModel.vendorperiod.value == 'monthly' ? "Monthly view" : "Yearly view", // Use the state variable for the selected value
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
                                                            vendorController.updatevendorperiod(newValue == "Monthly view" ? 'monthly' : 'yearly');

                                                            if (newValue == "Monthly view") {
                                                              if (kDebugMode) {
                                                                print('Monthly');
                                                              }
                                                            } else if (newValue == "Yearly view") {
                                                              print('Yearly');
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
                                                                widget.formatNumber(int.tryParse(vendorController.vendorModel.vendordata.value?.totalamount ?? "0") ?? 0),
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

                                                                    "${vendorController.vendorModel.vendordata.value?.totalinvoices.toString() ?? "0"} ${((vendorController.vendorModel.vendordata.value?.totalinvoices ?? 0) < 2) ? 'invoice' : 'invoices'}",
                                                                    style: const TextStyle(fontSize: Primary_font_size.Text5, color: Color.fromARGB(255, 1, 53, 92), letterSpacing: 1, fontWeight: FontWeight.bold),
                                                                  ),
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
                                                            'PAID',
                                                            style: TextStyle(
                                                              color: Color.fromARGB(255, 186, 185, 185),
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                          Obx(
                                                            () => Text(
                                                              // "₹ 18,6232",
                                                              widget.formatNumber(int.tryParse(vendorController.vendorModel.vendordata.value?.paidamount ?? "0") ?? 0),

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
                                                                  "${vendorController.vendorModel.vendordata.value?.paidinvoices.toString() ?? "0"} ${((vendorController.vendorModel.vendordata.value?.paidinvoices ?? 0) < 2) ? 'invoice' : 'invoices'}",
                                                                  style: const TextStyle(fontSize: Primary_font_size.Text5, color: Color.fromARGB(255, 2, 87, 4), letterSpacing: 1, fontWeight: FontWeight.bold),
                                                                ),
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
                                                            Obx(
                                                              () => Text(
                                                                // "₹ 6,232",
                                                                widget.formatNumber(int.tryParse(vendorController.vendorModel.vendordata.value?.unpaidamount ?? "0") ?? 0),

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
                                                                    "${vendorController.vendorModel.vendordata.value?.unpaidinvoices.toString() ?? "0"} ${((vendorController.vendorModel.vendordata.value?.unpaidinvoices ?? 0) < 2) ? 'invoice' : 'invoices'}",
                                                                    style: const TextStyle(fontSize: Primary_font_size.Text5, color: Color.fromARGB(255, 118, 9, 1), fontWeight: FontWeight.bold, letterSpacing: 1),
                                                                  ),
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
                                                  child: MouseRegion(
                                                    cursor: SystemMouseCursors.click,
                                                    child: _buildIconWithLabel(
                                                      image: 'assets/images/addvendorprocess.png',
                                                      label: 'Vendor Process',
                                                      color: Primary_colors.Color4,
                                                      onPressed: () {
                                                        widget.Generate_VendorRfq_dialougebox(context);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: MouseRegion(
                                                    cursor: SystemMouseCursors.click,
                                                    child: _buildIconWithLabel(
                                                      image: 'assets/images/vendor.png',
                                                      label: 'View Vendor',
                                                      color: Primary_colors.Color5,
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                          _createCustomPageRoute(() => VendorlistPage()),
                                                        );
                                                      },
                                                    ),
                                                  ),
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
                                                      child: MouseRegion(
                                                        cursor: SystemMouseCursors.click,
                                                        child: _buildIconWithLabel(
                                                          // key: ValueKey(vendorController.vendorModel.type.value), // Ensures re-build
                                                          image: vendorController.vendorModel.type.value == 0 ? 'assets/images/viewarchivelist.png' : 'assets/images/mainlist.png',
                                                          label: vendorController.vendorModel.type.value == 0 ? 'Archive List' : 'Main List',
                                                          color: Primary_colors.Color8,
                                                          onPressed: () {
                                                            vendorController.vendorModel.selectedIndices.clear();
                                                            vendorController.updatetype(vendorController.vendorModel.type.value == 0 ? 1 : 0);
                                                            widget.Get_vendorProcessList(vendorController.vendorModel.vendorId.value!);
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: _buildIconWithLabel(
                                                    image: 'assets/images/options.png',
                                                    label: 'Options',
                                                    color: Primary_colors.Dark,
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                // Expanded(
                                                //   child: Column(
                                                //     children: [
                                                //       MouseRegion(
                                                //           cursor: SystemMouseCursors.click,
                                                //           child: PopupMenuButton<String>(
                                                //             splashRadius: 20,
                                                //             padding: const EdgeInsets.all(0),
                                                //             icon: Image.asset(
                                                //               'assets/images/options.png',
                                                //             ),
                                                //             iconSize: 50,
                                                //             shape: const RoundedRectangleBorder(
                                                //               borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                                //               // side: const BorderSide(color: Primary_colors.Color3, width: 2),
                                                //             ),
                                                //             color: Colors.white,
                                                //             elevation: 6,
                                                //             offset: const Offset(170, 60),
                                                //             onSelected: (String item) async {},
                                                //             itemBuilder: (BuildContext context) {
                                                //               // Determine the label for the archive/unarchive action

                                                //             },
                                                //           )),
                                                //       const SizedBox(height: 8),
                                                //       const Text(
                                                //         "Options",
                                                //         style: TextStyle(
                                                //           letterSpacing: 1,
                                                //           fontSize: Primary_font_size.Text5,
                                                //           color: Primary_colors.Color1,
                                                //           fontWeight: FontWeight.w600,
                                                //           overflow: TextOverflow.ellipsis,
                                                //         ),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // )
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
                                        child: const Padding(padding: EdgeInsets.all(16), child: VendorChart()),
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
                                            child: Obx(
                                              () => Text(
                                                vendorController.vendorModel.type.value == 0 ? 'ACTIVE PROCESS LIST' : "ARCHIVED PROCESS LIST",
                                                style: TextStyle(letterSpacing: 1, wordSpacing: 3, color: vendorController.vendorModel.type.value == 0 ? Primary_colors.Color3 : const Color.fromARGB(255, 254, 113, 113), fontSize: Primary_font_size.Text10, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Obx(
                                            () => Row(
                                              children: [
                                                Text(
                                                  vendorController.vendorModel.searchQuery.value.isNotEmpty ? 'Found: ${vendorController.vendorModel.processList.length} Process | Selected: ${vendorController.vendorModel.selectedIndices.length}' : 'Total: ${vendorController.vendorModel.processList.length} Process | Selected: ${vendorController.vendorModel.selectedIndices.length}',
                                                  style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: Primary_font_size.Text8, letterSpacing: 1.0, overflow: TextOverflow.ellipsis),
                                                ),
                                                const SizedBox(width: 10),
                                                if (vendorController.vendorModel.selectedIndices.isNotEmpty)
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
                                                          Warning_dialog(
                                                            context: context,
                                                            title: 'Confirmation',
                                                            content: 'Are you sure you want to Archive this process?',
                                                            // showCancel: true,
                                                            onOk: () {
                                                              widget.ArchiveProcesscontrol(
                                                                context,
                                                                vendorController.vendorModel.selectedIndices.map((index) => vendorController.vendorModel.processList[index].processid).toList(),
                                                                1, // 1 for Archive, 0 for Unarchive
                                                              );
                                                            },
                                                          );
                                                          break;
                                                        case 'Unarchive':
                                                          Warning_dialog(
                                                            context: context,
                                                            title: 'Confirmation',
                                                            content: 'Are you sure you want to Unarchive this process?',
                                                            // showCancel: true,
                                                            onOk: () {
                                                              widget.ArchiveProcesscontrol(
                                                                context,
                                                                vendorController.vendorModel.selectedIndices.map((index) => vendorController.vendorModel.processList[index].processid).toList(),
                                                                0, // 1 for Archive, 0 for Unarchive
                                                              );
                                                            },
                                                          );
                                                          break;
                                                        case 'Modify':
                                                          Error_dialog(
                                                            context: context,
                                                            title: 'Error',
                                                            content: 'Unable to modify the process',
                                                            // showCancel: true,
                                                          );
                                                          break;
                                                        case 'Delete':
                                                          Warning_dialog(
                                                            context: context,
                                                            title: 'Confirmation',
                                                            content: 'Are you sure you want to delete this process?',
                                                            // showCancel: true,
                                                            onOk: () {
                                                              widget.DeleteProcess(
                                                                context,
                                                                vendorController.vendorModel.selectedIndices.map((index) => vendorController.vendorModel.processList[index].processid).toList(),
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
                                                          value: vendorController.vendorModel.type.value != 0 ? 'Unarchive' : 'Archive',
                                                          child: ListTile(
                                                            leading: Icon(
                                                              vendorController.vendorModel.type.value != 0 ? Icons.unarchive_outlined : Icons.archive_outlined,
                                                              color: Colors.blueAccent,
                                                            ),
                                                            title: Text(
                                                              vendorController.vendorModel.type.value != 0 ? 'Unarchive' : 'Archive',
                                                              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: Primary_font_size.Text10),
                                                            ),
                                                          ),
                                                        ),
                                                        const PopupMenuItem<String>(
                                                          value: 'Modify',
                                                          child: ListTile(
                                                            leading: Icon(Icons.edit_outlined, color: Colors.green),
                                                            title: Text(
                                                              'Modify',
                                                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: Primary_font_size.Text10),
                                                            ),
                                                          ),
                                                        ),
                                                        const PopupMenuItem<String>(
                                                          value: 'Delete',
                                                          child: ListTile(
                                                            leading: Icon(Icons.delete_outline, color: Colors.redAccent),
                                                            title: Text(
                                                              'Delete',
                                                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: Primary_font_size.Text10),
                                                            ),
                                                          ),
                                                        ),
                                                      ];
                                                    },
                                                  ),
                                              ],
                                            ),
                                          ),
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
                                                value: vendorController.vendorModel.isAllSelected.value,
                                                onChanged: (bool? value) {
                                                  vendorController.vendorModel.isAllSelected.value = value ?? false;
                                                  if (vendorController.vendorModel.isAllSelected.value) {
                                                    vendorController.updateselectedIndices(List.generate(vendorController.vendorModel.processList.length, (index) => index));
                                                  } else {
                                                    vendorController.vendorModel.selectedIndices.clear();
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
                                        child: vendorController.vendorModel.processList.isNotEmpty
                                            ? ListView.builder(
                                                itemCount: vendorController.vendorModel.processList.length,
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
                                                                  value: vendorController.vendorModel.selectedIndices.contains(index),
                                                                  onChanged: (bool? value) {
                                                                    if (value == true) {
                                                                      vendorController.vendorModel.selectedIndices.add(index);
                                                                    } else {
                                                                      vendorController.vendorModel.selectedIndices.remove(index);
                                                                      vendorController.updateisAllSelected(vendorController.vendorModel.selectedIndices.length == vendorController.vendorModel.processList.length);
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
                                                                    message: vendorController.vendorModel.processList[index].vendor_name, // Show client name
                                                                    textStyle: const TextStyle(color: Colors.white, fontSize: Primary_font_size.Text6),
                                                                    decoration: BoxDecoration(
                                                                      color: Colors.black87,
                                                                      borderRadius: BorderRadius.circular(8),
                                                                    ),
                                                                    child: Text(
                                                                      vendorController.vendorModel.processList[index].processid.toString(),
                                                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 15,
                                                                  child: Text(
                                                                    vendorController.vendorModel.processList[index].title,
                                                                    // items[showvendorprocess]['name'],
                                                                    style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                    flex: 4,
                                                                    child: Text(
                                                                      vendorController.vendorModel.processList[index].Process_date,
                                                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                                    )),
                                                                Expanded(
                                                                  flex: 4,
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.only(left: 5),
                                                                    child: Text(
                                                                      vendorController.vendorModel.processList[index].age_in_days.toString(),
                                                                      // items[showvendorprocess]['process'][index]['daycounts'],
                                                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          children: [
                                                            SizedBox(
                                                              height: ((vendorController.vendorModel.processList[index].TimelineEvents.length * 80) + 20).toDouble(),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(16.0),
                                                                child: ListView.builder(
                                                                  itemCount: vendorController.vendorModel.processList[index].TimelineEvents.length, // +1 for "Add Event" button
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
                                                                                      colors: childIndex == 0
                                                                                          ? [
                                                                                              const Color.fromARGB(78, 0, 0, 0),
                                                                                              const Color.fromARGB(36, 231, 139, 33),
                                                                                            ]
                                                                                          : childIndex == 1
                                                                                              ? [
                                                                                                  const Color.fromARGB(66, 0, 0, 0),
                                                                                                  const Color.fromARGB(24, 118, 253, 129),
                                                                                                ]
                                                                                              : childIndex == 2
                                                                                                  ? [
                                                                                                      const Color.fromARGB(78, 0, 0, 0),
                                                                                                      const Color.fromARGB(38, 223, 55, 55),
                                                                                                    ]
                                                                                                  : childIndex == 3
                                                                                                      ? [
                                                                                                          const Color.fromARGB(78, 0, 0, 0),
                                                                                                          const Color.fromARGB(24, 118, 253, 129),
                                                                                                        ]
                                                                                                      : childIndex == 4
                                                                                                          ? [
                                                                                                              const Color.fromARGB(78, 0, 0, 0),
                                                                                                              const Color.fromARGB(43, 0, 76, 240),
                                                                                                            ]
                                                                                                          : childIndex == 5
                                                                                                              ? [
                                                                                                                  const Color.fromARGB(78, 0, 0, 0),
                                                                                                                  const Color.fromARGB(43, 253, 205, 116),
                                                                                                                ]
                                                                                                              : [Colors.white],
                                                                                    ),
                                                                                    border: Border.all(
                                                                                      color: childIndex == 0
                                                                                          ? const Color.fromARGB(255, 243, 131, 56)
                                                                                          : childIndex == 1
                                                                                              ? Colors.green
                                                                                              : childIndex == 2
                                                                                                  ? Colors.green
                                                                                                  : childIndex == 3
                                                                                                      ? Colors.red
                                                                                                      : childIndex == 4
                                                                                                          ? Colors.blue
                                                                                                          : childIndex == 5
                                                                                                              ? const Color.fromARGB(255, 255, 191, 119)
                                                                                                              : Colors.white,
                                                                                      width: 2,
                                                                                    ),
                                                                                    shape: BoxShape.circle,
                                                                                    // color: vendorController.vendorModel.processList[index].TimelineEvents[childIndex].Eventname == "Client requirement"
                                                                                    //     ? const Color.fromARGB(36, 231, 139, 33)
                                                                                    //     : vendorController.vendorModel.processList[index].TimelineEvents[childIndex].Eventname == "Invoice"
                                                                                    //         ? const Color.fromARGB(24, 118, 253, 129)
                                                                                    //         : vendorController.vendorModel.processList[index].TimelineEvents[childIndex].Eventname == "Delivery Challan"
                                                                                    //             ? const Color.fromARGB(38, 223, 55, 55)
                                                                                    //             : vendorController.vendorModel.processList[index].TimelineEvents[childIndex].Eventname == "Quotation"
                                                                                    //                 ? const Color.fromARGB(24, 118, 253, 129)
                                                                                    //                 : vendorController.vendorModel.processList[index].TimelineEvents[childIndex].Eventname == "Revised Quotation"
                                                                                    //                     ? const Color.fromARGB(43, 0, 76, 240)
                                                                                    //                     : Colors.white,
                                                                                  ),
                                                                                  // child: const Icon(
                                                                                  //   Icons.event,
                                                                                  //   color: Colors.white,
                                                                                  // ),
                                                                                  child: Center(
                                                                                    child: Image.asset(
                                                                                      childIndex == 0
                                                                                          ? 'assets/images/request.png'
                                                                                          : childIndex == 1
                                                                                              ? 'assets/images/invoice.png'
                                                                                              : childIndex == 2
                                                                                                  ? 'assets/images/dc.png'
                                                                                                  : childIndex == 3
                                                                                                      ? 'assets/images/Estimate.png'
                                                                                                      : childIndex == 4
                                                                                                          ? 'assets/images/revision.png'
                                                                                                          : childIndex == 5
                                                                                                              ? 'assets/images/rfq.png'
                                                                                                              : 'assets/images/Estimate.png',
                                                                                      fit: BoxFit.fill,
                                                                                      width: 30,
                                                                                      height: 30,
                                                                                    ),

                                                                                    // Text(
                                                                                    //   (childIndex + 1).toString(),
                                                                                    //   // (vendorController.vendorModel.processList[index].TimelineEvents.length - 1 - childIndex + 1).toString(),
                                                                                    //   style: const TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold),
                                                                                    // ),
                                                                                  ),
                                                                                ),
                                                                                onTap: () async {
                                                                                  bool success = await widget.Get_vendorPDFfile(context: context, eventid: vendorController.vendorModel.processList[index].TimelineEvents[childIndex].Eventid);
                                                                                  if (success) {
                                                                                    showPDF(context, "${vendorController.vendorModel.processList[index].vendor_name}${vendorController.vendorModel.processList[index].title}${vendorController.vendorModel.processList[index].TimelineEvents[childIndex].Eventname}", vendorController.vendorModel.pdfFile.value!);
                                                                                  }
                                                                                },
                                                                              ),
                                                                            ),
                                                                            if (childIndex != vendorController.vendorModel.processList[index].TimelineEvents.length - 1)
                                                                              Container(
                                                                                width: 2,
                                                                                height: 40,
                                                                                color: childIndex == 0
                                                                                    ? const Color.fromARGB(255, 243, 131, 56)
                                                                                    : childIndex == 1
                                                                                        ? Colors.green
                                                                                        : childIndex == 2
                                                                                            ? Colors.green
                                                                                            : childIndex == 3
                                                                                                ? Colors.red
                                                                                                : childIndex == 4
                                                                                                    ? Colors.blue
                                                                                                    : childIndex == 5
                                                                                                        ? const Color.fromARGB(255, 255, 191, 119)
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
                                                                                            vendorController.vendorModel.processList[index].TimelineEvents[childIndex].Eventname,
                                                                                            style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: [
                                                                                        if ((vendorController.vendorModel.processList[index].TimelineEvents[childIndex].Allowed_process.rrfq == true) && (vendorController.vendorModel.processList[index].TimelineEvents.length == childIndex + 1))
                                                                                          TextButton(
                                                                                            onPressed: () async {
                                                                                              bool success = await widget.Get_vendorPDFfile(context: context, eventid: vendorController.vendorModel.processList[index].TimelineEvents[childIndex].Eventid, eventtype: "rrfq");

                                                                                              if (success) {
                                                                                                widget.GenerateRrfq_dialougebox(context);
                                                                                                vendorController.setProcessID(vendorController.vendorModel.processList[index].processid);
                                                                                              }

                                                                                              // widget.GenerateRrfq_dialougebox(context);
                                                                                            },
                                                                                            child: const Text(
                                                                                              "Revised RFQ",
                                                                                              style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                                            ),
                                                                                          ),
                                                                                        if ((vendorController.vendorModel.processList[index].TimelineEvents[childIndex].Allowed_process.getApproval == true) && (vendorController.vendorModel.processList[index].TimelineEvents.length == childIndex + 1))
                                                                                          TextButton(
                                                                                            onPressed: () async {},
                                                                                            child: const Text(
                                                                                              "Get Approval",
                                                                                              style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                                            ),
                                                                                          ),
                                                                                        if ((vendorController.vendorModel.processList[index].TimelineEvents[childIndex].Allowed_process.quotation == true) && (vendorController.vendorModel.processList[index].TimelineEvents.length == childIndex + 1))
                                                                                          TextButton(
                                                                                            onPressed: () async {
                                                                                              widget.uploadQuote_dialougebox(context);
                                                                                              vendorController.setProcessID(vendorController.vendorModel.processList[index].processid);
                                                                                            },
                                                                                            child: const Text(
                                                                                              "Upload Quote",
                                                                                              style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                                            ),
                                                                                          ),
                                                                                        if ((vendorController.vendorModel.processList[index].TimelineEvents[childIndex].Allowed_process.po == true) && (vendorController.vendorModel.processList[index].TimelineEvents.length == childIndex + 1))
                                                                                          TextButton(
                                                                                            onPressed: () async {
                                                                                              widget.GeneratePo_dialougebox(context);
                                                                                            },
                                                                                            child: const Text(
                                                                                              "Generate PO",
                                                                                              style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                                            ),
                                                                                          ),
                                                                                        if ((vendorController.vendorModel.processList[index].TimelineEvents[childIndex].Allowed_process.invoice == true) && (vendorController.vendorModel.processList[index].TimelineEvents.length == childIndex + 1))
                                                                                          TextButton(
                                                                                            onPressed: () async {},
                                                                                            child: const Text(
                                                                                              "Upload Invoice",
                                                                                              style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                                            ),
                                                                                          ),
                                                                                        if ((vendorController.vendorModel.processList[index].TimelineEvents[childIndex].Allowed_process.dc == true) && (vendorController.vendorModel.processList[index].TimelineEvents.length == childIndex + 1))
                                                                                          TextButton(
                                                                                            onPressed: () async {},
                                                                                            child: const Text(
                                                                                              "Upload DC",
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

                                                                                      controller: vendorController.vendorModel.processList[index].TimelineEvents[childIndex].feedback,

                                                                                      onChanged: (value) {
                                                                                        textColor.value = Colors.white;
                                                                                      },
                                                                                      onFieldSubmitted: (newValue) {
                                                                                        widget.UpdateFeedback(context, vendorController.vendorModel.vendorId.value!, vendorController.vendorModel.processList[index].TimelineEvents[childIndex].Eventid, vendorController.vendorModel.processList[index].TimelineEvents[childIndex].feedback.text);
                                                                                        // textColor = Colors.green;
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
                                              )
                                            : vendorController.vendorModel.type.value == 0
                                                ? Center(
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
                                                            'No Active Processes',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.w600,
                                                              color: Colors.blueGrey[800],
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 204),
                                                          child: Text(
                                                            'When you start a process, it will appear here',
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.blueGrey[400],
                                                              height: 1.4,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
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
                                                            'Archive is Empty',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.w600,
                                                              color: Colors.blueGrey[800],
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 204),
                                                          child: Text(
                                                            'Completed processes will appear here once archived',
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.blueGrey[400],
                                                              height: 1.4,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 250),
                                                          child: OutlinedButton(
                                                            style: OutlinedButton.styleFrom(
                                                              side: BorderSide(color: Colors.blue[600]!),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(8),
                                                              ),
                                                              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                                                            ),
                                                            onPressed: () {
                                                              vendorController.vendorModel.selectedIndices.clear();
                                                              vendorController.updatetype(vendorController.vendorModel.type.value == 0 ? 1 : 0);
                                                              widget.Get_vendorProcessList(vendorController.vendorModel.vendorId.value!);
                                                            },
                                                            child: Text(
                                                              'View Active Processes',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w500,
                                                                color: Colors.blue[700],
                                                              ),
                                                            ),
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
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 1,
                              child: Obx(
                                () => PageTransitionSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  reverse: !vendorController.vendorModel.isprofilepage.value, // Reverse animation when toggling back
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
                                  child: !vendorController.vendorModel.isprofilepage.value
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
                                                    'ACTIVE VENDOR LIST',
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
                                                    child: vendorController.vendorModel.processcustomerList.isNotEmpty
                                                        ? ListView.builder(
                                                            itemCount: vendorController.vendorModel.processcustomerList.length,
                                                            itemBuilder: (context, index) {
                                                              final vendorname = vendorController.vendorModel.processcustomerList[index].vendorName;
                                                              final vendorid = vendorController.vendorModel.processcustomerList[index].vendorId;
                                                              return _buildVendorCard(vendorname, vendorid, index);
                                                            },
                                                          )
                                                        : Center(
                                                            child: Stack(
                                                              alignment: Alignment.topCenter,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.only(top: 40),
                                                                  child: Lottie.asset(
                                                                    'assets/animations/JSON/emptycustomerlist.json',
                                                                    // width: 264,
                                                                    height: 150,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(top: 204),
                                                                  child: Text(
                                                                    'No Active Vendors',
                                                                    style: TextStyle(
                                                                      fontSize: 18,
                                                                      fontWeight: FontWeight.w600,
                                                                      color: Colors.blueGrey[800],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(top: 244),
                                                                  child: Text(
                                                                    'When you add vendors, they will appear here',
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                      fontSize: 14,
                                                                      color: Colors.blueGrey[400],
                                                                      height: 1.4,
                                                                    ),
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
                                                            vendorController.updateprofilepage(false);
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
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
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
                          (vendorController.vendorModel.Clientprofile.value?.vendorname ?? "0").trim().isEmpty
                              ? ''
                              : (vendorController.vendorModel.Clientprofile.value?.vendorname ?? "0").contains(' ') // If there's a space, take first letter of both words
                                  ? ((vendorController.vendorModel.Clientprofile.value?.vendorname ?? "0")[0].toUpperCase() + (vendorController.vendorModel.Clientprofile.value?.vendorname ?? "0")[(vendorController.vendorModel.Clientprofile.value?.vendorname ?? "0").indexOf(' ') + 1].toUpperCase())
                                  : (vendorController.vendorModel.Clientprofile.value?.vendorname ?? "0")[0].toUpperCase(), // If no space, take only the first letter
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
                          vendorController.vendorModel.Clientprofile.value?.vendorname ?? "0",
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
                          vendorController.vendorModel.Clientprofile.value?.mailid ?? "0",
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
                          vendorController.vendorModel.Clientprofile.value?.Phonenumber ?? "0",
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
                            vendorController.vendorModel.Clientprofile.value?.gstnumber ?? "0",
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
                            vendorController.vendorModel.Clientprofile.value?.clientaddress ?? "0",
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
                            vendorController.vendorModel.Clientprofile.value?.clientaddressname ?? "0",
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
                            vendorController.vendorModel.Clientprofile.value?.billingaddress ?? "0",
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
                            vendorController.vendorModel.Clientprofile.value?.billingaddressname ?? "0",
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
                                  vendorController.vendorModel.Clientprofile.value?.clienttype ?? "0",
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
                                  vendorController.vendorModel.Clientprofile.value?.companycount.toString() ?? "0",
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
                                  vendorController.vendorModel.Clientprofile.value?.sitecount.toString() ?? "0",
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
                                  vendorController.vendorModel.Clientprofile.value?.totalprocess.toString() ?? "0",
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
                                  vendorController.vendorModel.Clientprofile.value?.inactive_process.toString() ?? "0",
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
                                  vendorController.vendorModel.Clientprofile.value?.activeprocess.toString() ?? "0",
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

  Widget _buildVendorCard(String vendorName, int vendor_id, int index) {
    return Obx(
      () {
        return Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Card(
            color: (vendorController.vendorModel.showvendorprocess.value != null && vendorController.vendorModel.showvendorprocess.value == index) ? Primary_colors.Color3 : Primary_colors.Dark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 10,
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            // colors: (vendorController.vendorModel.showvendorprocess.value != null && vendorController.vendorModel.showvendorprocess.value == index)
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
                  backgroundColor: vendorController.vendorModel.showvendorprocess.value == index ? const Color.fromARGB(118, 18, 22, 33) : const Color.fromARGB(99, 100, 110, 255),
                  child: Text(
                    vendorName.trim().isEmpty
                        ? ''
                        : vendorName.contains(' ') // If there's a space, take first letter of both words
                            ? (vendorName[0].toUpperCase() + vendorName[vendorName.indexOf(' ') + 1].toUpperCase())
                            : vendorName[0].toUpperCase(), // If no space, take only the first letter
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
                vendorName,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7, fontWeight: FontWeight.w500),
                ),
              ),
              // trailing: IconButton(
              //   onPressed: () {},
              //   icon: Icon(
              //     size: 20,
              //     Icons.notifications,
              //     color: vendorController.vendorModel.showvendorprocess.value == index ? Colors.red : Colors.amber,
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
                    color: vendorController.vendorModel.showvendorprocess.value == index ? Primary_colors.Dark : Primary_colors.Color3,
                  ),
                ),
                onTap: () {
                  // widget.Getclientprofile(context, customerid);
                },
              ),
              onTap: vendorController.vendorModel.showvendorprocess.value != index
                  ? () {
                      vendorController.update_showVendorProcess(index);
                      vendorController.updatevendorId(vendor_id);

                      widget.Get_vendorProcessList(vendor_id);
                    }
                  : () {
                      vendorController.update_showVendorProcess(null);
                      vendorController.updatevendorId(0);
                      widget.Get_vendorProcessList(vendorController.vendorModel.vendorId.value!);
                    },
            ),
          ),
        );
      },
    );
  }
  // Widget _buildVendorCard(String vendorname, int vendorid, int index) {
  //   return Obx(
  //     () {
  //       return Padding(
  //         padding: const EdgeInsets.only(bottom: 0),
  //         child: Card(
  //           color: (vendorController.vendorModel.showvendorprocess.value != null && vendorController.vendorModel.showvendorprocess.value == index) ? Primary_colors.Color3 : Primary_colors.Dark,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(15),
  //           ),
  //           elevation: 10,
  //           // decoration: BoxDecoration(
  //           //   gradient: LinearGradient(
  //           // colors: (vendorController.vendorModel.showvendorprocess.value != null && vendorController.vendorModel.showvendorprocess.value == index)
  //           //     ? [Primary_colors.Color3, Primary_colors.Color3]
  //           //     : [Primary_colors.Dark, Primary_colors.Dark],
  //           //     begin: Alignment.topLeft,
  //           //     end: Alignment.bottomRight,
  //           //   ),
  //           //   borderRadius: BorderRadius.circular(20), // Ensure border radius for smooth corners
  //           // ),
  //           child: ListTile(
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(10), // Rounded corners
  //             ),
  //             splashColor: Colors.transparent,
  //             leading: Padding(
  //               padding: const EdgeInsets.all(7),
  //               child: CircleAvatar(
  //                 backgroundColor: vendorController.vendorModel.showvendorprocess.value == index ? const Color.fromARGB(118, 18, 22, 33) : const Color.fromARGB(99, 100, 110, 255),
  //                 child: Text(
  //                   vendorname.trim().isEmpty
  //                       ? ''
  //                       : vendorname.contains(' ') // If there's a space, take first letter of both words
  //                           ? (vendorname[0].toUpperCase() + vendorname[vendorname.indexOf(' ') + 1].toUpperCase())
  //                           : vendorname[0].toUpperCase(), // If no space, take only the first letter
  //                   style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7, fontWeight: FontWeight.w500),
  //                 ),
  //               ),
  //             ),
  //             // leading: const Icon(
  //             //   Icons.people,
  //             //   color: Colors.white,
  //             //   size: 25,
  //             // ),
  //             title: Text(
  //               vendorname,
  //               style: GoogleFonts.lato(
  //                 textStyle: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7, fontWeight: FontWeight.w500),
  //               ),
  //             ),
  //             // trailing: IconButton(
  //             //   onPressed: () {},
  //             //   icon: Icon(
  //             //     size: 20,
  //             //     Icons.notifications,
  //             //     color: vendorController.vendorModel.showvendorprocess.value == index ? Colors.red : Colors.amber,
  //             //   ),
  //             // ),
  //             trailing: GestureDetector(
  //               onTap: vendorController.vendorModel.showvendorprocess.value != index
  //                   ? () {
  //                       vendorController.update_showVendorProcess(index);
  //                       vendorController.updatevendorId(vendorid);

  //                       widget.Get_vendorProcessList(vendorid);
  //                     }
  //                   : () {
  //                       vendorController.update_showVendorProcess(null);
  //                       vendorController.updatevendorId(0);
  //                       widget.Get_vendorProcessList(vendorController.vendorModel.vendorId.value!);
  //                     },
  //               child: Container(
  //                 decoration: const BoxDecoration(
  //                   color: Color.fromARGB(0, 233, 4, 4),
  //                   // shape: BoxShape.circle,
  //                 ),
  //                 child: Icon(
  //                   Icons.info_rounded,
  //                   color: vendorController.vendorModel.showvendorprocess.value == index ? Primary_colors.Dark : Primary_colors.Color3,
  //                 ),
  //               ),
  //             ),
  //             onTap: vendorController.vendorModel.showvendorprocess.value != index ? () {} : () {},
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

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
