import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/VendorList_actions.dart';
// import 'package:ssipl_billing/5_VENDOR/controllers/Vendor_actions.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/VendorList_entities.dart';
import 'package:ssipl_billing/5_VENDOR/services/VendorList_service.dart';
// import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/THEMES/style.dart';

class VendorlistPage extends StatefulWidget {
  const VendorlistPage({super.key});

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
                  height: 500,
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
  // ... (keep existing autofill and initState methods)

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    bool readOnly = false,
    int? maxLines,
    TextInputType? keyboardType,
    double? width,
  }) {
    return SizedBox(
      width: width ?? 280, // Medium width default
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              decoration: BoxDecoration(
                color: readOnly ? Colors.grey[100] : Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
              child: TextFormField(
                controller: controller,
                readOnly: readOnly,
                maxLines: maxLines ?? 1,
                keyboardType: keyboardType,
                style: TextStyle(
                  color: readOnly ? Colors.grey[600] : Colors.black87,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 14,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileUploadField({
    required String label,
    required String? currentFile,
    required Function(File?) onFileChanged,
    double? width,
  }) {
    return SizedBox(
      width: width ?? 280, // Medium width default
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    if (currentFile != null && currentFile.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.attach_file, size: 18, color: Colors.blue),
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
                        padding: const EdgeInsets.all(8),
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
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[50],
                              foregroundColor: Colors.blue,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                            icon: const Icon(Icons.upload, size: 16),
                            label: const Text('Upload', style: TextStyle(fontSize: 13)),
                            onPressed: () async {
                              final result = await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
                              );
                              if (result != null) {
                                onFileChanged(File(result.files.single.path!));
                              }
                            },
                          ),
                        ),
                        if (currentFile != null && currentFile.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: IconButton(
                              icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                              onPressed: () => onFileChanged(null),
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
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 12.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.blue,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSectionContainer(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blueGrey[800]!,
                Colors.blueGrey[900]!,
              ],
            ),
          ),
        ),
        SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.85,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: DefaultTabController(
                length: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Vendor Details Editor",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white70),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    const Divider(height: 20, color: Colors.white24),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TabBar(
                        indicator: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.blue,
                        labelStyle: TextStyle(fontWeight: FontWeight.w500),
                        tabs: [
                          Tab(text: "KYC Information"),
                          Tab(text: "Business Info"),
                          Tab(text: "Bank & Documents"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Tab content
                    Expanded(
                      child: TabBarView(
                        children: [
                          // KYC Tab
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                _buildSectionContainer([
                                  buildSectionTitle("Basic Information"),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      buildTextField(
                                        label: "Vendor ID",
                                        controller: widget.controller.vendorListModel.vendor_IdController.value,
                                        readOnly: true,
                                        width: 180,
                                      ),
                                      buildTextField(
                                        label: "Vendor Name",
                                        controller: widget.controller.vendorListModel.vendor_NameController.value,
                                        width: 280,
                                      ),
                                      buildTextField(
                                        label: "Vendor Email",
                                        controller: widget.controller.vendorListModel.vendor_emailController.value,
                                        width: 280,
                                      ),
                                    ],
                                  ),
                                ]),
                                _buildSectionContainer([
                                  buildSectionTitle("Address Information"),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      buildTextField(
                                        label: "Address",
                                        controller: widget.controller.vendorListModel.vendor_addressController.value,
                                        width: 380,
                                        maxLines: 2,
                                      ),
                                      buildTextField(
                                        label: "State",
                                        controller: widget.controller.vendorListModel.vendor_stateController.value,
                                        width: 180,
                                      ),
                                      buildTextField(
                                        label: "Pincode",
                                        controller: widget.controller.vendorListModel.vendor_pincodeController.value,
                                        width: 120,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ],
                                  ),
                                ]),
                                _buildSectionContainer([
                                  buildSectionTitle("Contact Person"),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      buildTextField(
                                        label: "Contact Person Name",
                                        controller: widget.controller.vendorListModel.vendor_contactPersonNameController.value,
                                        width: 240,
                                      ),
                                      buildTextField(
                                        label: "Designation",
                                        controller: widget.controller.vendorListModel.vendor_contactPersonDesignationController.value,
                                        width: 200,
                                      ),
                                      buildTextField(
                                        label: "Phone Number",
                                        controller: widget.controller.vendorListModel.vendor_contactPersonPhoneController.value,
                                        width: 180,
                                        keyboardType: TextInputType.phone,
                                      ),
                                    ],
                                  ),
                                ]),
                              ],
                            ),
                          ),

                          // Business Information Tab
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                _buildSectionContainer([
                                  buildSectionTitle("Business Details"),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      buildTextField(
                                        label: "Business Type",
                                        controller: widget.controller.vendorListModel.vendor_businessTypeController.value,
                                        width: 220,
                                      ),
                                      buildTextField(
                                        label: "Year Established",
                                        controller: widget.controller.vendorListModel.vendor_yearOfEstablishmentController.value,
                                        width: 160,
                                      ),
                                      buildTextField(
                                        label: "GST Number",
                                        controller: widget.controller.vendorListModel.vendor_gstNumberController.value,
                                        width: 200,
                                      ),
                                      buildTextField(
                                        label: "PAN Number",
                                        controller: widget.controller.vendorListModel.vendor_panNumberController.value,
                                        width: 200,
                                      ),
                                      buildTextField(
                                        label: "Annual Turnover (₹)",
                                        controller: widget.controller.vendorListModel.vendor_annualTurnoverController.value,
                                        width: 180,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ],
                                  ),
                                ]),
                                _buildSectionContainer([
                                  buildSectionTitle("Products/Services"),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      buildTextField(
                                        label: "Product/Service List",
                                        controller: widget.controller.vendorListModel.vendor_productOrServiceListController.value,
                                        width: 300,
                                        maxLines: 2,
                                      ),
                                      buildTextField(
                                        label: "HSN/SAC Code",
                                        controller: widget.controller.vendorListModel.vendor_hsnOrSacCodeController.value,
                                        width: 160,
                                        keyboardType: TextInputType.number,
                                      ),
                                      buildTextField(
                                        label: "Description",
                                        controller: widget.controller.vendorListModel.vendor_productOrServiceDescriptionController.value,
                                        width: 380,
                                        maxLines: 3,
                                      ),
                                    ],
                                  ),
                                ]),
                                _buildSectionContainer([
                                  buildSectionTitle("Certifications"),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      buildTextField(
                                        label: "ISO Certification",
                                        controller: widget.controller.vendorListModel.vendor_isoCertificationController.value,
                                        width: 240,
                                      ),
                                      buildTextField(
                                        label: "Other Certifications",
                                        controller: widget.controller.vendorListModel.vendor_otherCertificationsController.value,
                                        width: 300,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ]),
                              ],
                            ),
                          ),

                          // Bank & Documents Tab
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                _buildSectionContainer([
                                  buildSectionTitle("Bank Details"),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      buildTextField(
                                        label: "Bank Name",
                                        controller: widget.controller.vendorListModel.vendor_bankNameController.value,
                                        width: 280,
                                      ),
                                      buildTextField(
                                        label: "Branch",
                                        controller: widget.controller.vendorListModel.vendor_branchController.value,
                                        width: 220,
                                      ),
                                      buildTextField(
                                        label: "Account Number",
                                        controller: widget.controller.vendorListModel.vendor_accountNumberController.value,
                                        width: 220,
                                        keyboardType: TextInputType.number,
                                      ),
                                      buildTextField(
                                        label: "IFSC Code",
                                        controller: widget.controller.vendorListModel.vendor_ifscCodeController.value,
                                        width: 160,
                                      ),
                                    ],
                                  ),
                                ]),
                                _buildSectionContainer([
                                  buildSectionTitle("Document Uploads"),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      _buildFileUploadField(
                                        label: "Registration Certificate",
                                        currentFile: '${widget.data.value.registrationCertificate}',
                                        onFileChanged: (file) {
                                          widget.controller.vendorListModel.vendor_registrationCertificate.value = file != null ? Uint8List.fromList(file.readAsBytesSync()) : null;
                                        },
                                        width: 280,
                                      ),
                                      _buildFileUploadField(
                                        label: "PAN Document",
                                        currentFile: '${widget.data.value.panUpload}',
                                        onFileChanged: (file) {
                                          widget.controller.vendorListModel.vendor_panUpload.value = file != null ? Uint8List.fromList(file.readAsBytesSync()) : null;
                                        },
                                        width: 280,
                                      ),
                                      _buildFileUploadField(
                                        label: "Cancelled Cheque",
                                        currentFile: '${widget.data.value.cancelledCheque}',
                                        onFileChanged: (file) {
                                          widget.controller.vendorListModel.vendor_cancelledCheque.value = file != null ? Uint8List.fromList(file.readAsBytesSync()) : null;
                                        },
                                        width: 280,
                                      ),
                                    ],
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Footer buttons
                    Container(
                      padding: const EdgeInsets.only(top: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[900],
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white70),
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                              elevation: 2,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () async {
                              // Submit action
                            },
                            child: const Text("Save Vendor Details"),
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
      ],
    );
  }
}
