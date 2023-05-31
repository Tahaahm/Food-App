// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unused_field

import 'package:app_food/feature/admin/widgets/loader.dart';
import 'package:app_food/feature/detail_screen/detail_screen.dart';
import 'package:app_food/feature/search/services/search_services.dart';
import 'package:app_food/model/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../../home/widgets/popular_product.dart';
import '../../home/widgets/search_widget.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  SearchScreen({Key? key, required this.searchQuery}) : super(key: key);
  final String searchQuery;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final SearchServices searchServices = SearchServices();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    fetchSearchProduct();
  }

  double avgRatings = 0.0;
  double myRating = 0.0;

  fetchSearchProduct() async {
    products = await searchServices.fetchSearchProducts(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: products == null
          ? Loader()
          : Padding(
              padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
              child: GridView.builder(
                  itemCount: products!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 0.1,
                  ),
                  itemBuilder: (context, index) {
                    double totalRating = 0;
                    for (int i = 0; i < products![index].rating!.length; i++) {
                      totalRating += products![index].rating![i].rating;
                      if (products![index].rating![i].userId ==
                          Provider.of<UserProvider>(context, listen: false)
                              .user
                              .id) {
                        myRating = products![index].rating![i].rating;
                      }
                    }
                    if (totalRating != 0) {
                      avgRatings =
                          totalRating / products![index].rating!.length;
                    }
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          DetailScreen.routeName,
                          arguments: products![index],
                        );
                      },
                      child: PopularProduct(
                        isCategory: true,
                        name: products![index].name,
                        rating: avgRatings,
                        pRate: 1324,
                        image: products![index].images[0],
                        isStars: true,
                      ),
                    );
                  }),
            ),
    );
  }
}
