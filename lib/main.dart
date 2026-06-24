import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/global_settings.dart';
import 'pages/splash_page.dart';

void main() async {
  // 1. 確保 Flutter 引擎綁定初始化 (在執行異步操作前必須呼叫)
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. 讀取使用者偏好設定 (SharedPreferences)
  // 用於記住使用者的設定：是否為深色模式、音量大小
  final prefs = await SharedPreferences.getInstance();
  
  // 讀取深色模式設定，預設為 false (淺色)
  bool isDark = prefs.getBool('isDarkMode') ?? false;
  GlobalSettings.themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
  
  // 讀取音量設定，若無紀錄則使用預設值
  GlobalSettings.voiceVolume = prefs.getDouble('voiceVolume') ?? 1.0; // 語音預設最大聲
  GlobalSettings.sfxVolume = prefs.getDouble('sfxVolume') ?? 0.5;   // 音效預設 50%

  // 3. 啟動 APP
  runApp(const MyApp());
}

// ==========================================
// --- 3. 應用程式入口 (Root Widget) ---
// 設定主題並監聽深色模式切換
// ==========================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 監聽 GlobalSettings.themeMode，當改變時重建 MaterialApp
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: GlobalSettings.themeMode,
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: 'Chin Chin Chinese',
          debugShowCheckedModeBanner: false, // 隱藏右上角 Debug 標籤
          themeMode: currentMode,
          
          // --- 亮色主題設定 (Light Mode) ---
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepPurple,
            scaffoldBackgroundColor: const Color(0xFFF5F7FA), // 淺灰背景
            cardColor: Colors.white,
            fontFamily: 'Roboto',
            useMaterial3: true,
            iconTheme: const IconThemeData(color: Colors.black54),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Color(0xFF1E293B)), // 深灰字
              bodyMedium: TextStyle(color: Color(0xFF334155)),
            ),
          ),
          
          // --- 深色主題設定 (Dark Mode) ---
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.deepPurple,
            scaffoldBackgroundColor: const Color(0xFF111827), // 深藍黑背景
            cardColor: const Color(0xFF1F2937), // 卡片深灰
            fontFamily: 'Roboto',
            useMaterial3: true,
            iconTheme: const IconThemeData(color: Colors.white70),
             textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Color(0xFFF1F5F9)), // 淺白字
              bodyMedium: TextStyle(color: Color(0xFFCBD5E1)),
            ),
          ),
          
          // 鎖定文字縮放比例，防止系統字體設定破壞排版
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child!,
            );
          },
          home: const SplashScreen(), // 第一個畫面：歡迎頁
        );
      },
    );
  }
}







