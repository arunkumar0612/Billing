import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
// import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/VendorList_actions.dart';
// import 'package:ssipl_billing/5_VENDOR/controllers/Vendor_actions.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/VendorList_entities.dart';
import 'package:ssipl_billing/5_VENDOR/services/VendorList_service.dart';
import 'package:ssipl_billing/5_VENDOR/services/manual_onboard_service.dart';
// import 'package:ssipl_billing/5_VENDOR/views/Manual_onboard/show_Manual_onboard.dart';
// import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/THEMES/style.dart';

class VendorlistPage extends StatefulWidget with ManualOnboardService {
  VendorlistPage({super.key});

  @override
  State<VendorlistPage> createState() => _VendorlistPageState();
}

class _VendorlistPageState extends State<VendorlistPage> with TickerProviderStateMixin {
  final VendorListController vendorListController = Get.find<VendorListController>();
  @override
  void initState() {
    super.initState();
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
                            color: Primary_colors.Color3, // Customize the button background color
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
                ],
              ),
            ],
          ),
          Expanded(
            child: Row(
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
                              Obx(
                                () {
                                  return Container(
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
                                    child: vendorListController.vendorListModel.VendorList.isNotEmpty
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
                                              itemCount: vendorListController.vendorListModel.VendorList.length,
                                              itemBuilder: (context, index) {
                                                var Vendor = vendorListController.vendorListModel.VendorList[index];
                                                return VendorCard(
                                                  name: Vendor.vendorName ?? '',
                                                  id: Vendor.vendorId ?? 0,
                                                  email: Vendor.email ?? '',
                                                  imageBytes: Vendor.vendorLogo ?? Uint8List(0),
                                                  index: index,
                                                  data: vendorListController.vendorListModel.VendorList,
                                                  controller: vendorListController,
                                                  isSelected: vendorListController.vendorListModel.VendorList[index].isSelected,
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
                                                    'No Live Vendor Found',
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
                                                    'When you add live vendor, they will appear here',
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
                                  );
                                },
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
            ),
          ),
        ],
      ),
    );
  }
}

class VendorCard extends StatefulWidget with VendorListService {
  final String name;
  final String email;
  final int id;
  final Uint8List imageBytes;
  final int index;
  final List<VendorsData> data; // Changed from VendorsData to List<VendorsData>
  final VendorListController controller;
  final bool isSelected;
  final double screenWidth;
  final Rx<VendorsData> selecteddata;
  // final VendorListController controller;
  VendorCard({
    super.key,
    required this.name,
    required this.email,
    required this.id,
    required this.imageBytes,
    required this.index,
    required this.data, // updated here
    required this.controller,
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
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.controller.onVendorSelected(widget.data, widget.index);
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
                    screenWidth: widget.screenWidth,
                    data: widget.selecteddata,
                    controller: widget.vendorListController,
                  ),
                );
              },
            );
            widget.controller.onVendorDeselected(widget.data);
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
                              icon: const Icon(Icons.edit_square, size: 15, color: Color.fromARGB(255, 110, 110, 110)),
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
                            widget.controller.vendorListModel.VendorList[widget.index].vendorName ?? "",
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

class VendorEditor extends StatefulWidget {
  final double screenWidth;
  final Rx<VendorsData> data;
  final VendorListController controller;

  const VendorEditor({
    super.key,
    required this.screenWidth,
    required this.data,
    required this.controller,
  });

  @override
  _VendorEditorState createState() => _VendorEditorState();
}

class _VendorEditorState extends State<VendorEditor> {
  final _formKey = GlobalKey<FormState>();
  File? _logoFile;

