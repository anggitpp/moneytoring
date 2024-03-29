import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneytoring/config/constant.dart';
import 'package:moneytoring/cubits/cubits.dart';
import 'package:moneytoring/screens/product/widgets/product_item.dart';
import 'package:moneytoring/widgets/header_page.dart';

import '../../config/route_name.dart';
import '../../../config/theme.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    context.read<ProductCubit>().loadProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "btnProduct",
        onPressed: () {
          Navigator.pushNamed(
            context,
            RouteName.addProduct,
            arguments: {
              'id': null,
            },
          );
        },
        backgroundColor: AppColors.yellowColor,
        child: const Icon(
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
              const SizedBox(width: 20),
              Text(
                'Products',
                style: AppTextStyle.largeText
                    .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const Icon(Icons.menu),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.defaultMargin),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  hintText: 'Search here ..',
                  hintStyle: AppTextStyle.greyMediumText,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Divider(
              color: AppColors.lightGreyColor,
              thickness: 1,
            ),
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                return state.productStatus != ProductStatus.loading
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          return ProductItem(
                            product: state.products[index],
                          );
                        },
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
