import 'package:flutter/material.dart';

import 'package:ssipl_billing/Graph.dart';
// import 'package:ssipl_billing/cards.dart';
import 'package:ssipl_billing/dashboardcards.dart';
import 'package:ssipl_billing/common_modules/style.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<String> vendorslist = [
    'Vendor 1',
    'Vendor 2',
    'Vendor 3',
    'Vendor 4',
    'Vendor 5',
    'Vendor 6',
    'Vendor 7',
    'Vendor 8',
    'Vendor 9',
    'Vendor 10',
    'Vendor 11',
    'Vendor 12',
    'Vendor 13',
    'Vendor 14',
    'Vendor 15',
    'Vendor 16',
    'Vendor 17',
    'Vendor 18',
    'Vendor 19',
    'Vendor 20',
  ];

  List<String> subscriptionlist = [
    'Subscription 1',
    'Subscription 2',
    'Subscription 3',
    'Subscription 4',
    'Subscription 5',
    'Subscription 6',
    'Subscription 7',
    'Subscription 8',
    'Subscription 9',
    'Subscription 10',
    'Subscription 11',
    'Subscription 12',
    'Subscription 13',
    'Subscription 14',
    'Subscription 15',
    'Subscription 16',
    'Subscription 17',
    'Subscription 18',
    'Subscription 19',
    'Subscription 20',
  ];
  final List<Map<String, dynamic>> Customerslist = [
    {
      "name": "Khivraj Groups",
      "age": "2 years",
      "dueDate": "10 days",
      "dueAmount": "13000",
    },
    {
      "name": "Maharaja",
      "age": "1 year",
      "dueDate": "0 days",
      "dueAmount": "0",
    },
    {
      "name": "Anamalais Groups",
      "age": "4 years",
      "dueDate": "20 days",
      "dueAmount": "33000",
    },
    {
      "name": "Honda Groups",
      "age": "6 years",
      "dueDate": "25 days",
      "dueAmount": "60000",
    },
    {
      "name": "Khivraj Groups",
      "age": "2 years",
      "dueDate": "10 days",
      "dueAmount": "13000",
    },
    {
      "name": "Maharaja",
      "age": "1 year",
      "dueDate": "0 days",
      "dueAmount": "0",
    },
    {
      "name": "Anamalais Groups",
      "age": "4 years",
      "dueDate": "20 days",
      "dueAmount": "33000",
    },
    {
      "name": "Honda Groups",
      "age": "6 years",
      "dueDate": "25 days",
      "dueAmount": "60000",
    },
    {
      "name": "Khivraj Groups",
      "age": "2 years",
      "dueDate": "10 days",
      "dueAmount": "13000",
    },
    {
      "name": "Maharaja",
      "age": "1 year",
      "dueDate": "0 days",
      "dueAmount": "0",
    },
    {
      "name": "Anamalais Groups",
      "age": "4 years",
      "dueDate": "20 days",
      "dueAmount": "33000",
    },
    {
      "name": "Honda Groups",
      "age": "6 years",
      "dueDate": "25 days",
      "dueAmount": "60000",
    },
    {
      "name": "Khivraj Groups",
      "age": "2 years",
      "dueDate": "10 days",
      "dueAmount": "13000",
    },
    {
      "name": "Maharaja",
      "age": "1 year",
      "dueDate": "0 days",
      "dueAmount": "0",
    },
    {
      "name": "Anamalais Groups",
      "age": "4 years",
      "dueDate": "20 days",
      "dueAmount": "33000",
    },
    {
      "name": "Honda Groups",
      "age": "6 years",
      "dueDate": "25 days",
      "dueAmount": "60000",
    },
    {
      "name": "Khivraj Groups",
      "age": "2 years",
      "dueDate": "10 days",
      "dueAmount": "13000",
    },
    {
      "name": "Maharaja",
      "age": "1 year",
      "dueDate": "0 days",
      "dueAmount": "0",
    },
    {
      "name": "Anamalais Groups",
      "age": "4 years",
      "dueDate": "20 days",
      "dueAmount": "33000",
    },
    {
      "name": "Honda Groups",
      "age": "6 years",
      "dueDate": "25 days",
      "dueAmount": "60000",
    },
    {
      "name": "Khivraj Groups",
      "age": "2 years",
      "dueDate": "10 days",
      "dueAmount": "13000",
    },
    {
      "name": "Maharaja",
      "age": "1 year",
      "dueDate": "0 days",
      "dueAmount": "0",
    },
    {
      "name": "Anamalais Groups",
      "age": "4 years",
      "dueDate": "20 days",
      "dueAmount": "33000",
    },
    {
      "name": "Honda Groups",
      "age": "6 years",
      "dueDate": "25 days",
      "dueAmount": "60000",
    },
    {
      "name": "Khivraj Groups",
      "age": "2 years",
      "dueDate": "10 days",
      "dueAmount": "13000",
    },
    {
      "name": "Maharaja",
      "age": "1 year",
      "dueDate": "0 days",
      "dueAmount": "0",
    },
    {
      "name": "Anamalais Groups",
      "age": "4 years",
      "dueDate": "20 days",
      "dueAmount": "33000",
    },
    {
      "name": "Honda Groups",
      "age": "6 years",
      "dueDate": "25 days",
      "dueAmount": "60000",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Primary_colors.Dark,
      body: Center(
        child: SizedBox(
          child: Column(
            children: [
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
                          Icons.notes_rounded,
                          size: 25.0,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Dashboard',
                        style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text13),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 400,
                        height: 40,
                        child: TextFormField(
                          style: const TextStyle(fontSize: 13, color: Colors.white),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(1),
                            filled: true,
                            fillColor: Primary_colors.Light,
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.transparent)),
                            // enabledBorder: InputBorder.none, // Removes the enabled border
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.transparent)),
                            hintStyle: const TextStyle(
                              fontSize: Primary_font_size.Text7,
                              color: Color.fromARGB(255, 167, 165, 165),
                            ),
                            hintText: 'Search',
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      // ShaderMask(
                      //   shaderCallback: (bounds) => const LinearGradient(
                      //     colors: [Primary_colors.Color5, Primary_colors.Color4], // Example gradient
                      //     begin: Alignment.topLeft,
                      //     end: Alignment.bottomRight,
                      //   ).createShader(bounds),
                      //   child: const Icon(
                      //     Icons.people,
                      //     size: 20.0,
                      //   ),
                      // ),
                      Container(
                        width: 35, // Diameter of the CircleAvatar (2 * radius)
                        height: 35, // Diameter of the CircleAvatar (2 * radius)
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Primary_colors.Color3,
                              Primary_colors.Color4,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const CircleAvatar(
                          backgroundColor: Colors.transparent, // Make background transparent to show gradient
                          radius: 20,
                          child: Icon(
                            Icons.person,
                            color: Primary_colors.Color1,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User Name',
                            style: TextStyle(
                              color: Primary_colors.Color1,
                              fontSize: Primary_font_size.Text8,
                            ),
                          ),
                          Text(
                            'User',
                            style: TextStyle(color: Color.fromARGB(255, 198, 198, 198), fontSize: Primary_font_size.Text6),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Expanded(child: Dashboard_cards()),
                          const SizedBox(height: 10),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Primary_colors.Light,
                                          Primary_colors.Light,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      boxShadow: const [
                                        // BoxShadow(
                                        //   color: Primary_colors.Color2,
                                        //   offset: Offset(0, 10),
                                        //   blurRadius: 20,
                                        // ),
                                      ],
                                    ),
                                    child: const Column(
                                      children: [
                                        SizedBox(height: 15),
                                        Row(
                                          children: [
                                            SizedBox(width: 10),
                                            // ShaderMask(
                                            //   shaderCallback: (bounds) => const LinearGradient(
                                            //     colors: [Primary_colors.Color3, Primary_colors.Color4], // Example gradient
                                            //     begin: Alignment.topLeft,
                                            //     end: Alignment.bottomRight,
                                            //   ).createShader(bounds),
                                            //   child: const Icon(
                                            //     FontAwesomeIcons.chartLine,
                                            //     size: 20.0,
                                            //   ),
                                            // ),
                                            // const SizedBox(width: 10),
                                            Text(
                                              'MONTHLY SALES',
                                              style: TextStyle(letterSpacing: 2, color: Primary_colors.Color3, fontSize: Primary_font_size.Text10, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        // const SizedBox(height: 10),
                                        Expanded(
                                            child: Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Sales_Graph(),
                                        )),
                                        // const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Primary_colors.Light,
                                      Primary_colors.Light,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 10),
                                      blurRadius: 20,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 15),
                                    const Row(
                                      children: [
                                        SizedBox(width: 10),
                                        // ShaderMask(
                                        //   shaderCallback: (bounds) => const LinearGradient(
                                        //     colors: [Primary_colors.Color3, Primary_colors.Color4],
                                        //     begin: Alignment.topLeft,
                                        //     end: Alignment.bottomRight,
                                        //   ).createShader(bounds),
                                        //   child: const Icon(
                                        //     Icons.storefront_outlined,
                                        //     size: 25.0,
                                        //   ),
                                        // ),
                                        // const SizedBox(width: 10),
                                        Text(
                                          'VENDOR',
                                          style: TextStyle(
                                            letterSpacing: 2,
                                            color: Primary_colors.Color3,
                                            fontSize: Primary_font_size.Text10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: ListView.separated(
                                        itemCount: vendorslist.length,
                                        separatorBuilder: (context, index) => const Divider(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          thickness: 1,
                                          indent: 20,
                                          endIndent: 20,
                                        ),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Primary_colors.Color5.withOpacity(0.1),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: ClipOval(
                                                    child: Image.asset(
                                                      'assets/images/download.jpg',
                                                      fit: BoxFit.cover, // Ensures the image covers the container
                                                      width: double.infinity, // Makes the image fill the container's width
                                                      height: double.infinity, // Makes the image fill the container's height
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        vendorslist[index],
                                                        style: const TextStyle(
                                                          letterSpacing: 1,
                                                          color: Primary_colors.Color1,
                                                          fontSize: Primary_font_size.Text7,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                      const Text(
                                                        'Additional details here', // Placeholder for extra details
                                                        style: TextStyle(
                                                          letterSpacing: 1,
                                                          color: Primary_colors.Color7,
                                                          fontSize: Primary_font_size.Text6,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // ShaderMask(
                                                //   shaderCallback: (bounds) => const LinearGradient(
                                                //     colors: [Primary_colors.Color3, Primary_colors.Color3],
                                                //     begin: Alignment.topLeft,
                                                //     end: Alignment.bottomRight,
                                                //   ).createShader(bounds),
                                                //   child: const Icon(
                                                //     Icons.arrow_forward_ios,
                                                //     size: 16,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Primary_colors.Light,
                                      Primary_colors.Light,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 10),
                                      blurRadius: 20,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 15),
                                    const Row(
                                      children: [
                                        SizedBox(width: 10),
                                        // ShaderMask(
                                        //   shaderCallback: (bounds) => const LinearGradient(
                                        //     colors: [Primary_colors.Color3, Primary_colors.Color4],
                                        //     begin: Alignment.topLeft,
                                        //     end: Alignment.bottomRight,
                                        //   ).createShader(bounds),
                                        //   child: const Icon(
                                        //     Icons.subscriptions,
                                        //     size: 25.0,
                                        //   ),
                                        // ),
                                        // const SizedBox(width: 10),
                                        Text(
                                          'SUBSCRIPTION',
                                          style: TextStyle(
                                            letterSpacing: 2,
                                            color: Primary_colors.Color3,
                                            fontSize: Primary_font_size.Text10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: ListView.separated(
                                        itemCount: subscriptionlist.length,
                                        separatorBuilder: (context, index) => const Divider(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          thickness: 1,
                                          indent: 20,
                                          endIndent: 20,
                                        ),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                            child: Row(
                                              children: [
                                                ShaderMask(
                                                  shaderCallback: (bounds) => const LinearGradient(
                                                    colors: [Primary_colors.Color3, Primary_colors.Color4],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ).createShader(bounds),
                                                  child: const Icon(
                                                    Icons.subscriptions,
                                                    size: 25.0,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        subscriptionlist[index],
                                                        style: const TextStyle(
                                                          letterSpacing: 1,
                                                          color: Primary_colors.Color1,
                                                          fontSize: Primary_font_size.Text7,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                      const Text(
                                                        'Additional details here', // Placeholder for extra details
                                                        style: TextStyle(
                                                          letterSpacing: 1,
                                                          color: Primary_colors.Color7,
                                                          fontSize: Primary_font_size.Text6,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // ShaderMask(
                                                //   shaderCallback: (bounds) => const LinearGradient(
                                                //     colors: [Primary_colors.Color3, Primary_colors.Color3],
                                                //     begin: Alignment.topLeft,
                                                //     end: Alignment.bottomRight,
                                                //   ).createShader(bounds),
                                                //   child: const Icon(
                                                //     Icons.arrow_forward_ios,
                                                //     size: 16,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(color: Primary_colors.Light, borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Row(
                                      children: [
                                        SizedBox(width: 10),
                                        // ShaderMask(
                                        //   shaderCallback: (bounds) => const LinearGradient(
                                        //     colors: [Primary_colors.Color3, Primary_colors.Color4], // Example gradient
                                        //     begin: Alignment.topLeft,
                                        //     end: Alignment.bottomRight,
                                        //   ).createShader(bounds),
                                        //   child: const Icon(
                                        //     Icons.people,
                                        //     size: 25.0,
                                        //   ),
                                        // ),
                                        // const SizedBox(width: 5),
                                        Text(
                                          'CLIENT',
                                          style: TextStyle(letterSpacing: 2, color: Primary_colors.Color3, fontSize: Primary_font_size.Text10, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          gradient: const LinearGradient(
                                            colors: [
                                              Primary_colors.Color3,
                                              Primary_colors.Color3,
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(2),
                                          child: Icon(
                                            Icons.add,
                                            size: 19,
                                          ),
                                        ),
                                      ),
                                    )
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(15),
                                    //     color: const Color.fromARGB(113, 125, 250, 130),
                                    //   ),
                                    //   height: 25,
                                    //   child: TextButton(
                                    //       onPressed: () {},
                                    //       child: const Text(
                                    //         'Add',
                                    //         style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 255, 255, 255)),
                                    //       )),
                                    // )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                    flex: 3,
                                    child: ListView.builder(
                                      itemCount: Customerslist.length,
                                      itemBuilder: (context, index) {
                                        // Sample data for demonstration
                                        final customerName = Customerslist[index]['name'];
                                        final age = Customerslist[index]['age'];
                                        final dueDate = Customerslist[index]['dueDate'];
                                        final dueAmount = Customerslist[index]['dueAmount'];

                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30), // Ensure border radius for smooth corners
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  // Customer Profile Image
                                                  Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: Primary_colors.Color5.withOpacity(0.1),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: ClipOval(
                                                      child: Image.asset(
                                                        'assets/images/human.jpg',
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),

                                                  // Customer Information Section
                                                  Expanded(
                                                    child: Wrap(
                                                      runSpacing: 5,
                                                      children: [
                                                        SizedBox(
                                                            width: 200,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  customerName,
                                                                  style: const TextStyle(
                                                                    letterSpacing: 1,
                                                                    color: Primary_colors.Color1,
                                                                    fontSize: Primary_font_size.Text7,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                                const SizedBox(height: 5),
                                                                Row(
                                                                  children: [
                                                                    const Icon(Icons.calendar_today, size: 16, color: Primary_colors.Color7),
                                                                    const SizedBox(width: 5),
                                                                    Text(
                                                                      'Age: $age',
                                                                      style: const TextStyle(
                                                                        color: Primary_colors.Color7,
                                                                        fontSize: Primary_font_size.Text5,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            )),
                                                        // Due Date
                                                        SizedBox(
                                                            width: 100,
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  'Due: $dueDate',
                                                                  style: TextStyle(
                                                                    color: dueAmount == "0" ? const Color.fromARGB(255, 119, 243, 125) : const Color.fromARGB(255, 255, 91, 91),
                                                                    fontSize: Primary_font_size.Text5,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                                const SizedBox(height: 5),
                                                                Container(
                                                                  width: 60, // Slightly increased width for better balance
                                                                  height: 20, // Slightly increased height for better alignment
                                                                  decoration: BoxDecoration(
                                                                    color: Primary_colors.Color3,
                                                                    borderRadius: BorderRadius.circular(12), // Smoother corner radius
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      '\$$dueAmount',
                                                                      style: const TextStyle(
                                                                        overflow: TextOverflow.ellipsis,
                                                                        color: Colors.white,
                                                                        fontSize: 10, // Slightly larger font for better readability
                                                                        fontWeight: FontWeight.w700,
                                                                        letterSpacing: 0.6, // Slightly increased letter spacing
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )),
                                                      ],
                                                    ),
                                                  ),

                                                  // Forward Arrow Icon
                                                  ShaderMask(
                                                    shaderCallback: (bounds) => const LinearGradient(
                                                      colors: [Primary_colors.Color3, Primary_colors.Color3],
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.bottomRight,
                                                    ).createShader(bounds),
                                                    child: const Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 18,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )),
                              ],
                            ),
                          ),
                        )),
                      ],
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
