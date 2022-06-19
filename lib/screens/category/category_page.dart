import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneytoring/config/route_name.dart';
import 'package:moneytoring/config/theme.dart';
import 'package:moneytoring/models/category.dart';
import 'package:moneytoring/screens/category/widgets/category_page_header.dart';
import 'package:moneytoring/screens/category/widgets/list_category.dart';

import '../../cubits/cubits.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    context.read<CategoryCubit>().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        var incomeCategories = state.categories
            .where((element) => element.categoryType == CategoryType.income)
            .toList();

        var expenseCategories = state.categories
            .where((element) => element.categoryType == CategoryType.expenses)
            .toList();
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
                child: const Icon(
                  Icons.add,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RouteName.addCategory,
                    arguments: {
                      'categoryType': selectedIndex,
                      'category': null,
                    },
                  );
                }),
            backgroundColor: AppColors.backgroundColor,
            body: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  CategoryPageHeader(
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                  Expanded(
                    child: state.categoryStatus == CategoryStatus.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : TabBarView(
                            children: [
                              ListCategory(
                                  categories: incomeCategories,
                                  selectedIndex: selectedIndex),
                              ListCategory(
                                  categories: expenseCategories,
                                  selectedIndex: selectedIndex),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
