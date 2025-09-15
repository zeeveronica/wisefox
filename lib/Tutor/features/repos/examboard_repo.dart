import 'dart:convert';
import 'package:wisefox/client/features/model/examboard_model.dart';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';
import 'package:wisefox/client/features/service/urls.dart';
import 'package:http/http.dart' as http;

class ExamBoardRepository {
  final ApiService apiService;

  ExamBoardRepository(this.apiService);

  Future<List<ExamBoardModel>> fetchExamBoardList() async {
    try {
      final loginData = await SharedPreferencesHelper.getData("loginData");
      final clientId = loginData["clientid"] ?? "defaultClientId";

      final response = await apiService.getResponse(
        '${Urls.exam_board_list}?id=$clientId', // Update the URL accordingly
      );

      print('Response body: ${response.body}'); // Log the response body

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> examBoardResults =
            jsonData['data']['results']; // Access results directly

        return examBoardResults
            .map((json) => ExamBoardModel.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Failed to load exam board list. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print("Error: $error"); // Log the error
      throw Exception("Failed to fetch exam board list: $error");
    }
  }
}
