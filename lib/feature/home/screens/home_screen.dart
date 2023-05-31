// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, unused_local_variable, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, unused_field, sized_box_for_whitespace

import 'package:app_food/constants/global_variable.dart';
import 'package:app_food/feature/admin/widgets/loader.dart';
import 'package:app_food/feature/detail_screen/detail_screen.dart';
import 'package:app_food/feature/home/services/home_services.dart';
import 'package:app_food/feature/home/screens/category_screen.dart';
import 'package:app_food/feature/home/widgets/category_list_product.dart';
import 'package:app_food/feature/home/widgets/custom_text.dart';
import 'package:app_food/feature/home/widgets/popular_product.dart';
import 'package:app_food/feature/search/screens/search_screen.dart';
import 'package:app_food/model/product.dart';

import 'package:app_food/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home-screen";
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchAllProduct();
    fetchDealOfDay();
  }

  Product? dealOfDay;

  Future<void> refereshIndic() async {
    fetchAllProduct();
  }

  double avgRatings = 0.0;
  double myRating = 0.0;
  List<Product>? product;

  fetchAllProduct() async {
    product = await homeServices.fetchAllData(context);
    setState(() {});
  }

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(
      context,
      CategoryScreen.routeName,
      arguments: category,
    );
  }

  fetchDealOfDay() async {
    dealOfDay = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToSearchScreen(String search) async {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: search);
  }

  void navigateToDetailAgain() async {
    Navigator.pushNamed(
      context,
      DetailScreen.routeName,
      arguments: product![2],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return RefreshIndicator(
      onRefresh: refereshIndic,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    Icon(
                      Icons.notifications,
                      size: 26,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 50,
                  child: TextFormField(
                    controller: _searchController,
                    onFieldSubmitted: navigateToSearchScreen,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5),
                      hintText: "Search For Food...",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      prefixIcon: Icon(Icons.search),
                      fillColor: GlobalVariable.greyBackgroundCOlor,
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.maxFinite,
                  height: 100,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: GlobalVariable.categoryImages.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => navigateToCategoryPage(
                          context,
                          GlobalVariable.categoryImages[index]['title']!,
                        ),
                        child: CategoryListProduct(
                          img: GlobalVariable.categoryImages[index]['image']!,
                          text: GlobalVariable.categoryImages[index]['title']
                              .toString(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                CustomText(
                    text: "Popular Local Resturants", prefixText: "See all"),
                SizedBox(
                  height: 20,
                ),
                product == null
                    ? Loader()
                    : Container(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: product!.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            double totalRating = 0;
                            for (int i = 0;
                                i < product![index].rating!.length;
                                i++) {
                              totalRating += product![index].rating![i].rating;
                              if (product![index].rating![i].userId ==
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .user
                                      .id) {
                                myRating = product![index].rating![i].rating;
                              }
                            }
                            if (totalRating != 0) {
                              avgRatings =
                                  totalRating / product![index].rating!.length;
                            }
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  DetailScreen.routeName,
                                  arguments: product![index],
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: PopularProduct(
                                  name: product![index].name,
                                  rating: avgRatings,
                                  pRate: 1324,
                                  image: product![index].images[0],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                SizedBox(
                  height: 20,
                ),
                dealOfDay == null
                    ? Loader()
                    : dealOfDay!.name.isEmpty
                        ? SizedBox()
                        : Container(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 1,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                // double totalRating = 0;
                                // for (int i = 0;
                                //     i < product![-1].rating!.length;
                                //     i++) {
                                //   totalRating +=
                                //       product![index].rating![i].rating;
                                //   if (product![index].rating![i].userId ==
                                //       Provider.of<UserProvider>(context,
                                //               listen: false)
                                //           .user
                                //           .id) {
                                //     myRating =
                                //         product![index].rating![i].rating;
                                //   }
                                // }
                                // if (totalRating != 0) {
                                //   avgRatings = totalRating /
                                //       product![index].rating!.length;
                                // }
                                return Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: GestureDetector(
                                    onTap: navigateToDetailAgain,
                                    child: PopularProduct(
                                      name: dealOfDay!.name,
                                      rating: 3,
                                      pRate: 2043,
                                      image: dealOfDay!.images[0],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
