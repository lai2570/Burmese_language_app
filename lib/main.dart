import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/global_settings.dart';
import 'pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool isDark = prefs.getBool('isDarkMode') ?? false;
  GlobalSettings.themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
  GlobalSettings.voiceVolume = prefs.getDouble('voiceVolume') ?? 1.0;
  GlobalSettings.sfxVolume = prefs.getDouble('sfxVolume') ?? 0.5;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: GlobalSettings.themeMode,
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: 'Chin Chin Chinese',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepPurple,
            scaffoldBackgroundColor: const Color(0xFFF5F7FA),
            cardColor: Colors.white,
            fontFamily: 'Roboto',
            useMaterial3: true,
            iconTheme: const IconThemeData(color: Colors.black54),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Color(0xFF1E293B)),
              bodyMedium: TextStyle(color: Color(0xFF334155)),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.deepPurple,
            scaffoldBackgroundColor: const Color(0xFF111827),
            cardColor: const Color(0xFF1F2937),
            fontFamily: 'Roboto',
            useMaterial3: true,
            iconTheme: const IconThemeData(color: Colors.white70),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Color(0xFFF1F5F9)),
              bodyMedium: TextStyle(color: Color(0xFFCBD5E1)),
            ),
          ),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child!,
            );
          },
          home: const SplashScreen(),
        );
      },
    );
  }
}
