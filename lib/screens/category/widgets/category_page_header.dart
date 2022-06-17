import 'package:flutter/material.dart';

import '../../../config/route_name.dart';
import '../../../config/theme.dart';
import '../../../widgets/header_page.dart';

class CategoryPageHeader extends StatelessWidget {
  const CategoryPageHeader({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderPage(
          InkWell(
              onTap: () => Navigator.pushNamed(context, RouteName.home),
              child: const Icon(Icons.arrow_back)),
          Text(
            'Category',
            style: AppTextStyle.largeText
                .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 20),
        ),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey, width: 0.8),
            ),
          ),
          child: TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                color: AppColors.yellowColor,
                width: 3.0,
              ),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            onTap: (index) => onTap!(index),
            tabs: const [
              Tab(
                child: Text(
                  'Income',
                ),
              ),
              Tab(
                child: Text(
                  'Expenses',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
