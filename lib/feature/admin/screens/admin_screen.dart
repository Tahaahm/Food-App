// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:app_food/feature/admin/screens/posts_screen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  AdminScreen({Key? key}) : super(key: key);

  static const String routeName = "/admin";

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  void onNavBarTap(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    PostsScreen(),
    Scaffold(
      body: Center(
        child: Text("Main"),
      ),
    ),
    Scaffold(
      body: Center(
        child: Text("Main"),
      ),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Text("Account"),
            Text("Admin"),
          ],
        ),
        // ignore: prefer_const_literals_to_create_immutables
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        onTap: onNavBarTap,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.all_inbox_outlined,
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
