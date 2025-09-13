import 'dart:convert';
import 'package:wisefox/apps/utils/urls.dart';
import 'package:wisefox/student/features/model/lesson_model.dart';
import 'package:wisefox/student/features/service/api_service.dart';
import 'package:wisefox/student/features/service/shared_preferences.dart';

class LessonRepository {
  ApiService apiService = ApiService();

  Future<List<LessonModel>> fetchLessons(String type, String? date) async {
    try {
      var loginData = await SharedPreferencesHelper.getData("loginData");
      print('Login Data fetchLessons: $loginData');

      var activeId = loginData["user"]["activeId"];
      print("ActiveId: $activeId");

      // var response = await apiService.getResponse(
      //   '${Url.lessons}?id=$activeId&type=$type',
      // );
      //
      // if (date != null) {
      //   response = await apiService.getResponse(
      //     '${Url.lessons}?id=$activeId&type=$type&date=$date',
      //   );
      // }

      // Build the URL conditionally
      String apiUrl = '${Url.lessons}?id=$activeId&type=$type';

      // Add date parameter if provided
      if (date != null) {
        apiUrl += '&date=$date';
      }

      // print('API URL: $apiUrl'); // Debug the final URL
      // print('Date parameter: $date'); // Debug the date

      // Make single API call
      var response = await apiService.getResponse(apiUrl);

      print('Response body: ${response.body}'); // Debugging line
      print('Response status code: ${response.statusCode}'); // Debugging line

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Decoded data: $data'); // Debugging line

        final lessonData = data['data']['results']; // Access 'results'
        if (lessonData != null) {
          final List<LessonModel> lessons = (lessonData as List<dynamic>)
              .map((json) => LessonModel.fromJson(json as Map<String, dynamic>))
              .toList();
          return lessons;
        } else {
          throw Exception('No lesson data found');
        }
      } else {
        throw Exception(
            'Failed to fetch lessons with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching lessons: $e');
      throw Exception('Error fetching lessons: $e');
    }
  }
}
