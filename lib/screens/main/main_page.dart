import 'package:flutter/material.dart';
import 'package:moneytoring/screens/graph/graph_page.dart';
import 'package:moneytoring/screens/product/product_page.dart';

import '../../config/constant.dart';
import '../home/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  void _onTapBottomNavigationBar(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => _onTapBottomNavigationBar(index),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: AppColors.yellowColor,
          unselectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.draw,
                  size: 30,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.pie_chart,
                  size: 30,
                ),
                label: ''),
          ],
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: const [
          HomePage(),
          ProductPage(),
          GraphPage(),
        ],
      ),
    );
  }
}
