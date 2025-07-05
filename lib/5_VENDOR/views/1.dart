// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:ssipl_billing/7_HIERARCHY/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/7_HIERARCHY/views/ORG/Org_card.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/NOTIFICATION-/NotificationServices.dart';
import 'package:ssipl_billing/NOTIFICATION-/Notification_actions.dart';
import 'package:ssipl_billing/THEMES/style.dart';

class VendorListPage extends StatefulWidget with BellIconFunction {
  VendorListPage({super.key});

  @override
  State<VendorListPage> createState() => _VendorListPageState();
}

class _VendorListPageState extends State<VendorListPage> with SingleTickerProviderStateMixin {
  //  final VoucherController voucherController = Get.find<VoucherController>();
  // final MainBilling_Controller mainBilling_Controller = Get.find<MainBilling_Controller>();
  // late AnimationController animationController;
  final searchController = TextEditingController().obs;

  final HierarchyController hierarchyController = Get.find<HierarchyController>();

  final NotificationController notificationController = Get.find<NotificationController>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      // widget.resetvoucherFilters();
      // await widget.get_VoucherList();
      // await widget.Get_SUBcustomerList();
      // await widget.Get_SALEScustomerList();

      // Initialize checkboxValues after data is loaded
      // voucherController.voucherModel.checkboxValues = List<bool>.filled(voucherController.voucherModel.voucher_list.length, false).obs;
    });
    await Future.delayed(const Duration(seconds: 1));
    loader.stop();
  }

  // void _startAnimation() {
  //   if (!animationController.isAnimating) {
  //     animationController.forward(from: 0).then((_) {
  //       widget.billing_refresh();
  //     });
  //   }
  // }

  // final GlobalKey _invoiceCopyKey = GlobalKey();
  // final GlobalKey _voucherCopyKey = GlobalKey();
  // final GlobalKey _GSTcopyKey = GlobalKey();

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
   

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Primary_colors.Dark,
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(8)),
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
                          const SizedBox(width: 8),
                          const Text(
                            'Vendor List',
                            style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text13),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  print('Manual onboard selected');
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

                        Obx(() {
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
                                      )),
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
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        // MouseRegion(
                        //   cursor: SystemMouseCursors.click,
                        //   child: GestureDetector(
                        //     onTap: _startAnimation,
                        //     child: AnimatedBuilder(
                        //       animation: animationController,
                        //       builder: (context, child) {
                        //         return Transform.rotate(
                        //           angle: animationController.value * 2 * pi, // Counterclockwise rotation
                        //           child: Transform.scale(
                        //             scale: TweenSequence([
                        //               TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.2), weight: 50),
                        //               TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 1.0), weight: 50),
                        //             ]).animate(CurvedAnimation(parent: animationController, curve: Curves.easeInOut)).value, // Zoom in and return to normal
                        //             child: Opacity(
                        //               opacity: TweenSequence([
                        //                 TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.5), weight: 50),
                        //                 TweenSequenceItem(tween: Tween<double>(begin: 0.5, end: 1.0), weight: 50),
                        //               ]).animate(CurvedAnimation(parent: animationController, curve: Curves.easeInOut)).value, // Fade and return to normal
                        //               child: ClipOval(
                        //                 child: Image.asset(
                        //                   'assets/images/reload.png',
                        //                   fit: BoxFit.cover,
                        //                   width: 30,
                        //                   height: 30,
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         );
                        //       },
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 400,
                          height: 40,
                          child: TextFormField(
                            controller: searchController.value,
                            // onChanged: (value) => widget.search(value),
                            style: const TextStyle(fontSize: 13, color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(1),
                              filled: true,
                              fillColor: Primary_colors.Light,
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                              hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 167, 165, 165)),
                              hintText: 'Search from the List',
                              prefixIcon: const Icon(Icons.search, color: Colors.white),
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
          const SizedBox(height: 15),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Obx(() {
                      return Container(
                        padding: const EdgeInsets.all(8),
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
                        child: hierarchyController.hierarchyModel.OrganizationList.value.Live.isNotEmpty
                            ? SizedBox(
                                // child: Padding(
                                //     padding: const EdgeInsets.all(2),
                                child: SingleChildScrollView(
                                child: SlideTransition(
                                  position: hierarchyController.hierarchyModel.slideAnimation,
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.all(8.0),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: hierarchyController.hierarchyModel.Org_cardCount.value,
                                      crossAxisSpacing: 30,
                                      mainAxisSpacing: 30,
                                    ),
                                    itemCount: hierarchyController.hierarchyModel.OrganizationList.value.Live.length,
                                    itemBuilder: (context, index) {
                                      var org = hierarchyController.hierarchyModel.OrganizationList.value.Live[index];
                                      return OrganizationCard(
                                        name: org.organizationName ?? "",
                                        id: org.organizationId ?? 0,
                                        email: org.email ?? "",
                                        imageBytes: org.organizationLogo!,
                                        index: index,
                                        data: hierarchyController.hierarchyModel.OrganizationList.value,
                                        controller: hierarchyController,
                                        isSelected: org.isSelected,
                                        type: "LIVE",
                                      );
                                    },
                                  ),
                                ),
                              ))
                            // )
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
                                        'No Live Organization Found',
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
                                        'When you add live organization, they will appear here',
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
                    }),
                  ),
                  SizedBox(
                    width: 20,
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
                                          const Divider(color: Color.fromARGB(255, 122, 121, 121),height: 0.5,),
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
          ),

          // SizedBox(
          //   width: 10,
          // ),
          // Expanded(flex: 1, child: Container()), // Placeholder for any additional content
        ],
      ),
    );
  }
}

String formatDateVoucher(DateTime date) {
  return DateFormat('dd-MM-yyyy').format(date);
}

Widget buildTextField(String label, TextEditingController controller, bool readOnly) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(color: Primary_colors.Color9, fontSize: Primary_font_size.Text8),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "  : ",
            style: TextStyle(color: Primary_colors.Color9, fontSize: Primary_font_size.Text8),
          ),
        ),
        Expanded(
          flex: 4,
          child: TextFormField(
            maxLines: null,
            readOnly: readOnly,
            controller: controller,
            onChanged: (value) {}, // ✅ Avoids unnecessary Obx()
            style: TextStyle(color: readOnly ? const Color.fromARGB(255, 167, 167, 167) : Primary_colors.Color1, fontSize: Primary_font_size.Text8),
            decoration: InputDecoration(
              fillColor: Colors.black,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: readOnly ? Colors.white : Primary_colors.Color3, width: 2),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 94, 94, 94), width: 1),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            ),
          ),
        ),
      ],
    ),
  );
}
