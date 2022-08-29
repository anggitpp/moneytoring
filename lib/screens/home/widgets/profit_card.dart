import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moneytoring/cubits/transaction/transaction_cubit.dart';
import 'package:moneytoring/models/category.dart';

import 'package:moneytoring/models/transaction_model.dart';
import 'package:moneytoring/screens/home/widgets/profit_text_box.dart';
import 'package:collection/collection.dart';

import '../../../config/constant.dart';
import '../../../config/theme.dart';

class ProfitCard extends StatelessWidget {
  final List<TransactionModel> transactions;
  const ProfitCard(
    this.transactions, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dataTransaction = context.read<TransactionCubit>().state;
    return Container(
      width: AppSizes.phoneWidth(context),
      height: 235,
      decoration: BoxDecoration(
        color: AppColors.yellowColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(26, 50, 26, 37),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: InkWell(
                    onTap: Scaffold.of(context).openDrawer,
                    child: const Icon(
                      Icons.menu,
                      size: 20,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Total Profit',
                      style: AppTextStyle.veryLargeText,
                    ),
                    Text(
                      NumberFormat.currency(
                              locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
                          .format(dataTransaction.totalProfit),
                      style: AppTextStyle.veryLargeText
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 22),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 35,
                ),
              ],
            ),
            const SizedBox(
              height: 28,
            ),
            Row(
              children: [
                ProfitTextBox(
                  title: 'Purchase',
                  value: dataTransaction.totalExpenses,
                ),
                SizedBox(
                  width: 20,
                ),
                ProfitTextBox(
                  title: 'Sale',
                  value: dataTransaction.totalIncome,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
