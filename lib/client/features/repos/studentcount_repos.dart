import 'dart:convert';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';
import 'package:wisefox/client/features/service/urls.dart';

class StudentCountRepository {
  final ApiService apiService = ApiService();

  Future<Map<String, dynamic>> fetchCounts() async {
    try {
      var loginData = await SharedPreferencesHelper.getData("loginData");

      final response = await apiService.getResponse(
          '${Urls.studentcount}?id=${loginData["clientid"].toString()}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Counts data: $data'); // Debug print to inspect the response

        final dataContent = data['data'] ?? {};
        final studentCount = dataContent['student'] ?? 0;
        final activeStudents = dataContent['active_student'] ?? 0;
        final inactiveStudents = dataContent['inactive_student'] ?? 0;
        final onLeaveStudents = dataContent['on_leave'] ?? 0;

        return {
          'student_count': studentCount,
          'active_students': activeStudents,
          'inactive_students': inactiveStudents,
          'on_leave_students': onLeaveStudents,
        };
      } else {
        throw Exception(
            'Failed to fetch counts with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching counts: $e');
      throw Exception('Error fetching counts: $e');
    }
  }

  Future<Map<String, dynamic>> fetchAllData() async {
    try {
      final counts = await fetchCounts();

      return {
        'student_count': counts['student_count'] as int? ?? 0,
        'active_students': counts['active_students'] as int? ?? 0,
        'inactive_students': counts['inactive_students'] as int? ?? 0,
        'on_leave_students': counts['on_leave_students'] as int? ?? 0,
      };
    } catch (e) {
      print('Error fetching all data: $e');
      throw Exception('Error fetching all data: $e');
    }
  }
}
