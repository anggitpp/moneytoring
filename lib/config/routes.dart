import 'package:flutter/material.dart';
import 'package:moneytoring/screens/add_product/add_product_page.dart';
import 'package:moneytoring/screens/category/category_page.dart';
import 'package:moneytoring/screens/detail_transaction/detail_transcation_page.dart';
import 'package:moneytoring/screens/main/main_page.dart';
import 'package:moneytoring/screens/transaction/transaction_page.dart';

import '../config/route_name.dart';
import '../screens/add_category/add_category_page.dart';
import '../screens/splash/splash_page.dart';
import '../screens/home/home_page.dart';
import '../screens/transaction_detail/transaction_detail_page.dart';

final routes = {
  RouteName.splash: (context) => const SplashPage(),
  RouteName.main: (context) => const MainPage(),
  RouteName.home: (context) => const HomePage(),
  RouteName.addProduct: (context) => AddProductPage(
      arguments: ModalRoute.of(context)!.settings.arguments as Map),
  RouteName.transaction: (context) => TransactionPage(
      arguments: ModalRoute.of(context)?.settings.arguments as Map?),
  RouteName.transactionDetail: (context) => TransactionDetailPage(
      arguments: ModalRoute.of(context)?.settings.arguments as Map?),
  RouteName.detailTransaction: (context) => DetailTransactionPage(
      arguments: ModalRoute.of(context)!.settings.arguments as Map),
  RouteName.category: (context) => const CategoryPage(),
  RouteName.addCategory: (context) => AddCategoryPage(
      arguments: ModalRoute.of(context)!.settings.arguments as Map),
};
