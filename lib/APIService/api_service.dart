import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://restcountries.com/v3.1';

  Future<List<dynamic>> fetchCountries() async {
    try {
      final Uri uri = Uri.parse("$baseUrl/all");
      print("Fetching countries from: $uri");

      final response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
      );
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        print("Parsed JSON Response: $jsonResponse");
        return jsonResponse;
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
      final Uri uri = Uri.parse("$baseUrl/alpha/$countryCode");
      final response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse[0];
      } else {
        throw Exception(
            "Failed to load country details : Status Code ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      throw Exception('Error : $e');
    }
  }
}
