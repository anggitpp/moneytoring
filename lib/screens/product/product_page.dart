import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneytoring/config/constant.dart';
import 'package:moneytoring/screens/product/widgets/product_item.dart';
import 'package:moneytoring/widgets/header_page.dart';

import '../../config/route_name.dart';
import '../../../config/theme.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "btnProduct",
        onPressed: () => Navigator.pushNamed(context, RouteName.addProduct),
        backgroundColor: AppColors.yellowColor,
        child: Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
        elevation: 0,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            HeaderPage(
              SizedBox(width: 20),
              Text(
                'Products',
                style: AppTextStyle.largeText
                    .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Icon(Icons.menu),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.defaultMargin),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  hintText: 'Search here ..',
                  hintStyle: AppTextStyle.greyMediumText,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 13,
            ),
            Divider(
              color: AppColors.lightGreyColor,
              thickness: 1,
            ),
            Column(
              children: List.generate(
                10,
                (index) => ProductItem(),
              ).toList(),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
