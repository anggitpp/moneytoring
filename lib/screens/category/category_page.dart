import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneytoring/config/route_name.dart';
import 'package:moneytoring/config/theme.dart';
import 'package:moneytoring/models/category.dart';
import 'package:moneytoring/screens/category/widgets/category_item.dart';
import 'package:moneytoring/widgets/header_page.dart';

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
    // TODO: implement initState
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
              onPressed: () => Navigator.pushNamed(
                context,
                RouteName.addCategory,
                arguments: {
                  'categoryType': selectedIndex,
                },
              ),
            ),
            backgroundColor: AppColors.backgroundColor,
            body: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  HeaderPage(
                    InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, RouteName.home),
                        child: const Icon(Icons.arrow_back)),
                    Text(
                      'Category',
                      style: AppTextStyle.largeText
                          .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 20),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.8),
                      ),
                    ),
                    child: TabBar(
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                          color: AppColors.yellowColor,
                          width: 3.0,
                        ),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      onTap: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      tabs: const [
                        Tab(
                          child: Text(
                            'Income',
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Expenses',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        state.categoryStatus == CategoryStatus.loading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                itemCount: incomeCategories.length,
                                itemBuilder: ((context, index) {
                                  Category category = incomeCategories[index];
                                  return CategoryItem(
                                    text: category.name,
                                    image: category.imagePath,
                                  );
                                }),
                              ),
                        state.categoryStatus == CategoryStatus.loading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                itemCount: expenseCategories.length,
                                itemBuilder: ((context, index) {
                                  Category category = expenseCategories[index];
                                  return CategoryItem(
                                    text: category.name,
                                    image: category.imagePath,
                                  );
                                }),
                              ),
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
