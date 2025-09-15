import 'dart:convert';
import 'dart:developer'; // For logging purposes

import 'package:wisefox/client/features/model/tutor_model.dart';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';
import 'package:wisefox/client/features/service/urls.dart';

class StudentTutorRepository {
  ApiService apiService = ApiService();

  // Fetch the list of tutors by passing the studentId
  Future<List<Tutor>> fetchTutors() async {
    try {
      // Retrieve the login data and selected student ID from shared preferences
      var loginData = await SharedPreferencesHelper.getData("loginData");
      var studentId =
          await SharedPreferencesHelper.getData("selectedStudentId");

      if (loginData == null || studentId == null) {
        throw Exception(
            'Error: loginData or studentId is null in SharedPreferences data');
      }

      log('Login Data: $loginData');
      log('Selected Student ID: $studentId');

      // Make the API request using the selectedStudentId
      final response =
          await apiService.getResponse('${Urls.my_tutor}?id=$studentId');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('Decoded data: $data');

        final results = data['data']['results'];
        if (results is List) {
          return results
              .map((tutorJson) =>
                  Tutor.fromJson(tutorJson as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Expected a list of tutors but found $results');
        }
      } else {
        throw Exception(
            'Failed to fetch tutors with status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching tutors: $e');
      throw Exception('Error fetching tutors: $e');
    }
  }

  // Fetch counts like approval, rejected, active, etc. using the studentId
  Future<Map<String, dynamic>> fetchCounts() async {
    try {
      var loginData = await SharedPreferencesHelper.getData("loginData");
      var studentId =
          await SharedPreferencesHelper.getData("selectedStudentId");

      if (loginData == null || studentId == null) {
        throw Exception(
            'Error: loginData or studentId is null in SharedPreferences data');
      }

      log('Login Data: $loginData');
      log('Selected Student ID: $studentId');

      // Make the API request using the selectedStudentId
      final response =
          await apiService.getResponse('${Urls.mycount}?id=$studentId');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('Counts data: $data');

        final dataContent = data['data'] ?? {};

        // Extract the counts from the response
        return {
          'pending_approval': dataContent['pending_approval'] ?? 0,
          'tutor_count': dataContent['tutor'] ?? 0,
          'approval': dataContent['approval'] ?? 0,
          'rejected': dataContent['rejected'] ?? 0,
          'active': dataContent['active'] ?? 0,
          'inactive': dataContent['inactive'] ?? 0,
          'on_leave': dataContent['on_leave'] ?? 0,
          'allocated': dataContent['allocated'] ?? 0,
          'un_allocated': dataContent['un_allocated'] ?? 0,
        };
      } else {
        throw Exception(
            'Failed to fetch counts with status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching counts: $e');
      throw Exception('Error fetching counts: $e');
    }
  }

  // Fetch both tutors and counts concurrently
  Future<Map<String, dynamic>> fetchAllData() async {
    try {
      final tutorsFuture = fetchTutors();
      final countsFuture = fetchCounts();

      // Wait for both tutors and counts to be fetched
      final List<dynamic> results = await Future.wait([
        tutorsFuture,
        countsFuture,
      ]);

      final tutors = results[0] as List<Tutor>;
      final counts = results[1] as Map<String, dynamic>;

      return {
        'tutors': tutors,
        'tutor_count': counts['tutor_count'] as int? ?? 0,
        'active_tutors': counts['active'] as int? ?? 0,
        'on_leave_tutors': counts['on_leave'] as int? ?? 0,
      };
    } catch (e) {
      log('Error fetching all data: $e');
      throw Exception('Error fetching all data: $e');
    }
  }
}
