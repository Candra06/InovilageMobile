import 'package:shared_preferences/shared_preferences.dart';

class Pref {
    static getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    return token;
  }
}