import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:moneytoring/models/transaction_model.dart';

import '../../../config/constant.dart';
import '../../../config/theme.dart';
import '../../../cubits/cubits.dart';

class RecentTransactionItem extends StatelessWidget {
  final TransactionModel transactionModel;
  const RecentTransactionItem(
    this.transactionModel, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var arrDetail = transactionModel.detailTransaction.split('|');
    // print(arrDetail);
    var productName = arrDetail[0] +
        (int.parse(arrDetail[2]) > 1
            ? ' + ${int.parse(arrDetail[2]) - 1} lainnya'
            : '');
    var imagePath =
        context.watch<HomeCubit>().localImagePath + '/' + arrDetail[1];

    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image(
                  image: FileImage(File(imagePath)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: AppTextStyle.mediumText,
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      transactionModel.buyerName,
                      style: AppTextStyle.greySmallText,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                        '(${DateFormat("dd MMMM yyyy").format(DateTime.parse(transactionModel.transactionDate))})',
                        style: AppTextStyle.greySmallText),
                  ],
                )
              ],
            ),
            const Spacer(),
            Text(
              NumberFormat.currency(
                      locale: 'id_ID', symbol: '', decimalDigits: 0)
                  .format(transactionModel.totalPrice),
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
