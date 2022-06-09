import 'package:flutter/material.dart';

class AppSizes {
  static const double defaultMargin = 26;
  static double phoneWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  static double phoneWidthMargin(context) {
    return MediaQuery.of(context).size.width - 2 * defaultMargin;
  }

  static double phoneHeight(context) {
    return MediaQuery.of(context).size.height;
  }
}
