// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_local_variable, prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:app_food/constants/global_variable.dart';
import 'package:app_food/feature/account/services/account_services.dart';
import 'package:app_food/feature/account/widgets/account_button.dart';
import 'package:app_food/feature/account/widgets/orders.dart';
import 'package:flutter/material.dart';

import '../../home/widgets/custom_text.dart';
import '../../search/screens/search_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  void navigateToSearchScreen(String search) async {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: search);
  }

  @override
  Widget build(BuildContext context) {
    final AccountServices accountScreen = AccountServices();
    final TextEditingController _searchController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: double.maxFinite,
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
            height: 20,
          ),
          Row(
            children: [
              AccountButton(
                text: "Your Orders",
                onTap: () {},
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              AccountButton(
                text: "LogOut",
                onTap: () => accountScreen.logOut(context),
              ),
              AccountButton(
                text: "Your Wish List",
                onTap: () {},
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          CustomText(
            text: "Your Orders",
            prefixText: "See all",
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 160,
            child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) => Orders(),
            ),
          ),
        ],
      ),
    );
  }
}
