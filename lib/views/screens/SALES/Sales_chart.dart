import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ssipl_billing/themes/style.dart';

class Sales_chart extends StatefulWidget {
  const Sales_chart({super.key});

  @override
  Sales_chartState createState() => Sales_chartState();
}

class Sales_chartState extends State<Sales_chart> {
  int touchedIndex = -1; // Initialize touchedIndex

  @override
  Widget build(BuildContext context) {
    double maxPercentage = getMaxPercentage();
    String maxLabel = getMaxPercentageLabel(); // Get the label for the max percentage

    return Row(
      children: <Widget>[
        const SizedBox(
          height: 18,
        ),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 2,
                    sections: showingSections(),
                  ),
                ),
                // Display the label and percentage in the center
                Text(
                  '$maxLabel\n${maxPercentage.toStringAsFixed(0)}%', // Show label and max percentage
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Indicator(
              color: Color.fromARGB(255, 249, 140, 236),
              text: 'Completed',
              isSquare: true,
            ),
            SizedBox(
              height: 10,
            ),
            Indicator(
              color: Primary_colors.Color8,
              text: 'Pending',
              isSquare: true,
            ),
          ],
        ),
        const SizedBox(
          width: 28,
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 15.0; // Increased size on hover
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      final valueList = [40, 30, 15, 15];
      return PieChartSectionData(
        color: getColor(i),
        value: valueList[i].toDouble(),
        title: isTouched ? '${valueList[i]}%' : '', // Show value on hover
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
    });
  }

  // Utility function to get color by index
  Color getColor(int index) {
    switch (index) {
      case 0:
        return Primary_colors.Color8;
      case 1:
        return Primary_colors.Color5;

      default:
        return Colors.grey;
    }
  }

  double getMaxPercentage() {
    final sections = showingSections();
    double maxValue = 0.0;
    for (var section in sections) {
      if (section.value > maxValue) {
        maxValue = section.value;
      }
    }
    return maxValue;
  }

  String getMaxPercentageLabel() {
    final sections = showingSections();
    double maxValue = 0.0;
    int maxIndex = 0;

    for (int i = 0; i < sections.length; i++) {
      if (sections[i].value > maxValue) {
        maxValue = sections[i].value;
        maxIndex = i;
      }
    }

    switch (maxIndex) {
      case 0:
        return 'Completed';
      case 1:
        return 'Pending';

      default:
        return '';
    }
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;

  const Indicator({
    required this.color,
    required this.text,
    this.isSquare = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 10, color: Color.fromARGB(255, 176, 176, 176)),
        ),
      ],
    );
  }
}
