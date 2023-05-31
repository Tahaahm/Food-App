// ignore_for_file: empty_catches, unused_local_variable, unused_import, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:app_food/constants/error_handling.dart';
import 'package:app_food/constants/global_variable.dart';
import 'package:app_food/constants/utils.dart';
import 'package:app_food/model/product.dart';
import 'package:app_food/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dxho6rpik', 'd0pri34e');
      List<String> imageUrl = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            images[i].path,
            folder: name,
          ),
        );
        imageUrl.add(res.secureUrl);
      }
      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrl,
        category: category,
        price: price,
      );
      http.Response response = await http.post(
        Uri.parse("$uri/admin/add-product"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token
        },
        body: product.toJson(),
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Product added Successfully");
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  Future<List<Product>> fetchAllData(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response response =
          await http.get(Uri.parse('$uri/admin/get-product'), headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "x-auth-token": userProvider.user.token
      });
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
          print("object");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
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
