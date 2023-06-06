import 'dart:convert';

import 'package:camp_booking/Models/customer_model.dart';
import 'package:camp_booking/Pages/LOGIN/loginPage.dart';
import 'package:camp_booking/constant.dart';
import 'package:camp_booking/Pages/HOME/laptopHomeScreen.dart';
import 'package:camp_booking/Pages/HOME/mobileHomeScreen.dart';
import 'package:camp_booking/Pages/HOME/tabletHomeScreen.dart';
import 'package:camp_booking/Responsive_Layout/responsive_layout.dart';
import 'package:camp_booking/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static String API_KEY = 'This is my supper secret key for jwt';
  //authentication by email or password
  static void loginUser(context, email, password) async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    final msg = jsonEncode({"name": email, "password": password});

    var response = await http.post(
      Uri.parse('https://titwi.in/api/login/authenticate'),
      headers: header,
      body: msg,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final myToken = jsonResponse['token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', myToken);
      nextReplacement(
          context,
          ResponsiveLayout(
              mobileScaffold: MobileHomeScreen(),
              tabletScaffold: TabletHomeScreen(),
              laptopScaffold: LaptopHomeScreen()));
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something Incorrect")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
  }

  //getting all customers from api
  static Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('https://titwi.in/api/customer/all'), headers: {
      'Authentication': "Bearer $API_KEY",
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
    } else {
      print("Error");
    }
  }

  //logout
  static logout(context) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.remove('token');
    nextReplacement(context, const MyApp());
  }
}
