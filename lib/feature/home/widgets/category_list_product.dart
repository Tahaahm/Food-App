// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:app_food/constants/global_variable.dart';
import 'package:flutter/material.dart';

class CategoryListProduct extends StatelessWidget {
  const CategoryListProduct({Key? key, required this.img, required this.text})
      : super(key: key);
  final String img;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: GlobalVariable.greyBackgroundCOlor,
            ),
            child: Center(
              child: Image.asset(
                img,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Text(text),
        ],
      ),
    );
  }
}
