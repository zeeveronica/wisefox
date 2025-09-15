import 'dart:convert';
import 'dart:developer';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/urls.dart';
import 'package:http/http.dart' as http;

class IsActiveRepository {
  final ApiService apiService = ApiService();

  Future<http.Response> toggleStatus({
    required String studentId,
    required String status,
  }) async {
    final body = {
      "id": studentId,
      "active_choices": status,
    };

    try {
      log("Request body: $body");
      final response = await apiService.postResponse(
        Urls.isActive,
        jsonEncode(body),
      );
      log("Completed request: $body");
      log('Response Status: ${response.statusCode}');
      log('Response Body: ${response.body}');
      return response;
    } catch (e) {
      throw Exception('Failed to change status: $e');
    }
  }
}
