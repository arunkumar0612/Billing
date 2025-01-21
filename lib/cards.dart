import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ssipl_billing/common_modules/style.dart';

class cardview extends StatefulWidget {
  const cardview({super.key});

  @override
  State<cardview> createState() => _CardViewState();
}

class _CardViewState extends State<cardview> with SingleTickerProviderStateMixin {
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDashboardCard(context,
                icon: FontAwesomeIcons.chartLine, title: "Sales", description: "Track and analyze sales performance.", totalCount: 540, activeCount: 412, Colors: Primary_colors.Color4),
            const SizedBox(width: 15),
            _buildDashboardCard(context,
                icon: FontAwesomeIcons.userCheck, title: "Subscription", description: "Oversee customer subscriptions effectively.", totalCount: 300, activeCount: 250, Colors: Primary_colors.Color5),
            const SizedBox(width: 15),
            _buildDashboardCard(context,
                icon: FontAwesomeIcons.truck, title: "Vendor", description: "Manage vendor relationships and supplies.", totalCount: 50, activeCount: 40, Colors: Primary_colors.Color6),
            const SizedBox(width: 15),
            _buildDashboardCard(
              context,
              icon: FontAwesomeIcons.boxesStacked,
              title: "Inventory",
              description: "Monitor and organize stock levels.",
              totalCount: 150,
              activeCount: 120,
              Colors: Primary_colors.Color8,
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
    required Color Colors,
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
            boxShadow: const [
              BoxShadow(
                color: Primary_colors.Color3,
                offset: Offset(0, 1),
                blurRadius: 1,
              ),
            ],
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
                        FaIcon(
                          icon,
                          color: Colors, // Color acts as a placeholder but won't appear due to the shader
                          size: 26,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          title,
                          style: TextStyle(
                            color: Colors,
                            fontSize: 12, // Heading text size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(height: 50, width: 1, color: Primary_colors.Color7),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total      :    $totalCount',
                          style: TextStyle(
                            color: Colors,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Active   :    $activeCount',
                          style: TextStyle(
                            color: Colors,
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
                    color: Color.fromARGB(255, 227, 225, 225),
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
