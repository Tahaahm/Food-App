// ignore_for_file: empty_catches, unused_local_variable, unused_import, use_build_context_synchronously, camel_case_types

import 'dart:convert';
import 'dart:io';

import 'package:app_food/constants/error_handling.dart';
import 'package:app_food/constants/global_variable.dart';
import 'package:app_food/constants/utils.dart';
import 'package:app_food/model/product.dart';
import 'package:app_food/model/user.dart';
import 'package:app_food/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response =
          await http.post(Uri.parse("$uri/api/save-user-product"),
              headers: {
                "Content-Type": "application/json; charset=UTF-8",
                "x-auth-token": userProvider.user.token
              },
              body: jsonEncode({
                'address': address,
              }));
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            address: jsonDecode(response.body)['address'],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  void orderPlace({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response response = await http.post(Uri.parse('$uri/api/order'),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": userProvider.user.token
          },
          body: jsonEncode({
            'cart': userProvider.user.cart,
            'address': address,
            'totalPrice': totalSum,
          }));
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Your order has been placed');
          User user = userProvider.user.copyWith(
            cart: [],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response =
          await http.post(Uri.parse("$uri/admin/delete-product"),
              headers: {
                "Content-Type": "application/json; charset=UTF-8",
                "x-auth-token": userProvider.user.token
              },
              body: jsonEncode({"id": product.id}));
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
      // ignore: dead_code_catch_following_catch
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
