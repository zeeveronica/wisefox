import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class AuthRepository {
  final http.Client httpClient;

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
        final accessToken = data['data']['token']; // Correct field name
        final studentId = data["data"]["user"]["student_id"];
        log("after login $studentId");
        return {
          'statusCode': response.statusCode,
          'accessToken': accessToken,
          "studentId": studentId
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
}
