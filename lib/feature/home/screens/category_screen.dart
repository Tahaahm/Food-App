// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:app_food/feature/admin/widgets/loader.dart';
import 'package:app_food/feature/home/services/home_services.dart';
import 'package:app_food/feature/home/widgets/popular_product.dart';
import 'package:app_food/model/product.dart';
import 'package:flutter/material.dart';

import '../../search/screens/search_screen.dart';

class CategoryScreen extends StatefulWidget {
  final String category;
  static const String routeName = "/category";
  CategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final HomeServices homeServices = HomeServices();
  List<Product>? products;
  @override
  void initState() {
    super.initState();
    fetchAllCategory();
  }

  fetchAllCategory() async {
    products = await homeServices.fetchCategoryProducts(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.topLeft,
            child: Text(
              "Keep shopping for ${widget.category}",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
            child: products == null
                ? Loader()
                : Expanded(
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: products!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          crossAxisCount: 2,
                          childAspectRatio: 0.92,
                        ),
                        itemBuilder: (context, index) {
                          return PopularProduct(
                            isCategory: true,
                            name: products![index].name,
                            rating: 4.5,
                            pRate: 1324,
                            image: products![index].images[0],
                          );
                        }),
                  ),
          ),
        ],
      ),
    );
  }
}
