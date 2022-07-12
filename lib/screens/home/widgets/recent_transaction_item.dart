import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:moneytoring/models/transaction_model.dart';

import '../../../config/constant.dart';
import '../../../config/theme.dart';

class RecentTransactionItem extends StatelessWidget {
  final TransactionModel transactionModel;
  const RecentTransactionItem(
    this.transactionModel, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('assets/images/aquarium.jpeg'),
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aquarium XL + 3 lainnya',
                  style: AppTextStyle.mediumText,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Buyer Name (25 November 2022)',
                  style: AppTextStyle.greySmallText,
                )
              ],
            ),
            const Spacer(),
            Text(
              NumberFormat.currency(
                      locale: 'id_ID', symbol: '', decimalDigits: 0)
                  .format(450000),
              style:
                  AppTextStyle.mediumText.copyWith(fontWeight: FontWeight.w500),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Spacer(),
            Container(
              width: AppSizes.phoneWidth(context) -
                  60 -
                  2 * AppSizes.defaultMargin,
              height: 1,
              color: AppColors.lightGreyColor,
              alignment: Alignment.centerRight,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
