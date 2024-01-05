import 'dart:convert';

import 'package:camp_booking/Models/vendor_model.dart';
import 'package:camp_booking/Services/database.dart';

import 'package:camp_booking/constant.dart';

import 'package:camp_booking/main.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/camp_model.dart';
import '../Models/customer_model.dart';

class ApiService {
  static int userId = 0;
  static int role = 0;
  //authentication by email or password
  static Future<bool> loginUser(context, email, password) async {
    final msg = jsonEncode({"name": email, "password": password});

    try {
      var response = await http.post(
        Uri.parse('https://PawnacampAppProd.titwi.in/api/login/authenticate'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: msg,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        String myToken = jsonResponse['token'];

        userId = int.parse(JwtDecoder.decode(myToken)['Id']);
        role = int.parse(JwtDecoder.decode(myToken)['RolesId']);
        DbHelper.saveData(myToken, userId, role);

        return true;
      } else if (response.statusCode == 401) {
        myToast(context, "Something written wrong");
        return false;
      } else {
        myToast(context, "Something went wrong");
        return false;
      }
    } catch (e) {
      myToast(context, e.toString());
      return false;
    }
  }

  //getting all customers from api
  static Future<List> fetchData(context) async {
    String token = await DbHelper.getToken();
    try {
      final response = await http.get(
          Uri.parse('https://PawnacampAppProd.titwi.in/api/customer/all'),
          headers: {"Authorization": "Bearer $token", "Accept": "*/*"});
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      } else {
        myToast(context, "Try again");
        return [];
      }
    } catch (e) {
      myToast(context, e.toString());
      return [];
    }
  }
  //server error-------------------------------------------------------

  //fetch customer by page and limit
  static Future<Map<String, dynamic>> fetchDataPage(
      page, noOfDatam, context) async {
    String token = await DbHelper.getToken();
    int id = await DbHelper.getId();

    try {
      final response = await http.get(
          Uri.parse(
              'https://PawnacampAppProd.titwi.in/api/customer/$id/$page/$noOfDatam'),
          headers: {"Authorization": "Bearer $token", "Accept": "*/*"});
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        return jsonResponse;
      } else {
        if (kDebugMode) {
          myToast(context, response.body.toString());
        }
        return {};
      }
    } catch (e) {
      myToast(context, e.toString());
      return {};
    }
  }
  //server error-------------------------------------------------------

  //add customer
  static Future<bool> addNew(context, Customer customer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    try {
      final response = await http.post(
          Uri.parse('https://PawnacampAppProd.titwi.in/api/customer/add'),
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json"
          },
          body: jsonEncode(customer.toJson()));
      if (response.statusCode == 200) {
        return true;
      } else {
        if (kDebugMode) {
          myToast(context, "Error: ${response.statusCode}");
        }
        return false;
      }
    } catch (e) {
      myToast(context, e.toString());
      return false;
    }
  }

  //fetch customer by Name with lazy loading
  static Future<List<dynamic>> findByName(context, name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    int userId = await DbHelper.getId();
    try {
      final response = await http.get(
          Uri.parse(
              'https://PawnacampAppProd.titwi.in/api/customer/$userId/$name/1/5'),
          headers: {"Authorization": "Bearer $token", "Accept": "*/*"});
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['items'];
      } else {
        return [];
      }
    } catch (e) {
      myToast(context, e.toString());
      return [];
    }
  }

  //fetch customer by formdate - todate
  static Future<List<dynamic>> findByFromToDate(
      context, formDate, toDate, page) async {
    String token = await DbHelper.getToken();
    int id = await DbHelper.getId();
    try {
      final response = await http.get(
          Uri.parse(
              'https://PawnacampAppProd.titwi.in/api/customer/$id/$formDate/$toDate/$page/17'),
          headers: {"Authorization": "Bearer $token", "Accept": "*/*"});
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      } else {
        return [];
      }
    } catch (e) {
      myToast(context, e.toString());
      return [];
    }
  }

  //update customer
  static Future<bool> update(context, Customer customer) async {
    String token = await DbHelper.getToken();

    try {
      final response = await http.put(
        Uri.parse(
            'https://PawnacampAppProd.titwi.in/api/customer/${customer.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(customer.toJson()),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        if (kDebugMode) {
          myToast(context, "Error: ${response.statusCode}");
        }
        return false;
      }
    } catch (e) {
      myToast(context, e.toString());
      return false;
    }
  }

  //camps detail by page and limit
  static Future<Map<String, dynamic>> fetchCampData(page, noOfData) async {
    String token = await DbHelper.getToken();
    int id = await DbHelper.getId();

    final response = await http.get(
        Uri.parse(
            'https://PawnacampAppProd.titwi.in/api/camp/$id/$page/$noOfData'),
        headers: {"Authorization": "Bearer $token", "Accept": "*/*"});
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      if (kDebugMode) {
        print("Error");
        print(response.body);
      }
      return {};
    }
  }

  //add camp
  static Future<bool> addCamp(context, Camp camp) async {
    String token = await DbHelper.getToken();
    final http.BaseResponse response;
    try {
      final url = Uri.parse('https://PawnacampAppProd.titwi.in/api/Camp/add');
      final resquest = http.MultipartRequest('POST', url);
      resquest.headers.addAll({
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      });
      resquest.fields.addAll(camp.toJson());
      if (camp.videoUrl.isEmpty) {
        resquest.files.add(await http.MultipartFile.fromPath(
            'TitleImageUrl', camp.titleImageUrl));
        response = await resquest.send();
      } else {
        resquest.files.add(await http.MultipartFile.fromPath(
            'TitleImageUrl', camp.titleImageUrl));
        resquest.files
            .add(await http.MultipartFile.fromPath('videoUrl', camp.videoUrl));

        response = await resquest.send();
      }
      if (response.statusCode == 200) {
        return true;
      } else {
        if (kDebugMode) {
          myToast(context, "Error: ${response.statusCode}");
        }
        return false;
      }
    } catch (e) {
      myToast(context, e.toString());
      return false;
    }
  }

