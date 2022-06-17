import 'package:flutter/material.dart';

import '../../../config/constant.dart';
import '../../../config/route_name.dart';
import '../../../config/theme.dart';
import '../../../widgets/header_page.dart';

class AddCategoryHeader extends StatelessWidget {
  const AddCategoryHeader({
    Key? key,
    required this.controller,
    required this.selectedIcon,
  }) : super(key: key);

  final TextEditingController controller;
  final String selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderPage(
          InkWell(
              onTap: () => Navigator.pushReplacementNamed(
                    context,
                    RouteName.category,
                    arguments: {
                      'category': null,
                    },
                  ),
              child: const Icon(Icons.arrow_back)),
          Text(
            'Add Category',
            style: AppTextStyle.largeText
                .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSizes.defaultMargin),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.yellowColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.asset(
                    selectedIcon,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Category Name',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.yellowColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.yellowColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
