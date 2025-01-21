import 'package:flutter/material.dart';

import 'package:ssipl_billing/addservice.dart';
import 'package:ssipl_billing/common_modules/style.dart';
import 'package:google_fonts/google_fonts.dart'; // For custom fonts
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart'; // For advanced grid layouts

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> with SingleTickerProviderStateMixin {
  // Original lists
  List<ProductDetails> productList = [
    ProductDetails('assets/images/car.jpg', 'Product 1'),
    ProductDetails('assets/images/car.jpg', 'Product 2'),
    ProductDetails('assets/images/car.jpg', 'Product 3'),
    ProductDetails('assets/images/car.jpg', 'Product 4'),
    ProductDetails('assets/images/car.jpg', 'Product 5'),
    ProductDetails('assets/images/car.jpg', 'Product 6'),
    ProductDetails('assets/images/car.jpg', 'Product 7'),
    ProductDetails('assets/images/car.jpg', 'Product 8'),
    ProductDetails('assets/images/car.jpg', 'Product 9'),
    ProductDetails('assets/images/car.jpg', 'Product 10'),
    ProductDetails('assets/images/car.jpg', 'Product 11'),
    ProductDetails('assets/images/car.jpg', 'Product 12'),
    ProductDetails('assets/images/car.jpg', 'Product 13'),
    ProductDetails('assets/images/car.jpg', 'Product 14'),
    ProductDetails('assets/images/car.jpg', 'Product 15'),
    ProductDetails('assets/images/car.jpg', 'Product 16'),
    ProductDetails('assets/images/car.jpg', 'Product 17'),
    ProductDetails('assets/images/car.jpg', 'Product 18'),
    ProductDetails('assets/images/car.jpg', 'Product 19'),
    ProductDetails('assets/images/car.jpg', 'Product 20'),
    ProductDetails('assets/images/car.jpg', 'Product 21'),
    ProductDetails('assets/images/car.jpg', 'Product 22'),
    ProductDetails('assets/images/car.jpg', 'Product 23'),
    ProductDetails('assets/images/car.jpg', 'Product 24'),
    ProductDetails('assets/images/car.jpg', 'Product 25'),
    ProductDetails('assets/images/car.jpg', 'Product 26'),
    ProductDetails('assets/images/car.jpg', 'Product 27'),
    ProductDetails('assets/images/car.jpg', 'Product 28'),
    ProductDetails('assets/images/car.jpg', 'Product 29'),
    ProductDetails('assets/images/car.jpg', 'Product 30'),
  ];

  List<String> serviceList = [
    'Service 1',
    'Service 2',
    'Service 3',
    'Service 4',
    'Service 5',
    'Service 6',
    'Service 7',
    'Service 8',
    'Service 9',
    'Service 10',
    'Service 11',
    'Service 12',
    'Service 13',
    'Service 14',
    'Service 15',
    'Service 16',
    'Service 17',
    'Service 18',
    'Service 19',
    'Service 20',
    'Service 21',
    'Service 22',
    'Service 23',
    'Service 24',
    'Service 25',
    'Service 26',
    'Service 27',
    'Service 28',
    'Service 29',
    'Service 30',
    'Service 31',
    'Service 32',
    'Service 33',
    'Service 34',
    'Service 35',
    'Service 36',
    'Service 37',
    'Service 38',
    'Service 39',
    'Service 40',
  ];
  // Search-related variables
  String productSearchQuery = '';
  String serviceSearchQuery = '';
  // Controllers for search fields
  final TextEditingController _productSearchController = TextEditingController();
  final TextEditingController _serviceSearchController = TextEditingController();
  // Filtered lists based on search queries
  List<ProductDetails> get filteredProductList {
    if (productSearchQuery.isEmpty) {
      return productList;
    } else {
      return productList.where((product) => product.productName.toLowerCase().contains(productSearchQuery.toLowerCase())).toList();
    }
  }

  List<String> get filteredServiceList {
    if (serviceSearchQuery.isEmpty) {
      return serviceList;
    } else {
      return serviceList.where((service) => service.toLowerCase().contains(serviceSearchQuery.toLowerCase())).toList();
    }
  }

  @override
  void dispose() {
    _productSearchController.dispose();
    _serviceSearchController.dispose();
    super.dispose();
  }
  // Animation Controller for dialogs

  @override
  void initState() {
    super.initState();
  }

  // Function to show add product dialog with animation
  void Addproduct() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Primary_colors.Dark,
          content: const SizedBox(
            height: 600,
            width: 900,
          ),
        );
      },
    );
  }

  void Addservice() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Primary_colors.Light,
          content: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: const SizedBox(
              height: 400,
              width: 800,
              child: addservice_page(),
            ),
          ),
        );
      },
    );
  }

  // Function to show product details dialog with enhanced UI
  void _showProductDetails(String imagePath, String productName) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: SizedBox(
            width: 500,
            child: _buildProductDetailsContent(imagePath, productName),
          ),
        );
      },
    );
  }

  Widget _buildProductDetailsContent(String imagePath, String productName) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: Primary_colors.Light,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                productName,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Primary_colors.Color1),
                ),
              ),
              const SizedBox(height: 15),
              Image.asset(
                imagePath,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 15),
              _buildDetailRow('Product Type', 'Camera'),
              _buildDetailRow('Product Brand', 'Hikvision'),
              _buildDetailRow('Supplier Name', 'Hikvision'),
              _buildDetailRow('Product Rate', '1500 Rs'),
              _buildDetailRow('Product MRP', '1300 Rs'),
              // const SizedBox(height: 20),
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: ElevatedButton(
              //     onPressed: () => Navigator.of(context).pop(),
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.red,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //     child: const Text('Close'),
              //   ),
              // ),
            ],
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          child: CircleAvatar(
            backgroundColor: Colors.red,
            radius: 20,
            child: IconButton(
              icon: const Icon(
                Icons.close,
                color: Primary_colors.Color1,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label : ',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.lato(
                textStyle: const TextStyle(color: Colors.blue, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable search field widget with enhanced UI
  Widget _buildSearchField({
    required TextEditingController controller,
    required String hintText,
    required Function(String) onChanged,
  }) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: GoogleFonts.lato(
        textStyle: const TextStyle(fontSize: 14, color: Colors.white),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Primary_colors.Light,
        hintText: hintText,
        hintStyle: GoogleFonts.lato(
          textStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.grey),
        ),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  controller.clear();
                  onChanged('');
                },
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Reusable card widget for services
  Widget _buildServiceCard(String service) {
    return Card(
      color: Primary_colors.Light,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: ListTile(
        leading: const Icon(
          Icons.miscellaneous_services,
          color: Primary_colors.Color1,
          size: 30,
        ),
        title: Text(
          service,
          style: GoogleFonts.lato(
            textStyle: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7, fontWeight: FontWeight.w500),
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
          size: 15,
        ),
        onTap: () {
          // Implement service details or actions here
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Primary_colors.Dark,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Primary_colors.Light),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_box, color: Colors.white),
                    tooltip: 'Add Product',
                    onPressed: Addproduct,
                  ),
                  IconButton(
                    icon: const Icon(Icons.design_services, color: Colors.white),
                    tooltip: 'Add Service',
                    onPressed: Addservice,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Row(
                children: [
                  // Products Section
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section Title
                        Text(
                          '${filteredProductList.length} Products Available',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(color: Colors.blue[600], fontSize: Primary_font_size.Text10, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Search Bar
                        _buildSearchField(
                          controller: _productSearchController,
                          hintText: 'Search products',
                          onChanged: (value) {
                            setState(() {
                              productSearchQuery = value;
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        // Products Grid
                        Expanded(
                          child: MasonryGridView.count(
                            crossAxisCount: 4,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            itemCount: filteredProductList.length,
                            itemBuilder: (context, index) {
                              final product = filteredProductList[index];
                              return GestureDetector(
                                onTap: () => _showProductDetails(product.image, product.productName),
                                child: Card(
                                  color: Primary_colors.Light,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                        child: Image.asset(
                                          product.image,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          product.productName,
                                          style: GoogleFonts.lato(
                                            textStyle: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7, fontWeight: FontWeight.w600),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Services Section
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section Title
                        Text(
                          '${filteredServiceList.length} Services Available',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(color: Colors.blue[600], fontSize: Primary_font_size.Text10, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Search Bar
                        _buildSearchField(
                          controller: _serviceSearchController,
                          hintText: 'Search services',
                          onChanged: (value) {
                            setState(() {
                              serviceSearchQuery = value;
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        // Services List
                        Expanded(
                          child: ListView.builder(
                            itemCount: filteredServiceList.length,
                            itemBuilder: (context, index) {
                              final service = filteredServiceList[index];
                              return _buildServiceCard(service);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Product Details Model
class ProductDetails {
  final String image;
  final String productName;

  ProductDetails(this.image, this.productName);
}



// Primary Colors and Styling
// class PrimaryColors {
//   static const Color background = Color.fromARGB(255, 23, 22, 34);
//   static const Color dark = Color.fromARGB(255, 234, 234, 236);
//   static const Color light = Color.fromARGB(255, 33, 33, 48);
//   static const Color primary = Color(0xFF3A7BD5);
//   static const Color searchBackground = Color.fromARGB(255, 33, 33, 48);
// }
