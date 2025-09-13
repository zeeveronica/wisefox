import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wisefox/student/features/model/tutorcount_model.dart';
import 'package:wisefox/student/features/service/api_service.dart';
import 'package:wisefox/student/features/service/shared_preferences.dart';
import 'package:wisefox/apps/utils/urls.dart';

class TutorListRepository {
  ApiService apiService = ApiService();

  TutorListRepository();

  Future<List<TutorList>> fetchTutorList() async {
    var loginData = await SharedPreferencesHelper.getData("loginData");

    var activeId = loginData["user"]["activeId"];
    print("ActiveId: $activeId");

    final response = await apiService.getResponse(
      '${Url.tutor_count}?id=$activeId',
    );

    print('Response body: ${response.body}'); // Log the response body

    if (response.statusCode == 200) {
      // Decode the JSON response
      final Map<String, dynamic> jsonData = json.decode(response.body);

      // Extract the list of tutors from the 'results' key inside 'data'
      final List<dynamic> tutorResults = jsonData['data']['results'];

      // Map the list to the TutorList model
      return tutorResults.map((json) => TutorList.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tutor list');
    }
  }
}
