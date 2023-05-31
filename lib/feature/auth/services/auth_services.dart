// ignore_for_file: empty_catches, unused_local_variable, use_build_context_synchronously, await_only_futures
import 'dart:convert';

import 'package:app_food/constants/error_handling.dart';
import 'package:app_food/constants/utils.dart';
import 'package:app_food/feature/home/screens/navbar_screen.dart';
import 'package:app_food/model/user.dart';
import 'package:app_food/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/global_variable.dart';

class AuthServices {
  void signUpUser(
      {required String name,
      required BuildContext context,
      required String email,
      required String password}) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        type: '',
        address: '',
        token: '',
        cart: [],
      );
      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            "Account Created! Login with the same email",
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void userSignIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      http.Response res = await http.post(Uri.parse("$uri/api/signin"),
          body: jsonEncode({
            "email": email,
            "password": password,
          }),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences pref = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await pref.setString(
              "x-auth-token",
              jsonDecode(res.body)['token'],
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              NavBarScreen.routeName,
              (route) => false,
            );
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");
      if (token == null) {
        prefs.setString("x-auth-token", '');
      }
      var tokenRes = await http
          .post(Uri.parse('$uri/tokenIsValid'), headers: <String, String>{
        "Content-type": "application/json; charset=UTF-8",
        'x-auth-token': token!,
      });
      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse("$uri/"),
          headers: <String, String>{
            "Content-type": "application/json; charset=UTF-8",
            'x-auth-token': token,
          },
        );
        var userProvoder = Provider.of<UserProvider>(context, listen: false);
        userProvoder.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
