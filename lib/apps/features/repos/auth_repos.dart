import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wisefox/apps/model/user.dart';
import 'package:wisefox/apps/utils/urls.dart';

class AuthRepository {
  AuthRepository();

  Future<User> authenticate({
    required String username,
    required String password,
  }) async {
    try {
      print('Url status: ${Url.login}');

      final response = await http.post(
        Uri.parse(Url.login), // <-- directly use it here
        body: {
          'username': username,
          'password': password,
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print('Success data: ${data}');
        final responseJson = jsonDecode(response.body);
        final userJson = responseJson['data']['user'];
        final tokenData = {
          "token": responseJson['data']['token'],
          "refresh": responseJson['data']['refresh'],
        };

        final user = User.fromJson(userJson, tokenData: tokenData);

        return user;
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
