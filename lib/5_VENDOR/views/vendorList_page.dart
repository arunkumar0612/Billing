import 'dart:typed_data';

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
    {'name': 'Arun Kumar', 'Date': '10-12-2024', 'email': true, 'whatsapp': false, 'phone': '1234567890', 'email_id': 'arun.kumar@sporadasecure.com'},
    {'name': 'Ganesh Kumar', 'Date': '10-12-2024', 'email': true, 'whatsapp': true, 'phone': '9498804981', 'email_id': 'ganesh.kumar@sporadasecure.com'},
    {'name': 'Rambo', 'Date': '10-12-2024', 'email': true, 'whatsapp': true, 'phone': '1234567890', 'email_id': 'rambo@sporadasecure.com'},
    {'name': 'Nidya Panneerselvam', 'Date': '10-12-2024', 'email': false, 'whatsapp': true, 'phone': '9498804981', 'email_id': 'nidya.p@sporadasecure.com'},
    {'name': 'Sydney Sherold', 'Date': '10-12-2024', 'email': true, 'whatsapp': true, 'phone': '1234567890', 'email_id': 'sydney.s@sporadasecure.com'},
    {'name': 'John Doe', 'Date': '10-12-2024', 'email': true, 'whatsapp': false, 'phone': '9498804981', 'email_id': 'john.doe@sporadasecure.com'},
    {'name': 'Hari Prasath', 'Date': '10-12-2024', 'email': false, 'whatsapp': true, 'phone': '9498804981', 'email_id': 'hariprasath.s@sporadasecure.com'},
    {'name': 'Arun Kumar', 'Date': '10-12-2024', 'email': true, 'whatsapp': false, 'phone': '1234567890', 'email_id': 'arun.kumar@sporadasecure.com'},
    {'name': 'Ganesh Kumar', 'Date': '10-12-2024', 'email': true, 'whatsapp': true, 'phone': '9498804981', 'email_id': 'ganesh.kumar@sporadasecure.com'},
    {'name': 'Rambo', 'Date': '10-12-2024', 'email': true, 'whatsapp': true, 'phone': '1234567890', 'email_id': 'rambo@sporadasecure.com'},
    {'name': 'Nidya Panneerselvam', 'Date': '10-12-2024', 'email': false, 'whatsapp': true, 'phone': '9498804981', 'email_id': 'nidya.p@sporadasecure.com'},
    {'name': 'Sydney Sherold', 'Date': '10-12-2024', 'email': true, 'whatsapp': true, 'phone': '1234567890', 'email_id': 'sydney.s@sporadasecure.com'},
    {'name': 'John Doe', 'Date': '10-12-2024', 'email': true, 'whatsapp': false, 'phone': '9498804981', 'email_id': 'john.doe@sporadasecure.com'},
    {'name': 'Hari Prasath', 'Date': '10-12-2024', 'email': false, 'whatsapp': true, 'phone': '9498804981', 'email_id': 'hariprasath.s@sporadasecure.com'},
    {'name': 'Arun Kumar', 'Date': '10-12-2024', 'email': true, 'whatsapp': false, 'phone': '1234567890', 'email_id': 'arun.kumar@sporadasecure.com'},
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
                                                  email: Vendor.emailId ?? '',
                                                  imageBytes: Vendor.vendorLogo!,
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
                            widget.controller.vendorListModel.VendorList[widget.index].clientAddress ?? "",
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
  void autofill() {
    final model = widget.controller.vendorListModel;
    final data = widget.data.value;

    model.vendor_IdController.value.text = (data.vendorId ?? "").toString();
    model.vendor_NameController.value.text = data.vendorName ?? "";
    model.vendor_CodeController.value.text = data.vendorCode ?? "";
    model.vendor_clientAddressNameController.value.text = data.clientAddressName ?? "";
    model.vendor_clientAddressController.value.text = data.clientAddress ?? "";
    model.vendor_gstNumberController.value.text = data.gstNumber ?? "";
    model.vendor_emailIdController.value.text = data.emailId ?? "";
    model.vendor_contactNumberController.value.text = data.contactNumber ?? "";
    model.vendor_contact_personController.value.text = data.contact_person ?? "";
    model.vendor_billingAddressController.value.text = data.billingAddress ?? "";
    model.vendor_billingAddressNameController.value.text = data.billingAddressName ?? "";
    model.vendor_siteTypeController.value.text = data.siteType ?? "";
    model.vendor_subscriptionIdController.value.text = (data.subscriptionId ?? "").toString();
    model.vendor_billingPlanController.value.text = data.billingPlan ?? "";
    model.vendor_billModeController.value.text = data.billMode ?? "";
    model.vendor_fromDateController.value.text = data.fromDate ?? "";
    model.vendor_toDateController.value.text = data.toDate ?? "";
    model.vendor_amountController.value.text = (data.amount ?? "").toString();
    model.vendor_billingPeriodController.value.text = (data.billingPeriod ?? "").toString();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    autofill();
    ever(widget.data, (_) => autofill());
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    bool readOnly = false,
    int? maxLines,
    TextInputType? keyboardType,
  }) {
    return Padding(
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
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              color: readOnly ? Colors.grey[100] : Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
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
                  vertical: 12,
                  horizontal: 12,
                ),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 1.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: false,
                fillColor: readOnly ? Colors.grey[100] : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDateField({
    required String label,
    required TextEditingController controller,
  }) {
    return Padding(
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
          const SizedBox(height: 4),
          InkWell(
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        surface: Colors.white,
                        onSurface: Colors.black,
                      ),
                      dialogBackgroundColor: Colors.white,
                    ),
                    child: child!,
                  );
                },
              );
              if (picked != null) {
                controller.text = DateFormat('yyyy-MM-dd').format(picked);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IgnorePointer(
                child: TextFormField(
                  controller: controller,
                  readOnly: true,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
                    suffixIcon: const Icon(Icons.calendar_today, size: 18),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.blue,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 24, 46, 78),
                Color.fromARGB(255, 15, 22, 46),
                // Color.fromARGB(255, 15, 22, 46),
                // // Color.fromARGB(255, 31, 45, 95),
                // Color.fromARGB(255, 56, 66, 103),
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
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Edit Vendor Details",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 204, 203, 203),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.grey),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    const Divider(height: 20, thickness: 1),

                    const TabBar(
                      indicatorColor: Colors.blue,
                      labelColor: Colors.blue,
                      unselectedLabelColor: Colors.grey,
                      labelStyle: TextStyle(fontWeight: FontWeight.w500),
                      tabs: [
                        Tab(text: "KYC Information"),
                        Tab(text: "Package Details"),
                      ],
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
                                buildSectionTitle("Basic Information"),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: buildTextField(
                                        label: "Vendor ID",
                                        controller: widget.controller.vendorListModel.vendor_IdController.value,
                                        readOnly: true,
                                      ),
                                    ),
                                    Expanded(
                                      child: buildTextField(
                                        label: "Vendor Name",
                                        controller: widget.controller.vendorListModel.vendor_NameController.value,
                                        readOnly: true,
                                      ),
                                    ),
                                    Expanded(
                                      child: buildTextField(
                                        label: "Vendor Code",
                                        controller: widget.controller.vendorListModel.vendor_CodeController.value,
                                      ),
                                    ),
                                  ],
                                ),
                                buildSectionTitle("Contact Information"),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: buildTextField(
                                        label: "Contact Person",
                                        controller: widget.controller.vendorListModel.vendor_contact_personController.value,
                                      ),
                                    ),
                                    Expanded(
                                      child: buildTextField(
                                        label: "Contact Number",
                                        controller: widget.controller.vendorListModel.vendor_contactNumberController.value,
                                        keyboardType: TextInputType.phone,
                                      ),
                                    ),
                                    Expanded(
                                      child: buildTextField(
                                        label: "Email ID",
                                        controller: widget.controller.vendorListModel.vendor_emailIdController.value,
                                        keyboardType: TextInputType.emailAddress,
                                      ),
                                    ),
                                  ],
                                ),
                                buildSectionTitle("Address Information"),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: buildTextField(
                                        label: "Client Address Name",
                                        controller: widget.controller.vendorListModel.vendor_clientAddressNameController.value,
                                      ),
                                    ),
                                    Expanded(
                                      child: buildTextField(
                                        label: "Billing Address Name",
                                        controller: widget.controller.vendorListModel.vendor_billingAddressNameController.value,
                                      ),
                                    ),
                                    Expanded(
                                      child: buildTextField(
                                        label: "Site Type",
                                        controller: widget.controller.vendorListModel.vendor_siteTypeController.value,
                                        readOnly: true,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: buildTextField(
                                        label: "Client Address",
                                        controller: widget.controller.vendorListModel.vendor_clientAddressController.value,
                                        maxLines: 2,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: buildTextField(
                                        label: "Billing Address",
                                        controller: widget.controller.vendorListModel.vendor_billingAddressController.value,
                                        maxLines: 2,
                                      ),
                                    ),
                                    Expanded(
                                      child: buildTextField(
                                        label: "GST Number",
                                        controller: widget.controller.vendorListModel.vendor_gstNumberController.value,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Package Tab
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                buildSectionTitle("Subscription Details"),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: buildTextField(
                                        label: "Subscription ID",
                                        controller: widget.controller.vendorListModel.vendor_subscriptionIdController.value,
                                        readOnly: true,
                                      ),
                                    ),
                                    Expanded(
                                      child: buildTextField(
                                        label: "Billing Plan",
                                        controller: widget.controller.vendorListModel.vendor_billingPlanController.value,
                                      ),
                                    ),
                                    Expanded(
                                      child: buildTextField(
                                        label: "Bill Mode",
                                        controller: widget.controller.vendorListModel.vendor_billModeController.value,
                                      ),
                                    ),
                                  ],
                                ),
                                buildSectionTitle("Billing Period"),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: buildDateField(
                                        label: "From Date",
                                        controller: widget.controller.vendorListModel.vendor_fromDateController.value,
                                      ),
                                    ),
                                    Expanded(
                                      child: buildDateField(
                                        label: "To Date",
                                        controller: widget.controller.vendorListModel.vendor_toDateController.value,
                                      ),
                                    ),
                                    Expanded(
                                      child: buildTextField(
                                        label: "Billing Period (Days)",
                                        controller: widget.controller.vendorListModel.vendor_billingPeriodController.value,
                                        readOnly: true,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ],
                                ),
                                buildSectionTitle("Payment Information"),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: buildTextField(
                                        label: "Amount",
                                        controller: widget.controller.vendorListModel.vendor_amountController.value,
                                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                                      ),
                                    ),
                                    const Spacer(flex: 2),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Divider(height: 20, thickness: 1),

                    // Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            // Submit action
                          },
                          child: const Text("Update Vendor"),
                        ),
                      ],
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
