import 'package:flutter/material.dart';

import '../config/constant.dart';

class ButtonSubmit extends StatelessWidget {
  final String text;
  const ButtonSubmit(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.phoneWidthMargin(context),
      height: 45,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          primary: AppColors.yellowColor,
        ),
        child: Text(
          'Save Product',
          style: AppTextStyle.mediumText.copyWith(fontSize: 15),
        ),
      ),
    );
  }
}
