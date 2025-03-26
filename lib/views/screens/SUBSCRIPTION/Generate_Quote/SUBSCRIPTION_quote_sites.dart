import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/SUBSCRIPTIONcontrollers/SUBSCRIPTION_Quote_actions.dart';
import 'package:ssipl_billing/services/SUBSCRIPTION/Quotation_services/SUBSCRIPTION_QuoteSite_services.dart';
import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/textfield.dart';

class SUBSCRIPTION_QuoteSites extends StatefulWidget with SUBSCRIPTION_QuotesiteService {
  SUBSCRIPTION_QuoteSites({super.key});

  @override
  State<SUBSCRIPTION_QuoteSites> createState() => _SUBSCRIPTION_QuoteSitesState();
}

class _SUBSCRIPTION_QuoteSitesState extends State<SUBSCRIPTION_QuoteSites> {
  final SUBSCRIPTION_QuoteController quoteController = Get.find<SUBSCRIPTION_QuoteController>();

  Widget Quote_siteDetailss() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < quoteController.quoteModel.Quote_sites.length; i++)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  widget.editsite(i);
                },
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: Primary_colors.Light),
                  height: 40,
                  width: 300,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 230,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              '${i + 1}. ${quoteController.quoteModel.Quote_sites[i].siteName}', // Display camera type from map
                              style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                quoteController.removeFromsiteList(i);
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: quoteController.quoteModel.siteKey.value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      Obx(
                        () {
                          return BasicTextfield(
                            digitsOnly: false,
                            width: 400,
                            readonly: false,
                            text: 'Site Name',
                            controller: quoteController.quoteModel.siteNameController.value,
                            icon: Icons.production_quantity_limits,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Site name';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 25),
                      Obx(
                        () {
                          return BasicTextfield(
                            digitsOnly: true,
                            width: 400,
                            readonly: false,
                            text: 'HSN',
                            controller: quoteController.quoteModel.hsnController.value,
                            icon: Icons.numbers,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter HSN';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: 400,
                        child: Obx(
                          () {
                            return TextFormField(
                              readOnly: false,
                              style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.white),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Primary_colors.Dark,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),

                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                // labelText: text,
                                hintText: 'Site GST',
                                hintStyle: TextStyle(
                                  fontSize: Primary_font_size.Text7,
                                  color: Color.fromARGB(255, 167, 165, 165),
                                ),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Icons.price_change,
                                  color: Colors.white,
                                ),
                              ),
                              controller: quoteController.quoteModel.gstController.value,
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Site GST';
                                }
                                return null;
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 25),
                      Obx(
                        () {
                          return SizedBox(
                            width: 400,
                            child: TextFormField(
                              readOnly: false,
                              style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.white),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Primary_colors.Dark,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),

                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                // labelText: text,
                                hintText: 'Site Price',
                                hintStyle: TextStyle(
                                  fontSize: Primary_font_size.Text7,
                                  color: Color.fromARGB(255, 167, 165, 165),
                                ),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Icons.currency_rupee,
                                  color: Colors.white,
                                ),
                              ),
                              controller: quoteController.quoteModel.priceController.value,
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Site price';
                                }
                                return null;
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 25),
                      Obx(
                        () {
                          return SizedBox(
                            width: 400,
                            child: TextFormField(
                              readOnly: false,
                              style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.white),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Primary_colors.Dark,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),

                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                // labelText: text,
                                hintText: 'Site Quantity',
                                hintStyle: TextStyle(
                                  fontSize: Primary_font_size.Text7,
                                  color: Color.fromARGB(255, 167, 165, 165),
                                ),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Icons.production_quantity_limits,
                                  color: Colors.white,
                                ),
                              ),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              controller: quoteController.quoteModel.quantityController.value,
                              keyboardType: TextInputType.number,
                              // inputFormatters: [
                              //   FilteringTextInputFormatter.digitsOnly
                              // ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Site Quantity';
                                }
                                return null;
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      Obx(
                        () {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BasicButton(
                                colors: Colors.red,
                                text: quoteController.quoteModel.site_editIndex.value == null ? 'Back' : 'Cancel',
                                onPressed: () {
                                  quoteController.quoteModel.site_editIndex.value == null ? quoteController.backTab() : widget.resetEditingState(); // Reset editing state when going back
                                },
                              ),
                              const SizedBox(width: 30),
                              BasicButton(
                                colors: quoteController.quoteModel.site_editIndex.value == null ? Colors.blue : Colors.orange,
                                text: quoteController.quoteModel.site_editIndex.value == null ? 'Add site' : 'Update',
                                onPressed: () {
                                  quoteController.quoteModel.site_editIndex.value == null ? widget.addsite(context) : widget.updatesite(context);
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(
                        // width: 750,
                        child: Text(
                          textAlign: TextAlign.center,
                          "The Quotation site details play a crucial role in the procurement process. Please ensure accuracy when entering site names,HSN codes, GST% and quantities, as these details directly impact order processing, inventory management, and subsequent workflows.",
                          style: TextStyle(color: Color.fromARGB(255, 124, 124, 124), fontSize: Primary_font_size.Text7),
                        ),
                      )
                    ],
                  ),
                ),
                // if (length != 0) const SizedBox(width: 60),

                Obx(
                  () {
                    return (quoteController.quoteModel.Quote_sites.isNotEmpty)
                        ? Expanded(
                            child: Column(
                            children: [
                              const SizedBox(height: 25),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Primary_colors.Dark,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10, top: 15),
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Site List',
                                        style: TextStyle(fontSize: Primary_font_size.Text10, color: Primary_colors.Color1, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        height: 295,
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: SingleChildScrollView(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Quote_siteDetailss(),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              if (quoteController.quoteModel.Quote_sites.isNotEmpty)
                                BasicButton(
                                  colors: Colors.green,
                                  text: 'Submit',
                                  onPressed: () {
                                    widget.onSubmit();
                                    quoteController.nextTab();
                                  },
                                ),
                            ],
                          ))
                        : const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
