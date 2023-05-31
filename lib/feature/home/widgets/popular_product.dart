// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, must_be_immutable

import 'package:app_food/constants/global_variable.dart';
import 'package:app_food/constants/stars.dart';
import 'package:flutter/material.dart';

class PopularProduct extends StatelessWidget {
  PopularProduct(
      {Key? key,
      required this.name,
      required this.rating,
      required this.pRate,
      required this.image,
      this.isadmin = false,
      this.isCategory = false,
      this.onPress,
      this.isStars = false})
      : super(key: key);
  final String name;
  final String image;
  final double rating;
  final int pRate;
  final bool isadmin;
  VoidCallback? onPress;
  final bool isStars;
  bool isCategory;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: 310,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: GlobalVariable.greyBackgroundCOlor,
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                isadmin
                    ? IconButton(
                        icon: Icon(Icons.delete_outline),
                        onPressed: onPress,
                      )
                    : isCategory
                        ? SizedBox()
                        : Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Icon(
                                Icons.star_rate_rounded,
                                color: GlobalVariable.secSelectNavBar,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  rating.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  "($pRate+ ratings)",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13),
                                ),
                              ),
                            ],
                          ),
              ],
            ),
          ),
          isStars
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Stars(rating: rating),
                )
              : Container(),
        ],
      ),
    );
  }
}
