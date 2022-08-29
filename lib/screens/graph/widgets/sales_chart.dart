import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneytoring/models/top_product_category.dart';
import 'package:supercharged/supercharged.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../config/theme.dart';
import '../../../cubits/cubits.dart';

class SalesChart extends StatefulWidget {
  const SalesChart({Key? key}) : super(key: key);

  @override
  State<SalesChart> createState() => _SalesChartState();
}

class _SalesChartState extends State<SalesChart> {
  @override
  void initState() {
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
      child: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          print(state.topCategories);
          return SfCircularChart(
            palette: [
              '#DAECFF'.toColor(),
              '#FFE8CF'.toColor(),
              '#FAE3EB'.toColor(),
            ],
            legend: Legend(isVisible: true),
            series: <CircularSeries>[
              DoughnutSeries<TopProductCategory, String>(
                dataSource: state.topCategories,
                xValueMapper: (TopProductCategory data, _) => data.title,
                yValueMapper: (TopProductCategory data, _) => data.value,
                enableTooltip: true,
              ),
            ],
          );
        },
      ),
    );
  }

  // List<TopProductCategory> getChartData() {
  //   final List<TopProductCategory> chartData = [
  //     TopProductCategory(title: 'Aquarium', value: 30),
  //     TopProductCategory(title: 'Smart Breaker', value: 50),
  //     TopProductCategory(title: 'Lampu', value: 10),
  //   ];

  //   return chartData;
  // }
}
