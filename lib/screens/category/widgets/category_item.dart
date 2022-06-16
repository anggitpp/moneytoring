import 'package:flutter/material.dart';

import '../../../config/constant.dart';
import '../../../config/theme.dart';

class CategoryItem extends StatelessWidget {
  final String text;
  final String image;
  final Function() onTapEdit;
  final Function() onTapDelete;

  const CategoryItem({
    Key? key,
    required this.text,
    required this.image,
    required this.onTapEdit,
    required this.onTapDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              SizedBox(
                width: 10,
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
              InkWell(
                onTap: onTapEdit,
                child: Icon(
                  Icons.edit,
                  color: AppColors.greyColor,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: onTapDelete,
                child: Icon(
                  Icons.delete,
                  color: AppColors.greyColor,
                ),
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
