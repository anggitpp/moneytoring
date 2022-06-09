import 'package:flutter/cupertino.dart';
import 'package:supercharged/supercharged.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../config/theme.dart';

class SalesChart extends StatefulWidget {
  const SalesChart({Key? key}) : super(key: key);

  @override
  State<SalesChart> createState() => _SalesChartState();
}

class _SalesChartState extends State<SalesChart> {
  late List<ChartData> _chartData;

  @override
  void initState() {
    _chartData = getChartData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGreyColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: SfCircularChart(
        palette: [
          '#DAECFF'.toColor(),
          '#FFE8CF'.toColor(),
          '#FAE3EB'.toColor(),
        ],
        legend: Legend(isVisible: true),
        series: <CircularSeries>[
          DoughnutSeries<ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (ChartData data, _) => data.title,
            yValueMapper: (ChartData data, _) => data.value,
            enableTooltip: true,
          ),
        ],
      ),
    );
  }

  List<ChartData> getChartData() {
    final List<ChartData> chartData = [
      ChartData(title: 'Aquarium', value: 30),
      ChartData(title: 'Smart Breaker', value: 50),
      ChartData(title: 'Lampu', value: 10),
    ];

    return chartData;
  }
}

class ChartData {
  final String title;
  final int value;
  ChartData({
    required this.title,
    required this.value,
  });
}
