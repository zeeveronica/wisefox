// import 'dart:convert';
// import 'package:wisefox/student/features/model/sentedfile_model.dart'; // Ensure correct model import
// import 'package:wisefox/student/features/service/api_service.dart';
// import 'package:wisefox/student/features/service/shared_preferences.dart';
// import 'package:wisefox/apps/utils/urls.dart';

// class SentFilesRepository {
//   ApiService apiService = ApiService();

//   SentFilesRepository();

//   Future<List<SentedModel>> fetchSentFiles() async {
//     try {
//       var loginData = await SharedPreferencesHelper.getData("loginData");
//       final studentId = loginData["activeId"].toString();

//       final response =
//           await apiService.getResponse('${Urls.sentedfiles}?id=$studentId');
//       print('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         print('Full response data: $data'); // Inspect the full response

//         if (data.containsKey('data')) {
//           final dataContent = data['data'];
//           print(
//               'data["data"] type: ${dataContent.runtimeType}'); // Inspect the type of data['data']

//           // Access the 'results' key inside 'data'
//           if (dataContent.containsKey('results')) {
//             final resultsList = dataContent['results'] as List<dynamic>;
//             return resultsList
//                 .map((file) => SentedModel.fromJson(file))
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

// }
import 'dart:convert';
import 'dart:developer';
import 'package:wisefox/student/features/model/sentedfile_model.dart';
import 'package:wisefox/student/features/service/api_service.dart';
import 'package:wisefox/student/features/service/shared_preferences.dart';
import 'package:wisefox/apps/utils/urls.dart';

class SentFilesRepository {
  final ApiService apiService;

  SentFilesRepository(this.apiService);

  Future<List<SentedModel>> fetchSentFiles() async {
    try {
      var loginData = await SharedPreferencesHelper.getData("loginData");

      var activeId = loginData["user"]["activeId"];
      print("ActiveId: $activeId");

      final response =
          await apiService.getResponse('${Url.sentedfiles}?id=$activeId');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Full response data: $data');

        if (data.containsKey('data')) {
          final dataContent = data['data'];
          print('data["data"] type: ${dataContent.runtimeType}');

          if (dataContent.containsKey('results')) {
            final resultsList = dataContent['results'] as List<dynamic>;
            return resultsList
                .map((file) => SentedModel.fromJson(file))
                .toList();
          } else {
            throw Exception('Expected "results" key in "data"');
          }
        } else {
          throw Exception('"data" key not found in response');
        }
      } else {
        throw Exception(
            'Failed to fetch sent files with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching sent files: $e');
      throw Exception('Error fetching sent files: $e');
    }
  }

  Future<void> deleteReceivedFile(int fileId) async {
    List<int> ids = [fileId];
    Map<String, dynamic> body = {"id": ids};
    log("ids are $body");
    final response =
        await apiService.deleteWithBody(Url.deletefile, jsonEncode(body));
    log("response is ${response.body}");
    if (response.statusCode != 200) {
      throw Exception('Failed to delete received file');
    }
  }
}