  Future<void> _pickLogo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        _logoFile = File(result.files.single.path!);
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
          ElevatedButton.icon(
            icon: const Icon(Icons.save, size: 18),
            label: const Text("Save Changes"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Save logic
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLogoSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Primary_colors.Dark,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Text(
          //   "Vendor Logo",
          //   style: TextStyle(
          //     fontSize: 16,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.blueGrey,
          //   ),
          // ),
          // const SizedBox(height: 5),
          Center(
            child: GestureDetector(
              onTap: _pickLogo,
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
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add_a_photo, color: Colors.grey, size: 32),
                          const SizedBox(height: 8),
                          Text(
                            "Upload Logo",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    bool isRequired = false,
    TextInputType? keyboardType,
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
            keyboardType: keyboardType,
            maxLines: 1, // ⬅️ ensure single-line for correct height alignment
            readOnly: readOnly,
            style: const TextStyle(fontSize: 12, color: Primary_colors.Color1), // optional: adjust font size
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[500], fontSize: 12),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0), // ⬅️ minimize vertical padding
              isCollapsed: true, // ⬅️ important to reduce internal height
              border: InputBorder.none,
            ),
            validator: (value) {
              if (isRequired && (value == null || value.isEmpty)) {
                return 'This field is required';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildFileUploadField({
    required String label,
    required String? currentFile,
    required Function(File?) onFileChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.blueGrey,
          ),
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
                        icon: const Icon(Icons.download, size: 18, color: Colors.blue),
                        onPressed: () {
                          // Implement download
                        },
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
                        foregroundColor: Colors.blue,
                        side: const BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onPressed: () async {
                        final result = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
                        );
                        if (result != null) {
                          onFileChanged(
                            File(result.files.single.path!),
                          );
                        }
                      },
                    ),
                  ),
                  if (currentFile != null && currentFile.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 20,
                        ),
                        onPressed: () => onFileChanged(null),
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
        child: Form(
          key: _formKey,
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
                                      hintText: "Enter vendor ID",
                                      controller: widget.controller.vendorListModel.vendor_IdController.value,
                                      readOnly: true,
                                    ),
                                    _buildTextField(
                                      label: "Vendor Name",
                                      hintText: "Enter vendor name",
                                      controller: widget.controller.vendorListModel.vendor_NameController.value,
                                      isRequired: true,
                                    ),
                                    _buildTextField(
                                      label: "Vendor Email",
                                      hintText: "Enter vendor email",
                                      controller: widget.controller.vendorListModel.vendor_emailController.value,
                                      isRequired: true,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
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
                                            label: "Registration Certificate",
                                            currentFile: '${widget.data.value.registrationCertificate}',
                                            onFileChanged: (file) {
                                              widget.controller.vendorListModel.vendor_registrationCertificate.value = file != null ? Uint8List.fromList(file.readAsBytesSync()) : null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: _buildFileUploadField(
                                            label: "PAN Document",
                                            currentFile: '${widget.data.value.panUpload}',
                                            onFileChanged: (file) {
                                              widget.controller.vendorListModel.vendor_panUpload.value = file != null ? Uint8List.fromList(file.readAsBytesSync()) : null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: _buildFileUploadField(
                                            label: "Cancelled Cheque",
                                            currentFile: '${widget.data.value.cancelledCheque}',
                                            onFileChanged: (file) {
                                              widget.controller.vendorListModel.vendor_cancelledCheque.value = file != null ? Uint8List.fromList(file.readAsBytesSync()) : null;
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
                                            hintText: "Enter contact person name",
                                            controller: widget.controller.vendorListModel.vendor_contactPersonNameController.value,
                                            isRequired: true,
                                          ),
                                          _buildTextField(
                                            label: "Designation",
                                            hintText: "Enter designation",
                                            controller: widget.controller.vendorListModel.vendor_contactPersonDesignationController.value,
                                          ),
                                          _buildTextField(
                                            label: "Phone Number",
                                            hintText: "Enter phone number",
                                            controller: widget.controller.vendorListModel.vendor_contactPersonPhoneController.value,
                                            keyboardType: TextInputType.phone,
                                          ),
                                          _buildTextField(
                                            label: "Address",
                                            hintText: "Enter full address",
                                            controller: widget.controller.vendorListModel.vendor_addressController.value,
                                            maxLines: 2,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: _buildTextField(
                                                  label: "State",
                                                  hintText: "Enter state",
                                                  controller: widget.controller.vendorListModel.vendor_stateController.value,
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: _buildTextField(
                                                  label: "Pincode",
                                                  hintText: "Enter pincode",
                                                  controller: widget.controller.vendorListModel.vendor_pincodeController.value,
                                                  keyboardType: TextInputType.number,
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
                                                  hintText: "Enter business type",
                                                  controller: widget.controller.vendorListModel.vendor_businessTypeController.value,
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: _buildTextField(
                                                  label: "Year Established",
                                                  hintText: "Enter year",
                                                  controller: widget.controller.vendorListModel.vendor_yearOfEstablishmentController.value,
                                                  keyboardType: TextInputType.number,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: _buildTextField(
                                                  label: "GST Number",
                                                  hintText: "Enter GST number",
                                                  controller: widget.controller.vendorListModel.vendor_gstNumberController.value,
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: _buildTextField(
                                                  label: "PAN Number",
                                                  hintText: "Enter PAN number",
                                                  controller: widget.controller.vendorListModel.vendor_panNumberController.value,
                                                ),
                                              ),
                                            ],
                                          ),
                                          _buildTextField(
                                            label: "Annual Turnover",
                                            hintText: "Enter annual turnover",
                                            controller: widget.controller.vendorListModel.vendor_annualTurnoverController.value,
                                            keyboardType: TextInputType.number,
                                          ),
                                          _buildTextField(
                                            label: "Products/Services",
                                            hintText: "List products or services",
                                            controller: widget.controller.vendorListModel.vendor_productOrServiceListController.value,
                                            maxLines: 2,
                                          ),
                                          _buildTextField(
                                            label: "Description",
                                            hintText: "Enter detailed description",
                                            controller: widget.controller.vendorListModel.vendor_productOrServiceDescriptionController.value,
                                            maxLines: 3,
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
                                            hintText: "Enter bank name",
                                            controller: widget.controller.vendorListModel.vendor_bankNameController.value,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: _buildTextField(
                                            label: "Account Number",
                                            hintText: "Enter account number",
                                            controller: widget.controller.vendorListModel.vendor_accountNumberController.value,
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildTextField(
                                            label: "IFSC Code",
                                            hintText: "Enter IFSC code",
                                            controller: widget.controller.vendorListModel.vendor_ifscCodeController.value,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: _buildTextField(
                                            label: "Branch",
                                            hintText: "Enter branch details",
                                            controller: widget.controller.vendorListModel.vendor_branchController.value,
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
                      // const SizedBox(height: 16),
                      // Container(
                      //   padding: const EdgeInsets.all(16),
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(12),
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.grey.withOpacity(0.1),
                      //         blurRadius: 6,
                      //         offset: const Offset(0, 3),
                      //       ),
                      //     ],
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       OutlinedButton(
                      //         style: OutlinedButton.styleFrom(
                      //           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      //           side: const BorderSide(color: Colors.blue),
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(8),
                      //           ),
                      //         ),
                      //         onPressed: () => Navigator.of(context).pop(),
                      //         child: const Text(
                      //           "Cancel",
                      //           style: TextStyle(color: Colors.blue),
                      //         ),
                      //       ),
                      //       const SizedBox(width: 16),
                      //       ElevatedButton(
                      //         style: ElevatedButton.styleFrom(
                      //           backgroundColor: Colors.blue,
                      //           foregroundColor: Colors.white,
                      //           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(8),
                      //           ),
                      //         ),
                      //         onPressed: () {
                      //           if (_formKey.currentState!.validate()) {
                      //             // Save logic
                      //           }
                      //         },
                      //         child: const Text("Save Vendor Details"),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
