import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:moneytoring/models/top_product_sales.dart';

import '../../../config/constant.dart';
import '../../../config/theme.dart';
import '../../../cubits/cubits.dart';

class TopProductItem extends StatelessWidget {
  final TopProductSales topProductSales;
  const TopProductItem({
    Key? key,
    required this.topProductSales,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imagePath = context.watch<HomeCubit>().localImagePath +
        '/' +
        topProductSales.imagePath;
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
                  topProductSales.productName,
                  style: AppTextStyle.mediumText,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  '${topProductSales.totalQuantity} Product Sold',
                  style: AppTextStyle.greySmallText,
                )
              ],
            ),
            const Spacer(),
            Text(
              NumberFormat.currency(
                      locale: 'id_ID', symbol: '', decimalDigits: 0)
                  .format(topProductSales.sellingPrice),
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
