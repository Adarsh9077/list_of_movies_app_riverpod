import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mvvm_statemanagements/enums/theme_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = StateNotifierProvider<ThemeProvider, ThemeEnums>(
  (ref) => ThemeProvider(),
);

class ThemeProvider extends StateNotifier<ThemeEnums> {
  final prefKey = "isDarkMode";

  ThemeProvider() : super(ThemeEnums.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(prefKey) ?? false;
    state = isDarkMode ? ThemeEnums.light : ThemeEnums.dark;
  }

  Future<void> toggleTheme() async {
    final pref = await SharedPreferences.getInstance();

    if (state == ThemeEnums.light) {
      state = ThemeEnums.dark;
      await pref.setBool(prefKey, true);
    } else {
      state = ThemeEnums.light;
      await pref.setBool(prefKey, false);
    }
  }
}
