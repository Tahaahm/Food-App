// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../constants/global_variable.dart';

class CustomText extends StatelessWidget {
  const CustomText({Key? key, required this.text, required this.prefixText})
      : super(key: key);
  final String text;
  final String prefixText;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Text(
          prefixText,
          style: TextStyle(
              color: GlobalVariable.secSelectNavBar.withOpacity(0.5),
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
