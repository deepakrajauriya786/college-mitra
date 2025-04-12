import 'package:shared_preferences/shared_preferences.dart';

String IS_LOGIN = "is_login";
String IS_SECOND_TIME = "is_first_time";
String USER_NAME = "user_name";
String USER_NUMBER = "user_number";
String CITY = "city";
String LOCALITY = "locality";
String COLLEGE = "college";
String USER_EMAIL = "email";

Future<void> savebool(String keys, bool isLogin) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool(keys, isLogin);
}

Future<bool> getbool(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key) ?? false; // Default to false if key doesn't exist
}

Future<void> savestring(String keys, String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(keys, value);
}

Future<String> getstring(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? " "; // Default to false if key doesn't exist
}
