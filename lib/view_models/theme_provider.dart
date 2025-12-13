// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mvvm_statemanagements/enums/theme_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends StateNotifier<ThemeEnums> {
  final String prefKey = "isDarkMode";
  ThemeProvider() : super(ThemeEnums.light) {
    _loadTheme();
  }
  Future<void> _loadTheme() async {
    final pref = await SharedPreferences.getInstance();
    final isDarkMode = pref.getBool(prefKey) ?? false;
    state = isDarkMode ? ThemeEnums.dark : ThemeEnums.light;
  }
}
