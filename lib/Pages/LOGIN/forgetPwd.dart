import 'package:camp_booking/Pages/LOGIN/loginPage.dart';
import 'package:camp_booking/constant.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ForegetPassword extends StatefulWidget {
  const ForegetPassword({super.key});

  @override
  State<ForegetPassword> createState() => _ForegetPasswordState();
}

class _ForegetPasswordState extends State<ForegetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: Colors.white,
            width: context.screenWidth > 800
                ? context.screenWidth * .6
                : context.screenWidth,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: SizedBox(
              width: context.screenWidth < 400 ? 320 : 350,
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    height(40),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Forget Password",
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
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Required password';
                            }
                            return null;
                          },
                          decoration: dec("New Password"),
                        ),
                        height(10),
                        TextFormField(
                          cursorColor: mainColor,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Required password';
                            }
                            return null;
                          },
                          decoration: dec("Confirm Paswword"),
                        ),
                        height(10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(350, 45),
                              backgroundColor: mainColor,
                              foregroundColor: Colors.black),
                          onPressed: () =>
                              nextReplacement(context, const LoginPage()),
                          child: const Text("Save"),
                        ),
                        height(10),

                        // if (isLoad)
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
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
