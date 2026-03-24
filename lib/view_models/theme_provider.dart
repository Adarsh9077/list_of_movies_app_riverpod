// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ThemeProvider extends StateNotifier {
  final prefKey = "isDarkMode";

 ThemeProvider():super(){
   _loadTheme();
 }
 Future<void> _loadTheme() async {

 }

}