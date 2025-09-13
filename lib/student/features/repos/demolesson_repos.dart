import 'dart:convert';
import 'package:wisefox/student/features/model/demolessons_model.dart';
import 'package:wisefox/student/features/service/api_service.dart';
import 'package:wisefox/student/features/service/shared_preferences.dart';
import 'package:wisefox/apps/utils/urls.dart';

class DemoLessonRepository {
  ApiService apiService = ApiService();

  Future<List<DemoLessonModel>> fetchDemoLessons() async {
    try {
      // Retrieve login data from shared preferences
      var loginData = await SharedPreferencesHelper.getData("loginData");
      print('Login Data: $loginData'); // Debugging line

      var activeId = loginData["user"]["activeId"];
      print("ActiveId: $activeId");

      // Send API request with studentId as a query parameter
      final response = await apiService.getResponse(
          '${Url.demoLessons}?id=$activeId');
      print('Response body: ${response.body}'); // Debugging line
      print('Response status code: ${response.statusCode}'); // Debugging line

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Decoded data: $data'); // Debugging line

        final demoLessonData = data['data']['results']; // Access 'results'
        if (demoLessonData != null) {
          final List<DemoLessonModel> demoLessons =
              (demoLessonData as List<dynamic>)
                  .map((json) =>
                      DemoLessonModel.fromJson(json as Map<String, dynamic>))
                  .toList();
          return demoLessons;
        } else {
          throw Exception('No demo lesson data found');
        }
      } else {
        throw Exception(
            'Failed to fetch demo lessons with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching demo lessons: $e');
      throw Exception('Error fetching demo lessons: $e');
    }
  }
}
