import 'dart:convert';

import 'package:mobile_app_for_country_info_with_theme_customization/constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://restfulcountries.com/api/v1';
  final String apiKey = Constants.apiKey;

  Future<List<dynamic>> fetchCountries() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/countries"),
        headers: {"Authorization": "Bearer $apiKey"},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body)['data'];
      } else {
        throw Exception("Failed to load countries");
      }
    } catch (e) {
      print(e);
      throw Exception('Error : $e');
    }
  }

  Future<Map<String, dynamic>> fetchCountryDetails(String countryCode) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/countries/$countryCode"),
        headers: {"Authorization": "Bearer $apiKey"},
      );

      if (response.statusCode == 200) {
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
