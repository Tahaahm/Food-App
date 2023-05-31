// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:app_food/model/product.dart';
import 'package:app_food/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/global_variable.dart';
import '../../../constants/utils.dart';
import '../../../providers/user_provider.dart';

class CartServices {
  void removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.delete(
        Uri.parse("$uri/api/remove-from-cart/${product.id}"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token
        },
        body: jsonEncode({
          "id": product.id!,
        }),
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            cart: jsonDecode(response.body)['cart'],
          );
          userProvider.setUserFromModel(user);

          showSnackBar(context, "Remove From Cart ");
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }
}
