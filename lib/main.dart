import 'package:flutter/material.dart';
import 'package:moneytoring/config/routes.dart';
import 'package:moneytoring/config/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moneytoring',
      routes: routes,
      theme: lightTheme,
    );
  }
}
