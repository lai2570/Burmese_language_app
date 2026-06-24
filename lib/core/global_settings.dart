import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalSettings {
  static final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.light);

  static double voiceVolume = 1.0;
  static double sfxVolume = 0.5;

  static void toggleTheme() async {
    themeMode.value = themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', themeMode.value == ThemeMode.dark);
  }

  static void saveVolumes() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('voiceVolume', voiceVolume);
    prefs.setDouble('sfxVolume', sfxVolume);
  }
}
