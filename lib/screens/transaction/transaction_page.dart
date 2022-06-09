import 'package:flutter/material.dart';
import 'package:moneytoring/config/constant.dart';
import 'package:moneytoring/config/route_name.dart';
import 'package:moneytoring/models/category.dart';
import 'package:moneytoring/screens/transaction/widget/category_box.dart';
import 'package:moneytoring/screens/transaction/widget/product_box.dart';
import 'package:moneytoring/widgets/header_page.dart';
import '../../../config/theme.dart';
import 'widget/transaction_item.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            HeaderPage(
              GestureDetector(
                  onTap: () => Navigator.pushNamed(context, RouteName.main),
                  child: const Icon(Icons.arrow_back)),
              Row(
                children: [
                  Text(
                    'Sale',
                    style: AppTextStyle.veryLargeText
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
            ),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dummyCategories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: index == 0 ? AppSizes.defaultMargin : 10),
                    child: CategoryBox(
                      category: dummyCategories[index],
                      isSelected: index == 0 ? true : false,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.defaultMargin),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(
                  8,
                  (index) => const ProductBox(),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: AppSizes.defaultMargin),
              child: Text(
                'Transaction Item',
                style: AppTextStyle.mediumText,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Divider(
              height: 0,
              thickness: 1,
              color: AppColors.lightGreyColor,
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: List.generate(
                3,
                (index) => const Padding(
                  padding: EdgeInsets.fromLTRB(
                      AppSizes.defaultMargin, 0, AppSizes.defaultMargin, 10),
                  child: TransactionItem(),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () =>
                  Navigator.pushReplacementNamed(context, RouteName.main),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.yellowColor,
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
