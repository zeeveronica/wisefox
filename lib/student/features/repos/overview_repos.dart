import 'dart:convert';
import 'package:wisefox/student/features/model/overview_model.dart';
import 'package:wisefox/student/features/service/api_service.dart';
import 'package:wisefox/student/features/service/shared_preferences.dart';
import 'package:wisefox/apps/utils/urls.dart';

class OverviewRepository {
  ApiService apiService = ApiService();

  Future<OverviewCount> fetchOverviewCount() async {
    try {
      var loginData = await SharedPreferencesHelper.getData("loginData");

      var activeId = loginData["user"]["activeId"];
      print("ActiveId: $activeId");

      final response = await apiService.getResponse(
          '${Url.overviewcount}?id=$activeId');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Counts data: $data'); // Debug print to inspect the response

        final dataContent = data['data'] ?? {};
        return OverviewCount.fromJson(dataContent);
      } else {
        throw Exception(
            'Failed to fetch overview counts with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching overview counts: $e');
      throw Exception('Error fetching overview counts: $e');
    }
  }
}
