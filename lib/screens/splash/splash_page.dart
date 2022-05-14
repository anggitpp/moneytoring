import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moneytoring/config/route_name.dart';

import '../../../config/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, RouteName.main));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Moneytoring',
                style: AppTextStyle.largeText.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Monitoring your money now\neasier than before.',
                textAlign: TextAlign.center,
                style: AppTextStyle.greyMediumText.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset('assets/splash_image.png'),
            ],
          ),
        ),
      ),
    );
  }
}
