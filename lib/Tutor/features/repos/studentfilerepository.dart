import 'dart:convert';
import 'dart:developer';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';
import 'package:wisefox/client/features/service/urls.dart';
import 'package:http/http.dart' as http;

class StudentFileRepository {
  ApiService apiService = ApiService();

  Future<http.Response> shareFileToApi({
    required int? id,
    required String receiver,
    required String sender,
    required String file,
    required String title,
    required String notes,
    required bool isDraft,
  }) async {
    final body = {
      // "id": id,
      "reciever": receiver,
      "sender": sender,
      "file": file,
      "title": title,
      "notes": notes,
      "is_draft": isDraft,
    };

    log('ID: $id');
    try {
      var loginData = await SharedPreferencesHelper.getData('loginData');
      String userId = loginData["userid"].toString();
      log("User ID: $userId");

      final response =
          await apiService.postResponse(Urls.sharefile, jsonEncode(body));

      log("Completed request with body: $body");
      print('Response Status: ${response.statusCode}');
      return response;
    } catch (e) {
      throw Exception('Failed to share file to API: $e');
    }
  }
}

// BLoC class

