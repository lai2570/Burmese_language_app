import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart'; 
import 'package:audioplayers/audioplayers.dart';
import 'data/vocab_data.dart'; 
import 'package:url_launcher/url_launcher.dart';

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
// --- 0. 全域設定管理 (Global Settings) ---
//這是一個靜態類別，負責管理整個 APP 共用的狀態
// ==========================================
class GlobalSettings {
  // 使用 ValueNotifier 監聽主題變化，當數值改變時，UI 會自動重繪
  static final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.light);
  
  // 音量變數 (範圍 0.0 ~ 1.0)
  static double voiceVolume = 1.0; // 單字發音音量
  static double sfxVolume = 0.5;   // 點擊與音效音量

  // 功能：切換深色/淺色主題並寫入手機儲存空間
  static void toggleTheme() async {
    themeMode.value = themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', themeMode.value == ThemeMode.dark);
  }

  // 功能：儲存音量設定 (當使用者在設定頁關閉時呼叫)
  static void saveVolumes() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('voiceVolume', voiceVolume);
    prefs.setDouble('sfxVolume', sfxVolume);
  }
}

// ==========================================
// --- 1. 樣式系統 (Design System) ---
// 定義 APP 中重複使用的顏色與漸層
// ==========================================
class AppColors {
  // 主色調漸層 (紫藍色系)
  static const primaryGradient = LinearGradient(
    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // 淺色模式卡片漸層
  static const cardGradient = LinearGradient(
    colors: [Colors.white, Color(0xFFF8F9FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // 深色模式卡片漸層
  static const darkCardGradient = LinearGradient(
    colors: [Color(0xFF2D3748), Color(0xFF1A202C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// ==========================================
// --- 2. 通用元件：3D 按壓效果按鈕 ---
// 封裝了一個帶有縮放動畫與音效的按鈕
// ==========================================
class ThreeDButton extends StatefulWidget {
  final Widget child;             // 按鈕內容
  final VoidCallback? onPressed;  // 點擊事件
  final BorderRadius borderRadius;// 圓角設定
  final bool playSound;           // 是否播放音效

  const ThreeDButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.borderRadius = BorderRadius.zero,
    this.playSound = true,
  });

  @override
  State<ThreeDButton> createState() => _ThreeDButtonState();
}

class _ThreeDButtonState extends State<ThreeDButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  final AudioPlayer _sfxPlayer = AudioPlayer();
  bool _isAnimating = false; // 防止連點

  @override
  void initState() {
    super.initState();
    // 設定按鈕縮放動畫：按下時耗時 50ms，回彈耗時 150ms
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
      reverseDuration: const Duration(milliseconds: 150),
    );
    // 縮放比例：從 1.0 縮小到 0.90
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.90).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _sfxPlayer.dispose();
    super.dispose();
  }

  // 播放點擊音效
  Future<void> _playClickSound() async {
    if (widget.playSound && widget.onPressed != null) {
      try {
        await _sfxPlayer.stop();
        // 注意：這裡使用了 GlobalSettings 控制音量
        await _sfxPlayer.play(AssetSource('audio/click.mp3'), volume: GlobalSettings.sfxVolume);
      } catch (e) {
        debugPrint("音效播放失敗: $e");
      }
    }
  }

  // 處理點擊邏輯
  Future<void> _handleTap() async {
    if (widget.onPressed == null || _isAnimating) return;
    setState(() => _isAnimating = true);
    try {
      _playClickSound();      // 1. 播音效
      await _controller.forward(); // 2. 動畫：按下去
      await _controller.reverse(); // 3. 動畫：彈回來
      if (mounted) widget.onPressed!(); // 4. 執行傳入的函式
    } finally {
      if (mounted) setState(() => _isAnimating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque, 
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: widget.borderRadius,
                  child: widget.child,
                ),
                // 這是按鈕按下去時的「變暗」遮罩效果
                if (_controller.value > 0)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: ClipRRect(
                        borderRadius: widget.borderRadius,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: const [0.0, 1.0],
                              colors: [
                                Colors.white.withOpacity(0.2 * _controller.value),
                                Colors.black.withOpacity(0.3 * _controller.value),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
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

// ==========================================
// --- 4. 啟動畫面 (Splash Screen) ---
// 控制歡迎動畫影片與跳轉
// ==========================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    // 1. 初始化影片控制器
    _controller = VideoPlayerController.asset("assets/intro.mp4")
      ..initialize().then((_) {
        // 確保影片載入完成後更新 UI 並開始播放
        setState(() {
          _initialized = true;
        });
        _controller.play();
        _controller.setVolume(0.0); // 如果影片有聲音不想播出來，設為靜音，若要聲音則改為 1.0
      });

    // 2. 設定定時器跳轉
    // 影片長度 1.2 秒 (1200ms)。
    // 建議設定稍微久一點點 (例如 2000ms)，讓使用者能看清楚最後的畫面再跳轉，才不會感覺太急促。
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) _navigateToHome();
    });
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // 務必釋放影片資源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 背景設為黑色，避免影片載入前瞬間白屏
      backgroundColor: Colors.black, 
      body: Stack(
        fit: StackFit.expand, // 讓 Stack 填滿整個螢幕
        children: [
          // --- 底層：影片 ---
          if (_initialized)
            SizedBox.expand(
              child: FittedBox(
                // 關鍵設定：Cover 會讓影片填滿容器，保持比例，多餘部分裁切
                // 這樣在平板上就不會變形，也不會留黑邊
                fit: BoxFit.cover, 
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          else
            // 影片載入前的佔位 (可選)
            Container(color: const Color(0xFF667eea)),

          // --- 上層：文字 ---
          // 移除所有裝飾容器，只保留文字
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 為了不擋住影片主體，這邊可以適度調整位置，目前置中
                const Text(
                  "Chin Chin Chinese",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    // 加一點陰影讓文字在任何影片背景上都看得清楚
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black45,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "For Myanmar Learners",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    letterSpacing: 1.2,
                    shadows: const [
                      Shadow(
                        blurRadius: 8.0,
                        color: Colors.black45,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// --- 5. 資料結構模型 (Data Models) ---
// 定義課程單元 (UnitGroup) 的結構
// ==========================================
class UnitGroup {
  final String title;       // 單元標題 (English + Burmese)
  final IconData icon;      // 圖示
  final int startId;        // 該單元單字 ID 起始
  final int endId;          // 該單元單字 ID 結束
  final List<String> subUnits; // 子單元列表
  final Color color;        // 主題色

  const UnitGroup({required this.title, required this.icon, required this.startId, required this.endId, required this.subUnits, required this.color});
}

// 這裡定義了所有的課程分類
final List<UnitGroup> appUnitGroups = [
  UnitGroup(title: "School (ကျောင်း)", icon: Icons.school, startId: 101, endId: 400, subUnits: ["Campus (ကျောင်းတင်း)", "Class (အတန်းထဲ)", "Classmates (အတန်းဖော်များ)"], color: const Color(0xFF2C3E50)), 
  UnitGroup(title: "Office (ရုံး)", icon: Icons.business_center, startId: 401, endId: 1000, subUnits: ["Office (ရုံး)", "Recruitment (ခန့်မှာ်းတော်)", "Communication (ဆက်သွယ်မှု)", "Finance (ငွေကြေး)", "Attendance (တတ်ရောက်မှု)"], color: const Color(0xFF34495E)), 
  UnitGroup(title: "Factory (စက်ရုံ)", icon: Icons.factory, startId: 1001, endId: 1300, subUnits: ["Factory (စက်ရုံ)", "Warehouse (ဂိုဒေါင်)"], color: const Color(0xFF5D4037)), 
  UnitGroup(title: "Restaurant (စားသောက်ဆိုင်)", icon: Icons.restaurant, startId: 1301, endId: 1600, subUnits: ["Restaurant (စားသောက်ဆိုင်)", "Tableware (ပန်းကန်တွက်ယောက်)", "Service (ခန်ဆောင်မှု)"], color: const Color(0xFFC0392B)), 
  UnitGroup(title: "Salon (ဆံပင်ဆိုင်)", icon: Icons.content_cut, startId: 1601, endId: 1800, subUnits: ["Salon (ဆံပင်ဆိုင်)", "Haircut (ဆံပင်ညှပ်)"], color: const Color(0xFF16A085)), 
  UnitGroup(title: "Customs (အကောက်ထွန်)", icon: Icons.local_airport, startId: 1801, endId: 2000, subUnits: ["Customs (အကောက်ထွန်)", "Airport (လေဆိပ်)"], color: const Color(0xFF27AE60)), 
  UnitGroup(title: "ARC (အေအာစီ)", icon: Icons.card_membership, startId: 2001, endId: 2100, subUnits: ["ARC (အေအာစီ)"], color: const Color(0xFF8E44AD)), 
  UnitGroup(title: "Majors (မေဂျာ)", icon: Icons.book, startId: 2101, endId: 2300, subUnits: ["Majors (မေဂျာ)", "Academics (ပညာရေး)"], color: const Color(0xFFD35400)), 
  UnitGroup(title: "Job Titles (အလုပ်အမည်များ)", icon: Icons.badge, startId: 2301, endId: 2500, subUnits: ["Job Titles 1 (အလုပ်အမည်များ)", "Job Titles 2 (အလုပ်အမည်များ)"], color: const Color(0xFF006064)), 
  UnitGroup(title: "Weather (ရာသီဥတု)", icon: Icons.wb_sunny, startId: 2501, endId: 2600, subUnits: ["Weather (ရာသီဥတု)"], color: const Color(0xFF455A64)), 
  UnitGroup(title: "Hospital (ဆေးရုံ)", icon: Icons.local_hospital, startId: 2601, endId: 2700, subUnits: ["Medical Care(ဆေးကုသမှု)","Symptoms(ရောဂါလက္ခဏာများ)","Clinics(ဆေးတန်းနှင့် ဌာနများ)"], color: const Color(0xFF00838F)), 
  UnitGroup(title: "Sports (အားကစား)", icon: Icons.sports_soccer, startId: 2701, endId: 2800, subUnits: ["Sports (အားကစား)"], color: const Color(0xFFAD1457)), 
  UnitGroup(title: "Food (အစားအစာ)", icon: Icons.fastfood, startId: 2801, endId: 2900, subUnits: ["Food (အစားအစာ)"], color: const Color(0xFF6A1B9A)), 
  UnitGroup(title: "Festivals (ပွဲတော်များ)", icon: Icons.celebration, startId: 2901, endId: 3000, subUnits: ["Festivals (ပွဲတော်များ)"], color: const Color(0xFFBF360C)), 
  UnitGroup(title: "Document (စာရွက်စာတမ်း)", icon: Icons.description, startId: 3001, endId: 3100, subUnits: ["Document (စာရွက်စာတမ်း)"], color: const Color(0xFF283593)), 
];

// ==========================================
// --- 6. 首頁 (HomePage) ---
// 應用程式的主要介面
// ==========================================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();
    // 設定清單項目的進場動畫
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _animationController.forward();
    
    // 檢查是否是第一次開啟 APP，如果是，顯示教學 (Tutorial)
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      bool hasShownTutorial = prefs.getBool('hasShownTutorial') ?? false;
      if (!hasShownTutorial) {
        _showTutorial();
        await prefs.setBool('hasShownTutorial', true); 
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showTutorial() {
    showDialog(context: context, builder: (context) => const TutorialDialog());
  }

  // 顯示設定視窗
  void _showSettings() {
    showDialog(
      context: context, 
      builder: (context) => const SettingsDialog(),
    );
  }

  // Helper: 建立 Header 上的白色圓角按鈕
  Widget _buildFlatHeaderIcon({required IconData icon, required Color color, required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: color, size: 24),
        ),
      ),
    );
  }

  // Helper: 建立像糖果一樣的彩色 3D 圖示
  Widget _buildCandyIcon({required IconData icon, required Color color, required VoidCallback onTap, double size = 56}) {
    return ThreeDButton(
      onPressed: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.7), color, color.withOpacity(0.9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(size * 0.35),
          boxShadow: [
            BoxShadow(color: Colors.white.withOpacity(0.4), offset: const Offset(-1, -1), blurRadius: 3),
            BoxShadow(color: color.withOpacity(0.8), offset: const Offset(1.0, 1.0), blurRadius: 8, spreadRadius: 1),
          ],
        ),
        child: Center(
          child: Icon(icon, size: size * 0.5, color: Colors.white, shadows: [Shadow(offset: const Offset(1, 1), blurRadius: 2, color: Colors.black.withOpacity(0.3))]),
        ),
      ),
    );
  }

  // 建立分類卡片
  Widget _buildGroupCard(BuildContext context, UnitGroup group) {
    // 根據深色/淺色模式取得對應顏色
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? const Color(0xFF1E293B);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10, 
            offset: const Offset(0, 4)
          )
        ],
      ),
      child: Row(
        children: [
          _buildCandyIcon(
            icon: group.icon, 
            color: group.color, 
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage(group: group))),
            size: 64
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.title, 
                  style: TextStyle(
                    color: textColor, 
                    fontWeight: FontWeight.bold, 
                    fontSize: 18
                  )
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: group.color.withOpacity(0.1), 
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Text(
                    "${group.subUnits.length} Topics", 
                    style: TextStyle(
                      color: group.color, 
                      fontSize: 12, 
                      fontWeight: FontWeight.w600
                    )
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // --- 頂部 Header 區塊 (紫色背景) ---
          Container(
            padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 32),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
              boxShadow: [BoxShadow(color: const Color(0xFF667eea).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50, height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
                          ),
                          child: const Center(child: Text("C", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF667eea)))),
                        ),
                        const SizedBox(width: 12),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Chin Chin Chinese", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5)), 
                            Text("For Myanmar Learners", style: TextStyle(color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                    // 右上角功能按鈕：設定、單字本
                    Row(
                      children: [
                        _buildFlatHeaderIcon(
                          icon: Icons.settings, // 設定按鈕
                          color: const Color(0xFF667eea), 
                          onTap: _showSettings,
                        ),
                        const SizedBox(width: 12),
                        _buildFlatHeaderIcon(
                          icon: Icons.menu_book, // 單字本按鈕
                          color: const Color(0xFFff9a9e), 
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const VocabBookPage())),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // --- 分類列表區塊 (Categories) ---
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.category, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Text("Categories", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // 使用 ListView 顯示所有分類
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: appUnitGroups.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        // 加入淡入滑動動畫
                        return FadeTransition(
                          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animationController, curve: Interval((index / appUnitGroups.length) * 0.5, ((index + 1) / appUnitGroups.length) * 0.5 + 0.5, curve: Curves.easeOut))),
                          child: SlideTransition(
                            position: Tween<Offset>(begin: const Offset(0.3, 0), end: Offset.zero).animate(CurvedAnimation(parent: _animationController, curve: Interval((index / appUnitGroups.length) * 0.5, ((index + 1) / appUnitGroups.length) * 0.5 + 0.5, curve: Curves.easeOut))),
                            child: _buildGroupCard(context, appUnitGroups[index]),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// --- 7. 設定 Dialog 元件 (SettingsDialog) ---
// 彈出式視窗：包含音量、深色模式、教學、關於
// ==========================================
class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  // 暫存變數，用於 Slider 拖動時即時更新 UI 顯示
  double _voiceVol = GlobalSettings.voiceVolume;
  double _sfxVol = GlobalSettings.sfxVolume;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    Color cardColor = Theme.of(context).cardColor;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 頂部圓形圖示
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFFF0F4F8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.settings, size: 36, color: Color(0xFF667eea)),
              ),
              const SizedBox(height: 16),
              Text('Settings', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor)),
              Text('ပြင်ဆင်မှုများ', style: TextStyle(color: Colors.grey.shade500, fontSize: 14)), // Myanmar
              const SizedBox(height: 24),

              // 1. 語音音量控制 Slider
              _buildVolumeControl(
                icon: Icons.record_voice_over,
                title: "Voice Volume",
                subTitle: "အသံ အတိုးအကျယ်",
                value: _voiceVol,
                onChanged: (val) {
                  setState(() => _voiceVol = val);
                  GlobalSettings.voiceVolume = val;
                },
              ),
              const SizedBox(height: 12),
              
              // 2. 音效音量控制 Slider
              _buildVolumeControl(
                icon: Icons.music_note,
                title: "Sound Effects",
                subTitle: "အသံ အထူးပြုလုပ်ချက်",
                value: _sfxVol,
                onChanged: (val) {
                  setState(() => _sfxVol = val);
                  GlobalSettings.sfxVolume = val;
                },
              ),
              const Divider(height: 32),

              // 3. 深色模式切換 Switch
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.indigo.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Icon(isDark ? Icons.dark_mode : Icons.light_mode, color: Colors.indigo),
                ),
                title: Text("Dark Mode", style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                subtitle: const Text("အမှောင်စနစ်", style: TextStyle(fontSize: 12, color: Colors.grey)),
                trailing: Switch(
                  value: isDark,
                  activeColor: const Color(0xFF667eea),
                  onChanged: (val) {
                    GlobalSettings.toggleTheme(); // 切換全域主題
                  },
                ),
              ),

              // 4. 教學按鈕
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.amber.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.school, color: Colors.amber),
                ),
                title: Text("Watch Tutorial", style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                subtitle: const Text("လမ်းညွှန် ကြည့်ရန်", style: TextStyle(fontSize: 12, color: Colors.grey)),
                onTap: () {
                  Navigator.pop(context); // 關閉目前視窗
                  showDialog(context: context, builder: (context) => const TutorialDialog()); // 開啟教學
                },
              ),

              // 5. 關於作者按鈕
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.blueGrey.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.info, color: Colors.blueGrey),
                ),
                title: Text("About", style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                subtitle: const Text("အကြောင်းအရာ", style: TextStyle(fontSize: 12, color: Colors.grey)),
                onTap: () {
                  Navigator.pop(context);
                  _showAuthorInfo(context);
                },
              ),

              const SizedBox(height: 24),

              // 關閉按鈕
              ThreeDButton(
                onPressed: () {
                  GlobalSettings.saveVolumes(); // 關閉時才真正將設定寫入手機硬碟
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: const Color(0xFF667eea).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: const Center(
                    child: Text("Close", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper: 建立音量調整列
  Widget _buildVolumeControl({required IconData icon, required String title, required String subTitle, required double value, required Function(double) onChanged}) {
    Color textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                Text(subTitle, style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ],
        ),
        Slider(
          value: value,
          min: 0.0,
          max: 1.0,
          activeColor: const Color(0xFF667eea),
          inactiveColor: Colors.grey.shade200,
          onChanged: onChanged,
        ),
      ],
    );
  }

  // 顯示開發者與版權資訊
// --- 新增這個函式：用來打開瀏覽器 ---
  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  // --- 修改後的 About 視窗 ---
  void _showAuthorInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10))],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.info_outline, size: 40, color: Color(0xFF667eea)),
              const SizedBox(height: 16),
              const Text('Chin Chin Chinese', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              const Text('Version 1.0.0', style: TextStyle(color: Colors.grey, fontSize: 14)),
              const Divider(height: 32),
              _buildInfoRow(Icons.code, "Developer", "賴泳在 (YUNG-TSAI LAI)"),
              _buildInfoRow(Icons.translate, "Translation", "ChinQing in Taiwan (林素青)"),
              
              const SizedBox(height: 16),
              const Text(
                '• Code: MIT License\n• Assets: CC BY-NC-ND 4.0\n© 2025 All Rights Reserved.',
                style: TextStyle(fontSize: 12, color: Colors.grey, height: 1.5),
                textAlign: TextAlign.center,
              ),

              // ==========================================
              // --- 新增：法律條款連結按鈕區 ---
              // ==========================================
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    // TODO: 請確認您的 GitHub Pages 網址是否正確
                    onPressed: () => _launchURL('https://lai2570.github.io/Burmese_language_app/privacy'),
                    child: const Text("Privacy Policy", style: TextStyle(color: Color(0xFF667eea), fontSize: 12, decoration: TextDecoration.underline)),
                  ),
                  const Text("|", style: TextStyle(color: Colors.grey)),
                  TextButton(
                    // TODO: 請確認您的 GitHub Pages 網址是否正確
                    onPressed: () => _launchURL('https://lai2570.github.io/Burmese_language_app/terms'),
                    child: const Text("Terms & Conditions", style: TextStyle(color: Color(0xFF667eea), fontSize: 12, decoration: TextDecoration.underline)),
                  ),
                ],
              ),
              // ==========================================
              
              const SizedBox(height: 16),
              ThreeDButton(
                onPressed: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(child: Text("Close", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF94A3B8)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
              Text(content, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF334155))),
            ],
          ),
        ],
      ),
    );
  }
}

