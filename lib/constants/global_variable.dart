import 'package:flutter/material.dart';

String uri = 'https://git.heroku.com/lit-tundra-31470.git';

class GlobalVariable {
  static const colorGradient = LinearGradient(colors: [
    Color.fromRGBO(239, 83, 80, 1),
    Color.fromRGBO(229, 115, 115, 1)
  ]);
  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Steak',
      'image': 'assets/images/steak.webp',
    },
    {
      'title': 'Desserts',
      'image': 'assets/images/desserts.png',
    },
    {
      'title': 'BreakFast',
      'image': 'assets/images/breakfast.webp',
    },
    {
      'title': 'FastFood',
      'image': 'assets/images/fastfood.webp',
    },
  ];
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static const Color selectNavBar = Color.fromRGBO(229, 115, 115, 1);
  static const secSelectNavBar = Color.fromRGBO(239, 83, 80, 1);
}
