import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moneytoring/config/route_name.dart';
import 'package:moneytoring/cubits/add_category/add_category_cubit.dart';
import 'package:moneytoring/models/category.dart';
import 'package:moneytoring/screens/add_category/widgets/add_category_header.dart';
import 'package:moneytoring/screens/add_category/widgets/list_icon_category.dart';
import 'package:moneytoring/widgets/button_submit.dart';

import '../../config/theme.dart';

class AddCategoryPage extends StatefulWidget {
  final Map arguments;
  const AddCategoryPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final TextEditingController nameController = TextEditingController();

  List<String> icons = [];

  @override
  void initState() {
    super.initState();
    if (widget.arguments['category'] != null) {
      Category category = widget.arguments['category'];
      nameController.text = category.name;
      context.read<AddCategoryCubit>().getCategory(category);
    } else {
      context.read<AddCategoryCubit>().resetData();
    }

    cekImages().then((value) {
      setState(() {
        icons = value;
      });
    });
  }

  Future<List<String>> cekImages() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final List<String> imagePaths = manifestMap.keys
        .where((String key) => key.contains('category/'))
        .where((String key) => key.contains('.png'))
        .map((e) => e.replaceAll('assets/category/', ''))
        .toList();

    return imagePaths;
  }

  @override
  void dispose() {
    nameController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCategoryCubit, AddCategoryState>(
      listener: (context, state) {
        state.addCategoryStatus == AddCategoryStatus.finish
            ? Navigator.pushReplacementNamed(context, RouteName.category)
            : null;
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: state.addCategoryStatus != AddCategoryStatus.submitting
                ? Stack(
                    children: [
                      Column(
                        children: [
                          AddCategoryHeader(
                              controller: nameController,
                              selectedIcon:
                                  'assets/category/${state.selectedIcon.replaceAll('assets/category/', '')}'),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Icon',
                            style: AppTextStyle.largeText,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ListIconCategory(
                              icons: icons, selectedIcon: state.selectedIcon),
                        ],
                      ),
                      Align(
                        alignment: const Alignment(0, 0.9),
                        child: ButtonSubmit(
                          'Simpan',
                          onPressed: () {
                            var category = Category(
                              id: widget.arguments['category'] == null
                                  ? 0
                                  : widget.arguments['category'].id,
                              categoryType:
                                  widget.arguments['categoryType'] == 0
                                      ? CategoryType.income
                                      : CategoryType.expenses,
                              name: nameController.text,
                              imagePath:
                                  'assets/category/${state.selectedIcon}',
                            );
                            widget.arguments['category'] == null
                                ? context
                                    .read<AddCategoryCubit>()
                                    .insertCategory(category)
                                : context
                                    .read<AddCategoryCubit>()
                                    .updateCategory(category);
                          },
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        );
      },
    );
  }
}
