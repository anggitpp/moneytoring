import 'dart:io';

import 'package:flutter/material.dart';

import '../../../config/theme.dart';
import '../../../models/product.dart';

class ProductBox extends StatelessWidget {
  final Product product;
  final Function()? onPress;
  const ProductBox(
    this.product, {
    this.onPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 80,
        height: 102,
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: FileImage(File(product.imagePath)),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              product.name,
              textAlign: TextAlign.start,
              style: AppTextStyle.greySmallText.copyWith(fontSize: 10),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Stock : ',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.greySmallText.copyWith(fontSize: 8),
                ),
                Text(
                  product.stock.toString(),
                  textAlign: TextAlign.center,
                  style: AppTextStyle.greySmallText
                      .copyWith(fontSize: 8, color: AppColors.greenColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
