import 'dart:convert';
import 'dart:io';
import 'package:camp_booking/Models/vendor_model.dart';
import 'package:camp_booking/Pages/LOGIN/loginPage.dart';
import 'package:camp_booking/constant.dart';
import 'package:camp_booking/Pages/HOME/laptopHomeScreen.dart';
import 'package:camp_booking/Pages/HOME/mobileHomeScreen.dart';
import 'package:camp_booking/Pages/HOME/tabletHomeScreen.dart';
import 'package:camp_booking/Responsive_Layout/responsive_layout.dart';
import 'package:camp_booking/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/camp_model.dart';
import '../Models/customer_model.dart';

class ApiService {
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

  //fetch customer by page and limit
  static Future<Map<String, dynamic>> fetchDataPage(page, noOfData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final response = await http.get(
        Uri.parse('https://titwi.in/api/customer/$page/$noOfData'),
        headers: {"Authorization": "Bearer $token", "Accept": "*/*"});
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      return jsonResponse;
    } else {
      if (kDebugMode) {
        print("Error");
      }
      return {};
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
        Uri.parse('https://titwi.in/api/customer/$name/1/5'),
        headers: {"Authorization": "Bearer $token", "Accept": "*/*"});
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      return [];
    }
  }

  //fetch customer by formdate - todate
  static Future<List<dynamic>> findByFromToDate(formDate, toDate, page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final response = await http.get(
        Uri.parse('https://titwi.in/api/customer/$formDate/$toDate/$page/14'),
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
      return true;
    } else {
      if (kDebugMode) {
        print(response.body);
      }
      return false;
    }
  }

  //camps detail by page and limit
  static Future<Map<String, dynamic>> fetchCampData(page, noOfData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final response = await http.get(
        Uri.parse('https://titwi.in/api/camp/$page/$noOfData'),
        headers: {"Authorization": "Bearer $token", "Accept": "*/*"});
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      return jsonResponse;
    } else {
      if (kDebugMode) {
        print("Error");
      }
      return {};
    }
  }

  //add camp
  static Future<bool> addCamp(Camp camp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final response = await http.post(Uri.parse('https://titwi.in/api/Camp'),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "*/*",
          "Content-Type": "application/json"
        },
        body: jsonEncode(camp.toJson()));
    // final url = Uri.parse('https://titwi.in/api/Camp');
    // final resquest = http.MultipartRequest('POST', url);
    // resquest.headers.addAll({
    //   "Authorization": "Bearer $token","Content-Type": "application/json"
    // });

    // resquest.fields.addAll({
    //   "campId": 20.toString(),
    //   "campName": "jah",
    //   "campLocation": "kana",
    //   "campFee": 139.toString(),
    //   "campImageGroupId": 1.toString(),
    //   "campBrochure": "j",
    //   "campViewDetails": "beach ",
    //   "campPlanId": 1.toString(),
    //   "discountStatus": "5%OFF",
    //   "controllerName": "shivangi ",
    //   "isActive": 0.toString(),
    //   "type": 1.toString()
    // });
    // resquest.files
    //     .add(await http.MultipartFile.fromPath('image', camp.titleImageUrl));
    // resquest.files
    //     .add(await http.MultipartFile.fromPath('image', camp.videoUrl));

    // final response = await resquest.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      if (kDebugMode) {
        final jsonResponse = jsonDecode(response.statusCode.toString());
        print("Error:$jsonResponse");
      }
      return false;
    }
  }

  //camps detail by id
  static Future<Map<String, dynamic>> fetchCampById(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final response = await http.get(Uri.parse('https://titwi.in/api/camp/$id'),
        headers: {"Authorization": "Bearer $token", "Accept": "*/*"});
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      if (kDebugMode) {
        print("Error");
      }
      return {};
    }
  }

  //add vendor
  static Future<bool> addVendor(Vendor vendor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    prefs.setBool('isRegister', true);

    final response = await http.post(Uri.parse('https://titwi.in/api/vendor'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
        body: jsonEncode(vendor.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      if (kDebugMode) {
        print(response.body);
      }
      return false;
    }
  }

  //fetch Vendor detail by page with limit
  static Future<Map<String, dynamic>> fetchVendor(
      int page, int noOfPage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final response = await http.get(
        Uri.parse('https://titwi.in/api/vendor/$page/$noOfPage'),
        headers: {"Authorization": "Bearer $token", "Accept": "*/*"});
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      if (kDebugMode) {
        print(response.body);
      }
      return {};
    }
  }

  //fetch Vendor detail by vendor id
  static Future<Map<String, dynamic>> fetchVendorId(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final response = await http.get(
        Uri.parse('https://titwi.in/api/vendor/$id'),
        headers: {"Authorization": "Bearer $token", "Accept": "*/*"});
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      if (kDebugMode) {
        print("Error");
      }
      return {};
    }
  }

  //fetch Vendor detail by userid
  static Future<Map<String, dynamic>> fetchVendorByUserId(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final response = await http.get(
        Uri.parse('https://titwi.in/api/vendor/$id'),
        headers: {"Authorization": "Bearer $token", "Accept": "*/*"});
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      if (kDebugMode) {
        print("Error");
      }
      return {};
    }
  }

  //

  //logoutA
  static logout(context) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.remove('token');
    nextReplacement(context, const MyApp());
  }

  //check token expire or not
  static Future<void> checkToken(context) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    String token = sf.getString('token') ?? '';
    if (JwtDecoder.isExpired(token)) {
      nextReplacement(context, const LoginPage());
    }
  }
}
