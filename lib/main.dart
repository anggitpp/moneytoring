import 'package:flutter/material.dart';
import 'package:moneytoring/config/routes.dart';
import 'package:moneytoring/config/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneytoring/cubits/cubits.dart';

import 'repository/repositories.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CategoryRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AddCategoryCubit>(
            create: (context) =>
                AddCategoryCubit(categoryRepository: CategoryRepository()),
          ),
          BlocProvider<CategoryCubit>(
            create: (context) => CategoryCubit(
              categoryRepository: CategoryRepository(),
            ),
          ),
          BlocProvider<TransactionCubit>(
            create: (context) => TransactionCubit(
              categoryRepository: CategoryRepository(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Moneytoring',
          routes: routes,
          theme: lightTheme,
        ),
      ),
    );
  }
}
