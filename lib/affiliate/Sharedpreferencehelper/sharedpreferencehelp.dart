import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // Function to save String or Map<String, dynamic> data to SharedPreferences
  static Future<void> saveData(String key, dynamic value) async {
    log("vaslue for saving is $value");
    final prefs = await SharedPreferences.getInstance();
    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is Map<String, dynamic>) {
      await prefs.setString(key, jsonEncode(value));
    }
  }
 static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }
  static clearData() async {
    final data = await SharedPreferences.getInstance();
    await data.clear();
  }
static Future<void> removeData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // Function to get data from SharedPreferences as String or Map<String, dynamic>
  static Future<dynamic> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key);
    if (value != null) {
      try {
        return jsonDecode(value);
      } catch (e) {
        return value;
      }
    }
    return null;
  }

  static Future<Map<String, String>> getHeaders() async {
    var loginData = await getData("loginData");
    log("login data is $loginData");
    if (loginData == null) {
      Map<String, String> headers = {"Content-type": "application/json"};
      return headers;
    } else {
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Authorization": "Bearer " + loginData["token"]
      };
      return headers;
    }
  }
}
