// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, unused_local_variable

import 'package:app_food/constants/utils.dart';
import 'package:app_food/feature/address/services/address_services.dart';
import 'package:app_food/feature/auth/widgets/custom_textfield.dart';
import 'package:app_food/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = "/address-screen";
  AddressScreen({Key? key, required this.totalAmount}) : super(key: key);
  final String totalAmount;
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressKey = GlobalKey<FormState>();
  String addressToBeUsed = '';
  final AddressServices addressServices = AddressServices();
  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  void onPay(addressFromProvider) {
    addressToBeUsed = '';
    bool isFrom = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isFrom) {
      if (_addressKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${pincodeController.text} - ${cityController.text}';
      } else {
        throw Exception("please enter all the values");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else if (Provider.of<UserProvider>(context).user.address.isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
      showSnackBar(context, "Please Enter the address");
    } else {
      showSnackBar(context, "ERROR");
    }
    if (addressFromProvider.isNotEmpty) {
      addressServices.orderPlace(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: AppBar(
        title: Text("Address"),
      ),
      body: Form(
        key: _addressKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (address.isNotEmpty)
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 5, right: 5, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Text(
                              address,
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "OR",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  isAddress: true,
                  hintText: "Flat,House no,Building",
                  controller: flatBuildingController,
                  icon: Icons.location_on,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  isAddress: true,
                  hintText: "Area, Street",
                  controller: areaController,
                  icon: Icons.location_searching,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  isAddress: true,
                  hintText: "Pincode",
                  controller: pincodeController,
                  icon: Icons.person_pin_circle_outlined,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  isAddress: true,
                  hintText: "City",
                  controller: cityController,
                  icon: Icons.location_city,
                ),
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    onPay(address);
                  },
                  child: Container(
                    height: 50,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Text(
                        "Pay",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
