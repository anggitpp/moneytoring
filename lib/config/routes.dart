import 'package:moneytoring/screens/add_product/add_product_page.dart';
import 'package:moneytoring/screens/main/main_page.dart';
import 'package:moneytoring/screens/transaction/transaction_page.dart';

import '../config/route_name.dart';
import '../screens/splash/splash_page.dart';
import '../screens/home/home_page.dart';
import '../screens/transaction_detail/transaction_detail_page.dart';

final routes = {
  RouteName.splash: (context) => const SplashPage(),
  RouteName.main: (context) => const MainPage(),
  RouteName.home: (context) => const HomePage(),
  RouteName.addProduct: (context) => const AddProductPage(),
  RouteName.transaction: (context) => const TransactionPage(),
  RouteName.transactionDetail: (context) => const TransactionDetailPage(),
};
