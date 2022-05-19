import 'package:flutter/material.dart';
import 'package:moneytoring/config/constant.dart';

import '../../../config/theme.dart';

class OrderInformationItem extends StatelessWidget {
  final String title;
  final Widget information;

  const OrderInformationItem({
    Key? key,
    required this.title,
    required this.information,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: AppSizes.phoneWidth(context) / 2 - AppSizes.defaultMargin,
            child: Text(
              title,
              style: AppTextStyle.greyMediumText,
            ),
          ),
          SizedBox(
            width: AppSizes.phoneWidth(context) / 2 - AppSizes.defaultMargin,
            child: Align(
              alignment: Alignment.centerRight,
              child: information,
            ),
          )
        ],
      ),
    );
  }
}
