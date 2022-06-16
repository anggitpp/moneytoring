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
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.arguments['category'] != null) {
      Category category = widget.arguments['category'];
      nameController.text = category.name;
      context.read<AddCategoryCubit>().getCategory(category);
    } else {
      context.read<AddCategoryCubit>().resetData();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> icons = [
      'icon-aquarium.png',
      'icon-electronic.png',
      'icon-bulb.png',
      'icon-tools.png',
      'icon-money.png',
    ];
    return BlocConsumer<AddCategoryCubit, AddCategoryState>(
      listener: (context, state) {
        state.addCategoryStatus == AddCategoryStatus.finish
            ? Navigator.pushReplacementNamed(context, RouteName.category)
            : null;
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: state.addCategoryStatus != AddCategoryStatus.submitting
                ? Stack(
                    children: [
                      Column(
                        children: [
                          HeaderPage(
                            InkWell(
                                onTap: () => Navigator.pushReplacementNamed(
                                        context, RouteName.category,
                                        arguments: {
                                          'category': null,
                                        }),
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
                        child: ButtonSubmit(
                          'Simpan',
                          onPressed: () => widget.arguments['category'] == null
                              ? context.read<AddCategoryCubit>().insertCategory(
                                    Category(
                                      categoryType:
                                          widget.arguments['categoryType'] == 0
                                              ? CategoryType.income
                                              : CategoryType.expenses,
                                      name: nameController.text,
                                      imagePath:
                                          'assets/icon/${state.selectedIcon}',
                                    ),
                                  )
                              : context.read<AddCategoryCubit>().updateCategory(
                                    Category(
                                      id: widget.arguments['category'].id,
                                      categoryType:
                                          widget.arguments['categoryType'] == 0
                                              ? CategoryType.income
                                              : CategoryType.expenses,
                                      name: nameController.text,
                                      imagePath:
                                          'assets/icon/${state.selectedIcon}',
                                    ),
                                  ),
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        );
      },
    );
  }
}
