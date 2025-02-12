import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mobile_app_for_country_info_with_theme_customization/provider/country_provider.dart';
import 'package:mobile_app_for_country_info_with_theme_customization/provider/theme_provider.dart';

class CountryDetailScreen extends ConsumerWidget {
  final String countryCode;

  const CountryDetailScreen({super.key, required this.countryCode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryDetails = ref.watch(countryDetailsProvider(countryCode));
    final isDarkMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: countryDetails.when(
          data: (country) => Text(
            country['name']?['common'] ?? 'Country Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          loading: () => CircularProgressIndicator(),
          error: (error, _) => Text("Error"),
        ),
      ),
      body: countryDetails.when(
        data: (country) => SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Country Flag
              Center(
                child: CachedNetworkImage(
                  imageUrl: country['flags']?['png'] ?? '',
                  width: 120,
                  height: 80,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(height: 20),

              // Country Name
              Text(
                country['name']?['common'] ?? 'Unknown Country',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              // Capital
              Text(
                "Capital: ${country['capital']?.join(", ") ?? 'N/A'}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),

              // Population
              Text(
                "Population: ${country['population']?.toString() ?? 'N/A'}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),

              // Region
              Text(
                "Region: ${country['region'] ?? 'N/A'}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),

              // Official Language
              Text(
                "Official Language: ${country['languages']?.values.join(", ") ?? 'N/A'}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),

              // Currency
              Text(
                "Currency: ${country['currencies']?.values.first['name'] ?? 'N/A'}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),

              // Time Zone
              Text(
                "Time Zone: ${country['timezones']?.join(", ") ?? 'N/A'}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),

              // Additional Details
              Text(
                "Additional Details:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Area: ${country['area']?.toString() ?? 'N/A'} km²",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Driving Side: ${country['car']?['side'] ?? 'N/A'}",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text(
            "Error: $error",
          ),
        ),
      ),
    );
  }
}
