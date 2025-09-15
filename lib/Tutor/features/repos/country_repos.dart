import 'dart:convert';
import 'package:wisefox/client/features/model/country_model.dart'; // Adjust the path as necessary
import 'package:wisefox/client/features/service/api_service.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';
import 'package:wisefox/client/features/service/urls.dart';
import 'package:http/http.dart' as http;

class CountryRepository {
  final ApiService apiService;

  CountryRepository(this.apiService);

  Future<List<CountryModel>> fetchCountryList() async {
    try {
      final loginData = await SharedPreferencesHelper.getData("loginData");
      final clientId = loginData["clientid"] ?? "defaultClientId";

      final response = await apiService.getResponse(
        '${Urls.country_list}?id=$clientId', // Update the URL accordingly
      );

      print('Response body: ${response.body}'); // Log the response body

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> countryResults =
            jsonData['data']; // Directly access "data"

        return countryResults
            .map((json) =>
                CountryModel.fromJson(json)) // Map each JSON to CountryModel
            .toList();
      } else {
        throw Exception(
            'Failed to load country list. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print("Error: $error"); // Log the error
      throw Exception("Failed to fetch country list: $error");
    }
  }
}
