import 'package:camp_booking/Services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constant.dart';

// ignore: must_be_immutable
class ResponsiveLayout extends StatefulWidget {
  Widget mobileScaffold;
  Widget tabletScaffold;
  Widget laptopScaffold;
  ResponsiveLayout(
      {super.key,
      required this.mobileScaffold,
      required this.tabletScaffold,
      required this.laptopScaffold});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  check() async {
    if (await ApiService.checkToken(context)) {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (_) {
            final formKey = GlobalKey<FormState>();
            TextEditingController username = TextEditingController(),
                password = TextEditingController();
            return AlertDialog(
              icon: Icon(FontAwesomeIcons.clockRotateLeft,
                  color: Colors.grey.shade500, size: 50),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Your Session has expired due to inactivity... ",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    height(15),
                    TextFormField(
                      cursorColor: mainColor,
                      controller: username,
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
                      decoration: dec("Username"),
                    ),
                    height(8),
                    TextFormField(
                      cursorColor: mainColor,
                      controller: password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter password";
                        } else {
                          return null;
                        }
                      },
                      decoration: dec("Password"),
                    ),
                    height(12),
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ApiService.loginUser(
                                context, username.text, password.text);
                            Navigator.pop(context);
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(mainColor),
                            minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 45))),
                        child: Text("login".toLowerCase()))
                  ],
                ),
              ),
            );
          });
    }
  }

  @override
  void initState() {
    check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: mainColor, // Rang badalne ke liye yahan color set karein
      statusBarIconBrightness:
          Brightness.light, // Icon (jaise ki clock, battery) ka rang set karein
    ));
    return LayoutBuilder(builder: (_, constraints) {
      if (constraints.maxWidth < 500) {
        return widget.mobileScaffold;
      } else if (constraints.maxWidth < 1100) {
        return widget.tabletScaffold;
      } else {
        return widget.laptopScaffold;
      }
    });
  }
}
