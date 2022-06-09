import 'package:flutter/material.dart';
import 'package:moneytoring/config/route_name.dart';
import 'package:moneytoring/config/theme.dart';
import 'package:moneytoring/models/category.dart';
import 'package:moneytoring/screens/category/widgets/category_item.dart';
import 'package:moneytoring/widgets/header_page.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var incomeCategories = dummyCategories
        .where((element) => element.categoryType == CategoryType.income)
        .toList();

    var expenseCategories = dummyCategories
        .where((element) => element.categoryType == CategoryType.expenses)
        .toList();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () => Navigator.pushNamed(context, RouteName.addCategory),
        ),
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              HeaderPage(
                Icon(Icons.arrow_back),
                Text(
                  'Category',
                  style: AppTextStyle.largeText
                      .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 20),
              ),
              Container(
                decoration: BoxDecoration(
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
                  tabs: [
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
                    ListView.builder(
                      itemCount: incomeCategories.length,
                      itemBuilder: ((context, index) {
                        Category category = incomeCategories[index];
                        return CategoryItem(
                          text: category.name,
                          image: category.imagePath,
                        );
                      }),
                    ),
                    ListView.builder(
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
  }
}
