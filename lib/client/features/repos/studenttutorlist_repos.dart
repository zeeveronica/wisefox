import 'dart:convert';

import 'package:wisefox/client/features/model/tutorlist_model.dart';
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/urls.dart';

class Tutorlistrepo {
  ApiService apiService = ApiService();

  Future<List<Result>> Tutorlistclasses() async {
    try {
      final response = await apiService.getResponse(
        '${Urls.tutordropdown}',
      );
      print("API response status: ${response.statusCode}");
      print("API response body: ${response.body}");
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("Raw JSON response: $jsonResponse");
        // Check if 'status' and 'data' exist
        if (jsonResponse.containsKey('status') &&
            jsonResponse['status'] == true &&
            jsonResponse.containsKey('data') &&
            jsonResponse['data'] != null) {
          final data = jsonResponse['data'];
          if (data.containsKey('results') && data['results'] is List) {
            final results = data['results'] as List<dynamic>;
            return results.map((json) => Result.fromJson(json)).toList();
          } else {
            throw Exception(
                'Invalid data format: "results" key is missing or not a list');
          }
        } else {
          throw Exception(
              'Invalid response structure: "status" or "data" key is missing');
        }
      } else {
        throw Exception(
            'Failed to load tutors. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to load tutors: $e');
    }
  }
}
