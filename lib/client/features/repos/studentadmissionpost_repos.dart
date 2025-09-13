import 'dart:convert';
import 'dart:developer';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';
import 'package:wisefox/client/features/service/urls.dart';
import 'package:http/http.dart' as http;

class StudentAdmissionRepository {
  ApiService apiService = ApiService();

  Future<http.Response> postStudentAdmission({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String phoneNumber,
    required String dateOfBirth,
    required String gender,
    required String year,
    required String country,
    required List<Map<String, int>> subjects,
  }) async {
    // Fetch the client ID from shared preferences
    var loginData = await SharedPreferencesHelper.getData("loginData");
    final clientId = loginData["clientid"].toString();

    final body = {
      "first_name": firstName,
      "last_name": lastName,
      "username": username,
      "email": email,
      "phonenumber": phoneNumber,
      "date_of_birth": dateOfBirth,
      "gender": gender,
      "year": year,
      "country": country,
      "subject": subjects,
      "client": clientId,
    };

    try {
      log("Request body for posting student admission: $body");
      final response = await apiService.postResponse(
          Urls.studentAdmissionPost, jsonEncode(body));

      log("Completed POST request for student admission: $body");
      log('Response Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw Exception('Failed to post: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to post student admission data: $e');
    }
  }
}
