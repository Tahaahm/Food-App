// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:app_food/constants/global_variable.dart';
import 'package:app_food/feature/admin/screens/add_product_screen.dart';
import 'package:app_food/feature/admin/services/admin_services.dart';
import 'package:app_food/feature/admin/widgets/loader.dart';
import 'package:app_food/model/product.dart';
import 'package:flutter/material.dart';

import '../../home/widgets/popular_product.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final AdminServices adminServices = AdminServices();
  void navigationToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  List<Product>? products;
  @override
  void initState() {
    super.initState();
    fetchAllProduct();
  }

  fetchAllProduct() async {
    products = await adminServices.fetchAllData(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          products!.removeAt(index);
          setState(() {});
        });
  }

  Future<void> refereshIndic() async {
    await fetchAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: products == null
          ? Loader()
          : RefreshIndicator(
              onRefresh: refereshIndic,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                child: GridView.builder(
                    itemCount: products!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 1,
                      crossAxisCount: 2,
                      childAspectRatio: 0.92,
                    ),
                    itemBuilder: (context, index) {
                      return PopularProduct(
                        isadmin: true,
                        name: products![index].name,
                        rating: 4.5,
                        pRate: 1324,
                        image: products![index].images[0],
                        onPress: () => deleteProduct(products![index], index),
                      );
                    }),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigationToAddProduct,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: GlobalVariable.secSelectNavBar,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
