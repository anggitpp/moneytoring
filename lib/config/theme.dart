import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supercharged/supercharged.dart';

class AppTextStyle {
  static TextStyle verySmallText =
      GoogleFonts.poppins(fontSize: 10, color: Colors.black);
  static TextStyle smallText =
      GoogleFonts.poppins(fontSize: 12, color: Colors.black);
  static TextStyle mediumText =
      GoogleFonts.poppins(fontSize: 14, color: Colors.black);
  static TextStyle largeText =
      GoogleFonts.poppins(fontSize: 16, color: Colors.black);
  static TextStyle veryLargeText =
      GoogleFonts.poppins(fontSize: 18, color: Colors.black);

  static TextStyle greySmallText =
      GoogleFonts.poppins(fontSize: 12, color: AppColors.greyColor);
  static TextStyle greyMediumText =
      GoogleFonts.poppins(fontSize: 14, color: AppColors.greyColor);
}

class AppColors {
  static Color yellowColor = '#FFC801'.toColor();
  static Color backgroundColor = '#FAFAFA'.toColor();
  static Color greyColor = '#8F8F8F'.toColor();
  static Color lightGreyColor = '#E5E5E5'.toColor();
  static Color greenColor = '#0C8B20'.toColor();
}

ThemeData lightTheme = ThemeData(
  tabBarTheme: TabBarTheme(
    labelStyle: AppTextStyle.mediumText,
    unselectedLabelStyle: AppTextStyle.mediumText,
    labelColor: Colors.black,
    unselectedLabelColor: AppColors.greyColor,
    // indicator: ShapeDecoration(
    //   shape: UnderlineInputBorder(
    //     borderSide: BorderSide(color: AppColors.yellowColor),
    //   ),
    // ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.yellowColor,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
);
