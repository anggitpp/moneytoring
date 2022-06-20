import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneytoring/config/route_name.dart';
import 'package:moneytoring/cubits/cubits.dart';
import 'package:moneytoring/models/product.dart';
import 'package:moneytoring/screens/add_product/widgets/add_product_photo.dart';
import 'package:moneytoring/widgets/button_submit.dart';
import 'package:moneytoring/widgets/create_text_field.dart';

import '../../config/constant.dart';
import '../../config/theme.dart';
import '../../models/category.dart';
import '../../widgets/header_page.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _buyingController = TextEditingController();
  final TextEditingController _sellingController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  late int _categoryId;

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        bottom: false,
        child: BlocConsumer<ProductCubit, ProductState>(
          listener: (context, state) {
            state.addProductStatus == AddProductStatus.success
                ? Navigator.pop(context)
                : null;
          },
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                HeaderPage(
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, RouteName.main),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                  ),
                  Text(
                    'Add Product',
                    style: AppTextStyle.largeText
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 24),
                ),
                const SizedBox(
                  height: 20,
                ),
                AddProductPhoto(
                  onTap: () => context.read<ProductCubit>().uploadImage(),
                  isLoadedImage: state.isLoadedImage,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.defaultMargin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CreateTextField(
                        controller: _nameController,
                        label: 'Product Name',
                        textHint: 'Type your product name',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Category Product',
                        style: AppTextStyle.largeText,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      DropdownButtonFormField<Category>(
                        decoration: InputDecoration(
                          hintText: 'Select your category product',
                          hintStyle: AppTextStyle.greyMediumText,
                          contentPadding: const EdgeInsets.all(17),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.yellowColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.greyColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        isExpanded: true,
                        items: state.categories.map((Category value) {
                          return DropdownMenuItem<Category>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                        onChanged: (_) {
                          _categoryId = _!.id!;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CreateTextField(
                        controller: _buyingController,
                        label: 'Buying Price',
                        textHint: 'Type your buying price',
                        isNumber: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CreateTextField(
                        controller: _sellingController,
                        label: 'Selling Price',
                        textHint: 'Type your selling price',
                        isNumber: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CreateTextField(
                        controller: _stockController,
                        label: 'Stock',
                        textHint: 'Type your stock',
                        isNumber: true,
                        maxLength: 3,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      state.addProductStatus != AddProductStatus.submitting
                          ? ButtonSubmit(
                              'Save Product',
                              onPressed: () => context
                                  .read<ProductCubit>()
                                  .insertProduct(
                                    Product(
                                      name: _nameController.text,
                                      categoryId: _categoryId,
                                      buyingPrice:
                                          double.parse(_buyingController.text),
                                      sellingPrice:
                                          double.parse(_sellingController.text),
                                      stock: int.parse(_stockController.text),
                                      imagePath: state.imagePath,
                                      status: 1,
                                    ),
                                  ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
