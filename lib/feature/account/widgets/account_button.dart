// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  const AccountButton({Key? key, required this.text, required this.onTap})
      : super(key: key);
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
            color: Colors.black12.withOpacity(0.1),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.white, width: 0.0)),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              primary: Colors.black12.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
          onPressed: onTap,
          child: Text(
            text,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
