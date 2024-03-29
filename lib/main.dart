import 'package:camp_booking/Responsive_Layout/responsive_layout.dart';
import 'package:camp_booking/Pages/LOGIN/loginPage.dart';

import 'package:flutter/material.dart';

import 'package:jwt_decoder/jwt_decoder.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import 'Pages/HOME/laptopHomeScreen.dart';
import 'Pages/HOME/mobileHomeScreen.dart';
import 'Pages/HOME/tabletHomeScreen.dart';

void main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'error\n${details.exception}',
        style: const TextStyle(color: Colors.black12, fontSize: 10),
      ),
    );
  };

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedToken = prefs.getString('token') ?? '';
    if (storedToken.isNotEmpty && JwtDecoder.isExpired(storedToken) == false) {
      return true;
    } else {
      return false;
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLoginStatus(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while checking the login status
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasData && snapshot.data!) {
            // User is already logged in, redirect to BookingPage
            return ResponsiveLayout(
                mobileScaffold: MobileHomeScreen(),
                tabletScaffold: TabletHomeScreen(),
                laptopScaffold: LaptopHomeScreen());
          } else {
            // User is not logged in, show the login page
            return const LoginPage();
          }
        }
      },
    );
  }
}
