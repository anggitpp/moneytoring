import 'package:flutter/material.dart';
import 'package:moneytoring/models/category.dart';

import '../../../config/theme.dart';

class CategoryBox extends StatelessWidget {
  final Category category;
  final bool isSelected;

  const CategoryBox({
    Key? key,
    required this.category,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 80,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color:
                  isSelected ? AppColors.yellowColor : AppColors.lightGreyColor,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: SizedBox(
              width: 40,
              height: 40,
              child: Image.asset(
                category.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            category.name,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: AppTextStyle.greySmallText.copyWith(fontSize: 8),
          ),
        ],
      ),
    );
  }
}
