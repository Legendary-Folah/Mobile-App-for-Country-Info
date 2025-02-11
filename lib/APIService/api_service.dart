import 'dart:convert';

import 'package:mobile_app_for_country_info_with_theme_customization/constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://restfulcountries.com/api/v1';
  final String apiKey = Constants.apiKey;

  Future<List<dynamic>> fetchCountries() async {
    try {
      final Uri uri = Uri.parse("$baseUrl/countries");
      print("Fetching countries from: $uri");
      print('token : $apiKey');

      final response = await http.get(
        uri,
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        print("Parsed JSON Response: $jsonResponse");
        return jsonResponse['data'];
      } else {
        throw Exception(
            "Failed to load countries. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error in fetchCountries: $e");
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> fetchCountryDetails(String countryCode) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/countries/$countryCode"),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body)['data'];
      } else {
        throw Exception("Failed to load country details");
      }
    } catch (e) {
      print(e);
      throw Exception('Error : $e');
    }
  }
}
