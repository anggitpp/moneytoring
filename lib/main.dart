import 'package:flutter/material.dart';
import 'package:moneytoring/config/routes.dart';
import 'package:moneytoring/config/theme.dart';
import 'package:moneytoring/cubits/add_category/add_category_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCategoryCubit(),
      child: MaterialApp(
        title: 'Moneytoring',
        routes: routes,
        theme: lightTheme,
      ),
    );
  }
}
