import 'dart:convert';

import 'package:wisefox/client/features/model/lesson_model.dart';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';
import 'package:wisefox/client/features/service/urls.dart';

class ClientLessonRepository {
  ApiService apiService = ApiService();

  Future<List<ClientLessonModel>> fetchLessons(
      String status, String timezone) async {
    try {
      var loginData = await SharedPreferencesHelper.getData("loginData");
      print('Login Data: $loginData'); // Debugging line

      final response = await apiService.getResponse(
          '${Urls.lessons}?id=${loginData["clientid"].toString()}&status=$status&timezone=$timezone');
      print('Response body: ${response.body}'); // Debugging line
      print('Response status code: ${response.statusCode}'); // Debugging line

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Decoded data: $data'); // Debugging line

        final lessonData = data['data']['results']; // Access 'results'
        if (lessonData != null) {
          final List<ClientLessonModel> lessons = (lessonData as List<dynamic>)
              .map((json) =>
                  ClientLessonModel.fromJson(json as Map<String, dynamic>))
              .toList();
          return lessons;
        } else {
          throw Exception('No lesson data found');
        }
      } else {
        throw Exception(
            'Failed to fetch lessons with status code: ${response.statusCode}');
      }
    }
    catch (e) {
      // print('Error fetching lessonsttttt: $e');
      throw Exception('');
    }
  }
}
