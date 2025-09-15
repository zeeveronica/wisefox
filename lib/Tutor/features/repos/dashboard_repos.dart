import 'dart:convert';

import 'package:wisefox/client/features/model/dashboard_model.dart';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';
import 'package:wisefox/client/features/service/urls.dart';

class DashboardRepository {
  final ApiService apiService;

  DashboardRepository(this.apiService);

  Future<DashboardModel?> fetchDashboardData() async {
    try {
      var loginData = await SharedPreferencesHelper.getData("loginData");
      final studentId = loginData["clientid"].toString();

      final response =
          await apiService.getResponse('${Urls.dashboardData}?id=$studentId');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Decoded data: $data');

        if (data['status'] == true && data['data'] != null) {
          return DashboardModel.fromJson(data['data']);
        } else {
          print("Error: ${data['message']}");
          throw Exception("Error: ${data['message']}");
        }
      } else if (response.statusCode == 400) {
        print('Error: Record not found');
        throw Exception('Record not found');
      } else {
        throw Exception(
            'Failed to fetch dashboard data with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching dashboard data: $e');
      return null;
    }
  }
}
