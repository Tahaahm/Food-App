// ignore_for_file: prefer_const_constructors, avoid_print, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  const Stars({Key? key, required this.rating, this.size = 12})
      : super(key: key);
  final double rating;
  final double size;
  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemCount: 5,
      itemSize: size,
      rating: rating,
      itemBuilder: (context, index) {
        return Icon(
          Icons.star,
          color: Colors.amber,
        );
      },
    );
  }
}
