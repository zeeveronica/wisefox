import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisefox/apps/model/user.dart';
import 'package:wisefox/client/features/model/tutor_model.dart';
import 'package:wisefox/student/features/model/student_model.dart';
import 'package:permission_handler/permission_handler.dart';

class AppColors {
  static const Color container = Color(0x5098B2E2);
  static const Color divider = Color(0xffAEAEAE);
  static const Color tabbarclr = Color(0xffF5F8FB);
  static const Color bluedark = Color(0xff00008B);
  static const Color textgrey = Color(0xff363636);
  static const Color lightblue = Color(0xff98B2E2);
  static const classbrdrclr = Color(0xffDCE4F2);
  static const classclr = Color(0xffF5F8FB);
  static const tabbarclr2 = Color(0xffE7ECF8);
  static const primaryColor = Color(0xFF2222AE);
  static const bottomnavColor = Color(0xff080557);
  static const white = Color(0xffFFFFFF);
  static const verticaldvdrclr = Color(0xffD4D5D1);
  static const lighttextgrey = Color(0x70707070);
}

class AppImages {
  static const getstartimg = "assets/student/images/Group 7934.png";
  static const backgroundimg = "assets/student/images/backgroundimg1.png";
  static const logo = "assets/student/images/prepsimg.png";
  static const homecvr = "assets/student/images/Mask Group 22.png";
  static const profilepc = "assets/student/images/profilepic.png";
  static const triangle = "assets/student/images/triangle.png";
  static const pagebackground = "assets/student/images/pagebackground.png";
}


class AppUtils {
  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final loginDataString = prefs.getString('loginData');

    if (loginDataString != null) {
      final Map<String, dynamic> loginData = jsonDecode(loginDataString);
      final userData = loginData['user']; // This is the JSON of your user
      return User.fromJson(userData); // Convert JSON back to User object
    }
    return null; // No user saved
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loginData');
  }




  static const String studentKey = "student_data";
  static const String clientKey = "client_data";

  /// Save student details in SharedPreferences
  // static Future<void> saveStudent(StudentModel student) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String jsonString = jsonEncode(student.toJson());
  //   await prefs.setString(studentKey, jsonString);
  // }
  //
  // /// Get student details from SharedPreferences
  // static Future<StudentModel?> getStudent() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? jsonString = prefs.getString(studentKey);
  //   if (jsonString == null) return null;
  //   return StudentModel.fromJson(jsonDecode(jsonString));
  // }
  //
  // /// Clear student details
  // static Future<void> clearStudent() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove(studentKey);
  // }
  //
  // static Future<void> saveTutor(Tutor tutor) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String jsonString = jsonEncode(tutor.toJson());
  //   await prefs.setString(clientKey, jsonString);
  // }
  //
  static Future<Tutor?> getTutor() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(clientKey);
    if (jsonString == null) return null;
    return Tutor.fromJson(jsonDecode(jsonString));
  }
  //
  // static Future<void> clearTutor() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove(clientKey);
  // }

  String formatDate(String? dateString) {
    if (dateString == null || dateString.trim().isEmpty) {
      return '-';
    }

    try {
      DateTime parsedDate = DateTime.parse(dateString);
      return DateFormat("d MMMM yyyy").format(parsedDate);
    } catch (e) {
      // If parsing fails (wrong format)
      return '-';
    }
  }

  Future<void> requestAllPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Permission.photos, // iOS
      Permission.storage, // Android
    ].request();

    statuses.forEach((permission, status) {
      if (status.isDenied) {
        print("$permission is denied");
      }
      if (status.isPermanentlyDenied) {
        openAppSettings();
      }
    });

    // For screen share (handled differently)
    // Use flutter_webrtc's navigator.mediaDevices.getDisplayMedia()
  }

}