// ==========================================
// --- 8. 分類頁面 (CategoryPage) ---
// 顯示某個大分類底下的子單元 (Topics)
// ==========================================
class CategoryPage extends StatelessWidget {
  final UnitGroup group;

  const CategoryPage({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    // 篩選出該分類範圍內的所有單字
    final allWords = getFullVocabulary();
    final groupWords = allWords.where((w) => w.id >= group.startId && w.id <= group.endId).toList();
    
    // 計算可用的單元數量 (每10個字一個單元)
    int availableUnitsCount = (groupWords.length / 10).floor();
    int displayCount = min(availableUnitsCount, group.subUnits.length);
    
    // Theme Colors
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? const Color(0xFF1E293B);

    return Scaffold(
      body: Column(
        children: [
          // 頂部導覽列 (與分類同色系)
          Container(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [group.color, group.color.withOpacity(0.8)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            ),
            child: Row(
              children: [
                ThreeDButton(
                  onPressed: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(30),
                  child: const Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.arrow_back_ios, color: Colors.white)),
                ),
                Expanded(child: Text(group.title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          
          // 列表內容
          Expanded(
            child: displayCount == 0
                // 如果沒有資料，顯示 Coming Soon
                ? const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.construction, size: 80, color: Colors.grey), SizedBox(height: 16), Text("Coming Soon", style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold))]))
                : ListView.separated(
                    padding: const EdgeInsets.all(24),
                    itemCount: displayCount,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      // 計算每個單元的單字範圍
                      int start = index * 10;
                      int end = start + 10;
                      final unitWords = groupWords.sublist(start, end);
                      String unitTitle = "UNIT ${index + 1}";
                      String subTitle = group.subUnits[index];

                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: cardColor, 
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [BoxShadow(color: group.color.withOpacity(0.2), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: Row(
                          children: [
                            ThreeDButton(
                              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => StudyPage(unitTitle: unitTitle, wordList: unitWords, themeColor: group.color))),
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                width: 64, height: 64,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [group.color, group.color.withOpacity(0.7)]), 
                                  borderRadius: BorderRadius.circular(16)
                                ),
                                child: Icon(group.icon, size: 32, color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(unitTitle, style: TextStyle(color: group.color, fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1.2)),
                                  const SizedBox(height: 6),
                                  Text(subTitle, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// --- 9. 學習頁面 (StudyPage) ---
// 顯示單字列表，可播放聲音與收藏單字
// ==========================================
class StudyPage extends StatefulWidget {
  final String unitTitle;
  final List<Word> wordList;
  final Color themeColor;

  const StudyPage({super.key, required this.unitTitle, required this.wordList, this.themeColor = const Color(0xFF667eea)});

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  List<int> savedIds = []; 
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadSavedWords(); // 載入已收藏的單字
  }
  
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // 播放單字發音
  Future<void> _playAudio(String fileName) async {
    try {
      await _audioPlayer.stop();
      // 使用全域設定的音量
      await _audioPlayer.play(AssetSource('audio/$fileName'), volume: GlobalSettings.voiceVolume);
    } catch (e) {
      debugPrint("播放失敗: $e");
    }
  }

  // 讀取最愛清單 (SharedPreferences)
  Future<void> _loadSavedWords() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedIds = (prefs.getStringList('savedWords') ?? []).map(int.parse).toList();
    });
  }

  // 切換收藏狀態 (加入/移除)
  Future<void> _toggleSave(int id) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (savedIds.contains(id)) savedIds.remove(id); else savedIds.add(id);
    });
    await prefs.setStringList('savedWords', savedIds.map((e) => e.toString()).toList());
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black87;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Column(
        children: [
          // 頂部導覽列
          Container(
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [widget.themeColor, widget.themeColor.withOpacity(0.8)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              boxShadow: [BoxShadow(color: widget.themeColor.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
            ),
            child: Row(
              children: [
                ThreeDButton(
                  onPressed: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(30),
                  child: const Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.arrow_back_ios, color: Colors.white)),
                ),
                Expanded(child: Column(children: [Text(widget.unitTitle, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)), const Text("STUDY MODE", style: TextStyle(color: Colors.white70, fontSize: 10, letterSpacing: 1.5))])),
                const SizedBox(width: 48),
              ],
            ),
          ),
          
           // 提示區域
           Container(
             margin: const EdgeInsets.all(16), 
             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
             decoration: BoxDecoration(color: widget.themeColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Icon(Icons.volume_up, color: widget.themeColor, size: 20),
                 const SizedBox(width: 8), 
                 RichText(text: TextSpan(style: TextStyle(color: widget.themeColor, fontSize: 13, fontFamily: 'Roboto'), children: const [TextSpan(text: "Click "), WidgetSpan(child: Icon(Icons.volume_up, size: 16, color: Colors.indigo), alignment: PlaceholderAlignment.middle), TextSpan(text: " to listen / နားထောင်ရန်နှိပ်ပါ")])),
               ],
             ),
           ),
          
          // 單字列表
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: widget.wordList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final word = widget.wordList[index];
                final isSaved = savedIds.contains(word.id);
                
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cardColor, 
                    borderRadius: BorderRadius.circular(20), 
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 第一列：中文、發音按鈕、收藏星星
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, 
                              children: [
                                Row(
                                  children: [                        
                                    Text("${index + 1}. ", style: const TextStyle(color: Colors.grey, fontFamily: 'monospace')), 
                                    Text(word.zh, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: textColor)),
                                    const SizedBox(width: 8),
                                    ThreeDButton(
                                      onPressed: () => _playAudio(word.audioZH),
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(color: widget.themeColor.withOpacity(0.1), shape: BoxShape.circle),
                                        child: Icon(Icons.volume_up, color: widget.themeColor, size: 24),
                                      ),
                                    ),
                                  ]
                                ),
                                Padding(padding: const EdgeInsets.only(left: 20, top: 4), child: Text(word.pinyin, style: TextStyle(color: widget.themeColor, fontSize: 16, fontWeight: FontWeight.w500)))
                              ]
                            ),
                          ),
                          ThreeDButton(
                            onPressed: () => _toggleSave(word.id),
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(isSaved ? Icons.star : Icons.star_border, color: isSaved ? Colors.amber : Colors.grey.shade300, size: 28),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 12),
                      // 緬甸語翻譯
                      Padding(padding: const EdgeInsets.only(left: 20), child: Text(word.myn, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor))),
                      const SizedBox(height: 16),
                      // 例句區塊
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.black26 : const Color(0xFFF8FAFC), 
                          borderRadius: BorderRadius.circular(12), 
                          border: Border(left: BorderSide(color: widget.themeColor.withOpacity(0.5), width: 4))
                        ),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildSentence(word.sentenceZH, true, widget.themeColor, textColor), const SizedBox(height: 8), _buildSentence(word.sentenceMYN, false, widget.themeColor, textColor)]),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          // 底部：開始測驗按鈕
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: cardColor, border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.1)))),
            child: ThreeDButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuizPage(words: widget.wordList, unitName: widget.unitTitle))),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(color: widget.themeColor, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: widget.themeColor.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 4))]),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.play_arrow, color: Colors.white), SizedBox(width: 8), Text("Start Quiz", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Helper: 解析並顯示帶有粗體標記 (**) 的例句
  Widget _buildSentence(String sentence, bool isZh, Color highlightColor, Color baseColor) {
    List<String> parts = sentence.split('**');
    return RichText(
      text: TextSpan(
        style: TextStyle(color: baseColor.withOpacity(0.8), fontSize: 15, height: 1.4, fontFamily: 'Roboto'),
        children: parts.asMap().entries.map((entry) {
          int idx = entry.key; String text = entry.value; bool isBold = idx % 2 == 1;
          if (isBold && isZh) return TextSpan(text: text, style: TextStyle(fontWeight: FontWeight.w900, color: highlightColor));
          return TextSpan(text: text, style: isBold ? TextStyle(fontWeight: FontWeight.w900, color: baseColor) : null);
        }).toList(),
      ),
    );
  }
}

