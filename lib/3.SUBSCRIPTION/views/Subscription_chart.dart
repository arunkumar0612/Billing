import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/Subscription_actions.dart';

class SubscriptionChart extends StatefulWidget {
  const SubscriptionChart({super.key});

  @override
  SubscriptionChartState createState() => SubscriptionChartState();
}

class SubscriptionChartState extends State<SubscriptionChart> {
  int touchedIndex = -1;

  @override
  @override
  Widget build(BuildContext context) {
    final SubscriptionController subscriptionController = Get.find<SubscriptionController>();

    return Obx(() {
      final int completed = subscriptionController.subscriptionModel.subscriptiondata.value?.paidinvoices ?? 0;
      final int pending = subscriptionController.subscriptionModel.subscriptiondata.value?.unpaidinvoices ?? 0;
      double maxPercentage = getMaxPercentage(completed, pending);
      String maxLabel = getMaxPercentageLabel(completed, pending);

      return Row(
        children: <Widget>[
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
                          if (!event.isInterestedForInteractions || pieTouchResponse?.touchedSection == null) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = pieTouchResponse!.touchedSection!.touchedSectionIndex;
                          }
                          setState(() {}); // Rebuild UI
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 2,
                      sections: showingSections(completed, pending),
                    ),
                  ),
                  Text(
                    '$maxLabel\n${maxPercentage.toStringAsFixed(0)}%',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 13.0, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color: Color.fromARGB(255, 128, 184, 240),
                text: 'Completed',
                isSquare: true,
              ),
              SizedBox(height: 10),
              Indicator(
                color: const Color.fromARGB(255, 251, 123, 155),
                text: 'Pending',
                isSquare: true,
              ),
            ],
          ),
          const SizedBox(width: 28),
        ],
      );
    });
  }

  List<PieChartSectionData> showingSections(int completed, int pending) {
    if (completed == 0 && pending == 0) {
      return [
        PieChartSectionData(
          color: Colors.grey, // Placeholder color
          value: 1, // Set a small value to ensure it renders
          title: '',
          radius: 15.0,
          titleStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [Shadow(color: Colors.black, blurRadius: 2)],
          ),
        ),
      ];
    }

    final List<int> valueList = [completed, pending];
    return List.generate(
      2,
      (i) {
        final isTouched = i == touchedIndex;
        final fontSize = isTouched ? 25.0 : 16.0;
        final radius = isTouched ? 60.0 : 15.0;
        const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

        return PieChartSectionData(
          color: getColor(i),
          value: valueList[i].toDouble(),
          title: isTouched ? '${valueList[i]}' : '',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      },
    );
  }

  Color getColor(int index) {
    switch (index) {
      case 0:
        return const Color.fromARGB(255, 128, 184, 240); // Completed
      case 1:
        return const Color.fromARGB(255, 251, 123, 155); // Pending
      default:
        return Colors.grey;
    }
  }

  double getMaxPercentage(int completed, int pending) {
    int maxValue = completed > pending ? completed : pending;
    int total = completed + pending;
    return total == 0 ? 0 : (maxValue / total) * 100;
  }

  String getMaxPercentageLabel(int completed, int pending) {
    return completed >= pending ? 'Completed' : 'Pending';
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
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 176, 176, 176)),
        ),
      ],
    );
  }
}
