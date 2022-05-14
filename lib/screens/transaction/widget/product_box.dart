import 'package:flutter/material.dart';

import '../../../config/theme.dart';

class ProductBox extends StatelessWidget {
  const ProductBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 102,
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70,
            height: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage('assets/images/aquarium.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Aquarium M',
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
                '10',
                textAlign: TextAlign.center,
                style: AppTextStyle.greySmallText
                    .copyWith(fontSize: 8, color: AppColors.greenColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
