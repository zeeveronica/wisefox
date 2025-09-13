import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<void> saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is Map<String, dynamic>) {
      await prefs.setString(key, jsonEncode(value));
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    }
  }

  static clearData(String s) async {
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

  static Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
    }
    return isFirstLaunch;
  }
}
