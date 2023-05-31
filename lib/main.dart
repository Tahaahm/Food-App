// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_food/constants/global_variable.dart';
import 'package:app_food/feature/admin/screens/admin_screen.dart';
import 'package:app_food/feature/auth/screen/auth_screen.dart';
import 'package:app_food/feature/auth/services/auth_services.dart';
import 'package:app_food/feature/home/screens/navbar_screen.dart';
import 'package:app_food/providers/user_provider.dart';
import 'package:app_food/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthServices authServices = AuthServices();
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    authServices.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Food',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariable.backgroundColor,
        colorScheme: ColorScheme.light(
          primary: GlobalVariable.selectNavBar,
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == "admin"
              ? AdminScreen()
              : NavBarScreen()
          : AuthScreen(),
    );
  }
}
