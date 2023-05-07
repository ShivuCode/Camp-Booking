import 'package:camp_booking/page/homePage.dart';
import 'package:camp_booking/page/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedToken = prefs.getString('token') ?? '';
    if (storedToken.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<bool>(
      future: checkLoginStatus(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while checking the login status
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          if (snapshot.hasData && snapshot.data!) {
            // User is already logged in, redirect to BookingPage
            return const  MaterialApp(
              debugShowCheckedModeBanner: false,
              home: HomeScreen(),
            );
          } else {
            // User is not logged in, show the login page
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: LoginPage(),
            );
          }
        }
      },
    );
  }
}
