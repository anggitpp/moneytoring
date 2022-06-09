import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../config/theme.dart';

class TransactionDetailItem extends StatelessWidget {
  const TransactionDetailItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
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
        const Spacer(),
        Text(
          '2 items',
          style: AppTextStyle.mediumText,
        ),
      ],
    );
  }
}
