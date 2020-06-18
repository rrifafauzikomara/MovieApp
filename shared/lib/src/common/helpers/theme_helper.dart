import 'package:shared_preferences/shared_preferences.dart';

class ThemeHelper {

  saveTheme(bool isDarkTheme) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("theme", isDarkTheme);
  }

  Future<bool>getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var isDarkTheme = preferences.getBool("theme") ?? false;
    return isDarkTheme;
  }

}