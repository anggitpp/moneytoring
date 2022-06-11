import 'package:flutter/material.dart';

import '../../../config/constant.dart';
import '../../../config/theme.dart';

class CategoryItem extends StatelessWidget {
  final String text;
  final String image;

  const CategoryItem({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.defaultMargin, vertical: 15),
          child: Row(
            children: [
              Icon(
                Icons.menu,
                color: AppColors.greyColor,
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.lightGreyColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                text,
                style: AppTextStyle.largeText,
              ),
              const Spacer(),
              Icon(
                Icons.delete,
                color: AppColors.greyColor,
              )
            ],
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: AppColors.lightGreyColor,
        ),
      ],
    );
  }
}
