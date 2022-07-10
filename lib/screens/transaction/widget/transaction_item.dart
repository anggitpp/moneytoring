import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneytoring/models/transaction_item.dart';

import '../../../config/theme.dart';
import '../../../models/product.dart';

class TransactionItemWidget extends StatelessWidget {
  final TransactionItem transactionItem;
  final Function()? onPressAdd;
  final Function()? onPressRemove;
  const TransactionItemWidget({
    Key? key,
    required this.transactionItem,
    this.onPressAdd,
    this.onPressRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              image: FileImage(File(transactionItem.product.imagePath)),
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
        GestureDetector(
          onTap: onPressRemove,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: AppColors.lightGreyColor,
              ),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.remove,
              size: 20,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 20,
          child: Text(
            '${transactionItem.amount}',
            style: AppTextStyle.veryLargeText.copyWith(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: onPressAdd,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: AppColors.lightGreyColor,
              ),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.add,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
