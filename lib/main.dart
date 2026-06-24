import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/global_settings.dart';
import 'l10n/app_localizations.dart';
import 'theme/app_colors.dart';
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
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          title: 'Chin Chin Chinese',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepPurple,
            scaffoldBackgroundColor: AppColors.scaffoldLight,
            cardColor: Colors.white,
            fontFamily: 'Roboto',
            useMaterial3: true,
            iconTheme: const IconThemeData(color: Colors.black54),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: AppColors.textDark),
              bodyMedium: TextStyle(color: AppColors.textMedium),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.deepPurple,
            scaffoldBackgroundColor: AppColors.scaffoldDark,
            cardColor: AppColors.cardDark,
            fontFamily: 'Roboto',
            useMaterial3: true,
            iconTheme: const IconThemeData(color: Colors.white70),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: AppColors.textLightOnDark),
              bodyMedium: TextStyle(color: AppColors.textMediumOnDark),
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
