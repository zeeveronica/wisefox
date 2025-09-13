import 'dart:convert';
import 'dart:developer';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/urls.dart';
import 'package:http/http.dart' as http;

class FileRepository {
  ApiService apiService = ApiService();

  Future<http.Response> shareFileToApi({
    required int? id,
    required List<int> receiver,
    required String file,
    required String title,
    required String notes,
    required bool isDraft,
  }) async {
    final body = {
      // Include id if needed
      "id": id,
      "reciever": receiver.first.toString(),
      "file": file,
      "title": title,
      "notes": notes,
      "is_draft": isDraft,
    };

    try {
      log("Request body: $receiver");
      final response =
          await apiService.postResponse(Urls.filesharepost, jsonEncode(body));
      log("Completed request: $body");
      log('Response Status: ${response.body}');
      return response;
    } catch (e) {
      throw Exception('Failed to share file to API: $e');
    }
  }
}
