// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:app_food/constants/global_variable.dart';
import 'package:app_food/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../constants/error_handling.dart';
import '../../../constants/utils.dart';
import '../../../model/product.dart';

class HomeServices {
  Future<List<Product>> fetchAllData(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response response =
          await http.get(Uri.parse('$uri/auth/get-product'), headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "x-auth-token": userProvider.user.token
      });
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(response.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response response = await http
          .get(Uri.parse('$uri/api/products?category=$category'), headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "x-auth-token": userProvider.user.token
      });
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(response.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<Product> fetchDealOfDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product productList = Product(
      name: "",
      description: '',
      quantity: 0,
      images: [],
      category: '',
      price: 0,
    );
    try {
      print("Successful first");
      http.Response response =
          await http.get(Uri.parse('$uri/api/deal-of-day'), headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "x-auth-token": userProvider.user.token
      });
      print("Success seco");
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          productList = Product.fromJson(response.body);
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    return productList;
  }
}
