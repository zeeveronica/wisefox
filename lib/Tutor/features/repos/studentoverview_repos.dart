import 'dart:convert';
import 'dart:developer';

import 'package:wisefox/client/features/model/studentoverview_model.dart';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';
import 'package:wisefox/client/features/service/urls.dart';

class StudentOverviewRepository {
  final ApiService apiService;

  StudentOverviewRepository({ApiService? apiService})
      : apiService = apiService ?? ApiService();

  Future<StudentOverviewModel> fetchStudentOverviewCount() async {
    try {
      // Retrieve the stored login data from shared preferences
      var loginData = await SharedPreferencesHelper.getData("loginData");
      if (loginData == null) {
        throw Exception("Login data not found");
      }

      final studentId =
          await SharedPreferencesHelper.getData("selectedStudentId");
      log("Selected Student ID: $studentId");

      final url = '${Urls.studentoverviewcount}?id=$studentId';
      log("Request URL: $url");

      // Make the API request
      final response = await apiService.getResponse(url);
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('Counts data: $data');

        final dataContent = data['data'] ?? {};
        return StudentOverviewModel.fromJson(dataContent);
      } else {
        throw Exception(
            'Failed to fetch overview counts with status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching overview counts: $e');
      throw Exception('Error fetching overview counts: $e');
    }
  }
}
