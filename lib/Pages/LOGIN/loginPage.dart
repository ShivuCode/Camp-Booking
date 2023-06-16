// ignore: file_names
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:camp_booking/constant.dart';

import '../../Services/ApiService.dart';

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
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.white,
                width: size > 800 ? size * .6 : size,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                child: SizedBox(
                  width: size < 400 ? 320 : 350,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        height(40),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.android,
                                color: mainColor, size: 100),
                            const Text("Login to Account",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: mainColor)),
                            height(10),
                            Container(
                              width: 70,
                              height: 3,
                              color: mainColor,
                            ),
                            height(20),
                            const Text("Our use your email and password.",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                            height(10),
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
                                  child: Text("Forget Password",
                                      style: TextStyle(
                                          color: Colors.grey.shade400))),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(350, 60),
                                  backgroundColor: mainColor,
                                  foregroundColor: Colors.white),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  setState(() {
                                    isLoad = true;
                                  });
                                  await Future.delayed(const Duration(
                                      seconds: 1)); // Add a 1-second delay

                                  // ignore: use_build_context_synchronously
                                  ApiService.loginUser(
                                      context, email.text, password.text);
                                  setState(() {
                                    isLoad = false;
                                  });
                                }
                              },
                              child: const Text("Sign In"),
                            ),
                            height(10),
                            Text.rich(TextSpan(
                                text: "Didn't have Account | ",
                                style: TextStyle(color: Colors.grey.shade400),
                                children: const [
                                  TextSpan(
                                      text: "Register Now",
                                      style: TextStyle(
                                          color: mainColor,
                                          fontStyle: FontStyle.italic))
                                ])),
                            height(10),
                            if (isLoad)
                              Center(
                                child: CircularProgressIndicator(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                          child: Text("Privacy Security  .  Terms & conditions",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              if (size > 800)
                Expanded(
                    child: Center(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Text("Hello, Welcome",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1)),
                    height(10),
                    Container(
                      width: 70,
                      height: 3,
                      color: Colors.white,
                    ),
                    height(50),
                    SizedBox(
                        width: size * 0.3,
                        child: const Text(
                            "Fill up personal nformation and start journey with us.",
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w100))),
                  ]),
                ))
            ],
          ),
        ),
      ),
    );
  }
}
