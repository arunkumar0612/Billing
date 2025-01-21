import 'package:flutter/material.dart';
import 'package:ssipl_billing/common_modules/style.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Bar_line extends StatefulWidget {
  const Bar_line({super.key});

  @override
  Bar_lineState createState() => Bar_lineState();
}

class Bar_lineState extends State<Bar_line> {
  late List<_ChartData> data;

  @override
  void initState() {
    data = [_ChartData('KIV', 15), _ChartData('MAH', 80), _ChartData('ATHE', 60.4), _ChartData('HON', 105)];
    super.initState();
  }

  // Method to assign different colors based on the index
  Color getBarColor(int index) {
    const List<Color> colors = [
      Primary_colors.Color3, // Red
      Primary_colors.Color4, // Green
      Primary_colors.Color5, // Orange
      Primary_colors.Color6 // Purple
    ];
    return colors[index % colors.length]; // Cycle through colors if there are more bars
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SfCartesianChart(
              plotAreaBorderWidth: 0, // Remove border around the plot area
              borderWidth: 0, // Remove outer chart border
              primaryXAxis: const CategoryAxis(
                axisLine: AxisLine(color: Colors.transparent), // Make the X axis line transparent
                majorGridLines: MajorGridLines(color: Colors.transparent), // Make the X grid lines transparent
                majorTickLines: MajorTickLines(color: Colors.transparent), // Remove major ticks
              ),
              primaryYAxis: const NumericAxis(
                labelStyle: TextStyle(color: Primary_colors.Color1),
                minimum: 0,
                maximum: 40,
                interval: 10,
                axisLine: AxisLine(color: Colors.transparent), // Make the Y axis line transparent
                majorGridLines: MajorGridLines(color: Colors.transparent), // Make the Y grid lines transparent
              ),
              tooltipBehavior: TooltipBehavior(
                enable: screenHeight > 750 ? true : false,
              ),
              series: <CartesianSeries<_ChartData, String>>[
                BarSeries<_ChartData, String>(
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x.substring(0, 3),

                  yValueMapper: (_ChartData data, _) => data.y * 0.3, // Decrease bar height to 30% of original value
                  name: 'Profit',
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  width: 0.2, // Set bar width to a smaller value (0.4 makes it narrower)
                  pointColorMapper: (dynamic data, int index) {
                    return getBarColor(index); // Use index passed by the chart to assign color
                  },
                )
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          )
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: data.length,
          //     itemBuilder: (context, index) {
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Icon(
          //               Icons.circle,
          //               size: 15.0,
          //               color: getBarColor(index),
          //             ),
          //             const SizedBox(width: 10),
          //             Expanded(
          //               child: Text(
          //                 data[index].x, // Access the x property of the _ChartData object
          //                 style: TextStyle(
          //                   color: getBarColor(index),
          //                   fontSize: Primary_font_size.Text7,
          //                   fontWeight: FontWeight.w600,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       );
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final String x;
  final double y;
}
