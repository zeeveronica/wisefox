import 'dart:convert';
import 'package:wisefox/client/features/model/tutor_model.dart';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';
import 'package:wisefox/client/features/service/urls.dart';

class TutorRepository {
  ApiService apiService = ApiService();

  Future<List<Tutor>> fetchTutors() async {
    try {
      var loginData = await SharedPreferencesHelper.getData("loginData");
      print('Login Data: $loginData');

      if (loginData["clientid"] == null) {
        throw Exception('Error: clientId is null in SharedPreferences data');
      }

      final response = await apiService.getResponse(
          '${Urls.my_tutor}?id=${loginData["clientid"].toString()}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Decoded data: $data');

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
      print('Error fetching tutors: $e');
      throw Exception('Error fetching tutors: $e');
    }
  }

  Future<Map<String, dynamic>> fetchCounts() async {
    try {
      var loginData = await SharedPreferencesHelper.getData("loginData");
      print('Login Data: $loginData');

      if (loginData["clientid"] == null) {
        throw Exception('Error: clientId is null in SharedPreferences data');
      }

      final response = await apiService.getResponse(
          '${Urls.mycount}?id=${loginData["clientid"].toString()}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Counts data: $data'); // Debug print to inspect the response

        final dataContent = data['data'] ?? {};

        // Fetch relevant fields from the response
        final pendingApproval = dataContent['pending_approval'] ?? 0;
        final tutorCount = dataContent['tutor'] ?? 0;
        final approval = dataContent['approval'] ?? 0;
        final rejected = dataContent['rejected'] ?? 0;
        final active = dataContent['active'] ?? 0;
        final inactive = dataContent['inactive'] ?? 0;
        final onLeave = dataContent['on_leave'] ?? 0;
        final allocated = dataContent['allocated'] ?? 0;
        final unAllocated = dataContent['un_allocated'] ?? 0;

        // Return the counts
        return {
          'pending_approval': pendingApproval,
          'tutor_count': tutorCount,
          'approval': approval,
          'rejected': rejected,
          'active': active,
          'inactive': inactive,
          'on_leave': onLeave,
          'allocated': allocated,
          'un_allocated': unAllocated,
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
      final tutorsFuture = fetchTutors();
      final countsFuture = fetchCounts();

      final List<dynamic> results = await Future.wait([
        tutorsFuture,
        countsFuture,
      ]);

      final tutors = results[0] as List<Tutor>;
      final counts = results[1] as Map<String, dynamic>;

      return {
        'tutors': tutors,
        'tutor_count': counts['tutor_count'] as int? ?? 0,
        'active_tutors': counts['active'] as int? ?? 0, // This line
        'on_leave_tutors': counts['on_leave'] as int? ?? 0, // This line
      };
    } catch (e) {
      print('Error fetching all data: $e');
      throw Exception('Error fetching all data: $e');
    }
  }
}
