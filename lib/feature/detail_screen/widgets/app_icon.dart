// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({Key? key, this.size = 40, required this.icon})
      : super(key: key);
  final double size;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size),
      ),
      child: Center(
        child: Icon(
          icon,
          color: Colors.black,
        ),
      ),
    );
  }
}
