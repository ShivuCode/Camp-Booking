import 'dart:convert';
import 'package:camp_booking/page/homePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants/constant.dart';

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

  void loginUser() async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      final response = await http.post(
        Uri.parse('https://jobmanagementw.onrender.com/api/user/login'),
        body: {
          'email': email.text,
          'password': password.text,
        },
      );
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var myToken = jsonResponse['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', myToken);
        setState(() {
          isLoad = false;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {}
    }
  }

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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        setState(() {
                          isLoad = true;
                        });
                        loginUser();
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
