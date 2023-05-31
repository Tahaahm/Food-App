// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:app_food/feature/address/screens/address_screen.dart';
import 'package:app_food/feature/admin/screens/add_product_screen.dart';
import 'package:app_food/feature/admin/screens/admin_screen.dart';
import 'package:app_food/feature/auth/screen/auth_screen.dart';
import 'package:app_food/feature/auth/screen/signup_screen.dart';
import 'package:app_food/feature/detail_screen/detail_screen.dart';
import 'package:app_food/feature/home/screens/category_screen.dart';
import 'package:app_food/feature/home/screens/home_screen.dart';
import 'package:app_food/feature/home/screens/navbar_screen.dart';
import 'package:app_food/feature/search/screens/search_screen.dart';
import 'package:app_food/model/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (builder) => AuthScreen(),
      );
    case SignUpScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (builder) => SignUpScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (builder) => HomeScreen(),
      );
    case NavBarScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (builder) => NavBarScreen(),
      );

    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (builder) => AdminScreen(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (builder) => AddProductScreen(),
      );
    case CategoryScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (builder) => CategoryScreen(
          category: category,
        ),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (builder) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case DetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (builder) => DetailScreen(
          products: product,
        ),
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (builder) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (builder) => Scaffold(
          body: Center(
            child: Text("Page doesn't exist"),
          ),
        ),
      );
  }
}
