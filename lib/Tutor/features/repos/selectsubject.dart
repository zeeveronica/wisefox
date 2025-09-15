import 'dart:convert';
import 'package:wisefox/client/features/model/subject_model.dart';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';
import 'package:wisefox/client/features/service/urls.dart';
import 'package:http/http.dart' as http;

class SubjectRepository {
  final ApiService apiService;

  SubjectRepository(this.apiService);

  Future<List<SubjectModel>> fetchSubjectList() async {
    try {
      final loginData = await SharedPreferencesHelper.getData("loginData");
      final clientId = loginData["clientid"] ?? "defaultClientId";

      final response = await apiService.getResponse(
        '${Urls.subject_list}?id=$clientId',
      );

      print('Response body: ${response.body}'); // Log the response body

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> subjectResults =
            jsonData['data']['results']; // Access results directly

        return subjectResults
            .map((json) => SubjectModel.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Failed to load subject list. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print("Error: $error"); // Log the error
      throw Exception("Failed to fetch subject list: $error");
    }
  }
}
