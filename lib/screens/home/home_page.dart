import 'package:flutter/material.dart';
import 'package:moneytoring/config/constant.dart';
import 'package:moneytoring/config/route_name.dart';
import 'package:moneytoring/models/category.dart';
import 'package:moneytoring/repository/category_repository.dart';
import 'package:moneytoring/screens/home/widgets/home_drawer.dart';
import 'package:moneytoring/screens/home/widgets/profit_card.dart';
import 'package:moneytoring/screens/home/widgets/recent_transaction_item.dart';
import '../../config/theme.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    // openDB(
    //   Category(
    //     id: 1,
    //     categoryType: CategoryType.expenses,
    //     name: 'Kategori',
    //     imagePath: 'test',
    //   ),
    // );

    // cekDB();

    tabController = TabController(
      initialIndex: selectedIndex,
      length: 2,
      vsync: this,
    );
  }

  // Future<void> cekDB() async {
  //   var db = await openDatabase('moneytoring.db');

  //   var result = await db.rawQuery('SELECT * FROM categories');
  //   print(result);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      floatingActionButton: FloatingActionButton(
        heroTag: "btnTransaction",
        onPressed: () =>
            Navigator.pushReplacementNamed(context, RouteName.transaction),
        backgroundColor: AppColors.yellowColor,
        child: const Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
        elevation: 0,
      ),
      drawer: const Drawer(
        child: HomeDrawer(),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const ProfitCard(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizes.defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent Transactions',
                  style: AppTextStyle.mediumText.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: AppSizes.phoneWidth(context),
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppColors.lightGreyColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: TabBar(
                    controller: tabController,
                    labelColor: Colors.black,
                    labelStyle: AppTextStyle.mediumText
                        .copyWith(fontWeight: FontWeight.w500),
                    unselectedLabelColor: AppColors.greyColor,
                    unselectedLabelStyle: AppTextStyle.mediumText
                        .copyWith(fontWeight: FontWeight.w500),
                    indicator: BoxDecoration(
                      color: AppColors.yellowColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    tabs: const [
                      Text(
                        'Income',
                      ),
                      Text(
                        'Expenses',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: List.generate(
                    10,
                    (index) => const RecentTransactionItem(),
                  ).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
