import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/route_name.dart';
import '../../../cubits/category/category_cubit.dart';
import '../../../models/category.dart';
import '../../../widgets/alert_dialog.dart';
import 'category_item.dart';

class ListCategory extends StatelessWidget {
  const ListCategory({
    Key? key,
    required this.categories,
    required this.selectedIndex,
  }) : super(key: key);

  final List<Category> categories;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: ((context, index) {
        Category category = categories[index];
        return CategoryItem(
          text: category.name,
          image: category.imagePath,
          onTapEdit: () => Navigator.pushNamed(
            context,
            RouteName.addCategory,
            arguments: {
              'categoryType': selectedIndex,
              'category': category,
            },
          ),
          onTapDelete: () => showGlobalAlertConfirm(
            context,
            'Delete',
            'Are you sure to delete this category? this action cannot be undone.',
            () => context.read<CategoryCubit>().deleteCategory(category.id!),
          ),
        );
      }),
    );
  }
}
