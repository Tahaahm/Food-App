// ignore_for_file: prefer_const_constructors

import 'package:app_food/constants/global_variable.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.text,
      required this.onTap,
      this.colorText = GlobalVariable.secSelectNavBar,
      this.bgColor = Colors.white,
      this.width = double.maxFinite,
      this.borderRaduis = 50})
      : super(key: key);
  final String text;
  final VoidCallback onTap;
  final Color colorText;
  final Color bgColor;
  final double width;
  final double borderRaduis;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: 50,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(borderRaduis),
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
            color: colorText,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        )),
      ),
    );
  }
}
