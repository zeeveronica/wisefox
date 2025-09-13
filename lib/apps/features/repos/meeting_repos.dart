import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:wisefox/student/features/service/api_service.dart';
import 'package:wisefox/apps/utils/urls.dart';
import 'package:wisefox/student/features/service/shared_preferences.dart';

class MeetingRepository {
  ApiService apiService = ApiService();

  Future<http.Response> meetingCreate({
    required int lessonId,
  }) async {
    try {
      // Get login data
      var loginData = await SharedPreferencesHelper.getData("loginData");
      var activeId = loginData["user"]["activeId"];
      var firstName = loginData["user"]["firstName"];

      // Prepare request body
      final body = {
        "id": lessonId,
        "student_info": [
          {
            "id": activeId,
            "name": firstName,
          }
        ],
        "tutor": 0,
      };

      log("Request body: $body");

      final response = await apiService.postResponse(
        Url.create_meeting,
        jsonEncode(body),
      );

      log("Completed request: $body");
      log('Response Status: ${response.statusCode}');
      log('Response Body: ${response.body}');

      return response;
    } catch (e) {
      throw Exception('Failed to create meeting: $e');
    }
  }
}
