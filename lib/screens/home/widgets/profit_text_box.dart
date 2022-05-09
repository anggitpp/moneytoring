import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../config/constant.dart';

class ProfitTextBox extends StatelessWidget {
  final String title;
  final int value;

  const ProfitTextBox({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.phoneWidth(context) / 2 - 26 - 10,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyle.greyMediumText,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Rp. ',
                style: AppTextStyle.greyMediumText,
              ),
              Text(
                NumberFormat.currency(
                        locale: 'id_ID', decimalDigits: 0, symbol: '')
                    .format(value),
                style: AppTextStyle.mediumText
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
