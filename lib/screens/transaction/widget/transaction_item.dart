import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../config/constant.dart';
import '../../../config/theme.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage('assets/images/aquarium.jpeg'),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Aquarium M',
              style: AppTextStyle.mediumText,
            ),
            Text(
              NumberFormat.currency(
                      locale: 'id_ID', symbol: '', decimalDigits: 0)
                  .format(50000),
              style: AppTextStyle.greySmallText,
            ),
          ],
        ),
        Spacer(),
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: AppColors.lightGreyColor,
            ),
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.remove,
            size: 20,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          '3',
          style: AppTextStyle.veryLargeText.copyWith(
            fontSize: 20,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: AppColors.lightGreyColor,
            ),
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.add,
            size: 20,
          ),
        ),
      ],
    );
  }
}
