import 'package:flutter/material.dart';
import 'package:moneytoring/widgets/button_submit.dart';
import 'package:moneytoring/widgets/create_text_field.dart';

import '../../config/constant.dart';
import '../../widgets/header_page.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            HeaderPage(
              Icon(
                Icons.arrow_back,
                size: 24,
              ),
              Text(
                'Add Product',
                style: AppTextStyle.largeText
                    .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 24),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/photo_border.png'),
                ),
              ),
              alignment: Alignment.center,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/photo.png'),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CreateTextField(
                    label: 'Product Name',
                    textHint: 'Type your product name',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CreateTextField(
                    label: 'Buying Price',
                    textHint: 'Type your buying price',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CreateTextField(
                    label: 'Selling Price',
                    textHint: 'Type your selling price',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CreateTextField(
                    label: 'Stock',
                    textHint: 'Type your stock',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ButtonSubmit('Save Product'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
