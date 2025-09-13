import 'dart:convert';
import 'dart:developer';

import 'package:wisefox/student/features/model/student_model.dart';
import 'package:wisefox/student/features/service/api_service.dart';
import 'package:wisefox/student/features/service/shared_preferences.dart';
import 'package:wisefox/apps/utils/urls.dart';

class StudentRepository {
  ApiService apiService = ApiService();

  Future<List<StudentModel>> fetchStudents() async {
    try {
      var loginData = await SharedPreferencesHelper.getData("loginData");
      log("loginData is $loginData");

      var activeId = loginData["user"]["activeId"];
      print("ActiveId: $activeId");

      final response = await apiService.getResponse(
          '${Url.students}?id=$activeId');
      print('Response body: ${response.body}');


      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Decoded data for students: $data');

        // Access the 'data' object directly
        final studentData = data['data'];
        if (studentData != null) {
          // Convert single student data to a list
          final student =
              StudentModel.fromJson(studentData as Map<String, dynamic>);
          return [student]; // Return a list containing the single student
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
}
