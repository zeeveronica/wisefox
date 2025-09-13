import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wisefox/apps/login.dart';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/urls.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final http.Client httpClient;
  ApiService apiService = ApiService();
  AuthRepository({required this.httpClient});

  Future<Map<String, dynamic>> authenticate({
    required String email,
    required String password,
  }) async {
    try {
      final response = await httpClient.post(
        Uri.parse('https://api.wisefox.uk/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': email, 'password': password}),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print('Success data: ${data}');
        final accessToken = data['data']['token'];
        final refreshToken = data['data']['refresh'];
        final clientid = data["data"]["user"]["client_id"];
        final userid = data["data"]["user"]["id"];
        final referralcode = data["data"]["user"]["referral_code"];

        log("after login $clientid");
        log("userid : $userid");
        log("referralcode : $referralcode");
        log("refreshToken : $refreshToken");
        return {
          'statusCode': response.statusCode,
          'accessToken': accessToken,
          "clientid": clientid,
          "userid": userid,
          "referralcode": referralcode,
          "refresh": refreshToken,
        };
      } else {
        throw Exception(
            'Failed to authenticate with status code: ${response.statusCode}');
      }
    } catch (e) {
      // Print error details
      print('Error during authentication: $e');
      throw Exception('Error during authentication: $e');
    }
  }

  Future<void> logout(String refreshToken, BuildContext context) async {
    try {
      final body = jsonEncode({
        'refresh': refreshToken,
      });

      final response = await apiService.postResponse(Urls.logout, body);

      if (response.statusCode == 200) {
        // Clear SharedPreferences data
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear(); // This will remove all stored data

        log('SharedPreferences cleared successfully');

        // Navigate to the login page after successful logout
        // Navigator.of(context).pushNamedAndRemoveUntil(
        //   '/login',
        //   (Route<dynamic> route) => false,
        // );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => UnifiedLoginPage()),
              (Route<dynamic> route) => false,
        );

      } else {
        final errorResponse = jsonDecode(response.body);
        final errorMessage = errorResponse['message'] ?? 'Failed to logout';
        log('Error Response: $errorResponse');
        throw Exception(errorMessage);
      }
    } catch (e) {
      log('Logout failed: ${e.toString()}');
      throw Exception('Logout failed: ${e.toString()}');
    }
  }
}
