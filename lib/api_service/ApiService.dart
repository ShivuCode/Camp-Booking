import 'dart:convert';

import 'package:camp_booking/constant.dart';
import 'package:camp_booking/page/HOME/laptopHomeScreen.dart';
import 'package:camp_booking/page/HOME/mobileHomeScreen.dart';
import 'package:camp_booking/page/HOME/tabletHomeScreen.dart';
import 'package:camp_booking/responsive_layout/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static void loginUser(context, email, password) async {
    final response = await http.post(
      Uri.parse('https://jobmanagementw.onrender.com/api/user/login'),
      body: {
        'email': email,
        'password': password,
      },
    );
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      var myToken = jsonResponse['token'];
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
          .showSnackBar(SnackBar(content: Text("Something want wrong")));
    }
  }
}
