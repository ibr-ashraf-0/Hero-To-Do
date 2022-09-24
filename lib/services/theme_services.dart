import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final GetStorage _box  = GetStorage();
  final String _key = 'isDarkMood';

  ThemeMode get currentTheme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme(){
   Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light);
   _saveThemeToBox(!_loadThemeFromBox());
  }
  bool _loadThemeFromBox() => _box.read<bool>(_key)?? false;

  void _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);
}
