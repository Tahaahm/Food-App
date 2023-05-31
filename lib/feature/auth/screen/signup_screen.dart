// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:app_food/constants/global_variable.dart';
import 'package:app_food/feature/auth/screen/auth_screen.dart';
import 'package:app_food/feature/auth/services/auth_services.dart';
import 'package:app_food/feature/auth/widgets/custom_button.dart';
import 'package:app_food/feature/auth/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "/signUp-screen";
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final AuthServices authServices = AuthServices();
  final _keyForm = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
  }

  void userSignUp() async {
    authServices.signUpUser(
      name: _nameController.text,
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              GlobalVariable.secSelectNavBar,
              GlobalVariable.selectNavBar
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.2, 0.7],
          ),
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10)
                .copyWith(top: 180),
            child: Column(
              children: [
                Text(
                  "Food Order",
                  style: TextStyle(
                    fontSize: 42,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Alaways Give Better Food Ever",
                  style: TextStyle(color: Colors.amber),
                ),
                SizedBox(
                  height: 80,
                ),
                Form(
                  key: _keyForm,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        CustomTextField(
                          hintText: "UserName",
                          controller: _nameController,
                          icon: Icons.person,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          hintText: "Email",
                          controller: _emailController,
                          icon: Icons.email,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          hintText: "Password",
                          controller: _passwordController,
                          icon: Icons.key,
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        CustomButton(
                            text: "SignUp",
                            onTap: () {
                              if (_keyForm.currentState!.validate()) {
                                userSignUp();
                              }
                            }),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Do you have account?",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, AuthScreen.routeName);
                              },
                              child: Text(
                                "Login Now",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
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