// ==========================================
// --- 10. Tutorial Dialog ---
// 新手教學彈窗
// ==========================================
class TutorialDialog extends StatefulWidget {
  const TutorialDialog({super.key});
  @override
  State<TutorialDialog> createState() => _TutorialDialogState();
}

class _TutorialDialogState extends State<TutorialDialog> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _steps = [
    {"icon": Icons.category, "color": Color(0xFF667eea), "text": "1. Click the left icon to start.\nဘယ်ဘက်ရှိ လေးထောင့်ပုံကို နှိပ်ပြီး စတင်လေ့လာပါ။"},
    {"icon": Icons.star, "color": Colors.amber, "text": "2. Take quizzes & Star words to save.\nပဟေဠိဖြေပါ၊ မသိသော စကားလုံးများကို Star နှိပ်ပြီး မှတ်သားပါ။"},
    {"icon": Icons.menu_book, "color": Color(0xFFff9a9e), "text": "3. Collect 10+ words to unlock review quiz!\nစကားလုံး ၁၀ လုံးကျော်ပါက ပြန်လည်လေ့ကျင့်နိုင်ပါပြီ။"},
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: Colors.transparent,
      child: Container(
        height: 420,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) => setState(() => _currentPage = page),
                itemCount: _steps.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(color: _steps[index]['color'].withOpacity(0.1), shape: BoxShape.circle),
                          child: Icon(_steps[index]['icon'], size: 60, color: _steps[index]['color']),
                        ),
                        const SizedBox(height: 24),
                        Text(_steps[index]['text'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.5, color: Colors.black87)),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(_steps.length, (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8, height: 8,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: _currentPage == index ? const Color(0xFF667eea) : Colors.grey.shade300),
                    )),
                  ),
                  ThreeDButton(
                    onPressed: () {
                      if (_currentPage < _steps.length - 1) {
                        _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(color: const Color(0xFF667eea), borderRadius: BorderRadius.circular(20)),
                      child: Text(_currentPage == _steps.length - 1 ? "Start" : "Next", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ==========================================
// --- 11. 測驗頁面 (QuizPage) ---
// 聽力/閱讀測驗邏輯
// ==========================================
class QuizPage extends StatefulWidget {
  final List<Word> words;
  final String unitName;
  const QuizPage({super.key, required this.words, required this.unitName});
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  late List<Map<String, dynamic>> quizQueue;
  int currentIndex = 0;
  List<Map<String, dynamic>> results = [];
  late AnimationController _timerController; // 計時器動畫
  int timerSeconds = 5;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _prepareQuiz(); // 準備題目
    // 設定計時器 5 秒
    _timerController = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _timerController.reverse(from: 1.0);
    // 時間到自動觸發錯誤答案
    _timerController.addStatusListener((status) { if (status == AnimationStatus.dismissed) _handleAnswer(null); });
    _timerController.addListener(() { setState(() { timerSeconds = (_timerController.value * 5).ceil(); }); });
    // 進入頁面後播放第一題聲音
    WidgetsBinding.instance.addPostFrameCallback((_) { _playCurrentWordAudio(); });
  }

  // 播放當前題目的發音
  Future<void> _playCurrentWordAudio() async {
    if (currentIndex < quizQueue.length) {
      final word = quizQueue[currentIndex]['word'] as Word;
      try { 
        await _audioPlayer.stop(); 
        await _audioPlayer.play(AssetSource('audio/${word.audioZH}'), volume: GlobalSettings.voiceVolume); 
      } catch (e) { debugPrint("Quiz audio error: $e"); }
    }
  }

  // 準備題庫：洗牌並產生錯誤選項
  void _prepareQuiz() {
    final random = Random();
    final allWords = getFullVocabulary(); 
    List<Word> shuffledWords = List.from(widget.words)..shuffle();
    quizQueue = shuffledWords.map((word) {
      Word distractor;
      // 找一個錯誤選項 (避免選到自己)
      if (allWords.length <= 1) {
         distractor = Word(id: -1, zh: "錯誤", pinyin: "cuò", myn: "Wrong", sentenceZH: "", sentenceMYN: "", audioZH: "");
      } else {
        do { distractor = allWords[random.nextInt(allWords.length)]; } while (distractor.myn == word.myn); 
      }
      // 隨機決定正確答案在上面還是下面
      bool correctIsTop = random.nextBool();
      return { 'word': word, 'options': correctIsTop ? [word.myn, distractor.myn] : [distractor.myn, word.myn], 'correctIndex': correctIsTop ? 0 : 1 };
    }).toList();
  }

  // 處理作答結果
  void _handleAnswer(int? index) {
    _timerController.stop();
    final currentQ = quizQueue[currentIndex];
    final word = currentQ['word'] as Word;
    final options = currentQ['options'] as List<String>;
    final correctIndex = currentQ['correctIndex'] as int;
    
    bool isTimeout = index == null;
    bool isCorrect = !isTimeout && index == correctIndex;
    results.add({'word': word, 'isCorrect': isCorrect, 'isTimeout': isTimeout, 'correctAnswer': word.myn, 'userAnswer': isTimeout ? 'Timeout' : options[index]});

    // 還有下一題嗎？
    if (currentIndex < 9 && currentIndex < quizQueue.length - 1) { 
      setState(() { currentIndex++; _timerController.duration = const Duration(seconds: 5); _timerController.reverse(from: 1.0); });
      _playCurrentWordAudio();
    } else {
      // 測驗結束，跳轉到結果頁
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ResultPage(results: results, unitName: widget.unitName, originalWords: widget.words)));
    }
  }

  @override
  void dispose() { _timerController.dispose(); _audioPlayer.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    if (quizQueue.isEmpty || currentIndex >= quizQueue.length) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    final currentQ = quizQueue[currentIndex];
    final word = currentQ['word'] as Word;
    final options = currentQ['options'] as List<String>;
    final totalQuestions = quizQueue.length;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // 深色背景專注答題
      body: SafeArea(
        child: Column(
          children: [
            // 進度條
            LinearProgressIndicator(value: (currentIndex) / totalQuestions, backgroundColor: Colors.white10, color: const Color(0xFF38ef7d), minHeight: 6),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [ThreeDButton(onPressed: () => Navigator.pop(context), borderRadius: BorderRadius.circular(20), child: const Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.close, color: Colors.grey))), Text("${currentIndex + 1} / $totalQuestions", style: const TextStyle(color: Colors.grey, fontSize: 16, fontFamily: 'monospace')), const SizedBox(width: 48)])),
            
            // 倒數計時圓圈
            Stack(alignment: Alignment.center, children: [SizedBox(width: 60, height: 60, child: CircularProgressIndicator(value: _timerController.value, strokeWidth: 4, color: Colors.white, backgroundColor: Colors.white24)), Text("$timerSeconds", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))]),
            
            // 題目區塊 (中文 + 播放按鈕)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min, 
                  children: [
                    ThreeDButton(
                      onPressed: _playCurrentWordAudio,
                      borderRadius: BorderRadius.circular(20),
                      child: Text(word.zh, style: const TextStyle(color: Colors.white, fontSize: 64, fontWeight: FontWeight.w900)),
                    ),
                    const SizedBox(height: 12), 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(word.pinyin, style: const TextStyle(color: Color(0xFF667eea), fontSize: 24, fontWeight: FontWeight.w500)),
                         const SizedBox(width: 10),
                         ThreeDButton(
                           onPressed: _playCurrentWordAudio,
                           borderRadius: BorderRadius.circular(20),
                           child: const Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.volume_up, color: Colors.white70)),
                         )
                      ],
                    )
                  ]
                )
              )
            ),
            // 選項按鈕區
            Padding(
              padding: const EdgeInsets.all(24.0), 
              child: Column(
                children: List.generate(2, (idx) => Padding(
                  padding: const EdgeInsets.only(bottom: 16), 
                  child: ThreeDButton(
                    onPressed: () => _handleAnswer(idx),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: double.infinity, 
                      height: 80, 
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                      alignment: Alignment.center,
                      child: Text(options[idx], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)))
                    ),
                  )
                ))
              )
            )
          ],
        ),
      ),
    );
  }
}

