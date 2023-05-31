// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, unused_local_variable

import 'dart:io';

import 'package:app_food/constants/global_variable.dart';
import 'package:app_food/constants/utils.dart';
import 'package:app_food/feature/admin/services/admin_services.dart';
import 'package:app_food/feature/admin/widgets/custom_textfield_admin.dart';
import 'package:app_food/feature/auth/widgets/custom_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = "/add-product";
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();
  final _addProductFormKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _productController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
  }

  void sellProduct() async {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
          context: context,
          name: _productController.text,
          description: _descController.text,
          price: double.parse(_priceController.text),
          quantity: double.parse(_quantityController.text),
          category: categories,
          images: images);
    }
  }

  String categories = 'Steak';
  List<String> productCategories = [
    'Steak',
    'Desserts',
    'BreakFast',
    'FastFood',
  ];
  List<File> images = [];
  void selectImages() async {
    var res = await pickImage();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map((i) => Image.file(i)).toList(),
                        options:
                            CarouselOptions(viewportFraction: 1, height: 200),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          dashPattern: [10, 4],
                          child: Container(
                            width: double.maxFinite,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                Text(
                                  "Select Product Image",
                                  style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 30,
                ),
                CustomTextFieldAdmin(
                  controller: _productController,
                  hintText: "Product Name",
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFieldAdmin(
                  controller: _descController,
                  hintText: "Description",
                  maxLine: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFieldAdmin(
                  controller: _priceController,
                  hintText: "Price",
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFieldAdmin(
                  controller: _quantityController,
                  hintText: "Quantity",
                ),
                SizedBox(
                  height: 22,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: DropdownButton(
                    value: categories,
                    hint: Text(categories),
                    items: productCategories
                        .map((String item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        categories = value!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomButton(
                  text: "Sell",
                  onTap: sellProduct,
                  bgColor: GlobalVariable.selectNavBar,
                  colorText: Colors.white,
                  borderRaduis: 12,
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
