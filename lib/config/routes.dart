import 'package:moneytoring/screens/main/main_page.dart';

import '../config/route_name.dart';
import '../screens/splash/splash_page.dart';
import '../screens/home/home_page.dart';

final routes = {
  RouteName.splash: (context) => const SplashPage(),
  RouteName.main: (context) => const MainPage(),
  RouteName.home: (context) => const HomePage(),
};