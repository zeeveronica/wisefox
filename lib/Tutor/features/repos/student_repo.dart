import 'dart:convert';
import 'dart:developer';
import 'package:wisefox/client/features/model/student_model.dart';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';
import 'package:wisefox/client/features/service/urls.dart';

class StudentRepository {
  final ApiService apiService;

  StudentRepository({ApiService? apiService})
      : apiService = apiService ?? ApiService();

  Future<List<StudentModel>> fetchStudents() async {
    try {
      log("Attempting to fetch students...");
      var loginData = await SharedPreferencesHelper.getData("loginData");
      log("Retrieved loginData: $loginData");

      if (loginData == null) {
        log("No login data found");
        throw Exception("Login data not found");
      }

      final loginDataMap = jsonDecode(loginData);
      if (!loginDataMap.containsKey("studentId")) {
        log("studentId is missing from login data");
        throw Exception("studentId is missing");
      }

      String id = loginDataMap["studentId"].toString();
      log("student id: $id");

      final url = '${Urls.students}?id=$id';
      log('Fetching students from URL: $url');

      final response = await apiService.getResponse(url);
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('Decoded data for students: $data');

        final studentData = data['data'];
        if (studentData != null && studentData['results'] != null) {
          final results = studentData['results'] as List<dynamic>;
          return results.map((json) => StudentModel.fromJson(json)).toList();
        } else {
          throw Exception('No student data found');
        }
      } else {
        throw Exception(
            'Failed to fetch students with status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching students: $e');
      throw Exception('Error fetching students: $e');
    }
  }

  Future<StudentModel> fetchStudentById(String studentId) async {
    try {
      log("Fetching student by ID: $studentId");

      final url = '${Urls.students}?id=$studentId';
      log('Fetching student details from URL: $url');

      final response = await apiService.getResponse(url);
      log('Response body for student ID $studentId: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('Decoded data for student: $data');

        final studentData = data['data'];
        if (studentData != null) {
          return StudentModel.fromJson(studentData as Map<String, dynamic>);
        } else {
          throw Exception('No student data found for ID: $studentId');
        }
      } else {
        throw Exception(
            'Failed to fetch student with ID: $studentId, status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching student by ID: $e');
      throw Exception('Error fetching student by ID: $e');
    }
  }
}
