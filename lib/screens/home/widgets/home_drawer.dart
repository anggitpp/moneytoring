import 'package:flutter/material.dart';
import 'package:moneytoring/config/constant.dart';
import 'package:moneytoring/config/route_name.dart';
import 'package:moneytoring/config/theme.dart';
import 'package:moneytoring/widgets/button_submit.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: AppSizes.phoneHeight(context) / 4,
          color: AppColors.yellowColor,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 80,
                height: 80,
                child: Image.asset('assets/photo.png'),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Anggit Pangestu',
                style: AppTextStyle.mediumText,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () => Navigator.pushNamed(context, RouteName.category),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
              child: Row(
                children: [
                  Icon(
                    Icons.category,
                    size: 30,
                    color: AppColors.greenColor,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Kategori',
                    style: AppTextStyle.largeText,
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: AppColors.lightGreyColor,
        ),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.defaultMargin, vertical: 20),
          child: ButtonSubmit('Sign In'),
        ),
      ],
    );
  }
}
