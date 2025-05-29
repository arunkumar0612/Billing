import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Pie_chart extends StatefulWidget {
  final int? totalInvoices;
  final int? paidInvoices;
  final int? pendingInvoices;

  const Pie_chart({
    super.key,
    required this.totalInvoices,
    required this.paidInvoices,
    required this.pendingInvoices,
  });

  @override
  Pie_chartState createState() => Pie_chartState();
}

class Pie_chartState extends State<Pie_chart> {
  int touchedIndex = -1;

  double getPercentage(int count) {
    if ((widget.totalInvoices ?? 0) == 0) return 0;
    return (count / widget.totalInvoices!) * 100;
  }

  @override
  Widget build(BuildContext context) {
    final hasData = (widget.totalInvoices ?? 0) > 0 && ((widget.paidInvoices ?? 0) > 0 || (widget.pendingInvoices ?? 0) > 0);

    final sectionData = hasData
        ? [
            {'label': 'Paid', 'value': widget.paidInvoices ?? 0, 'color': const Color.fromARGB(255, 131, 195, 247)},
            {'label': 'Unpaid', 'value': widget.pendingInvoices ?? 0, 'color': const Color.fromARGB(255, 249, 140, 236)},
          ]
        : [
            {
              'label': 'No Data',
              'value': 1,
              'color': Colors.grey.shade400,
            }
          ];

    final maxSection = sectionData.reduce((a, b) => (a['value'] as int) > (b['value'] as int) ? a : b);
    final maxLabel = maxSection['label'] as String;
    final maxValue = getPercentage(maxSection['value'] as int);

    return Row(
      children: <Widget>[
        const SizedBox(height: 18),
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
                    sections: List.generate(sectionData.length, (i) {
                      final isTouched = i == touchedIndex;
                      final fontSize = isTouched ? 25.0 : 16.0;
                      final radius = isTouched ? 60.0 : 15.0;

                      final sectionValue = sectionData[i]['value'] as int;
                      final percentage = hasData ? getPercentage(sectionValue) : 100.0;

                      return PieChartSectionData(
                        color: sectionData[i]['color'] as Color,
                        value: percentage,
                        title: isTouched
                            ? hasData
                                ? '${percentage.toStringAsFixed(0)}%'
                                : ''
                            : '',
                        radius: radius,
                        titleStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: const [Shadow(color: Colors.black, blurRadius: 2)],
                        ),
                      );
                    }),
                  ),
                ),
                Text(
                  hasData ? '$maxLabel\n${maxValue.toStringAsFixed(0)}%' : 'No Data',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: hasData
              ? sectionData
                  .map((section) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Indicator(
                          color: section['color'] as Color,
                          text: '${section['label']} (${section['value']})',
                          isSquare: true,
                        ),
                      ))
                  .toList()
              : [
                  Indicator(
                    color: Colors.grey,
                    text: "No data",
                    isSquare: true,
                  )
                ],
        ),
        const SizedBox(width: 28),
      ],
    );
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
          style: const TextStyle(fontSize: 10, color: Color.fromARGB(255, 176, 176, 176)),
        ),
      ],
    );
  }
}
