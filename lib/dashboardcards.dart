import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ssipl_billing/Bar_Line.dart';

import 'package:ssipl_billing/common_modules/style.dart';

class Dashboard_cards extends StatefulWidget {
  const Dashboard_cards({super.key});

  @override
  State<Dashboard_cards> createState() => _Dashboard_cardsState();
}

class _Dashboard_cardsState extends State<Dashboard_cards> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Define the animation curve

    // Start the animation when the widget is first created
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Primary_colors.Dark,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDashboardCard(
                    context,
                    icon: FontAwesomeIcons.chartLine,
                    title: "205",
                    description: "Track and analyze sales performance.",
                    totalCount: 540,
                    activeCount: 412,
                    gradientColors: [Primary_colors.Color5],
                  ),
                  const SizedBox(width: 15),
                  _buildDashboardCard(
                    context,
                    icon: FontAwesomeIcons.userCheck,
                    title: "60",
                    description: "Oversee customer subscriptions effectively.",
                    totalCount: 300,
                    activeCount: 250,
                    gradientColors: [Primary_colors.Color4],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDashboardCard(
                    context,
                    icon: FontAwesomeIcons.boxesStacked,
                    title: "400",
                    description: "Monitor and organize stock levels.",
                    totalCount: 150,
                    activeCount: 120,
                    gradientColors: [Primary_colors.Color6],
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            colors: [Primary_colors.Light, Primary_colors.Light],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          // boxShadow: const [
                          //   BoxShadow(
                          //     color: Colors.black12,
                          //     offset: Offset(0, 10),
                          //     blurRadius: 20,
                          //   ),
                          // ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    // ShaderMask(
                                    //   shaderCallback: (bounds) => const LinearGradient(
                                    //     colors: [Primary_colors.Color3, Primary_colors.Color4], // Example gradient
                                    //     begin: Alignment.topLeft,
                                    //     end: Alignment.bottomRight,
                                    //   ).createShader(bounds),
                                    //   child: const Icon(
                                    //     FontAwesomeIcons.moneyBillTrendUp,
                                    //     size: 20.0,
                                    //   ),
                                    // ),
                                    // const SizedBox(width: 10),
                                    Text(
                                      'MONTHLY PROFIT',
                                      style: TextStyle(letterSpacing: 2, color: Primary_colors.Color3, fontSize: Primary_font_size.Text10, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Bar_line(),
                              )
                            ],
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
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required int totalCount,
    required int activeCount,
    required List<Color> gradientColors,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [Primary_colors.Light, Primary_colors.Light],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            // boxShadow: const [
            //   BoxShadow(
            //     color: Colors.black12,
            //     offset: Offset(0, 10),
            //     blurRadius: 20,
            //   ),
            // ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        // ShaderMask(
                        //   shaderCallback: (bounds) => LinearGradient(
                        //     colors: gradientColors, // Example gradient
                        //     begin: Alignment.topLeft,
                        //     end: Alignment.bottomRight,
                        //   ).createShader(bounds),
                        //   child: FaIcon(
                        //     icon,
                        //     color: Primary_colors.Color3, // Color acts as a placeholder but won't appear due to the shader
                        //     size: 26,
                        //   ),
                        // ),
                        const SizedBox(height: 5),
                        Text(
                          title,
                          style: TextStyle(
                            letterSpacing: 1,
                            color: gradientColors[0],
                            fontSize: 30, // Heading text size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(height: 50, width: 1, color: Primary_colors.Color1),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total      :    $totalCount',
                          style: const TextStyle(
                            letterSpacing: 1,
                            color: Primary_colors.Color1,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Active   :    $activeCount',
                          style: const TextStyle(
                            letterSpacing: 1,
                            color: Primary_colors.Color1,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    letterSpacing: 1,
                    color: Primary_colors.Color1,
                    fontSize: 10, // Description text size
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up the controller
    super.dispose();
  }
}
