// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_local_variable

import 'package:app_food/constants/global_variable.dart';
import 'package:app_food/feature/cart/screens/cart_screen.dart';
import 'package:app_food/feature/home/screens/home_screen.dart';
import 'package:app_food/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../account/screens/account_screen.dart';

class NavBarScreen extends StatefulWidget {
  static const String routeName = "/nav-bar";
  NavBarScreen({Key? key}) : super(key: key);

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _page = 0;
  void onNavBarTap(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    HomeScreen(),
    AccountScreen(),
    CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart!.length;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        onTap: onNavBarTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text(userCartLen.toString()),
              backgroundColor: GlobalVariable.secSelectNavBar,
              child: Icon(
                Icons.add_shopping_cart,
              ),
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
