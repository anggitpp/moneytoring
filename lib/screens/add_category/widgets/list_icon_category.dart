import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/constant.dart';
import '../../../config/theme.dart';
import '../../../cubits/add_category/add_category_cubit.dart';

class ListIconCategory extends StatelessWidget {
  const ListIconCategory({
    Key? key,
    required this.icons,
    required this.selectedIcon,
  }) : super(key: key);

  final List<String> icons;
  final String selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultMargin),
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: icons.map((icon) {
                return InkWell(
                  onTap: () =>
                      context.read<AddCategoryCubit>().changeImage(icon),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: icon == selectedIcon
                          ? AppColors.yellowColor
                          : AppColors.lightGreyColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset(
                        'assets/category/$icon',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
