import 'dart:convert';

import 'package:wisefox/client/features/model/clientoverview_model.dart';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';
import 'package:wisefox/client/features/service/urls.dart';

class ClientOverviewRepository {
  ApiService apiService = ApiService();

  Future<ClientOverviewCount> fetchOverviewCount() async {
    try {
      var loginData = await SharedPreferencesHelper.getData("loginData");

      final response = await apiService.getResponse(
          '${Urls.clientoverviewcount}?id=${loginData["clientid"].toString()}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Counts data: $data'); // Debug print to inspect the response

        final dataContent = data['data'] ?? {};
        return ClientOverviewCount.fromJson(dataContent);
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
