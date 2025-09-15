// import 'dart:convert';

// import 'package:wisefox/client/features/model/lesson_details_model.dart';
// import 'package:wisefox/client/features/service/api_service.dart';
// import 'package:wisefox/client/features/service/shared_preferences.dart';
// import 'package:wisefox/client/features/service/urls.dart';

// class LessondetailsRepository {
//   ApiService apiService = ApiService();

//   LessondetailsRepository();

//   Future<LessonData> fetchLessonDetails(String lessonId) async {
//     try {
//       // Retrieve login data from SharedPreferences if needed
//       var loginData = await SharedPreferencesHelper.getData("loginData");

//       // Construct the URL for fetching lesson details
//       final url = '${Urls.lessonDetails}?id=$lessonId';

//       // Make the HTTP GET request using the ApiService
//       final response = await apiService.getResponse(url);
//       print(
//           'Response body: ${response.body}'); // Debug print to inspect the response

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         print('Lesson data: $data'); // Debug print to inspect the lesson data

//         // Parse the data using the model
//         final lessonDetails = LessonDetails.fromJson(data);
//         return lessonDetails.data;
//       } else {
//         throw Exception(
//             'Failed to load lesson details with status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching lesson details: $e');
//       throw Exception('Error fetching lesson details: $e');
//     }
//   }
// }
import 'dart:convert';
import 'package:wisefox/client/features/model/lesson_details_model.dart';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';
import 'package:wisefox/client/features/service/urls.dart';

class LessondetailsRepository {
  ApiService apiService = ApiService();

  LessondetailsRepository();
  Future<LessonData> fetchLessonDetails(
      String lessonId, String timezone) async {
    try {
      // Retrieve login data from SharedPreferences if needed
      var loginData = await SharedPreferencesHelper.getData("loginData");
      final url = '${Urls.lessonDetails}?id=$lessonId&timezone=$timezone';
      final response = await apiService.getResponse(url);
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Lesson data: $data');
        if (data != null && data['data'] != null) {
          final lessonDetails = LessonDetails.fromJson(data);
          return lessonDetails.data;
        } else {
          throw Exception('No lesson data found');
        }
      } else {
        throw Exception(
            'Failed to load lesson details with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching lesson details: $e');
      throw Exception('Error fetching lesson details: $e');
    }
  }
}
