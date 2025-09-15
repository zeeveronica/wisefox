import 'dart:convert';
import 'dart:developer';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/urls.dart';
import 'package:http/http.dart' as http;

class CancelLessonRepository {
  ApiService apiService = ApiService();

  Future<http.Response> cancelLesson({
    required int id,
    required String reasonForCancellation,
  }) async {
    final body = {
      "id": id,
      "reason_for_cancellation": reasonForCancellation,
    };

    try {
      log("Request body: $body");
      final response = await apiService.postResponse(
        Urls.cancellesson, // Replace with actual URL
        jsonEncode(body),
      );
      log("Completed request: $body");
      log('Response Status: ${response.statusCode}');
      log('Response Body: ${response.body}');
      return response;
    } catch (e) {
      throw Exception('Failed to cancel lesson: $e');
    }
  }
}
