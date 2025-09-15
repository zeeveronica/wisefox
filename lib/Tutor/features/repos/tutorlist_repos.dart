import 'dart:convert';
import 'package:wisefox/client/features/model/academicyear_model.dart';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';
import 'package:wisefox/client/features/service/urls.dart';
import 'package:http/http.dart' as http;

class AcademicYearRepository {
  ApiService apiService = ApiService();

  AcademicYearRepository();

  Future<List<AcademicYearModel>> fetchTutorList() async {
    var loginData = await SharedPreferencesHelper.getData("loginData");

    final response = await apiService.getResponse(
      '${Urls.tutor_count}?id=${loginData["clientid"].toString()}',
    );

    print('Response body: ${response.body}'); // Log the response body

    if (response.statusCode == 200) {
      // Decode the JSON response
      final Map<String, dynamic> jsonData = json.decode(response.body);

      // Extract the list of tutors from the 'results' key inside 'data'
      final List<dynamic> tutorResults = jsonData['data']['results'];

      // Map the list to the TutorList model
      return tutorResults
          .map((json) => AcademicYearModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load tutor list');
    }
  }
}
