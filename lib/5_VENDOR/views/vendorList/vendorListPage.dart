import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/VendorList_actions.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/Vendor_entities.dart';
import 'package:ssipl_billing/5_VENDOR/services/VendorList_service.dart';
import 'package:ssipl_billing/COMPONENTS-/PDF_methods/showPDF.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/validators/minimal_validators.dart';

class VendorlistPage extends StatefulWidget with VendorlistServices {
  VendorlistPage({super.key});

  @override
  State<VendorlistPage> createState() => _VendorlistPageState();
}

class _VendorlistPageState extends State<VendorlistPage> with TickerProviderStateMixin {
  final VendorListController vendorListController = Get.find<VendorListController>();

  @override
  void initState() {
    super.initState();
    widget.get_VendorList(context);
    vendorListController.vendorListModel.Vendor_controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    vendorListController.vendorListModel.slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: vendorListController.vendorListModel.Vendor_controller,
      curve: Curves.easeInCubic,
    ));
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) vendorListController.vendorListModel.Vendor_controller.forward();
    });
    // GenerateRfq._tabController = ;
  }

  final List<Map<String, dynamic>> items = [
    {'name': 'Nidya Panneerselvam', 'Date': '10-12-2024', 'email': false, 'whatsapp': true, 'phone': '9498804981', 'email_id': 'nidya.p@sporadasecure.com'},
    {'name': 'Sydney Sherold', 'Date': '10-12-2024', 'email': true, 'whatsapp': true, 'phone': '1234567890', 'email_id': 'sydney.s@sporadasecure.com'},
    {'name': 'John Doe', 'Date': '10-12-2024', 'email': true, 'whatsapp': false, 'phone': '9498804981', 'email_id': 'john.doe@sporadasecure.com'},
    {'name': 'Hari Prasath', 'Date': '10-12-2024', 'email': false, 'whatsapp': true, 'phone': '9498804981', 'email_id': 'hariprasath.s@sporadasecure.com'},
    {'name': 'Arunkumar', 'Date': '10-12-2024', 'email': true, 'whatsapp': false, 'phone': '1234567890', 'email_id': 'arun.kumar@sporadasecure.com'},
    {'name': 'Ganesh Kumar', 'Date': '10-12-2024', 'email': true, 'whatsapp': true, 'phone': '9498804981', 'email_id': 'ganesh.kumar@sporadasecure.com'},
    {'name': 'Rambo', 'Date': '10-12-2024', 'email': true, 'whatsapp': true, 'phone': '1234567890', 'email_id': 'rambo@sporadasecure.com'},
    {'name': 'Nidya Panneerselvam', 'Date': '10-12-2024', 'email': false, 'whatsapp': true, 'phone': '9498804981', 'email_id': 'nidya.p@sporadasecure.com'},
    {'name': 'Sydney Sherold', 'Date': '10-12-2024', 'email': true, 'whatsapp': true, 'phone': '1234567890', 'email_id': 'sydney.s@sporadasecure.com'},
    {'name': 'John Doe', 'Date': '10-12-2024', 'email': true, 'whatsapp': false, 'phone': '9498804981', 'email_id': 'john.doe@sporadasecure.com'},
    {'name': 'Hari Prasath', 'Date': '10-12-2024', 'email': false, 'whatsapp': true, 'phone': '9498804981', 'email_id': 'hariprasath.s@sporadasecure.com'},
    {'name': 'Arunkumar', 'Date': '10-12-2024', 'email': true, 'whatsapp': false, 'phone': '1234567890', 'email_id': 'arun.kumar@sporadasecure.com'},
    {'name': 'Ganesh Kumar', 'Date': '10-12-2024', 'email': true, 'whatsapp': true, 'phone': '9498804981', 'email_id': 'ganesh.kumar@sporadasecure.com'},
    {'name': 'Rambo', 'Date': '10-12-2024', 'email': true, 'whatsapp': true, 'phone': '1234567890', 'email_id': 'rambo@sporadasecure.com'},
    {'name': 'Nidya Panneerselvam', 'Date': '10-12-2024', 'email': false, 'whatsapp': true, 'phone': '9498804981', 'email_id': 'nidya.p@sporadasecure.com'},
    {'name': 'Sydney Sherold', 'Date': '10-12-2024', 'email': true, 'whatsapp': true, 'phone': '1234567890', 'email_id': 'sydney.s@sporadasecure.com'},
    {'name': 'John Doe', 'Date': '10-12-2024', 'email': true, 'whatsapp': false, 'phone': '9498804981', 'email_id': 'john.doe@sporadasecure.com'},
    {'name': 'Hari Prasath', 'Date': '10-12-2024', 'email': false, 'whatsapp': true, 'phone': '9498804981', 'email_id': 'hariprasath.s@sporadasecure.com'},
    {'name': 'Arunkumar', 'Date': '10-12-2024', 'email': true, 'whatsapp': false, 'phone': '1234567890', 'email_id': 'arun.kumar@sporadasecure.com'},
    {'name': 'Ganesh Kumar', 'Date': '10-12-2024', 'email': true, 'whatsapp': true, 'phone': '9498804981', 'email_id': 'ganesh.kumar@sporadasecure.com'},
    {'name': 'Rambo', 'Date': '10-12-2024', 'email': true, 'whatsapp': true, 'phone': '1234567890', 'email_id': 'rambo@sporadasecure.com'},
  ];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Primary_colors.Dark,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Vendor List',
                    style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text13),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        popupMenuTheme: PopupMenuThemeData(
                          color: Primary_colors.Light,
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      child: PopupMenuButton<String>(
                        tooltip: '',
                        onSelected: (value) async {
                          if (value == 'link') {
                            print('Send link selected');
                            // Add your logic here
                          } else if (value == 'manual_onboard') {
                            widget.show_ManualOnboard_DialogBox(context);
                            // Add your logic here
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'link',
                            child: Row(
                              children: [
                                Image.asset('assets/images/link.png', width: 20, height: 20),
                                const SizedBox(width: 10),
                                const Text('Send Link'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'manual_onboard',
                            child: Row(
                              children: [
                                Image.asset('assets/images/addpeople.png', width: 20, height: 20),
                                const SizedBox(width: 10),
                                const Text('Manual Onboard'),
                              ],
                            ),
                          ),
                        ],
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 75, 131, 216), // Customize the button background color
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "Add Vendor",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Obx(
                    () => SizedBox(
                      width: 400,
                      height: 40,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          TextFormField(
                            controller: TextEditingController(text: vendorListController.vendorListModel.searchQuery.value)
                              ..selection = TextSelection.fromPosition(
                                TextPosition(offset: vendorListController.vendorListModel.searchQuery.value.length),
                              ),
                            onChanged: (value) => vendorListController.search(value), // ✅ Updates GetX state
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
                          if (vendorListController.vendorListModel.searchQuery.value.isEmpty)
                            Positioned(
                              left: 40,
                              child: IgnorePointer(
                                child: AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                      "Search vendor from the list..",
                                      textStyle: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 185, 183, 183), letterSpacing: 1),
                                      speed: const Duration(milliseconds: 100),
                                    ),
                                    // TypewriterAnimatedText(
                                    //   "Search from the Demo...",
                                    //   textStyle: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 185, 183, 183), letterSpacing: 1),
                                    //   speed: const Duration(milliseconds: 100),
                                    // ),
                                    // TypewriterAnimatedText(
                                    //   "Find an invoice...",
                                    //   textStyle: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 185, 183, 183), letterSpacing: 1),
                                    //   speed: const Duration(milliseconds: 100),
                                    // ),
                                    // TypewriterAnimatedText(
                                    //   "Find a Quotation...",
                                    //   textStyle: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 185, 183, 183), letterSpacing: 1),
                                    //   speed: const Duration(milliseconds: 100),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(child: Obx(() {
            return Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Primary_colors.Light,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: vendorListController.vendorListModel.Vendorlist.isNotEmpty
                                    ? SlideTransition(
                                        position: vendorListController.vendorListModel.slideAnimation,
                                        child: GridView.builder(
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.all(8.0),
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: vendorListController.vendorListModel.Vendor_cardCount.value,
                                            crossAxisSpacing: 30,
                                            mainAxisSpacing: 30,
                                          ),
                                          itemCount: vendorListController.vendorListModel.Vendorlist.length,
                                          itemBuilder: (context, index) {
                                            var Vendor = vendorListController.vendorListModel.Vendorlist[index];
                                            return VendorCard(
                                              name: Vendor.vendorName ?? '',
                                              id: Vendor.vendorId ?? 0,
                                              email: Vendor.email ?? '',
                                              imageBytes: Vendor.vendorLogo ?? Uint8List(0),
                                              index: index,
                                              data: vendorListController.vendorListModel.Vendorlist,
                                              vendorController: vendorListController,
                                              isSelected: vendorListController.vendorListModel.Vendorlist[index].isSelected,
                                              screenWidth: screenWidth,
                                              selecteddata: vendorListController.vendorListModel.selectedVendorDetails,
                                            );
                                          },
                                        ),
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
                                                'No Vendor Found',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.blueGrey[800],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 244, bottom: 40),
                                              child: Text(
                                                'When you add vendor, they will appear here',
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
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(width: 20),
                      // Obx(() {
                      //   return vendorListController.vendorListModel.Vendor_DataPageView.value
                      //       ? Expanded(
                      //           flex: 1,
                      //           child: Padding(
                      //             padding: const EdgeInsets.only(),
                      //             child: AnimatedSwitcher(
                      //               duration: const Duration(milliseconds: 300), // Smooth animation duration
                      //               transitionBuilder: (Widget child, Animation<double> animation) {
                      //                 final Offset beginOffset = vendorListController.vendorListModel.Vendor_DataPageView.value
                      //                     ? const Offset(1.0, 0.0) // Slide in from right
                      //                     : const Offset(1.0, 0.0); // Slide in from left

                      //                 return SlideTransition(
                      //                   position: Tween<Offset>(
                      //                     begin: beginOffset,
                      //                     end: Offset.zero,
                      //                   ).animate(animation),
                      //                   child: child,
                      //                 );
                      //               },
                      //               child: vendorListController.vendorListModel.Vendor_DataPageView.value
                      //                   ? VendorEditor(
                      //                       screenWidth: screenWidth,
                      //                       data: vendorListController.vendorListModel.selectedVendorDetails,
                      //                       controller: vendorListController,
                      //                     )
                      //                   : const SizedBox.shrink(key: ValueKey(0)),
                      //             ),
                      //           ),
                      //         )
                      //       : const SizedBox.shrink();
                      // }),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 300,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: DefaultTabController(
                      length: 2,
                      child: GlassmorphicContainer(
                        width: double.infinity,
                        height: double.infinity,
                        borderRadius: 20,
                        blur: 10,
                        alignment: Alignment.center,
                        border: 1,
                        linearGradient: LinearGradient(
                          colors: [
                            Primary_colors.Light,
                            Primary_colors.Light,
                          ],
                        ),
                        borderGradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 36, 36, 36),
                            Color.fromARGB(255, 34, 34, 34),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TabBar(
                                indicatorColor: Primary_colors.Color4,
                                tabs: [
                                  Tab(text: 'LINK SENT TO'),
                                  Tab(text: 'RESPONSES RECEIVED'),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    /// --- Tab 1: LINKS SENT TO ---
                                    Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: items.length,
                                            itemBuilder: (context, index) {
                                              final item = items[index];
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                                                child: Container(
                                                  padding: const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    // color: Primary_colors.Light,
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      /// Name & Date
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            '${index + 1}. ${item['name']}',
                                                            style: const TextStyle(color: Primary_colors.Color9, fontSize: 12),
                                                          ),
                                                          const SizedBox(height: 4),
                                                          Text(
                                                            'Sent on:  ${item['Date']}',
                                                            style: const TextStyle(
                                                              color: Primary_colors.Color7,
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                      /// Icons
                                                      Row(
                                                        children: [
                                                          if (item['email'] == true)
                                                            Tooltip(
                                                              message: item['email_id'] ?? 'No Email',
                                                              child: MouseRegion(
                                                                cursor: SystemMouseCursors.click,
                                                                child: AnimatedContainer(
                                                                  duration: const Duration(milliseconds: 150),
                                                                  padding: const EdgeInsets.all(6),
                                                                  decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    color: Colors.blue.withOpacity(0.1),
                                                                  ),
                                                                  child: const Icon(
                                                                    Icons.email_outlined,
                                                                    color: Colors.blue,
                                                                    size: 18,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          if (item['email'] == true && item['whatsapp'] == true) const SizedBox(width: 8),
                                                          if (item['whatsapp'] == true)
                                                            Tooltip(
                                                              message: item['phone'] ?? 'No Number',
                                                              child: MouseRegion(
                                                                cursor: SystemMouseCursors.click,
                                                                child: AnimatedContainer(
                                                                  duration: const Duration(milliseconds: 150),
                                                                  padding: const EdgeInsets.all(6),
                                                                  decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    color: Colors.green.withOpacity(0.1),
                                                                  ),
                                                                  child: const FaIcon(
                                                                    FontAwesomeIcons.whatsapp,
                                                                    color: Colors.green,
                                                                    size: 18,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        const Divider(
                                          color: Color.fromARGB(255, 122, 121, 121),
                                          height: 0.5,
                                        ),
                                        const SizedBox(height: 20),
                                        const SizedBox(
                                          width: 430,
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            "This section lists the links that have been sent to vendors for onboarding.",
                                            style: TextStyle(
                                              color: Primary_colors.Color9,
                                              fontSize: Primary_font_size.Text6,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    /// --- Tab 2: RESPONSE RECEIVED ---
                                    const Center(
                                      child: Text(
                                        'Response tab content goes here',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          })),
        ],
      ),
    );
  }
}

class VendorCard extends StatefulWidget with VendorlistServices {
  final String name;
  final String email;
  final int id;
  final Uint8List imageBytes;
  final int index;
  final List<VendorList> data; // Changed from VendorsData to List<VendorsData>
  final VendorListController vendorController;
  final bool isSelected;
  final double screenWidth;
  final Rx<VendorList> selecteddata;

  // final VendorListController controller;
  VendorCard({
    super.key,
    required this.name,
    required this.email,
    required this.id,
    required this.imageBytes,
    required this.index,
    required this.data, // updated here
    required this.vendorController,
    required this.isSelected,
    required this.screenWidth,
    required this.selecteddata,

    // required this.controller,
  });

  @override
  State<VendorCard> createState() => _VendorCardState();
}

class _VendorCardState extends State<VendorCard> {
  bool _isHovered = false;
  // final Ve manualOnboardController = Get.find<ManualOnboardController>();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(
          0,
          _isHovered ? -10 : (widget.isSelected ? -8 : 0), // Pop up on hover
          0,
        ),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              widget.isSelected ? Colors.redAccent : Primary_colors.Color3,
              const Color.fromARGB(255, 189, 189, 189),
              Primary_colors.Color7,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.isSelected ? Colors.redAccent : Colors.transparent,
            width: widget.isSelected ? 2 : 1,
          ),
          boxShadow: widget.isSelected
              ? [
                  BoxShadow(
                    color: Colors.redAccent.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ]
              : _isHovered
                  ? [
                      BoxShadow(
                        color: Primary_colors.Color3.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(2, 2),
                      ),
                    ],
        ),
        child: GestureDetector(
          onTap: () async {
            widget.vendorController.update_requiredData(widget.vendorListController.vendorListModel.Vendorlist[widget.index]);
            // widget.get_requiredData(context, widget.vendorListController.vendorListModel.Vendorlist[widget.index].vendorId!);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.vendorController.onVendorSelected(widget.data, widget.index);
            });
            await showModalBottomSheet(
              backgroundColor: Primary_colors.Dark,
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) {
                return SizedBox(
                  height: 720,
                  child: VendorEditor(
                    index: widget.index,
                    screenWidth: widget.screenWidth,
                    data: widget.selecteddata,
                    vendorcontroller: widget.vendorController,
                  ),
                );
              },
            );
            widget.vendorController.onVendorDeselected(widget.data);
            widget.vendorController.vendorListModel.isFormEditable.value = false;
            widget.vendorController.resetData();
            // print('object');
          },
          child: Card(
            color: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            color: Colors.white,
                            child: widget.imageBytes.isNotEmpty ? Image.memory(widget.imageBytes, fit: BoxFit.contain) : const Center(child: Text("No Image Available")),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Tooltip(
                          message: "Edit",
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white.withOpacity(0.0),
                            child: IconButton(
                              icon: const Icon(Icons.delete, size: 15, color: Color.fromARGB(255, 110, 110, 110)),
                              onPressed: () {
                                // widget.pickFile(context, 'vendor', widget.id);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.vendorController.vendorListModel.Vendorlist[widget.index].vendorName ?? "",
                            style: const TextStyle(fontSize: 8),
                            textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, // Truncate when resizing
                            maxLines: 1,
                          ),
                          const SizedBox(height: 4),
                        ],
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
  }
}

class VendorEditor extends StatefulWidget with VendorlistServices {
  final double screenWidth;
  final Rx<VendorList> data;
  final int index;
  final VendorListController vendorcontroller;

  VendorEditor({
    super.key,
    required this.screenWidth,
    required this.data,
    required this.index,
    required this.vendorcontroller,
  });

  @override
  _VendorEditorState createState() => _VendorEditorState();
}

class _VendorEditorState extends State<VendorEditor> {
  File? _logoFile;

  Future<void> _pickLogo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null && result.files.single.path != null) {
      final pickedFile = File(result.files.single.path!);
      widget.vendorcontroller.vendorListModel.uploadedLogo_path.value = pickedFile.path;
      widget.vendorcontroller.vendorListModel.logoFileChanged.value = true;
      await widget.vendorListController.setUploadedLogo(pickedFile);
      setState(() {
        _logoFile = pickedFile;
      });
    }
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Primary_colors.Light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        // boxShadow: [
        //   BoxShadow(
        //     // ignore: deprecated_member_use
        //     color: Colors.grey.withOpacity(0.2),
        //     blurRadius: 8,
        //     offset: const Offset(0, 4),
        //   ),
        // ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 16),
          const Text(
            "Vendor Management",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const Spacer(),
          // Obx(() {
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // if (!widget.vendorcontroller.vendorListModel.isFormEditable.value)
              ElevatedButton.icon(
                icon: const Icon(Icons.edit, size: 18),
                label: const Text("Edit"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                onPressed: () {
                  widget.vendorcontroller.enableEditMode();
                },
              ),
              SizedBox(
                width: 10,
              ),
              // if (widget.vendorcontroller.vendorListModel.isFormEditable.value)
              ElevatedButton.icon(
                icon: const Icon(Icons.save, size: 18),
                label: const Text("Save Changes"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onPressed: () {
                  if (widget.vendorcontroller.vendorListModel.vendorManagementFormKey.value.currentState!.validate()) {
                    widget.postData(context, 'update');
                    widget.vendorcontroller.vendorListModel.isFormEditable.value = false;
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogoSection() {
    final uploadedLogo = widget.vendorcontroller.vendorListModel.uploadedLogo.value;
    final isEditable = widget.vendorcontroller.vendorListModel.isFormEditable.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Primary_colors.Dark,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 40, 44, 54),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color.fromARGB(255, 17, 17, 17),
                width: 1,
              ),
            ),
            child: _logoFile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(_logoFile!, fit: BoxFit.cover),
                  )
                : (uploadedLogo != null
                    ? FutureBuilder<Uint8List>(
                        future: uploadedLogo.readAsBytes(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(snapshot.data!, fit: BoxFit.cover),
                            );
                          } else {
                            return const Center(child: CircularProgressIndicator());
                          }
                        },
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add_a_photo, color: Colors.grey, size: 32),
                          const SizedBox(height: 8),
                          Text(
                            "No Logo",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )),
          ),
        ),
        const SizedBox(height: 8),
        MouseRegion(
          cursor: isEditable ? SystemMouseCursors.click : SystemMouseCursors.basic,
          child: GestureDetector(
            onTap: isEditable ? _pickLogo : null,
            child: Text(
              isEditable ? "Upload Logo" : 'Click Edit to Upload',
              style: TextStyle(
                fontSize: 13,
                color: isEditable ? Colors.blue : Colors.grey,
                // decoration: isEditable ? TextDecoration.underline : TextDecoration.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    // required String hintText,
    required TextEditingController controller,
    String? Function(String?)? validator,
    bool isRequired = false,
    bool digitsOnly = false,
    int? maxLines = 1,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: Primary_font_size.Text8,
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey,
              ),
            ),
            if (isRequired)
              const Text(
                " *",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 40, // ⬅️ set a fixed height
          decoration: BoxDecoration(
            color: readOnly ? const Color.fromARGB(255, 61, 66, 80) : const Color.fromARGB(255, 40, 44, 54),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color.fromARGB(255, 34, 34, 34),
              width: 1,
            ),
          ),
          alignment: Alignment.center, // ensures vertical alignment
          child: TextFormField(
            controller: controller,
            inputFormatters: digitsOnly ? [FilteringTextInputFormatter.digitsOnly] : null,
            maxLines: 1, // ⬅️ ensure single-line for correct height alignment
            readOnly: readOnly,
            style: const TextStyle(fontSize: 12, color: Primary_colors.Color1), // optional: adjust font size
            decoration: InputDecoration(
              // hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[500], fontSize: 12),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0), // ⬅️ minimize vertical padding
              isCollapsed: true, // ⬅️ important to reduce internal height
              border: InputBorder.none,
            ),
            validator: validator,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildFileUploadField({
    required String label,
    required String? currentFile,
    required VoidCallback onPressed,
    bool isRequired = false,
    required Function(File?) onFileChanged,
    required bool isEditable, // 👈 new flag
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey,
              ),
            ),
            if (isRequired)
              const Text(
                " *",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 40, 44, 54),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color.fromARGB(255, 31, 30, 30),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              if (currentFile != null && currentFile.isNotEmpty)
                Container(
                  padding: const EdgeInsets.only(left: 3),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(17, 227, 242, 253),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.insert_drive_file, size: 18, color: Colors.blue),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          currentFile.split('/').last,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.blue,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.description, size: 18, color: Colors.orangeAccent),
                        onPressed: onPressed, // 👈 always allow view
                      ),
                    ],
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Center(
                    child: Text(
                      'No file uploaded',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.upload, size: 18),
                      label: const Text(
                        "Upload File",
                        style: TextStyle(fontSize: 10),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: isEditable ? Colors.blue : Colors.grey,
                        side: BorderSide(color: isEditable ? Colors.blue : Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onPressed: isEditable
                          ? () async {
                              final result = await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['pdf'],
                              );
                              if (result != null) {
                                onFileChanged(File(result.files.single.path!));
                              }
                            }
                          : null, // 👈 disables button
                    ),
                  ),
                  if (currentFile != null && currentFile.isNotEmpty && isEditable)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                        onPressed: onPressed,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Primary_colors.Dark,
        borderRadius: BorderRadius.circular(12),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.1),
        //     blurRadius: 6,
        //     offset: const Offset(0, 3),
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Primary_colors.Light,
          ),
          child: Obx(() {
            return Form(
              key: widget.vendorcontroller.vendorListModel.vendorManagementFormKey.value,
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    _buildLogoSection(),
                                    SizedBox(height: 15),
                                    _buildSection(
                                      title: "Basic Information",
                                      children: [
                                        _buildTextField(
                                          label: "Vendor ID",
                                          // hintText: "Enter vendor ID"
                                          controller: TextEditingController(
                                            text: widget.vendorcontroller.vendorListModel.vendorId.value.toString(),
                                          ),
                                          readOnly: true,
                                        ),
                                        _buildTextField(
                                          label: "Vendor Name",
                                          // hintText: "Enter vendor name",
                                          controller: widget.vendorcontroller.vendorListModel.vendorNameController.value,
                                          readOnly: !widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                          isRequired: true,
                                          digitsOnly: false,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter vendor name';
                                            }
                                            return null;
                                          },
                                        ),
                                        _buildTextField(
                                            label: "Vendor Email",
                                            //hintText: "Enter vendor email",
                                            controller: widget.vendorcontroller.vendorListModel.contactPersonEmail.value,
                                            readOnly: !widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                            isRequired: true,
                                            digitsOnly: false,
                                            validator: (value) {
                                              return Validators.email_validator(value);
                                            }),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    _buildSection(
                                      title: "Documents",
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: _buildFileUploadField(
                                                label: "GST Reg Certificate",
                                                currentFile: '${widget.vendorcontroller.vendorListModel.GSTregCerti_uploadedPath}',
                                                isRequired: true,
                                                isEditable: widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                                onFileChanged: (file) {
                                                  widget.vendorcontroller.vendorListModel.gstRegFileChanged.value = true;
                                                  widget.vendorcontroller.vendorListModel.GSTregCerti_uploadedPath.value = file?.path;
                                                  widget.vendorcontroller.vendorListModel.GSTregCertiFile.value = file;
                                                },
                                                onPressed: () async {
                                                  bool success = await widget.Get_vendorFile(context: context, vendorId: widget.vendorcontroller.vendorListModel.vendorId.toInt(), type: 'gstreg');
                                                  if (success) {
                                                    if (widget.vendorcontroller.vendorListModel.GSTregCertiFile.value != null) {
                                                      showPDF(context, widget.vendorcontroller.vendorListModel.GSTregCerti_uploadedPath.string,
                                                          widget.vendorcontroller.vendorListModel.GSTregCertiFile.value);
                                                    } else {
                                                      showPDF(context, widget.vendorcontroller.vendorListModel.GSTregCerti_uploadedPath.string, widget.vendorcontroller.vendorListModel.pdfFile.value);
                                                    }
                                                  }
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: _buildFileUploadField(
                                                label: "PAN Document",
                                                currentFile: '${widget.vendorcontroller.vendorListModel.PAN_uploadedPath}',
                                                isRequired: true,
                                                isEditable: widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                                onFileChanged: (file) {
                                                  widget.vendorcontroller.vendorListModel.panFileChanged.value = true;
                                                  widget.vendorcontroller.vendorListModel.PAN_uploadedPath.value = file?.path;
                                                  widget.vendorcontroller.vendorListModel.vendorPANfile.value = file;
                                                },
                                                onPressed: () async {
                                                  bool success = await widget.Get_vendorFile(context: context, vendorId: widget.vendorcontroller.vendorListModel.vendorId.toInt(), type: 'pan');
                                                  if (success) {
                                                    if (widget.vendorcontroller.vendorListModel.vendorPANfile.value != null) {
                                                      showPDF(context, widget.vendorcontroller.vendorListModel.PAN_uploadedPath.string, widget.vendorcontroller.vendorListModel.vendorPANfile.value);
                                                    } else {
                                                      showPDF(context, widget.vendorcontroller.vendorListModel.PAN_uploadedPath.string, widget.vendorcontroller.vendorListModel.pdfFile.value);
                                                    }
                                                  }
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: _buildFileUploadField(
                                                label: "Cancelled Cheque",
                                                currentFile: '${widget.vendorcontroller.vendorListModel.cheque_uploadedPath}',
                                                isRequired: true,
                                                isEditable: widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                                onFileChanged: (file) {
                                                  widget.vendorcontroller.vendorListModel.chequeFileChanged.value = true;
                                                  widget.vendorcontroller.vendorListModel.cheque_uploadedPath.value = file?.path;
                                                  widget.vendorcontroller.vendorListModel.cancelledChequeFile.value = file;
                                                },
                                                onPressed: () async {
                                                  bool success = await widget.Get_vendorFile(context: context, vendorId: widget.vendorcontroller.vendorListModel.vendorId.toInt(), type: 'cheque');
                                                  if (success) {
                                                    if (widget.vendorcontroller.vendorListModel.cancelledChequeFile.value != null) {
                                                      showPDF(context, widget.vendorcontroller.vendorListModel.cheque_uploadedPath.string,
                                                          widget.vendorcontroller.vendorListModel.cancelledChequeFile.value);
                                                    } else {
                                                      showPDF(context, widget.vendorcontroller.vendorListModel.cheque_uploadedPath.string, widget.vendorcontroller.vendorListModel.pdfFile.value);
                                                    }
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildSection(
                                            title: "Contact Information",
                                            children: [
                                              _buildTextField(
                                                label: "Contact Person",
                                                // hintText: "Enter contact person name",
                                                controller: widget.vendorcontroller.vendorListModel.contactpersonName.value,
                                                readOnly: !widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                                isRequired: true,
                                                digitsOnly: false,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter contact person name';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              _buildTextField(
                                                label: "Designation",
                                                // hintText: "Enter designation",
                                                controller: widget.vendorcontroller.vendorListModel.contactPersonDesignation.value,
                                                readOnly: !widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                                isRequired: true,
                                                digitsOnly: false,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter designation';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              _buildTextField(
                                                label: "Phone Number",
                                                // hintText: "Enter phone number",
                                                controller: widget.vendorcontroller.vendorListModel.contactPersonPhoneNumber.value,
                                                readOnly: !widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                                isRequired: true,
                                                digitsOnly: true,
                                                validator: (value) {
                                                  return Validators.phnNo_validator(value);
                                                },
                                              ),
                                              _buildTextField(
                                                label: "Address",
                                                // hintText: "Enter full address",
                                                controller: widget.vendorcontroller.vendorListModel.vendorAddressController.value,
                                                readOnly: !widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                                maxLines: 2,
                                                isRequired: true,
                                                digitsOnly: false,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter vendor address';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: _buildTextField(
                                                      label: "State",
                                                      // hintText: "Enter state",
                                                      controller: widget.vendorcontroller.vendorListModel.vendorAddressStateController.value,
                                                      readOnly: !widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                                      isRequired: true,
                                                      digitsOnly: false,
                                                      validator: (value) {
                                                        if (value == null || value.isEmpty) {
                                                          return 'Please enter state';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  Expanded(
                                                    child: _buildTextField(
                                                      label: "Pincode",
                                                      //hintText: "Enter pincode",
                                                      controller: widget.vendorcontroller.vendorListModel.vendorAddressPincodeController.value,
                                                      readOnly: !widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                                      isRequired: true,
                                                      digitsOnly: true,
                                                      validator: (value) {
                                                        if (value == null || value.isEmpty) {
                                                          return 'Please enter pincode';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: _buildSection(
                                            title: "Business Information",
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: _buildTextField(
                                                      label: "Business Type",
                                                      //hintText: "Enter business type",
                                                      controller: widget.vendorcontroller.vendorListModel.typeOfBusiness.value,
                                                      readOnly: !widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                                      isRequired: true,
                                                      digitsOnly: false,
                                                      validator: (value) {
                                                        if (value == null || value.isEmpty) {
                                                          return 'Please enter business Type';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  Expanded(
                                                    child: _buildTextField(
                                                      label: "Year of  Establishment",
                                                      //hintText: "Enter year",
                                                      controller: widget.vendorcontroller.vendorListModel.yearOfEstablishment.value,
                                                      readOnly: !widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                                      isRequired: true,
                                                      digitsOnly: true,
                                                      validator: (value) {
                                                        if (value == null || value.isEmpty) {
                                                          return 'Please enter year of establishment';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: _buildTextField(
                                                        label: "GST Number",
                                                        //hintText: "Enter GST number",
                                                        controller: widget.vendorcontroller.vendorListModel.vendorGstNo.value,
                                                        readOnly: !widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                                        isRequired: true,
                                                        digitsOnly: false,
                                                        validator: (value) {
                                                          return Validators.GST_validator(value);
                                                        }),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  Expanded(
                                                    child: _buildTextField(
                                                      label: "PAN Number",
                                                      //hintText: "Enter PAN number",
                                                      controller: widget.vendorcontroller.vendorListModel.vendorPanNo.value,
                                                      readOnly: !widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                                      isRequired: true,
                                                      digitsOnly: false,
                                                      validator: (value) {
                                                        return Validators.PAN_validator(value);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: _buildTextField(
                                                      label: "Annual Turnover",
                                                      // hintText: "Enter annual turnover",
                                                      controller: widget.vendorcontroller.vendorListModel.vendorAnnualTurnover.value,
                                                      readOnly: !widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                                      isRequired: true,
                                                      digitsOnly: true,
                                                      validator: (value) {
                                                        if (value == null || value.isEmpty) {
                                                          return 'Please enter annual turnover';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  Expanded(
                                                    child: _buildTextField(
                                                      label: "Products/Services",
                                                      //hintText: "List products or services",
                                                      controller: widget.vendorcontroller.vendorListModel.productInputController,
                                                      readOnly: !widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                                      maxLines: 2,
                                                      isRequired: true,
                                                      digitsOnly: false,
                                                      validator: (value) {
                                                        if (value == null || value.isEmpty) {
                                                          return 'Please enter product details';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: _buildTextField(
                                                      label: "HSN/SAC Code",
                                                      //hintText: "Enter HSN/SAC Codes",
                                                      controller: widget.vendorcontroller.vendorListModel.HSNcodeController,
                                                      readOnly: !widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                                      maxLines: 2,
                                                      isRequired: true,
                                                      digitsOnly: false,
                                                      validator: (value) {
                                                        if (value == null || value.isEmpty) {
                                                          return 'Please enter HSN/SAC Code';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  Expanded(
                                                    child: _buildTextField(
                                                      label: "Description",
                                                      //hintText: "Enter detailed description",
                                                      controller: widget.vendorcontroller.vendorListModel.descriptionOfProducts.value,
                                                      readOnly: !widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                                      maxLines: 3,
                                                      isRequired: true,
                                                      digitsOnly: false,
                                                      validator: (value) {
                                                        if (value == null || value.isEmpty) {
                                                          return 'Please enter description';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: _buildTextField(
                                                      label: "ISO Certification",
                                                      //hintText: "Enter ISO certification details",
                                                      controller: widget.vendorcontroller.vendorListModel.isoCertification.value,
                                                      readOnly: !widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                                      maxLines: 2,
                                                      isRequired: false,
                                                      digitsOnly: false,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  Expanded(
                                                    child: _buildTextField(
                                                      label: "Other Certifications",
                                                      //hintText: "Enter Other Certifications",
                                                      controller: widget.vendorcontroller.vendorListModel.otherCertification.value,
                                                      readOnly: !widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                                      maxLines: 3,
                                                      isRequired: false,
                                                      digitsOnly: false,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    _buildSection(
                                      title: "Bank Details",
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: _buildTextField(
                                                label: "Bank Name",
                                                //hintText: "Enter bank name",
                                                controller: widget.vendorcontroller.vendorListModel.vendorBankName.value,
                                                readOnly: !widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                                isRequired: true,
                                                digitsOnly: false,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter bank name';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: _buildTextField(
                                                label: "Account Number",
                                                //hintText: "Enter account number",
                                                controller: widget.vendorcontroller.vendorListModel.vendorBankAccountNumber.value,
                                                readOnly: !widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                                isRequired: true,
                                                digitsOnly: true,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter account number';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: _buildTextField(
                                                label: "IFSC Code",
                                                //hintText: "Enter IFSC code",
                                                controller: widget.vendorcontroller.vendorListModel.vendorBankIfsc.value,
                                                readOnly: !widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                                isRequired: true,
                                                digitsOnly: false,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter IFSC Code';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: _buildTextField(
                                                label: "Branch",
                                                // hintText: "Enter branch details",
                                                controller: widget.vendorcontroller.vendorListModel.vendorBankBranch.value,
                                                readOnly: !widget.vendorcontroller.vendorListModel.isFormEditable.value,
                                                isRequired: true,
                                                digitsOnly: false,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter bank branch';
                                                  }
                                                  return null;
                                                },
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
                  ),
                ],
              ),
            );
          })),
    );
  }
}

Future<File> convertUint8ListToFile(Uint8List data, String filename) async {
  // Get temporary directory (e.g., cache folder)
  final directory = await getTemporaryDirectory();

  // Create a path to save the file
  final filePath = '${directory.path}/$filename';

  // Write the Uint8List to the file
  final file = File(filePath);
  return await file.writeAsBytes(data);
}
