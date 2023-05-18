import 'package:camp_booking/Services/ApiService.dart';
import 'package:camp_booking/Pages/HOME/laptopHomeScreen.dart';
import 'package:camp_booking/Pages/HOME/mobileHomeScreen.dart';
import 'package:camp_booking/Pages/HOME/tabletHomeScreen.dart';
import 'package:camp_booking/Responsive_Layout/responsive_layout.dart';
import 'package:flutter/material.dart';

import 'package:camp_booking/constant.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoad = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: SizedBox(
          width: size < 400 ? 320 : 350,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.android, color: Colors.black, size: 100),
                  height(20),
                  Text("Hello Again".toUpperCase(),
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                  const Text("Welcome to Invoice, Login in account",
                      style: TextStyle(color: Colors.grey)),
                  height(20),
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required Email";
                      } else if (!value.contains("@") ||
                          !value.contains(".com")) {
                        return 'Invalid Email';
                      } else {
                        return null;
                      }
                    },
                    decoration: dec("Email"),
                  ),
                  height(10),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: password,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Required password';
                      }
                      return null;
                    },
                    decoration: dec("Password"),
                  ),
                  height(10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: const Text("Forget Password",
                            style: TextStyle(color: Colors.blue))),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(350, 60),
                        backgroundColor: Colors.deepPurpleAccent,
                        foregroundColor: Colors.white),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        setState(() {
                          isLoad = true;
                        });
                        Auth.loginUser(context, email.text, password.text);
                      }
                    },
                    child: const Text("Sign In"),
                  ),
                  height(10),
                  const Text.rich(
                      TextSpan(text: "Didn't have Account | ", children: [
                    TextSpan(
                        text: "Register Now",
                        style: TextStyle(
                            color: Colors.blue, fontStyle: FontStyle.italic))
                  ])),
                  height(10),
                  if (isLoad)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
