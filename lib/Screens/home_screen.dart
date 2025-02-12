import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app_for_country_info_with_theme_customization/Screens/country_details_screen.dart';
import 'package:mobile_app_for_country_info_with_theme_customization/provider/country_provider.dart';
import 'package:mobile_app_for_country_info_with_theme_customization/provider/theme_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredCountries = ref.watch(filteredCountriesProvider);
    final isDarkMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Explore",
          style: TextStyle(
            fontSize: 16,
            letterSpacing: 1.5,
          ),
        ),
        actions: [
          IconButton(
            icon: isDarkMode
                ? Icon(Icons.dark_mode_outlined)
                : Icon(Icons.light_mode_outlined),
            onPressed: () {
              ref.read(themeProvider.notifier).state = !isDarkMode;
            },
          )
        ],
      ),
      body: Column(
        spacing: 10,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Country",
                prefixIcon: Icon(Icons.search),
              ),
              textAlign: TextAlign.center,
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
              },
            ),
          ),
          Expanded(
            child: ref.watch(countryFutureProvider).when(
                  data: (countries) {
                    if (filteredCountries.isEmpty) {
                      return Center(
                        child: Text(
                          "No countries found",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: filteredCountries.length,
                      itemBuilder: (context, index) {
                        final country = filteredCountries[index];
                        return ListTile(
                          leading: country['flags']?['png'] != null
                              ? CachedNetworkImage(
                                  imageUrl: country['flags']['png'],
                                  width: 40,
                                  height: 40,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                )
                              : Icon(Icons.flag),
                          title: Text(
                              country['name']?['common'] ?? 'Unknown Country'),
                          subtitle:
                              Text(country['capital']?.join(", ") ?? 'N/A'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CountryDetailScreen(
                                    countryCode: country['cca2']),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (error, _) => Center(
                    child: Text(
                      "Error: $error",
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
