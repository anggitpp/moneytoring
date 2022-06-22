import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneytoring/config/route_name.dart';

import 'package:moneytoring/models/product.dart';

import '../../../config/constant.dart';
import '../../../config/theme.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 17, horizontal: AppSizes.defaultMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 85,
                    height: 85,
                    child: Card(
                      color: Colors.transparent,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          image: FileImage(File(product.imagePath)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: AppSizes.phoneWidth(context) -
                            95 -
                            AppSizes.defaultMargin * 2,
                        child: Text(
                          product.name,
                          maxLines: 2,
                          style: AppTextStyle.smallText
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        NumberFormat.currency(
                                locale: 'id_ID',
                                symbol: 'Rp. ',
                                decimalDigits: 0)
                            .format(product.sellingPrice),
                        style: AppTextStyle.smallText,
                      ),
                      SizedBox(
                        width: AppSizes.phoneWidth(context) -
                            95 -
                            AppSizes.defaultMargin * 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Stock: ${product.stock}',
                              style: AppTextStyle.smallText,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    RouteName.addProduct,
                                    arguments: {
                                      'id': product.id,
                                    },
                                  ),
                                  child: Container(
                                    width: 80,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: AppColors.yellowColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Edit Product',
                                      style: AppTextStyle.verySmallText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(
          color: AppColors.lightGreyColor,
          thickness: 1,
        ),
      ],
    );
  }
}
