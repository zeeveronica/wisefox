// import 'dart:convert';
// import 'package:wisefox/student/features/model/tutor_model.dart';
// import 'package:wisefox/student/features/service/api_service.dart';
// import 'package:wisefox/student/features/service/shared_preferences.dart';
// import 'package:wisefox/apps/utils/urls.dart';

// class TutorRepository {
//   ApiService apiService = ApiService();

//   Future<List<Tutor>> fetchTutors() async {
//     try {
//       var loginData = await SharedPreferencesHelper.getData("loginData");

//       final response = await apiService.getResponse(
//           '${Urls.my_tutor}?id=${loginData["activeId"].toString()}');
//       print('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         print('Decoded data: $data');

//         final results = data['data']['results'];
//         if (results is List) {
//           return results
//               .map((tutorJson) =>
//                   Tutor.fromJson(tutorJson as Map<String, dynamic>))
//               .toList();
//         } else {
//           throw Exception('Expected a list of tutors but found ${results}');
//         }
//       } else {
//         throw Exception(
//             'Failed to fetch tutors with status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching tutors: $e');
//       throw Exception('Error fetching tutors: $e');
//     }
//   }

//   Future<Map<String, dynamic>> fetchCounts() async {
//     try {
//       var loginData = await SharedPreferencesHelper.getData("loginData");

//       final response = await apiService.getResponse(
//           '${Urls.mycount}?id=${loginData["activeId"].toString()}');
//       print('Response body: ${response.body}');
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         print('Counts data: $data'); // Debug print to inspect the response

//         final dataContent = data['data'] ?? {};
//         final tutorCount = dataContent['tutor_count'] ?? 0;
//         final activeTutors = dataContent['active_tutors'] ?? 0;
//         final onLeaveTutors = dataContent['on_leave_tutors'] ?? 0;

//         return {
//           'tutor_count': tutorCount,
//           'active_tutors': activeTutors,
//           'on_leave_tutors': onLeaveTutors,
//         };
//       } else {
//         throw Exception(
//             'Failed to fetch counts with status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching counts: $e');
//       throw Exception('Error fetching counts: $e');
//     }
//   }

//   Future<Map<String, dynamic>> fetchAllData() async {
//     try {
//       final tutorsFuture = fetchTutors();
//       final countsFuture = fetchCounts();

//       final List<dynamic> results = await Future.wait([
//         tutorsFuture,
//         countsFuture,
//       ]);

//       final tutors = results[0] as List<Tutor>;
//       final counts = results[1] as Map<String, dynamic>;

//       return {
//         'tutors': tutors,
//         'tutor_count': counts['tutor_count'] as int? ?? 0,
//         'active_tutors': counts['active_tutors'] as int? ?? 0,
//         'on_leave_tutors': counts['on_leave_tutors'] as int? ?? 0,
//       };
//     } catch (e) {
//       print('Error fetching all data: $e');
//       throw Exception('Error fetching all data: $e');
//     }
//   }
// }
import 'dart:convert';
import 'package:wisefox/student/features/model/tutor_model.dart';

import 'package:wisefox/student/features/service/api_service.dart';
import 'package:wisefox/student/features/service/shared_preferences.dart';
import 'package:wisefox/apps/utils/urls.dart';

class TutorRepository {
  ApiService apiService = ApiService();

  Future<List<Tutor>> fetchTutors() async {
    try {
      var loginData = await SharedPreferencesHelper.getData("loginData");

      var activeId = loginData["user"]["activeId"];
      print("ActiveId: $activeId");

      final response = await apiService.getResponse(
          '${Url.my_tutor}?id=$activeId');
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
          throw Exception('Expected a list of tutors but found ${results}');
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

      var activeId = loginData["user"]["activeId"];
      print("ActiveId: $activeId");

      final response = await apiService.getResponse(
          '${Url.mycount}?id=$activeId');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Counts data: $data'); // Debug print to inspect the response

        final dataContent = data['data'] ?? {};
        final tutorCount = dataContent['tutor_count'] ?? 0;
        final activeTutors = dataContent['active_tutors'] ?? 0;
        final onLeaveTutors = dataContent['on_leave_tutors'] ?? 0;

        return {
          'tutor_count': tutorCount,
          'active_tutors': activeTutors,
          'on_leave_tutors': onLeaveTutors,
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
        'active_tutors': counts['active_tutors'] as int? ?? 0,
        'on_leave_tutors': counts['on_leave_tutors'] as int? ?? 0,
      };
    } catch (e) {
      print('Error fetching all data: $e');
      throw Exception('Error fetching all data: $e');
    }
  }
}
