import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneytoring/screens/home/widgets/profit_text_box.dart';

import '../../../config/constant.dart';
import '../../../config/theme.dart';

class ProfitCard extends StatelessWidget {
  const ProfitCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  child: const Icon(
                    Icons.menu,
                    size: 20,
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
                          .format(5000000),
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
              children: const [
                ProfitTextBox(
                  title: 'Purchase',
                  value: 2000000,
                ),
                SizedBox(
                  width: 20,
                ),
                ProfitTextBox(
                  title: 'Sale',
                  value: 7000000,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
