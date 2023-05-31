// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:app_food/constants/utils.dart';
import 'package:app_food/feature/auth/screen/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountServices {
  void logOut(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
          context, AuthScreen.routeName, (route) => false);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
