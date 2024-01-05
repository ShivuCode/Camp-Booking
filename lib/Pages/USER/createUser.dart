import 'package:camp_booking/Services/api.dart';

import 'package:camp_booking/constant.dart';

import 'package:flutter/material.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  int role = 2;
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
      drawer: myDrawer(context, 1),
      appBar: appBar(context),
      body: Center(
        child: Container(
          width: size < 400 ? 320 : 350,
          alignment: Alignment.center,
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Create New User",
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
                  decoration: dec("Username"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    } else {
                      return null;
                    }
                  },
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
                height(8),
                TextFormField(
                  cursorColor: mainColor,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  controller: password,
                  decoration: dec("Password"),
                  validator: (value) {
                    if (!isStrongPassword(value!)) {
                      return 'Weak Password';
                    } else {
                      return null;
                    }
                  },
                ),
                height(8),
                DropdownButtonFormField<int>(
                    decoration: dec("Role"),
                    items: const [
                      DropdownMenuItem(value: 1, child: Text("Admin")),
                      DropdownMenuItem(value: 2, child: Text("Vendor")),
                      DropdownMenuItem(value: 3, child: Text("User")),
                    ],
                    value: role,
                    onChanged: (v) => setState(() {
                          role = v!;
                        })),
                height(10),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoad = true;
                      });
                      final data = await ApiService.fetchUsers();

                      // ignore: use_build_context_synchronously
                      if (await ApiService.addUser(context, name.text,
                          data.length, email.text, role, password.text)) {
                        myToast(context, "Successfully");
                      }
                    }
                    setState(() {
                      isLoad = false;
                    });
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(mainColor),
                      minimumSize: MaterialStateProperty.all(
                          Size(size < 400 ? 320 : 350, 45))),
                  child: const Text("Submit"),
                ),
                height(5),
                isLoad
                    ? CircularProgressIndicator(
                        color: Colors.grey.shade300,
                      )
                    : const Center()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
