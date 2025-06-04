// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:intl/intl.dart';
import 'package:ssipl_billing/7.HIERARCHY/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/7.HIERARCHY/models/entities/Hierarchy_entities.dart';
import 'package:ssipl_billing/7.HIERARCHY/services/Branch_service.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/THEMES/style.dart';

class BranchEditor extends StatefulWidget with BranchService {
  final double screenWidth;
  final Rx<BranchsData> data;
  final HierarchyController controller;

  BranchEditor({
    super.key,
    required this.screenWidth,
    required this.data,
    required this.controller,
  });

  @override
  _BranchEditorState createState() => _BranchEditorState();
}

class _BranchEditorState extends State<BranchEditor> {
  void autofill() {
    widget.controller.hierarchyModel.branch_IdController.value.text = (widget.data.value.branchId ?? "").toString();
    widget.controller.hierarchyModel.branch_NameController.value.text = widget.data.value.branchName ?? "";
    widget.controller.hierarchyModel.branch_CodeController.value.text = widget.data.value.branchCode ?? "";
    widget.controller.hierarchyModel.branch_clientAddressNameController.value.text = widget.data.value.clientAddressName ?? "";
    widget.controller.hierarchyModel.branch_clientAddressController.value.text = widget.data.value.clientAddress ?? "";
    widget.controller.hierarchyModel.branch_gstNumberController.value.text = widget.data.value.gstNumber ?? "";
    widget.controller.hierarchyModel.branch_emailIdController.value.text = widget.data.value.emailId ?? "";
    widget.controller.hierarchyModel.branch_contactNumberController.value.text = widget.data.value.contactNumber ?? "";
    widget.controller.hierarchyModel.branch_contact_personController.value.text = widget.data.value.contact_person ?? "";
    widget.controller.hierarchyModel.branch_billingAddressController.value.text = widget.data.value.billingAddress ?? "";
    widget.controller.hierarchyModel.branch_billingAddressNameController.value.text = widget.data.value.billingAddressName ?? "";
    widget.controller.hierarchyModel.branch_siteTypeController.value.text = widget.data.value.siteType ?? "";
    widget.controller.hierarchyModel.branch_subscriptionIdController.value.text = (widget.data.value.subscriptionId ?? "").toString();
    widget.controller.hierarchyModel.branch_billingPlanController.value.text = widget.data.value.billingPlan ?? "";
    widget.controller.hierarchyModel.branch_billModeController.value.text = widget.data.value.billMode ?? "";
    widget.controller.hierarchyModel.branch_fromDateController.value.text = widget.data.value.fromDate ?? "";
    widget.controller.hierarchyModel.branch_toDateController.value.text = widget.data.value.toDate ?? "";
    widget.controller.hierarchyModel.branch_amountController.value.text = (widget.data.value.amount ?? "").toString();
    widget.controller.hierarchyModel.branch_billingPeriodController.value.text = (widget.data.value.billingPeriod ?? "").toString();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    autofill();
    ever(widget.data, (_) {
      autofill();
    });
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: GlassmorphicContainer(
        width: widget.screenWidth * 0.3,
        height: double.infinity,
        borderRadius: 20,
        blur: 10,
        alignment: Alignment.center,
        border: 1,
        linearGradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 78, 77, 77).withOpacity(0.1),
            const Color.fromARGB(255, 105, 104, 104).withOpacity(0.05),
          ],
        ),
        borderGradient: const LinearGradient(
          colors: [
            Primary_colors.Light,
            Primary_colors.Dark,
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
                  Tab(text: 'KYC'),
                  Tab(text: 'PACKAGE'),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: TabBarView(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                buildTextField("Branch ID", widget.controller.hierarchyModel.branch_IdController.value, true),
                                buildTextField("Branch Name", widget.controller.hierarchyModel.branch_NameController.value, true),
                                buildTextField("Branch Code", widget.controller.hierarchyModel.branch_CodeController.value, false),
                                buildTextField("Client Address Name", widget.controller.hierarchyModel.branch_clientAddressNameController.value, false),
                                buildTextField("Client Address", widget.controller.hierarchyModel.branch_clientAddressController.value, false),
                                buildTextField("GST Number", widget.controller.hierarchyModel.branch_gstNumberController.value, false),
                                buildTextField("Email ID", widget.controller.hierarchyModel.branch_emailIdController.value, false),
                                buildTextField("Contact Person", widget.controller.hierarchyModel.branch_contact_personController.value, false),
                                buildTextField("Contact Number", widget.controller.hierarchyModel.branch_contactNumberController.value, false),
                                buildTextField("Billing Address", widget.controller.hierarchyModel.branch_billingAddressController.value, false),
                                buildTextField("Billing Address Name", widget.controller.hierarchyModel.branch_billingAddressNameController.value, false),
                                buildTextField("Subscription ID", widget.controller.hierarchyModel.branch_subscriptionIdController.value, true),
                                buildTextField("Site Type", widget.controller.hierarchyModel.branch_siteTypeController.value, true),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                buildTextField("Billing Plan", widget.controller.hierarchyModel.branch_billingPlanController.value, false),
                                buildTextField("Bill Mode", widget.controller.hierarchyModel.branch_billModeController.value, false),
                                // buildTextField("From Date", widget.controller.hierarchyModel.branch_fromDateController.value, true),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Expanded(
                                        flex: 2,
                                        child: Text(
                                          'From Date',
                                          style: TextStyle(color: Primary_colors.Color9, fontSize: Primary_font_size.Text8),
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
                                          controller: widget.controller.hierarchyModel.branch_fromDateController.value,
                                          readOnly: true, // Ensures keyboard doesn't pop up
                                          onTap: () async {
                                            DateTime? pickedDate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2100),
                                            );

                                            if (pickedDate != null) {
                                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                              widget.controller.hierarchyModel.branch_fromDateController.value.text = formattedDate;
                                            }
                                          },
                                          style: const TextStyle(
                                            color: Primary_colors.Color1,
                                            fontSize: Primary_font_size.Text8,
                                          ),
                                          decoration: const InputDecoration(
                                            fillColor: Colors.black,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Primary_colors.Color3,
                                                width: 2,
                                              ),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(255, 94, 94, 94),
                                                width: 1,
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Expanded(
                                        flex: 2,
                                        child: Text(
                                          'To Date',
                                          style: TextStyle(color: Primary_colors.Color9, fontSize: Primary_font_size.Text8),
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
                                          controller: widget.controller.hierarchyModel.branch_toDateController.value,
                                          readOnly: true, // Ensures keyboard doesn't pop up
                                          onTap: () async {
                                            DateTime? pickedDate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2100),
                                            );
                                            if (pickedDate != null) {
                                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                              widget.controller.hierarchyModel.branch_fromDateController.value.text = formattedDate;
                                            }
                                          },
                                          style: const TextStyle(
                                            color: Primary_colors.Color1,
                                            fontSize: Primary_font_size.Text8,
                                          ),
                                          decoration: const InputDecoration(
                                            fillColor: Colors.black,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Primary_colors.Color3,
                                                width: 2,
                                              ),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(255, 94, 94, 94),
                                                width: 1,
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // buildTextField("To Date", widget.controller.hierarchyModel.branch_toDateController.value, true),
                                buildTextField("Amount", widget.controller.hierarchyModel.branch_amountController.value, false),
                                buildTextField("Billing Period", widget.controller.hierarchyModel.branch_billingPeriodController.value, true),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.white),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // BasicButton(text: "Revert", colors: Colors.redAccent, onPressed: () {}),
                        BasicButton(
                          text: "Update",
                          colors: Colors.blue,
                          onPressed: () {
                            widget.UpdateKYC(
                              context,
                              widget.controller.hierarchyModel.branch_IdController.value.text,
                              widget.controller.hierarchyModel.branch_NameController.value.text,
                              widget.controller.hierarchyModel.branch_emailIdController.value.text,
                              widget.controller.hierarchyModel.branch_contactNumberController.value.text,
                              widget.controller.hierarchyModel.branch_clientAddressNameController.value.text,
                              widget.controller.hierarchyModel.branch_clientAddressController.value.text,
                              widget.controller.hierarchyModel.branch_gstNumberController.value.text,
                              widget.controller.hierarchyModel.branch_billingAddressNameController.value.text,
                              widget.controller.hierarchyModel.branch_billingAddressController.value.text,
                              widget.controller.hierarchyModel.branch_contact_personController.value.text,
                              widget.controller.hierarchyModel.branch_CodeController.value.text,
                              widget.controller.hierarchyModel.branch_siteTypeController.value.text,
                              widget.controller.hierarchyModel.branch_billingPlanController.value.text,
                              widget.controller.hierarchyModel.branch_billModeController.value.text,
                              widget.controller.hierarchyModel.branch_fromDateController.value.text,
                              widget.controller.hierarchyModel.branch_toDateController.value.text,
                              widget.controller.hierarchyModel.branch_amountController.value.text,
                              widget.controller.hierarchyModel.branch_billingPeriodController.value.text,
                              widget.controller.hierarchyModel.branch_subscriptionIdController.value.text,
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
