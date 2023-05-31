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
  //authentication by email or password
  static void loginUser(context, email, password) async {
    try {
      final response = await http.post(
        // Uri.parse('https://titwi.in/authentication'),
        // body: jsonEncode({
        //   'username': 'admin',
        //   'password': 'admin5555',
        // }),
        Uri.parse('https://jobmanagementw.onrender.com/api/user/login'),
        body: {
          'email': email,
          'password': password,
        },
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
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Something went wrong")));
      }
    } catch (e) {
      print(e);
    }
  }

  //getting all customers from api
  static Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://titwi.in/api/customer/all'));
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
