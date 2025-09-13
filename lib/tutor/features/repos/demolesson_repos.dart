import 'dart:convert';
import 'dart:developer';

import 'package:wisefox/client/features/model/studentlesson.dart';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';
import 'package:wisefox/client/features/service/urls.dart';

class DemoLessonRepository {
  final ApiService apiService;

  DemoLessonRepository({ApiService? apiService})
      : apiService = apiService ?? ApiService();

  Future<List<StudentLessonModel>> fetchLessons(String type) async {
    var loginData = await SharedPreferencesHelper.getData("loginData");
    log("inside fetch lessons $loginData");
    try {
      var loginData = await SharedPreferencesHelper.getData("loginData");
      if (loginData == null) {
        throw Exception("Login data not found");
      }
      log("login data is $loginData");

      final studentId =
          await SharedPreferencesHelper.getData("selectedStudentId");

      final url = '${Urls.studentlesson}?id=$studentId&type=$type';
      log("URL for fetching lessons: $url");

      final response = await apiService.getResponse(url);
      log('Response body for lessons: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null && data['data']['results'] is List) {
          final lessonData = data['data']['results'] as List;

          log('Lesson Data: $lessonData');

          final List<StudentLessonModel> lessons = lessonData.map((json) {
            if (json is Map<String, dynamic>) {
              return StudentLessonModel.fromJson(json);
            } else {
              log('Unexpected type for lesson data: ${json.runtimeType}');
              throw Exception('Unexpected data format');
            }
          }).toList();

          return lessons;
        } else {
          throw Exception('Unexpected data format: ${data['data']}');
        }
      } else {
        throw Exception('Failed to fetch lessons: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching lessons: $e');
      throw Exception('Error fetching lessons: $e');
    }
  }

  // New method to fetch demo lessons by demotype
  Future<List<StudentLessonModel>> fetchDemoLessons(String type) async {
    var loginData = await SharedPreferencesHelper.getData("loginData");
    log("inside fetch demo lessons $loginData");
    try {
      var loginData = await SharedPreferencesHelper.getData("loginData");
      if (loginData == null) {
        throw Exception("Login data not found");
      }
      log("login data is $loginData");

      final studentId =
          await SharedPreferencesHelper.getData("selectedStudentId");

      final url = '${Urls.studentlesson}?id=$studentId&type=$type';
      log("URL for fetching demo lessons: $url");

      final response = await apiService.getResponse(url);
      log('Response body for demo lessons: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null && data['data']['results'] is List) {
          final demoLessonData = data['data']['results'] as List;

          log('Demo Lesson Data: $demoLessonData');

          final List<StudentLessonModel> demoLessons =
              demoLessonData.map((json) {
            if (json is Map<String, dynamic>) {
              return StudentLessonModel.fromJson(json);
            } else {
              log('Unexpected type for demo lesson data: ${json.runtimeType}');
              throw Exception('Unexpected data format');
            }
          }).toList();

          return demoLessons;
        } else {
          throw Exception('Unexpected data format: ${data['data']}');
        }
      } else {
        throw Exception('Failed to fetch demo lessons: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching demo lessons: $e');
      throw Exception('Error fetching demo lessons: $e');
    }
  }
}
