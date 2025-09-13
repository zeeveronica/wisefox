import 'dart:convert';
import 'dart:developer';

import 'package:wisefox/affiliate/Sharedpreferencehelper/Apiservice.dart';
import 'package:wisefox/affiliate/Sharedpreferencehelper/sharedpreferencehelp.dart';
import 'package:wisefox/affiliate/utils/url.dart';
import 'package:http/http.dart' as http;


class AuthRepository {
  ApiService apiService = ApiService();
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(Url.login),
      body: jsonEncode({
        'username': email,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print('Response Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      if (data['data'] != null && data['data']['token'] is String) {
        log("tutor id is ${data["data"]["user"]["tutor_id"]}");
        final token = data['data']['token'] as String;
        final userId = data['data']['user']['id'] as int;
        final tutorId = data['data']['user']['tutor_id'] ?? 0 as int;

        await SharedPreferencesHelper.saveData('token', token);
        await SharedPreferencesHelper.saveData('userId', userId);
        await SharedPreferencesHelper.saveData('tutorId', tutorId);

        print('Token saved: $token');
        print('user saved: $userId');
        print('user saved: $tutorId');
        return {'token': token, 'userId': userId, 'tutorId': tutorId};
      } else {
        throw Exception('Access token or user ID not found in response');
      }
    } else {
      final errorResponse = jsonDecode(response.body);
      final errorMessage = errorResponse['message'] ?? 'Failed to login';
      print('Error Response: $errorResponse');
      throw Exception(errorMessage);
    }
  }

  Future<void> logout(String refreshToken) async {
    final body = {
      // "id": id,
      "reciever": refreshToken,
    };

    try {
      final response =
          await apiService.postResponse(Url.logout, jsonEncode(body));

      if (response.statusCode == 200) {
        // Remove token and user data from SharedPreferences
        await SharedPreferencesHelper.removeData('token');
        await SharedPreferencesHelper.removeData('userId');
        await SharedPreferencesHelper.removeData('tutorId');

        print('Token and user data removed');
      } else {
        final errorResponse = jsonDecode(response.body);
        final errorMessage = errorResponse['message'] ?? 'Failed to logout';
        print('Error Response: $errorResponse');
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('Logout failed: ${e.toString()}');
    }
  }
}
