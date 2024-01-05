import 'package:shared_preferences/shared_preferences.dart';

class DbHelper {
  static saveData(token, userId, role) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.setString('token', token);
    sf.setInt('id', userId);
    sf.setInt("role", role);
  }

  static getId() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    int id = sf.getInt('id') ?? 0;
    return id;
  }

  static roleId() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    int id = sf.getInt('role') ?? 0;
    return id;
  }

  static getToken() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    String token = sf.getString('token') ?? '';
    return token;
  }
}
