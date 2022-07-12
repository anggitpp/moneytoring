import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:moneytoring/models/transaction_item.dart';

import '../../../config/theme.dart';
import '../../../cubits/home/home_cubit.dart';

class TransactionDetailItem extends StatelessWidget {
  final TransactionItem transactionItem;
  const TransactionDetailItem(this.transactionItem, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imagePath = context.watch<HomeCubit>().localImagePath +
        '/' +
        transactionItem.product.imagePath;
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
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
                  transactionItem.product.name,
                  style: AppTextStyle.mediumText,
                ),
                Text(
                  NumberFormat.currency(
                          locale: 'id_ID', symbol: '', decimalDigits: 0)
                      .format(transactionItem.product.sellingPrice),
                  style: AppTextStyle.greySmallText,
                ),
              ],
            ),
            const Spacer(),
            Text(
              NumberFormat.currency(
                          locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
                      .format(transactionItem.product.sellingPrice *
                          transactionItem.amount) +
                  ' (${transactionItem.amount})',
              style: AppTextStyle.mediumText,
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
