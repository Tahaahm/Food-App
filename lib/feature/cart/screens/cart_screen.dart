// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, unnecessary_string_interpolations, unused_local_variable, unnecessary_brace_in_string_interps, prefer_is_empty

import 'package:app_food/constants/global_variable.dart';
import 'package:app_food/constants/utils.dart';
import 'package:app_food/feature/address/screens/address_screen.dart';
import 'package:app_food/feature/auth/widgets/custom_button.dart';
import 'package:app_food/feature/cart/services/cart_services.dart';
import 'package:app_food/feature/cart/widgets/custom_cart_product.dart';
import 'package:app_food/feature/detail_screen/services/detial_services.dart';
import 'package:app_food/model/product.dart';
import 'package:app_food/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final DetailServices detailServices = DetailServices();
  final CartServices cartServices = CartServices();
  void increaseQuantity(Product product) {
    detailServices.addToCart(context: context, product: product);
  }

  void decreaseQuantity(Product product) {
    cartServices.removeFromCart(context: context, product: product);
  }

  void navigateToAddress(double sum) {
    if (Provider.of<UserProvider>(context, listen: false).user.cart!.length >
        0) {
      Navigator.pushNamed(context, AddressScreen.routeName,
          arguments: sum.toString());
    } else {
      showSnackBar(context, "You don't have any item");
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final carts = context.watch<UserProvider>().user;

    double sum = 0;
    carts.cart!
        .map((e) => sum += e['quantity'] * e['product']['price'] as double)
        .toList();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ).copyWith(top: 45),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  user.name,
                  style: TextStyle(fontSize: 18),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Location",
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: GlobalVariable.selectNavBar,
                        ),
                        Text("${user.address}"),
                      ],
                    )
                  ],
                ),
                Container(),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: carts.cart!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final productCart =
                        context.watch<UserProvider>().user.cart![index];
                    final product = Product.fromMap(
                      productCart['product'],
                    );
                    final quantity = productCart['quantity'];
                    return CustomCartProduct(
                      name: product.name,
                      image: product.images[0],
                      price: product.price,
                      quantity: quantity,
                      decrease: () => decreaseQuantity(product),
                      increase: () => increaseQuantity(product),
                    );
                  }),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 75,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$ ${sum.toStringAsFixed(2)}",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              CustomButton(
                width: 200,
                text: "Order",
                onTap: () => navigateToAddress(sum),
                bgColor: Colors.black,
                colorText: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