// ==========================================
// --- 12. 結果頁面 (ResultPage) ---
// 顯示測驗成績，並根據分數播放音效
// ==========================================
class ResultPage extends StatefulWidget {
  final List<Map<String, dynamic>> results;
  final String unitName;
  final List<Word> originalWords;
  const ResultPage({super.key, required this.results, required this.unitName, required this.originalWords});
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<int> savedIds = [];
  final AudioPlayer _resultAudioPlayer = AudioPlayer(); 

  @override
  void initState() {
    super.initState();
    _loadSavedWords();
    _playResultSound(); // 播放過關或失敗音效
  }

  @override
  void dispose() {
    _resultAudioPlayer.dispose();
    super.dispose();
  }

  // 播放結果音效 (>=60分 通過，否則失敗)
  Future<void> _playResultSound() async {
    int correctCount = widget.results.where((r) => r['isCorrect'] as bool).length;
    int total = widget.results.isNotEmpty ? widget.results.length : 1;
    int percentage = ((correctCount / total) * 100).round();

    try {
      if (percentage >= 60) {
        await _resultAudioPlayer.play(AssetSource('audio/pass.mp3'), volume: GlobalSettings.sfxVolume);
      } else {
        await _resultAudioPlayer.play(AssetSource('audio/fail.mp3'), volume: GlobalSettings.sfxVolume);
      }
    } catch (e) {
      debugPrint("結果音效播放失敗: $e");
    }
  }

