import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app_for_country_info_with_theme_customization/colors.dart';

final themeProvider = StateProvider<bool>((ref) {
  return false;
});

final appThemeProvider = Provider<ThemeData>(
  (ref) {
    final isDarkMode = ref.watch(themeProvider);
    return isDarkMode
        ? ThemeData.dark().copyWith(
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: TextStyle(color: Colors.grey[200]),
              filled: true,
              fillColor: ColorsConst.darkModeTextFiled,
              border: InputBorder.none,
            ),
          )
        : ThemeData.light().copyWith(
            appBarTheme: AppBarTheme(
              // color: Colors.white,
              backgroundColor: Colors.white,
            ),
            scaffoldBackgroundColor: Colors.white,
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: TextStyle(color: Colors.black54),
              filled: true,
              fillColor: Colors.grey[100],
              border: InputBorder.none,
            ),
          );
  },
);
