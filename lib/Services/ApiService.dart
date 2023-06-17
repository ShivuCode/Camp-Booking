import 'dart:convert';
import 'package:camp_booking/constant.dart';
import 'package:camp_booking/Pages/HOME/laptopHomeScreen.dart';
import 'package:camp_booking/Pages/HOME/mobileHomeScreen.dart';
import 'package:camp_booking/Pages/HOME/tabletHomeScreen.dart';
import 'package:camp_booking/Responsive_Layout/responsive_layout.dart';
import 'package:camp_booking/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/customer_model.dart';

class ApiService {
  // ignore: non_constant_identifier_names
  static String API_KEY = 'This is my supper secret key for jwt';
  //authentication by email or password
  static void loginUser(context, email, password) async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final msg = jsonEncode({"name": email, "password": password});

    try {
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
            .showSnackBar(const SnackBar(content: Text("Something Incorrect")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Something went wrong")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  //getting all customers from api
  static Future<List> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final response = await http.get(
        Uri.parse('https://titwi.in/api/customer/all'),
        headers: {"Authorization": "Bearer $token", "Accept": "*/*"});
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      return [];
    }
  }

  static Future<List> fetchDataPage(page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final response = await http.get(
        Uri.parse(
            'https://titwi.in/api/customer/all?context=embed&per_page=2&page=$page'),
        headers: {"Authorization": "Bearer $token", "Accept": "*/*"});
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      if (kDebugMode) {
        print("Error");
      }
      return [];
    }
  }

  //add customer
  static Future<bool> addNew(Customer customer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final response = await http.post(
        Uri.parse('https://titwi.in/api/customer/add'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
        body: jsonEncode(customer.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      if (kDebugMode) {
        print(response.body);
      }
      return false;
    }
  }

  //fetch customer by id
  static Future<Map<String, dynamic>> findByID(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final response = await http.get(
        Uri.parse('https://titwi.in/api/customer/$id'),
        headers: {"Authorization": "Bearer $token", "Accept": "*/*"});
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      return {};
    }
  }

  //fetch customer by Name
  static Future<List<dynamic>> findByName(name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final response = await http.get(
        Uri.parse('https://titwi.in/api/customer/$name'),
        headers: {"Authorization": "Bearer $token", "Accept": "*/*"});
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      return [];
    }
  }

  //update customer
  static Future<bool> update(Customer customer) async {
    print(customer.toJson());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final response = await http.put(
      Uri.parse('https://titwi.in/api/customer/${customer.id}'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode(customer.toJson()),
    );
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      if (kDebugMode) {
        print(response.body);
      }
      return false;
    }
  }

  //logoutA
  static logout(context) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.remove('token');
    nextReplacement(context, const MyApp());
  }
}