  Future<void> _loadSavedWords() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() { savedIds = (prefs.getStringList('savedWords') ?? []).map(int.parse).toList(); });
  }

  Future<void> _toggleSave(int id) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() { if (savedIds.contains(id)) savedIds.remove(id); else savedIds.add(id); });
    await prefs.setStringList('savedWords', savedIds.map((e) => e.toString()).toList());
  }

  @override
  Widget build(BuildContext context) {
    int correctCount = widget.results.where((r) => r['isCorrect'] as bool).length;
    int percentage = ((correctCount / (widget.results.isNotEmpty ? widget.results.length : 1)) * 100).round();
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const SizedBox(height: 40),
                // 成績卡片
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(32), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))]),
                  child: Column(children: [const Icon(Icons.emoji_events, size: 60, color: Color(0xFF764ba2)), const SizedBox(height: 16), Text("Quiz Complete!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: textColor)), Text(widget.unitName, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)), const SizedBox(height: 16), Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [Text("$percentage", style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w900, color: Color(0xFF667eea))), const Text("%", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey))]), const Text("ACCURACY SCORE", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey))]),
                ),
                const SizedBox(height: 24),
                // 答案檢討
                Text("Review Answers", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor)),
                const SizedBox(height: 12),
                ...widget.results.map((res) {
                  final word = res['word'] as Word;
                  final isCorrect = res['isCorrect'] as bool;
                  final isSaved = savedIds.contains(word.id);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12), 
                    padding: const EdgeInsets.all(16), 
                    decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(16)), 
                    child: Row(
                      children: [
                        Icon(isCorrect ? Icons.check_circle : Icons.cancel, color: isCorrect ? const Color(0xFF38ef7d) : const Color(0xFFF5576C), size: 30),
                        const SizedBox(width: 16),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(word.zh, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)), Text(word.pinyin, style: const TextStyle(color: Colors.grey, fontSize: 13)), if (!isCorrect) Text("Ans: ${res['correctAnswer']}", style: const TextStyle(color: Color(0xFF38ef7d), fontWeight: FontWeight.bold))])),
                        ThreeDButton(
                          onPressed: () => _toggleSave(word.id),
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(padding: const EdgeInsets.all(8.0), child: Icon(isSaved ? Icons.star : Icons.star_border, color: isSaved ? Colors.amber : Colors.grey.shade300, size: 28)),
                        )
                      ]
                    )
                  );
                }),
              ],
            ),
          ),
          // 底部按鈕：回首頁 / 再測一次
          Container(
            padding: const EdgeInsets.all(24), color: cardColor,
            child: Row(children: [
              Expanded(
                child: ThreeDButton(
                  onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(padding: const EdgeInsets.symmetric(vertical: 16), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(16)), alignment: Alignment.center, child: const Text("Home", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                )
              ), 
              const SizedBox(width: 16), 
              Expanded(
                child: ThreeDButton(
                  onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StudyPage(unitTitle: widget.unitName, wordList: widget.originalWords, themeColor: const Color(0xFF667eea)))),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(padding: const EdgeInsets.symmetric(vertical: 16), decoration: BoxDecoration(color: const Color(0xFF667eea), borderRadius: BorderRadius.circular(16)), alignment: Alignment.center, child: const Text("Study Again", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                )
              )
            ]),
          )
        ],
      ),
    );
  }
}

