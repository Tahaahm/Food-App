// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings, unused_local_variable
import 'package:app_food/constants/stars.dart';
import 'package:app_food/feature/auth/widgets/custom_button.dart';
import 'package:app_food/feature/detail_screen/services/detial_services.dart';
import 'package:app_food/feature/detail_screen/widgets/app_icon.dart';
import 'package:app_food/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../model/product.dart';

class DetailScreen extends StatefulWidget {
  static const String routeName = "/detail-screen";
  const DetailScreen({Key? key, required this.products}) : super(key: key);
  final Product products;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final DetailServices detailServices = DetailServices();
  double avgRatings = 0.0;
  double myRating = 0.0;
  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.products.rating!.length; i++) {
      totalRating += widget.products.rating![i].rating;
      if (widget.products.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.products.rating![i].rating;
      }
    }
    if (totalRating != 0) {
      avgRatings = totalRating / widget.products.rating!.length;
    }
  }

  void addToCart() async {
    detailServices.addToCart(context: context, product: widget.products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: AppIcon(icon: Icons.close),
                ),
                AppIcon(
                  icon: Icons.favorite_outline,
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: Center(
                  child: Text(
                    widget.products.name,
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            pinned: true,
            automaticallyImplyLeading: false,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.products.images[0],
                fit: BoxFit.cover,
                width: double.maxFinite,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${widget.products.price}",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Stars(
                        rating: avgRatings,
                        size: 25,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.products.description,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("ID: " + widget.products.id!),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "You can rate here ",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  RatingBar.builder(
                      initialRating: myRating,
                      itemSize: 24,
                      minRating: 1,
                      allowHalfRating: true,
                      itemPadding: EdgeInsets.symmetric(horizontal: 1),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Icon(
                          Icons.star,
                          color: Colors.amber,
                        );
                      },
                      onRatingUpdate: (rating) {
                        detailServices.rateProduct(
                          context: context,
                          product: widget.products,
                          rating: rating,
                        );
                      })
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
        child: CustomButton(
          onTap: addToCart,
          text: 'Order',
          colorText: Colors.white,
          bgColor: Colors.black,
        ),
      ),
    );
  }
}
