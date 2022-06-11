import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../config/constant.dart';
import '../../../config/theme.dart';

class GraphCardItem extends StatelessWidget {
  const GraphCardItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.phoneWidthMargin(context) / 2 - 15,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Purchase',
            style: AppTextStyle.greyMediumText.copyWith(fontSize: 15),
          ),
          const SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Rp. ',
                style: AppTextStyle.greyMediumText.copyWith(fontSize: 15),
              ),
              Text(
                NumberFormat.currency(
                        locale: 'id_ID', symbol: '', decimalDigits: 0)
                    .format(7000000),
                style: AppTextStyle.mediumText
                    .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
