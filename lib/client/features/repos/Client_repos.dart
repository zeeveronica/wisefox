import 'dart:convert';
import 'dart:developer';

import 'package:wisefox/client/features/model/client_model.dart';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';
import 'package:wisefox/client/features/service/urls.dart';

class ClientRepository {
  ApiService apiService = ApiService();

  Future<List<ClientModel>> fetchStudents() async {
    try {
      var loginData = await SharedPreferencesHelper.getData("loginData");
      log("loginData is $loginData");

      final response = await apiService.getResponse(
          '${Urls.clients}?id=${loginData["clientid"].toString()}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Decoded data for students: $data');
        final studentData = data['data'];
        if (studentData != null) {
          final student =
              ClientModel.fromJson(studentData as Map<String, dynamic>);
          return [student];
        } else {
          throw Exception('No student data found');
        }
      } else {
        throw Exception(
            'Failed to fetch students with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching students: $e');
      throw Exception('Error fetching students: $e');
    }
  }

  fetchAllData() {}
}
