// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/PO_actions.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/Vendor_actions.dart';
// import 'package:ssipl_billing/5_VENDOR/controllers/Sales_actions.dart';
import 'package:ssipl_billing/5_VENDOR/services/PO_services/PO_Details_service.dart';
import 'package:ssipl_billing/5_VENDOR/views/Generate_PO/PO_details.dart';
import 'package:ssipl_billing/5_VENDOR/views/Generate_PO/PO_note.dart';
import 'package:ssipl_billing/5_VENDOR/views/Generate_PO/PO_products.dart';
import 'package:ssipl_billing/5_VENDOR/views/Generate_PO/post_PO.dart';
// import 'package:ssipl_billing/COMPONENTS-/PDF_methods/PDFviewonly.dart';
import 'package:ssipl_billing/THEMES/style.dart';

class GeneratePo extends StatefulWidget with PodetailsService {
  GeneratePo({
    super.key,
  });

  @override
  _GeneratePoState createState() => _GeneratePoState();
}

class _GeneratePoState extends State<GeneratePo> with SingleTickerProviderStateMixin {
  final vendor_PoController poController = Get.find<vendor_PoController>();
  final VendorController vendorController = Get.find<VendorController>();
  @override
  void initState() {
    super.initState();
    // GeneratePo._tabController = ;
    poController.initializeTabController(TabController(length: 4, vsync: this));

    widget.get_requiredData(context);
    widget.get_noteSuggestionList(context);
  }

  @override
  void dispose() {
    // GeneratePo._tabController.dispose();
    poController.poModel.tabController.value?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Primary_colors.Dark,
        body: Row(
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "QUOTATION",
                    style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 420,
                    // decoration: BoxDecoration(
                    //   border: Border.all(width: 3, color: const Color.fromARGB(255, 161, 232, 250)),
                    // ),
                    child: GestureDetector(
                      child: Stack(
                        children: [
                          // if (vendorController.vendorModel.pdfFile.value != null)
                          // PDFviewonly.dialogWidget(vendorController.vendorModel.pdfFile.value!),
                          Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      onDoubleTap: () {
                        // PDFviewonly(context, vendorController.vendorModel.pdfFile.value!);
                        // _showReadablePdf();
                      },
                    ),
                  ),
                )
              ],
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    // Primary_colors.Dark,
                    Color.fromARGB(255, 4, 6, 10), // Slightly lighter blue-grey
                    Primary_colors.Light, // Dark purple/blue
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    color: Primary_colors.Dark,
                    child: PreferredSize(
                      preferredSize: const Size.fromHeight(50),
                      child: IgnorePointer(
                        child: TabBar(
                          unselectedLabelStyle: const TextStyle(
                            color: Primary_colors.Color1,
                            fontSize: Primary_font_size.Text7,
                          ),
                          labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 227, 77, 60),
                            fontSize: Primary_font_size.Text10,
                            fontWeight: FontWeight.bold,
                          ),
                          controller: poController.poModel.tabController.value,
                          indicator: const BoxDecoration(),
                          tabs: const [
                            Tab(text: "DETAILS"),
                            Tab(text: "PRODUCT"),
                            Tab(text: "NOTE"),
                            Tab(text: "POST"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: poController.poModel.tabController.value,
                      children: [
                        PoDetails(),
                        PoProducts(),
                        PoNote(),
                        PostPo(type: 'E:/${(poController.poModel.Po_no.value ?? "default_filename").replaceAll("/", "-")}.pdf'
                            // Pass the expected file path
                            ),
                      ],
                    ),
                  ),
                ],
              ),
            ))
          ],
        ));
  }
}
