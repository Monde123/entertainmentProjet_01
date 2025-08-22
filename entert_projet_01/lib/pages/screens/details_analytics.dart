// pages/screens/details_analytics.dart
import 'package:entert_projet_01/theme/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailsAnalytics extends StatefulWidget {
  const DetailsAnalytics({super.key});

  @override
  State<DetailsAnalytics> createState() => _DetailsAnalyticsState();
}

class _DetailsAnalyticsState extends State<DetailsAnalytics> {
  @override
  Widget build(BuildContext context) {
    double largeurEcran = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        actionsPadding: EdgeInsets.all(20),
        backgroundColor: backgroundColor,
        title: Text('Detail analytics', style: style(18, 2)),
        centerTitle: true,
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(FontAwesomeIcons.upRightFromSquare, size: 2),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // debut du widget du container des stats
              branchAnalytics(),

              //fin du widget des revenus(container)
              const SizedBox(height: 12),
              ListTile(
                title: Text('Analytics', style: style(18, 2)),
                trailing: Icon(Icons.menu_sharp, color: textColor, size: 24),
              ),
              SizedBox(height: 12),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 12, bottom: 0),
                  width: largeurEcran,
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: backgroundColor,
                          child: Icon(
                            FontAwesomeIcons.shirt,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                        title: Text('Clothes', style: style(14, 2)),
                        trailing: CircleAvatar(
                          backgroundColor: Colors.amber,
                          child: Icon(
                            FontAwesomeIcons.arrowRightArrowLeft,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      // Line chart implementation
                      Expanded(
                        child: LineChart(
                          LineChartData(
                            lineTouchData: LineTouchData(
                              touchTooltipData: LineTouchTooltipData(
                                getTooltipColor:
                                    (LineBarSpot color) => Colors.blueAccent,
                                getTooltipItems: (
                                  List<LineBarSpot> touchedBarSpots,
                                ) {
                                  return touchedBarSpots.map((barSpot) {
                                    return LineTooltipItem(
                                      '\$${(barSpot.y * 10000).toStringAsFixed(0)}',
                                      TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }).toList();
                                },
                              ),
                            ),
                            gridData: FlGridData(show: false),
                            titlesData: FlTitlesData(
                              show: true,
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  getTitlesWidget: (value, meta) {
                                    switch (value.toInt()) {
                                      case 0:
                                        return Text('Jan');
                                      case 1:
                                        return Text('Feb');
                                      case 2:
                                        return Text('Mar');
                                      case 3:
                                        return Text('May');
                                      default:
                                        return Text('');
                                    }
                                  },
                                ),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  /* getTitlesWidget: (value, meta) {
                                    return Text(value.toInt().toString());
                                  },*/
                                  interval: 10,
                                  reservedSize: 30,
                                ),
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                            minX: 0,
                            maxX: 4,
                            minY: 0,
                            maxY: 90,
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  FlSpot(0, 60),
                                  FlSpot(0.7, 60),
                                  FlSpot(1.4, 75),
                                  FlSpot(2.1, 48),
                                  FlSpot(2.7, 18),
                                  FlSpot(3.4, 58),
                                  FlSpot(3.8, 46),
                                  FlSpot(4, 45),
                                ],
                                isCurved: true,
                                color: primaryColor,
                                barWidth: 2,
                                isStrokeCapRound: true,
                                dotData: FlDotData(show: false),
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: primaryColor.withOpacity(0.1),
                                  spotsLine: BarAreaSpotsLine(
                                    show: true,
                                    checkToShowSpotLine:
                                        (spot) => spot.x == 2.7,
                                    flLineStyle: FlLine(
                                      color: Colors.blue.withOpacity(0.5),
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container branchAnalytics() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20),
      margin: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Net Income',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$74000',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '+25.22% (\$5.00)',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            width: 60,
            height: 60,
            child: BarChart(
              BarChartData(
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [BarChartRodData(toY: 1, color: primaryColor)],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [BarChartRodData(toY: 2, color: primaryColor)],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [BarChartRodData(toY: 3, color: primaryColor)],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [BarChartRodData(toY: 4, color: primaryColor)],
                  ),
                ],
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
