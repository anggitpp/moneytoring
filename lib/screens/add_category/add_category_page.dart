import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moneytoring/config/constant.dart';
import 'package:moneytoring/config/route_name.dart';
import 'package:moneytoring/cubits/add_category/add_category_cubit.dart';
import 'package:moneytoring/models/category.dart';
import 'package:moneytoring/widgets/button_submit.dart';
import 'package:moneytoring/widgets/header_page.dart';

import '../../config/theme.dart';

class AddCategoryPage extends StatefulWidget {
  final Map arguments;
  const AddCategoryPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> icons = [
      'icon-aquarium.png',
      'icon-electronic.png',
      'icon-bulb.png',
    ];
    return BlocConsumer<AddCategoryCubit, AddCategoryState>(
      listener: (context, state) {
        state.addCategoryStatus == AddCategoryStatus.finish
            ? Navigator.pushReplacementNamed(context, RouteName.category)
            : null;
      },
      builder: (context, state) {
        print(widget.arguments);
        return Scaffold(
          body: SafeArea(
            child: state.addCategoryStatus != AddCategoryStatus.submitting
                ? Stack(
                    children: [
                      Column(
                        children: [
                          HeaderPage(
                            InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, RouteName.category),
                                child: const Icon(Icons.arrow_back)),
                            Text(
                              'Add Category',
                              style: AppTextStyle.largeText.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(width: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSizes.defaultMargin),
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
                                      'assets/icon/${state.selectedIcon}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      hintText: 'Category Name',
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.yellowColor),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.yellowColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Icon',
                            style: AppTextStyle.largeText,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.defaultMargin),
                              child: SingleChildScrollView(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Wrap(
                                    spacing: 20,
                                    runSpacing: 20,
                                    children: icons.map((icon) {
                                      return InkWell(
                                        onTap: () => context
                                            .read<AddCategoryCubit>()
                                            .changeImage(icon),
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: icon == state.selectedIcon
                                                ? AppColors.yellowColor
                                                : AppColors.lightGreyColor,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          alignment: Alignment.center,
                                          child: SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: Image.asset(
                                              'assets/icon/$icon',
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
                          ),
                        ],
                      ),
                      Align(
                        alignment: const Alignment(0, 0.9),
                        child: state.addCategoryStatus !=
                                AddCategoryStatus.submitting
                            ? ButtonSubmit(
                                'Simpan',
                                onPressed: () => context
                                    .read<AddCategoryCubit>()
                                    .insertCategory(
                                      Category(
                                        categoryType:
                                            widget.arguments['categoryType'] ==
                                                    0
                                                ? CategoryType.income
                                                : CategoryType.expenses,
                                        name: nameController.text,
                                        imagePath:
                                            'assets/icon/${state.selectedIcon}',
                                      ),
                                    ),
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        );
      },
    );
  }
}
