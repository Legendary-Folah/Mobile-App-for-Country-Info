import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mobile_app_for_country_info_with_theme_customization/provider/country_provider.dart';
import 'package:mobile_app_for_country_info_with_theme_customization/widgets/custom_loader.dart';
import 'package:mobile_app_for_country_info_with_theme_customization/widgets/custom_rich_text.dart';

class CountryDetailScreen extends ConsumerWidget {
  final String countryCode;

  const CountryDetailScreen({super.key, required this.countryCode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryDetails = ref.watch(countryDetailsProvider(countryCode));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: countryDetails.when(
          data: (country) => Text(
            country['name']?['common'] ?? 'Country Details',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Axiforma',
              fontWeight: FontWeight.bold,
            ),
          ),
          loading: () => CustomLoader(),
          error: (error, _) => Text("Error"),
        ),
      ),
      body: countryDetails.when(
        data: (country) => SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CachedNetworkImage(
                  imageUrl: country['flags']?['png'] ?? '',
                  width: 200,
                  height: 80,
                  placeholder: (context, url) => CustomLoader(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              CustomRichText(
                text1: 'Population: ',
                text2: country['population']?.toString() ?? 'N/A',
              ),
              CustomRichText(
                text1: 'Region: ',
                text2: country['region'] ?? 'N/A',
              ),
              CustomRichText(
                text1: 'Capital: ',
                text2: country['capital']?.join(", ") ?? 'N/A',
              ),
              CustomRichText(
                text1: 'Continent: ',
                text2: country['continents']?.join(", ") ?? 'N/A',
              ),
              const SizedBox(height: 10),
              CustomRichText(
                text1: 'Official Language: ',
                text2: country['languages']?.values.join(", ") ?? 'N/A',
              ),
              CustomRichText(
                text1: 'Country Code: ',
                text2: country['cioc'] ?? 'N/A',
              ),
              const SizedBox(height: 10),
              CustomRichText(
                text1: 'Area: ',
                text2: '${country['area']?.toString() ?? 'N/A'} km²',
              ),
              CustomRichText(
                text1: 'Currency: ',
                text2: country['currencies']?.values.first['name'] ?? 'N/A',
              ),
              const SizedBox(height: 10),
              CustomRichText(
                text1: 'Time Zone: ',
                text2: country['timezones']?.join(", ") ?? 'N/A',
              ),
              CustomRichText(
                text1: 'Driving Side: ',
                text2: country['car']?['side'] ?? 'N/A',
              ),
            ],
          ),
        ),
        loading: () => Center(child: CustomLoader()),
        error: (error, _) => Center(
          child: Text(
            "Error: $error",
          ),
        ),
      ),
    );
  }
}
