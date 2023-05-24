import 'dart:convert';

import 'package:camp_booking/Models/customer_model.dart';
import 'package:camp_booking/constant.dart';
import 'package:camp_booking/Pages/HOME/laptopHomeScreen.dart';
import 'package:camp_booking/Pages/HOME/mobileHomeScreen.dart';
import 'package:camp_booking/Pages/HOME/tabletHomeScreen.dart';
import 'package:camp_booking/Responsive_Layout/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  //authentication by email or password
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

  //getting all customers from api
  static Future<void> getCustomers() async {
    final response =
        await http.get(Uri.parse("https://titwi.in/api/customer/all"));
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("Gotted");
      // List<Customer> customers = [];
      // for (var item in jsonResponse) {
      //   customers.addAll(item);
      // }
    } else {}
  }
}