// ==========================================
// --- 13. 單字本頁面 (VocabBookPage) ---
// 顯示所有已收藏 (Starred) 的單字，滿10個可測驗
// ==========================================
class VocabBookPage extends StatefulWidget {
  const VocabBookPage({super.key});
  @override
  State<VocabBookPage> createState() => _VocabBookPageState();
}

class _VocabBookPageState extends State<VocabBookPage> {
  List<Word> savedWords = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedWords();
  }

  // 從資料庫撈出所有單字，並過濾出已收藏的 ID
  Future<void> _loadSavedWords() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIds = (prefs.getStringList('savedWords') ?? []).map(int.parse).toList();
    final allWords = getFullVocabulary();
    setState(() { savedWords = allWords.where((w) => savedIds.contains(w.id)).toList(); isLoading = false; });
  }

  // 移除收藏
  Future<void> _removeWord(int id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedIdStrings = (prefs.getStringList('savedWords') ?? []);
    savedIdStrings.remove(id.toString());
    await prefs.setStringList('savedWords', savedIdStrings);
    _loadSavedWords(); // 重新整理列表
  }

  // 開始隨機測驗 (僅針對收藏單字)
  void _startRandomQuiz() {
    if (savedWords.length < 10) return;
    List<Word> shuffled = List.from(savedWords)..shuffle();
    List<Word> quizSet = shuffled.take(10).toList(); // 取前10個
    Navigator.push(context, MaterialPageRoute(builder: (context) => QuizPage(words: quizSet, unitName: "My Vocab Quiz")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
           Container(
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 20),
            decoration: const BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
            child: Row(
              children: [
                ThreeDButton(onPressed: () => Navigator.pop(context), borderRadius: BorderRadius.circular(30), child: const Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.arrow_back_ios, color: Colors.white))),
                const Expanded(child: Center(child: Text("My Vocabulary", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)))),
                const SizedBox(width: 48),
              ],
            ),
          ),
          
          Expanded(
            child: isLoading ? const Center(child: CircularProgressIndicator()) : Column(
              children: [
                // 統計資訊卡片
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))]),
                  child: Row(
                    children: [
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("${savedWords.length}", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF667eea))), const Text("Saved Words", style: TextStyle(color: Colors.grey))])),
                      ThreeDButton(
                        onPressed: savedWords.length >= 10 ? _startRandomQuiz : null,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(color: savedWords.length >= 10 ? const Color(0xFF667eea) : Colors.grey.shade300, borderRadius: BorderRadius.circular(12)),
                          child: const Row(children: [Icon(Icons.play_arrow, color: Colors.white, size: 20), SizedBox(width: 8), Text("Quiz (10)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
                        ),
                      )
                    ],
                  ),
                ),
                if (savedWords.length < 10) Container(width: double.infinity, padding: const EdgeInsets.all(8), color: Colors.orange.shade50, child: const Text("Save 10+ words to unlock quiz!", textAlign: TextAlign.center, style: TextStyle(color: Colors.orange, fontSize: 12))),
                
                // 單字列表
                Expanded(
                  child: savedWords.isEmpty ? const Center(child: Text("No words yet.", style: TextStyle(color: Colors.grey))) : ListView.separated(
                    padding: const EdgeInsets.all(16), itemCount: savedWords.length, separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final word = savedWords[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4, offset: const Offset(0, 2))]),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(word.zh, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), Text(word.pinyin, style: const TextStyle(color: Color(0xFF667eea), fontSize: 14))]),
                          Row(children: [Text(word.myn, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)), const SizedBox(width: 16), ThreeDButton(onPressed: () => _removeWord(word.id), borderRadius: BorderRadius.circular(20), child: const Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.delete_outline, color: Colors.grey)))])
                        ]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}