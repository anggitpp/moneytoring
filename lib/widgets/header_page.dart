import 'package:flutter/material.dart';

import '../config/constant.dart';

class HeaderPage extends StatelessWidget {
  final Widget? widget1;
  final Widget? widget2;
  final Widget? widget3;

  const HeaderPage(
    this.widget1,
    this.widget2,
    this.widget3, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.defaultMargin, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget1!,
          widget2!,
          widget3!,
        ],
      ),
    );
  }
}
