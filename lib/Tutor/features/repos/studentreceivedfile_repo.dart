import 'dart:convert';

import 'package:wisefox/client/features/model/studentrecievedfile.dart';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/urls.dart';

class ReceivedFileRepository {
  ApiService apiService = ApiService();
  // Constructor injection of ApiService for better testability

  Future<List<StudentReceivedFile>> getReceivedFiles() async {
    try {
      final response = await apiService.getResponse(Urls.recievedfile);

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
              .map((fileMap) => StudentReceivedFile.fromMap(fileMap))
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

  /// Adds a new received file to the backend API.
}
