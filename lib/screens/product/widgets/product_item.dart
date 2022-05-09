import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../config/constant.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: 17, horizontal: AppSizes.defaultMargin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 85,
                height: 85,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  child: Image(
                    image: AssetImage('assets/images/bulb.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: AppSizes.phoneWidth(context) -
                        95 -
                        AppSizes.defaultMargin * 2,
                    child: Text(
                      'Bardi Smart Bulb 9W With RGB 16 Million Color',
                      maxLines: 2,
                      style: AppTextStyle.smallText
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    NumberFormat.currency(
                            locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
                        .format(99900),
                    style: AppTextStyle.smallText,
                  ),
                  SizedBox(
                    width: AppSizes.phoneWidth(context) -
                        95 -
                        AppSizes.defaultMargin * 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Stock: 10',
                          style: AppTextStyle.smallText,
                        ),
                        Container(
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
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          color: AppColors.lightGreyColor,
          thickness: 1,
        ),
      ],
    );
  }
}
