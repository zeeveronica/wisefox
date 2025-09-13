import 'dart:convert';
import 'package:wisefox/student/features/model/filesharing_model.dart';
import 'package:wisefox/student/features/service/api_service.dart';
import 'package:wisefox/student/features/service/shared_preferences.dart';
import 'package:wisefox/apps/utils/urls.dart';

class FilesharingRepository {
  final ApiService apiService = ApiService();

  Future<List<FilesharingModel>> fetchFiles() async {
    try {
      var loginData = await SharedPreferencesHelper.getData("loginData");
      print('Login Data: $loginData');

      var activeId = loginData["user"]["activeId"];
      print("ActiveId: $activeId");

      final response = await apiService.getResponse(
          '${Url.filesharing}?id=$activeId');
      print('Response body: ${response.body}');
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Decoded data: $data');

        final fileData = data['data']['results'];
        if (fileData != null) {
          final List<FilesharingModel> files = (fileData as List<dynamic>)
              .map((json) =>
                  FilesharingModel.fromJson(json as Map<String, dynamic>))
              .toList();
          return files;
        } else {
          throw Exception('No file data found');
        }
      } else {
        throw Exception(
            'Failed to fetch files with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching files: $e');
      throw Exception('Error fetching files: $e');
    }
  }
}
