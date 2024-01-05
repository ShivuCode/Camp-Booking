import 'dart:convert';
import 'package:camp_booking/Pages/LOGIN/loginPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constant.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final name = TextEditingController(),
      password = TextEditingController(),
      email = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoad = false;
  bool isStrongPassword(String password) {
    // Define criteria for a strong password
    const minLength = 6;
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
    final hasLowercase = RegExp(r'[a-z]').hasMatch(password);
    final hasDigits = RegExp(r'[0-9]').hasMatch(password);
    final hasSpecialCharacters =
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

    // Check if the password meets all criteria
    return password.length >= minLength &&
        hasUppercase &&
        hasLowercase &&
        hasDigits &&
        hasSpecialCharacters;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: SizedBox(
          width: size < 400 ? 320 : 350,
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                height(40),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.home, color: mainColor, size: 100),
                    const Text("Welcome to Our journey",
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
                    height(25),
                    const Text("Use your email and password.",
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    height(10),
                    TextFormField(
                      cursorColor: mainColor,
                      controller: name,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required name";
                        } else {
                          return null;
                        }
                      },
                      decoration: dec("Username"),
                    ),
                    height(10),
                    TextFormField(
                      cursorColor: mainColor,
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
                      cursorColor: mainColor,
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
                    height(12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(350, 45),
                          backgroundColor: mainColor,
                          foregroundColor: Colors.black),
                      onPressed: () async {
                        setState(() {
                          isLoad = true;
                        });
                        try {
                          final response = await http.post(
                              Uri.parse('https://titwi.in/api/signupuser'),
                              headers: {
                                "Accept": "*/*",
                                "Content-Type": "application/json"
                              },
                              body: jsonEncode({
                                "userName": name.text,
                                "passCred": password.text,
                                "rolesid": 3,
                                "email": email.text
                              }));
                          if (response.statusCode == 200) {
                            if (kDebugMode) {
                              print(response.body);
                            }
                            setState(() {
                              isLoad = false;
                            });
                            // ignore: use_build_context_synchronously
                            myToast(context, "Registration successfully");
                          } else {
                            if (kDebugMode) {
                              print(response.body);
                            }
                          }
                        } catch (e) {
                          myToast(context, e.toString());
                          setState(() {
                            isLoad = false;
                          });
                        }
                      },
                      child: const Text("Submit"),
                    ),
                    height(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "I have Account | ",
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                        GestureDetector(
                            onTap: () =>
                                nextReplacement(context, const LoginPage()),
                            child: const Text('Login',
                                style: TextStyle(
                                    color: mainColor,
                                    fontStyle: FontStyle.italic)))
                      ],
                    ),
                    height(10),
                    if (isLoad)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                  child: Text("Privacy Security  .  Terms & conditions",
                      style: TextStyle(color: Colors.grey, fontSize: 14)),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
