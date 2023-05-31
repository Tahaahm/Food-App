// ignore_for_file: avoid_returning_null_for_void, unnecessary_brace_in_string_interps, unnecessary_null_comparison

import 'package:app_food/constants/utils.dart';
import 'package:flutter/material.dart';

class CustomTextFieldAdmin extends StatelessWidget {
  const CustomTextFieldAdmin(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.maxLine = 1})
      : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final int maxLine;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onFieldSubmitted: (value) {
        if (value.isEmpty || value == null) {
          showSnackBar(context, "Please Enter ${hintText}");
        }
        return null;
      },
    );
  }
}
