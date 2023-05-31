// ignore_for_file: prefer_const_constructors

import 'package:app_food/constants/global_variable.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget(
      {Key? key, required this.controller, required this.hintText})
      : super(key: key);
  final TextEditingController controller;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextFormField(
        controller: controller,
        onFieldSubmitted: (value) {},
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 5),
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(35),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(35),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(35),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(35),
          ),
          prefixIcon: Icon(Icons.search),
          fillColor: GlobalVariable.greyBackgroundCOlor,
          filled: true,
        ),
      ),
    );
  }
}
