// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../../constants/global_variable.dart';

class CustomCartProduct extends StatelessWidget {
  const CustomCartProduct(
      {Key? key,
      required this.image,
      required this.price,
      required this.name,
      required this.quantity,
      required this.decrease,
      required this.increase})
      : super(key: key);
  final String image;
  final double price;
  final String name;
  final int quantity;
  final VoidCallback decrease;
  final VoidCallback increase;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.maxFinite,
      child: Row(
        children: [
          Container(
            height: 100,
            width: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(
                  image,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: 280,
            padding: const EdgeInsets.symmetric(vertical: 12).copyWith(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "\$$price",
                  style: TextStyle(
                      color: GlobalVariable.secSelectNavBar,
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.only(left: 7, right: 7, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: decrease,
                            child: Icon(Icons.remove),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(quantity.toString()),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: increase,
                            child: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
