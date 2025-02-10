import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app_for_country_info_with_theme_customization/APIService/api_service.dart';

final countryFutureProvider = FutureProvider<List<dynamic>>((ref) async {
  final apiService = ApiService();
  return apiService.fetchCountries();
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredCountriesProvider = Provider<List<dynamic>>((ref) {
  final searchQuery = ref.watch(searchQueryProvider);
  final countriesProvider = ref.watch(countryFutureProvider);

  return countriesProvider.when(
    data: (countries) {
      if (searchQuery.isEmpty) {
        return countries;
      }
      return countries
          .where((country) =>
              country['name'].toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
});
