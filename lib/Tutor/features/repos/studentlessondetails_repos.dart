import 'dart:convert';
import 'dart:developer';

import 'package:wisefox/client/features/model/lesson_details_model.dart';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';
import 'package:wisefox/client/features/service/urls.dart';

class StudentLessonDetailsRepository {
  ApiService apiService = ApiService();

  StudentLessonDetailsRepository();

  Future<LessonData> fetchLessonDetails(
      String lessonId, String timezone) async {
    try {
      final studentId =
          await SharedPreferencesHelper.getData("selectedStudentId");
      final loginData = await SharedPreferencesHelper.getData("loginData");

      if (studentId == null || loginData == null) {
        throw Exception("Missing studentId or login data.");
      }

      final url = '${Urls.lessonDetails}?id=$studentId&timezone=$timezone';
      log("Fetching lesson details with URL: $url");

      final response = await apiService.getResponse(url);
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null && data['data'] != null) {
          final lessonDetails = LessonDetails.fromJson(data);
          return lessonDetails.data;
        } else {
          throw Exception('No lesson data found in the response.');
        }
      } else {
        throw Exception(
            'Failed to load lesson details with status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching lesson details: $e');
      throw Exception('Error fetching lesson details: $e');
    }
  }
}
