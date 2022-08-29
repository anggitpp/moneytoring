import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneytoring/cubits/transaction/transaction_cubit.dart';
import 'package:moneytoring/screens/graph/widgets/sales_chart.dart';
import 'package:moneytoring/screens/graph/widgets/top_product_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moneytoring/config/constant.dart';
import 'package:moneytoring/config/theme.dart';
import 'package:moneytoring/screens/graph/widgets/graph_card_item.dart';
import 'package:moneytoring/widgets/header_page.dart';

import '../../models/category.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  @override
  void initState() {
    super.initState();

    context.read<TransactionCubit>().getRecapTransaction();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        return state.transactionRecapStatus == TransactionRecapStatus.loaded
            ? SafeArea(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    HeaderPage(
                      const SizedBox(),
                      Text(
                        'Graph',
                        style: AppTextStyle.mediumText.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.defaultMargin),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: AppSizes.phoneWidthMargin(context),
                            padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
                            height: 155,
                            decoration: BoxDecoration(
                              color: AppColors.yellowColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Today',
                                      style: AppTextStyle.verySmallText
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                                    const Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  NumberFormat.currency(
                                    locale: 'id_ID',
                                    symbol: 'Rp. ',
                                    decimalDigits: 0,
                                  ).format(state.totalProfit),
                                  style: AppTextStyle.veryLargeText.copyWith(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    GraphCardItem(state.totalExpenses,
                                        text: 'Purchase'),
                                    const SizedBox(width: 10),
                                    GraphCardItem(state.totalIncome,
                                        text: 'Sale'),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Sales',
                            style: AppTextStyle.mediumText
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const SalesChart(),
                          const SizedBox(height: 20),
                          Text(
                            'Top 5 Product',
                            style: AppTextStyle.mediumText.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.topSales.length,
                            itemBuilder: (context, index) {
                              return TopProductItem(
                                topProductSales: state.topSales[index],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
