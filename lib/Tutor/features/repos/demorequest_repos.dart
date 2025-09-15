// import 'dart:convert';
// import 'dart:developer';

// import 'package:wisefox/client/features/model/sentedfile_model.dart';
// import 'package:wisefox/client/features/service/api_service.dart';
// import 'package:wisefox/client/features/service/shared_preferences.dart';
// import 'package:wisefox/client/features/service/urls.dart';

// class DemoRequestRepository {
//   final ApiService apiService;

//   DemoRequestRepository(this.apiService);

//   Future<List<StudentListModel>> fetchSentFiles() async {
//     try {
//       var loginData = await SharedPreferencesHelper.getData("loginData");
//       final studentId = loginData["clientid"].toString();

//       final response =
//           await apiService.getResponse('${Urls.studentlist}?id=$studentId');
//       print('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         print('Full response data: $data');

//         if (data.containsKey('data')) {
//           final dataContent = data['data'];
//           print('data["data"] type: ${dataContent.runtimeType}');

//           if (dataContent.containsKey('results')) {
//             final resultsList = dataContent['results'] as List<dynamic>;
//             return resultsList
//                 .map((file) => StudentListModel.fromJson(file))
//                 .toList();
//           } else {
//             throw Exception('Expected "results" key in "data"');
//           }
//         } else {
//           throw Exception('"data" key not found in response');
//         }
//       } else {
//         throw Exception(
//             'Failed to fetch sent files with status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching sent files: $e');
//       throw Exception('Error fetching sent files: $e');
//     }
//   }

//   Future<List<StudentListModel>> listsearchstudents(
//       {String? searchQuery}) async {
//     try {
//       var loginData = await SharedPreferencesHelper.getData('loginData');
//       final studentId = loginData["clientid"].toString(); // Fetching studentId
//       log("Fetching students for studentId: $studentId");

//       String url =
//           '${Urls.studentlist}?id=$studentId'; // Appending studentId to URL

//       // Append the search query if it's provided and not empty
//       if (searchQuery != null && searchQuery.isNotEmpty) {
//         url += '&search=$searchQuery';
//       }

//       final response = await apiService.getResponse(url);
//       log('Response from API: ${response.body}');

//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         log("Response data: $jsonResponse");

//         if (jsonResponse.containsKey('data') && jsonResponse['data'] != null) {
//           final dataContent = jsonResponse['data'];
//           log('data["data"] type: ${dataContent.runtimeType}');

//           if (dataContent.containsKey('results')) {
//             final resultsList = dataContent['results'] as List<dynamic>;
//             return resultsList
//                 .map((json) => StudentListModel.fromJson(json))
//                 .toList();
//           } else {
//             throw Exception('Expected "results" key in "data"');
//           }
//         } else {
//           throw Exception('No data available or invalid response structure');
//         }
//       } else {
//         throw Exception('Failed to load students: ${response.statusCode}');
//       }
//     } catch (e) {
//       log("Error occurred: $e");
//       throw Exception('Failed to load students: $e');
//     }
//   }

//   Future<void> deleteReceivedFile(int fileId) async {
//     List<int> ids = [fileId];
//     Map<String, dynamic> body = {"id": ids};
//     log("ids are $body");
//     final response =
//         await apiService.deleteWithBody(Urls.deletefile, jsonEncode(body));
//     log("response is ${response.body}");
//     if (response.statusCode != 200) {
//       throw Exception('Failed to delete received file');
//     }
//   }
// }
import 'dart:convert';
import 'dart:developer';

import 'package:wisefox/client/features/model/sentedfile_model.dart';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';
import 'package:wisefox/client/features/service/urls.dart';

class DemoRequestRepository {
  final ApiService apiService;

  DemoRequestRepository(this.apiService);

  Future<List<StudentListModel>> fetchSentFiles() async {
    try {
      var loginData = await SharedPreferencesHelper.getData("loginData");
      final studentId = loginData?["clientid"]?.toString();

      if (studentId == null) {
        throw Exception('Student ID not found in login data.');
      }

      final response =
          await apiService.getResponse('${Urls.studentlist}?id=$studentId');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('Full response data: $data');

        if (data.containsKey('data') && data['data'] != null) {
          final dataContent = data['data'];
          log('data["data"] type: ${dataContent.runtimeType}');

          if (dataContent.containsKey('results')) {
            final resultsList = dataContent['results'] as List<dynamic>;
            return resultsList
                .map((file) => StudentListModel.fromJson(file))
                .toList();
          } else {
            throw Exception('Expected "results" key in "data".');
          }
        } else {
          throw Exception('"data" key not found in response.');
        }
      } else {
        throw Exception(
            'Failed to fetch sent files with status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching sent files: $e');
      throw Exception('Error fetching sent files: $e');
    }
  }

  Future<List<StudentListModel>> listSearchStudents(
      {String? searchQuery}) async {
    try {
      var loginData = await SharedPreferencesHelper.getData('loginData');
      final clientid = loginData["clientid"]?.toString();

      if (clientid == null) {
        throw Exception('Tutor ID not found in login data.');
      }

      log("Fetching students for clientid: $clientid");

      // Construct the base URL
      String url = Urls.studentlist;

      // Append the search query if it's provided and not empty
      if (searchQuery != null && searchQuery.isNotEmpty) {
        url += '?search=$searchQuery';
      }

      final response = await apiService.getResponse(url);
      log('Response from API: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        log("Response data: $jsonResponse");

        if (jsonResponse['status'] == true && jsonResponse['data'] != null) {
          final results = jsonResponse['data']['results'] as List<dynamic>;
          return results
              .map((json) => StudentListModel.fromJson(json))
              .toList();
        } else {
          throw Exception('No data available or invalid response structure.');
        }
      } else {
        throw Exception('Failed to load students: ${response.statusCode}');
      }
    } catch (e) {
      log("Error occurred: $e");
      throw Exception('Failed to load students: $e');
    }
  }

  Future<void> deleteReceivedFile(int fileId) async {
    List<int> ids = [fileId];
    Map<String, dynamic> body = {"id": ids};
    log("ids are $body");

    final response =
        await apiService.deleteWithBody(Urls.deletefile, jsonEncode(body));
    log("response is ${response.body}");

    if (response.statusCode != 200) {
      throw Exception('Failed to delete received file');
    }
  }
}
