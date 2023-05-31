// ignore_for_file: prefer_const_constructors, must_be_immutable, unnecessary_brace_in_string_interps

import 'package:app_food/constants/global_variable.dart';
import 'package:app_food/constants/utils.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.isobscure = false,
      required this.icon,
      this.isAddress = false})
      : super(key: key);
  final String hintText;
  bool? isobscure;
  final TextEditingController controller;
  final IconData icon;
  final bool isAddress;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.2),
        borderRadius: BorderRadius.circular(25),
        color: GlobalVariable.greyBackgroundCOlor.withOpacity(0.3),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Icon(icon),
            ),
          ),
          Expanded(
            child: TextFormField(
              style: TextStyle(color: isAddress ? Colors.black : Colors.white),
              controller: controller,
              obscureText: isobscure!,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                labelStyle:
                    TextStyle(color: isAddress ? Colors.black : Colors.white),
                hintText: hintText,
                hintStyle:
                    TextStyle(color: isAddress ? Colors.black : Colors.white),
                hoverColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  showSnackBar(context, "Please enter your ${hintText}");
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
