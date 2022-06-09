import 'package:flutter/material.dart';

import '../config/constant.dart';
import '../../../config/theme.dart';

class ButtonSubmit extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  const ButtonSubmit(
    this.text, {
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.phoneWidthMargin(context),
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          primary: AppColors.yellowColor,
        ),
        child: Text(
          text,
          style: AppTextStyle.mediumText.copyWith(fontSize: 15),
        ),
      ),
    );
  }
}