//editing camp
  static Future<bool> editCamp(context, Camp camp) async {
    String token = await DbHelper.getToken();
    final http.BaseResponse response;
    final url = Uri.parse('https://PawnacampAppProd.titwi.in/api/Camp/add');
    final resquest = http.MultipartRequest('PUT', url);
    resquest.headers.addAll(
        {"Authorization": "Bearer $token", "Content-Type": "application/json"});
    resquest.fields.addAll(camp.toJson());
    if (camp.videoUrl.isEmpty) {
      if (!camp.titleImageUrl.contains('data')) {
        resquest.files.add(await http.MultipartFile.fromPath(
            'TitleImageUrl', camp.titleImageUrl));
      }
      response = await resquest.send();
    } else {
      resquest.files.add(await http.MultipartFile.fromPath(
          'TitleImageUrl', camp.titleImageUrl));
      if (camp.videoUrl.isNotEmpty) {
        resquest.files
            .add(await http.MultipartFile.fromPath('videoUrl', camp.videoUrl));
      }
      response = await resquest.send();
    }
    if (response.statusCode == 200) {
      return true;
    } else {
      if (kDebugMode) {
        myToast(context, "Error: ${response.statusCode}");
      }
      return false;
    }
  }

  //camps by name with lazy loading
  static Future<Map<String, dynamic>> fetchCampBySearchName(campName) async {
    String token = await DbHelper.getToken();
    int id = await DbHelper.getId();
    final response = await http.get(
        Uri.parse(
            'https://PawnacampAppProd.titwi.in/api/camp/$id/$campName/1/10'),
        headers: {"Authorization": "Bearer $token", "Accept": "*/*"});
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      return jsonResponse;
    } else {
      if (kDebugMode) {
        print("Error");
        print(response.body);
      }
      return {};
    }
  }

  //camps detail by id
  static Future<Map<String, dynamic>> fetchCampById(campId) async {
    String token = await DbHelper.getToken();
    int id = await DbHelper.getId();
    final response = await http.get(
        Uri.parse('https://PawnacampAppProd.titwi.in/api/camp/$id/$campId'),
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

//add users by admin
  static Future<bool> addUser(
      context, username, id, email, role, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final response = await http.post(
        Uri.parse('https://PawnacampAppProd.titwi.in/api/credpass'),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "*/*",
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "id": id,
          "userName": username,
          "passCred": password,
          "rolesid": role,
          "email": email
        }));

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }
      return true;
    } else {
      if (kDebugMode) {
        print(response.body);
      }
      myToast(context, response.body.toString());
      return false;
    }
  }

  //add vendor
  static Future<bool> addVendor(context, Vendor vendor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final response = await http.post(
        Uri.parse('https://PawnacampAppProd.titwi.in/api/vendor/add'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
        body: jsonEncode(vendor.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      if (kDebugMode) {
        myToast(context, "Error: ${response.statusCode}");
      }
      return false;
    }
  }

  //add vendor
  static Future<bool> updateVendor(context, Vendor vendor) async {
    String token = await DbHelper.getToken();
    // print(vendor.ownerName);
    final response = await http.put(
        Uri.parse(
            'https://PawnacampAppProd.titwi.in/api/vendor/${vendor.vendorid}'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
        body: jsonEncode(vendor.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      if (kDebugMode) {
        myToast(context, "Error: ${response.statusCode}");
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
        Uri.parse(
            'https://PawnacampAppProd.titwi.in/api/vendor/$page/$noOfPage'),
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
        Uri.parse('https://PawnacampAppProd.titwi.in/api/vendor/$id'),
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

  //fetch Vendor detail by vendor id
  static Future<bool> venderExists(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final response = await http.get(
        Uri.parse(
            'https://PawnacampAppProd.titwi.in/api/vendor/vendorExist/${id}'),
        headers: {"Authorization": "Bearer $token", "Accept": "*/*"});
    if (response.statusCode == 200) {
      return true;
    } else {
      if (kDebugMode) {
        print("Error");
      }
      return false;
    }
  }

  //fetch Vendor detail by userid
  static Future<Map<String, dynamic>> fetchVendorByUserId(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final response = await http.get(
        Uri.parse('https://PawnacampAppProd.titwi.in/api/vendor/$id'),
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

  static Future<List<dynamic>> fetchUsers() async {
    String token = await DbHelper.getToken();
    final response = await http.get(
        Uri.parse(
            'https://PawnacampAppProd.titwi.in/api/credpass/FetchAllUser'),
        headers: {"Authorization": "Bearer $token", "Accept": "*/*"});
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      if (kDebugMode) {
        print(response.body);
      }
      return [];
    }
  }

  //logoutA
  static logout(context) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.remove('token');
    nextReplacement(context, const MyApp());
  }

  //check token expire or not
  static Future<bool> checkToken(context) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    String token = sf.getString('token') ?? '';
    if (JwtDecoder.isExpired(token)) {
      return true;
    }
    return false;
  }
}
