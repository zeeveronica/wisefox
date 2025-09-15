import 'dart:convert';
import 'dart:developer';

import 'package:wisefox/client/features/model/studentsendfile.dart';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/urls.dart';
import 'package:http/http.dart';

class SendFileRepository {
  ApiService apiService = ApiService();
  // Constructor injection of ApiService for better testability

  Future<List<StudentSendfile>> getsendFiles() async {
    try {
      final response = await apiService.getResponse(Urls.sendfiles);

      print("API response status: ${response.statusCode}");
      print("API response body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print("Parsed JSON response: $jsonResponse");

        if (jsonResponse.containsKey('status') &&
            jsonResponse['status'] == true) {
          // Access the 'results' key to get the list of files
          final List<dynamic> results = jsonResponse['data']['results'];
          return results
              .map((fileMap) => StudentSendfile.fromMap(fileMap))
              .toList();
        } else {
          throw Exception('Invalid response: "status" is false or missing.');
        }
      } else {
        throw Exception(
            'Failed to load received files. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error in getReceivedFiles: $e");
      throw Exception('Failed to load received files: $e');
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

  /// Adds a new received file to the backend API.
}
