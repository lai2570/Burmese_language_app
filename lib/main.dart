import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // 用於儲存使用者的收藏與教學觀看紀錄
import 'package:audioplayers/audioplayers.dart'; // 用於播放發音與音效
import 'data/vocab_data.dart'; // 匯入外部單字庫資料

void main() {
  runApp(const MyApp());
}

// ==========================================
// --- 1. 全域設定與樣式系統 ---
// 定義應用程式中通用的顏色漸層，方便統一修改
// ==========================================
class AppColors {
  // 主色調漸層 (藍紫色系)，用於 Header 與重要按鈕
  static const primaryGradient = LinearGradient(
    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // 卡片背景漸層 (極淺的灰白色)，增加立體感
  static const cardGradient = LinearGradient(
    colors: [Colors.white, Color(0xFFF8F9FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// ==========================================
// --- 2. 通用元件：3D 按壓效果按鈕 ---
// 封裝了「點擊縮放動畫」與「點擊音效」，全站通用
// ==========================================
class ThreeDButton extends StatefulWidget {
  final Widget child; // 按鈕內部的內容
  final VoidCallback? onPressed; // 點擊回調，若為 null 則按鈕無效
  final BorderRadius borderRadius; // 圓角設定
  final bool playSound; // 是否播放 "Click" 音效

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
  late Animation<double> _scaleAnimation; // 控制縮放比例
  final AudioPlayer _sfxPlayer = AudioPlayer(); // 專用於按鈕音效

  @override
  void initState() {
    super.initState();
    // 設定動畫時間：按下去 100ms，彈回來 150ms
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100), 
      reverseDuration: const Duration(milliseconds: 150),
    );
    // 設定縮放範圍：從 1.0 (原大小) 縮小到 0.9 (按壓感)
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

  // 播放點擊音效的邏輯
  Future<void> _playClickSound() async {
    if (widget.playSound && widget.onPressed != null) {
      try {
        await _sfxPlayer.stop(); // 防止連續點擊聲音重疊
        await _sfxPlayer.play(AssetSource('audio/click.mp3'), volume: 0.5);
      } catch (e) {
        debugPrint("音效播放失敗: $e");
      }
    }
  }

  // 手指按下時觸發：播放動畫與聲音
  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed != null) {
      _controller.forward();
      _playClickSound();
    }
  }

  // 手指放開時觸發：反轉動畫並執行功能
  void _onTapUp(TapUpDetails details) {
    if (widget.onPressed != null) {
      _controller.reverse();
      // 延遲一點點執行，讓使用者看得到按鈕彈回的效果
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) widget.onPressed!();
      });
    }
  }

  // 手指移開取消點擊
  void _onTapCancel() {
    if (widget.onPressed != null) _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Stack(
              children: [
                widget.child,
                // 當按鈕被按下時，疊加一層半透明黑色遮罩，增加「按壓變暗」的視覺效果
                if (_controller.value > 0)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.15 * _controller.value),
                          borderRadius: widget.borderRadius,
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
// 設定全域主題與路由
// ==========================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chin Chin Chinese',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA), // 全域背景色 (淺灰)
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      // 鎖定字體縮放，避免使用者手機設定字體過大導致 UI 跑版
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
      home: const SplashScreen(), // 啟動畫面
    );
  }
}

// ==========================================
// --- 4. 啟動畫面 (Splash Screen) ---
// 顯示 Logo 動畫，並在結束後跳轉至首頁
// ==========================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation; // Logo 彈性縮放
  late Animation<double> _fadeAnimation;  // 文字淡入

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 1200), vsync: this);
    // 設定彈性曲線 (ElasticOut) 讓 Logo 有ㄉㄨㄞㄉㄨㄞ的效果
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();
    
    // 1.8秒後跳轉至 HomePage
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) _navigateToHome();
    });
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF667eea), Color(0xFF764ba2)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo 容器
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 30, spreadRadius: 5)],
                    ),
                    child: Image.asset("assets/intro.gif", fit: BoxFit.contain, width: 200, height: 200),
                  ),
                  const SizedBox(height: 40),
                  const Text("Chin Chin Chinese", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                  const SizedBox(height: 10),
                  Text("For Myanmar Learners", style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16, letterSpacing: 1.2)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// --- 5. 資料結構模型 (Data Models) ---
// 定義分類 (UnitGroup) 與預設資料
// ==========================================
class UnitGroup {
  final String title;       // 分類標題 (英文+緬文)
  final IconData icon;      // 圖示
  final int startId;        // 該分類的起始單字 ID (對應 vocab_data.dart)
  final int endId;          // 該分類的結束單字 ID
  final List<String> subUnits; // 子單元名稱列表
  final Color color;        // 該分類的主題色

  const UnitGroup({required this.title, required this.icon, required this.startId, required this.endId, required this.subUnits, required this.color});
}

// 靜態資料列表：定義所有課程分類
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
// 包含 Header, 分類列表, 作者資訊, 以及第一次開啟時的教學
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
    // 控制列表項目的進場動畫 (Staggered Animation)
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _animationController.forward();
    
    // 檢查是否為第一次使用，若是則顯示教學導覽 (Tutorial)
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      bool hasShownTutorial = prefs.getBool('hasShownTutorial') ?? false;
      if (!hasShownTutorial) {
        _showTutorial();
        await prefs.setBool('hasShownTutorial', true); // 標記為已觀看
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // 顯示教學導覽 Dialog
  void _showTutorial() {
    showDialog(
      context: context,
      builder: (context) {
        return const TutorialDialog();
      },
    );
  }

  // 顯示作者與版權資訊 Dialog
  void _showAuthorInfo() {
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
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // --- 標題區 ---
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF0F4F8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.info_outline, size: 40, color: Color(0xFF667eea)),
                ),
                const SizedBox(height: 16),
                const Text('Chin Chin Chinese', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                const Text('Version 1.0.0', style: TextStyle(color: Colors.grey, fontSize: 14)),
                const SizedBox(height: 24),

                // --- 團隊資訊 ---
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Credits / 製作團隊", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF64748B), fontSize: 12)),
                ),
                const Divider(),
                _buildInfoRow(Icons.code, "Developer", "賴泳在 (YUNG-TSAI LAI)"),
                _buildInfoRow(Icons.translate, "Translation", "ChinQing in Taiwan (林素青)"),
                const SizedBox(height: 16),

                // --- 授權資訊 ---
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("License / 授權聲明", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF64748B), fontSize: 12)),
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    '• Code: MIT License\n• Assets (Audio/Data): CC BY-NC-ND 4.0\n© 2025 All Rights Reserved.',
                    style: TextStyle(fontSize: 12, color: Colors.grey, height: 1.5),
                  ),
                ),
                const SizedBox(height: 24),

                // --- 按鈕區 (Tutorial & Close) ---
                Row(
                  children: [
                    Expanded(
                      child: ThreeDButton(
                        onPressed: () {
                          Navigator.pop(context); // 先關閉當前 Dialog
                          _showTutorial();        // 再開啟教學
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFF667eea)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text("Tutorial", style: TextStyle(color: Color(0xFF667eea), fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ThreeDButton(
                        onPressed: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 作者資訊頁的小 Helper Widget (建立一行資訊)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // --- Header 區塊 (包含 Logo 與功能按鈕) ---
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
                    // 左側 Logo 與標題
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
                    // 右側功能按鈕 (資訊 & 單字本)
                    Row(
                      children: [
                        // 修改：使用平面風格的按鈕
                        _buildFlatHeaderIcon(
                          icon: Icons.info_outline, 
                          color: const Color(0xFF667eea), 
                          onTap: _showAuthorInfo,
                        ),
                        const SizedBox(width: 12),
                        _buildFlatHeaderIcon(
                          icon: Icons.menu_book, 
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
          
          // --- Categories 列表區塊 ---
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
                      const Text("Categories", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: appUnitGroups.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        // 使用動畫包裹每一個列表項目，做出依序滑入的效果
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

  // Helper: 右上角專用的平面按鈕 (Flat Style)
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
            // 輕微的陰影，讓白色方塊在漸層背景上清楚一點
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

  // Helper: 糖果質感的 Icon 按鈕 (用於列表左側)
  Widget _buildCandyIcon({required IconData icon, required Color color, required VoidCallback onTap, double size = 56}) {
    return ThreeDButton(
      onPressed: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          // 創造玻璃/糖果般的漸層質感
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7), 
              color,                  
              color.withOpacity(0.9), 
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(size * 0.35),
          boxShadow: [
            // 左上亮光 (Highlight)
            BoxShadow(
              color: Colors.white.withOpacity(0.4),
              offset: const Offset(-1, -1), 
              blurRadius: 3,
              spreadRadius: 0,
            ),
            // 右下陰影
            BoxShadow(
              color: color.withOpacity(0.8),
              offset: const Offset(1.5, 1.5),   
              blurRadius: 8,
              spreadRadius: 1,
            ),
            // 底部擴散陰影
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: -2, 
              offset: const Offset(-2, -2),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon, 
            size: size * 0.5, 
            color: Colors.white,
            shadows: [
              Shadow(
                offset: const Offset(1, 1),
                blurRadius: 2,
                color: Colors.black.withOpacity(0.3),
              )
            ],
          ),
        ),
      ),
    );
  }

  // 構建列表卡片：只有點擊左側糖果 Icon 才會進入頁面 (符合使用者需求)
  Widget _buildGroupCard(BuildContext context, UnitGroup group) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE2E8F0), 
            blurRadius: 10, 
            offset: const Offset(0, 4)
          )
        ],
      ),
      child: Row(
        children: [
          // 左邊：糖果質感 Icon (這是唯一可以點擊的地方)
          _buildCandyIcon(
            icon: group.icon, 
            color: group.color, 
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage(group: group))),
            size: 64
          ),
          
          const SizedBox(width: 16),
          
          // 右邊：文字區域 (無點擊功能)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.title, 
                  style: const TextStyle(
                    color: Color(0xFF1E293B), 
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
          
          // 右側裝飾用的箭頭
          Icon(Icons.arrow_left, size: 24, color: Colors.grey.shade200),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

// ==========================================
// --- 新增：導覽 Dialog 元件 ---
// 用於引導新使用者如何使用 APP
// ==========================================
class TutorialDialog extends StatefulWidget {
  const TutorialDialog({super.key});

  @override
  State<TutorialDialog> createState() => _TutorialDialogState();
}

class _TutorialDialogState extends State<TutorialDialog> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // 定義導覽的三個步驟
  final List<Map<String, dynamic>> _steps = [
    {
      "icon": Icons.category,
      "color": Color(0xFF667eea),
      "text": "1. Click the left icon to start.\nဘယ်ဘက်ရှိ လေးထောင့်ပုံကို နှိပ်ပြီး စတင်လေ့လာပါ။"
    },
    {
      "icon": Icons.star,
      "color": Colors.amber,
      "text": "2. Take quizzes & Star words to save.\nပဟေဠိဖြေပါ၊ မသိသော စကားလုံးများကို Star နှိပ်ပြီး မှတ်သားပါ။"
    },
    {
      "icon": Icons.menu_book,
      "color": Color(0xFFff9a9e),
      "text": "3. Collect 10+ words to unlock review quiz!\nစကားလုံး ၁၀ လုံးကျော်ပါက ပြန်လည်လေ့ကျင့်နိုင်ပါပြီ။"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: Colors.transparent,
      child: Container(
        height: 420,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            // 上半部：可滑動的 PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _steps.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: _steps[index]['color'].withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(_steps[index]['icon'], size: 60, color: _steps[index]['color']),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          _steps[index]['text'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.5),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // 下半部：指示點 (Dots Indicator) 與下一步按鈕
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 指示點
                  Row(
                    children: List.generate(_steps.length, (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8, height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index ? const Color(0xFF667eea) : Colors.grey.shade300,
                      ),
                    )),
                  ),
                  // Next / Start 按鈕
                  ThreeDButton(
                    onPressed: () {
                      if (_currentPage < _steps.length - 1) {
                        _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                      } else {
                        Navigator.pop(context); // 結束導覽
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
// --- 7. 分類子選單頁面 (CategoryPage) ---
// 根據選擇的大分類 (如 Office)，列出底下的小單元 (Unit 1, Unit 2...)
// ==========================================
class CategoryPage extends StatelessWidget {
  final UnitGroup group;

  const CategoryPage({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    // 獲取所有單字
    final allWords = getFullVocabulary();
    // 過濾出屬於目前分類的單字 (根據 ID 範圍)
    final groupWords = allWords.where((w) => w.id >= group.startId && w.id <= group.endId).toList();
    // 計算可用的單元數量 (每 10 個單字為一個 Unit)
    int availableUnitsCount = (groupWords.length / 10).floor();
    // 實際顯示數量取「資料庫有的」與「UI定義的」兩者之最小值
    int displayCount = min(availableUnitsCount, group.subUnits.length);

    return Scaffold(
      body: Column(
        children: [
          // 頂部 Header
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
          
          // 列表區域
          Expanded(
            child: displayCount == 0
                // 若無資料顯示 Coming Soon
                ? const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.construction, size: 80, color: Colors.grey), SizedBox(height: 16), Text("Coming Soon", style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold))]))
                : ListView.separated(
                    padding: const EdgeInsets.all(24),
                    itemCount: displayCount,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      // 切割該單元的單字列表 (每次取 10 個)
                      int start = index * 10;
                      int end = start + 10;
                      final unitWords = groupWords.sublist(start, end);
                      String unitTitle = "UNIT ${index + 1}";
                      String subTitle = group.subUnits[index];

                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: AppColors.cardGradient,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [BoxShadow(color: group.color.withOpacity(0.2), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: Row(
                          children: [
                            // 左邊：按鈕 (這是有 3D 特效且可以點擊進入 StudyPage 的地方)
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
                            
                            // 右邊：文字區域 (不可點擊)
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(unitTitle, style: TextStyle(color: group.color, fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1.2)),
                                  const SizedBox(height: 6),
                                  Text(subTitle, style: const TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 16)),
                                ],
                              ),
                            ),
                            
                            // 裝飾用箭頭 (指向左邊，提示按鈕在左側)
                            Icon(Icons.arrow_left, size: 24, color: Colors.grey.shade200),
                            const SizedBox(width: 8),
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
// --- 8. 學習頁面 (StudyPage) ---
// 核心功能：顯示單字卡、播放發音、顯示例句、收藏功能
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
  List<int> savedIds = []; // 儲存已收藏的單字 ID
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadSavedWords(); // 初始化時讀取收藏紀錄
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
      await _audioPlayer.play(AssetSource('audio/$fileName'));
    } catch (e) {
      debugPrint("播放失敗: $e");
    }
  }

  // 從本地存儲 (SharedPreferences) 讀取收藏
  Future<void> _loadSavedWords() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedIds = (prefs.getStringList('savedWords') ?? []).map(int.parse).toList();
    });
  }

  // 切換收藏狀態 (存入/移除)
  Future<void> _toggleSave(int id) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (savedIds.contains(id)) savedIds.remove(id); else savedIds.add(id);
    });
    // 更新本地存儲
    await prefs.setStringList('savedWords', savedIds.map((e) => e.toString()).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          // 頂部 Header
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
          
           // 提示區域：告訴使用者可以點擊發音
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
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 上半部：中文、拼音、發音按鈕、收藏星星
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
                                    Text(word.zh, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.black87)),
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
                          // 星星收藏按鈕
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
                      // 緬甸文翻譯
                      Padding(padding: const EdgeInsets.only(left: 20), child: Text(word.myn, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87))),
                      const SizedBox(height: 16),
                      // 例句區塊 (灰色背景)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(12), border: Border(left: BorderSide(color: widget.themeColor.withOpacity(0.5), width: 4))),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildSentence(word.sentenceZH, true, widget.themeColor), const SizedBox(height: 8), _buildSentence(word.sentenceMYN, false, widget.themeColor)]),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          // 底部按鈕：開始測驗
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade100))),
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

  // Helper: 解析例句中的強調標記 (**)
  // 例如 "這是 **蘋果**" 會將 "蘋果" 變色加粗
  Widget _buildSentence(String sentence, bool isZh, Color color) {
    List<String> parts = sentence.split('**');
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.grey.shade700, fontSize: 15, height: 1.4, fontFamily: 'Roboto'),
        children: parts.asMap().entries.map((entry) {
          int idx = entry.key; String text = entry.value; bool isBold = idx % 2 == 1;
          if (isBold && isZh) return TextSpan(text: text, style: TextStyle(fontWeight: FontWeight.w900, color: color));
          return TextSpan(text: text, style: isBold ? const TextStyle(fontWeight: FontWeight.w900, color: Colors.black87) : null);
        }).toList(),
      ),
    );
  }
}

// ==========================================
// --- 9. 測驗頁面 (QuizPage) ---
// 遊戲化測驗：5秒倒數、二選一(正確 vs 干擾項)
// ==========================================
class QuizPage extends StatefulWidget {
  final List<Word> words;
  final String unitName;
  const QuizPage({super.key, required this.words, required this.unitName});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  late List<Map<String, dynamic>> quizQueue; // 題目佇列
  int currentIndex = 0;
  List<Map<String, dynamic>> results = []; // 儲存答題結果
  late AnimationController _timerController; // 倒數計時動畫
  int timerSeconds = 5;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _prepareQuiz(); // 生成題目
    // 設定 5 秒倒數
    _timerController = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _timerController.reverse(from: 1.0);
    // 監聽：時間到自動判錯
    _timerController.addStatusListener((status) { if (status == AnimationStatus.dismissed) _handleAnswer(null); });
    // 監聽：更新 UI 數字
    _timerController.addListener(() { setState(() { timerSeconds = (_timerController.value * 5).ceil(); }); });
    // 播放第一題語音
    WidgetsBinding.instance.addPostFrameCallback((_) { _playCurrentWordAudio(); });
  }

  // 播放目前題目的發音
  Future<void> _playCurrentWordAudio() async {
    if (currentIndex < quizQueue.length) {
      final word = quizQueue[currentIndex]['word'] as Word;
      try { await _audioPlayer.stop(); await _audioPlayer.play(AssetSource('audio/${word.audioZH}')); } catch (e) { debugPrint("Quiz audio error: $e"); }
    }
  }

  // 題目生成邏輯：隨機洗牌，並為每個單字隨機挑選一個錯誤答案 (干擾項)
  void _prepareQuiz() {
    final random = Random();
    final allWords = getFullVocabulary(); 
    List<Word> shuffledWords = List.from(widget.words)..shuffle();
    quizQueue = shuffledWords.map((word) {
      Word distractor;
      // 確保干擾項不是正確答案本身
      if (allWords.length <= 1) {
         distractor = Word(id: -1, zh: "錯誤", pinyin: "cuò", myn: "Wrong", sentenceZH: "", sentenceMYN: "", audioZH: "");
      } else {
        do { distractor = allWords[random.nextInt(allWords.length)]; } while (distractor.myn == word.myn); 
      }
      // 隨機決定正確答案在上面 (0) 還是下面 (1)
      bool correctIsTop = random.nextBool();
      return { 'word': word, 'options': correctIsTop ? [word.myn, distractor.myn] : [distractor.myn, word.myn], 'correctIndex': correctIsTop ? 0 : 1 };
    }).toList();
  }

  // 處理作答：檢查答案、紀錄結果、跳下一題
  void _handleAnswer(int? index) {
    _timerController.stop();
    final currentQ = quizQueue[currentIndex];
    final word = currentQ['word'] as Word;
    final options = currentQ['options'] as List<String>;
    final correctIndex = currentQ['correctIndex'] as int;
    
    bool isTimeout = index == null;
    bool isCorrect = !isTimeout && index == correctIndex;
    results.add({'word': word, 'isCorrect': isCorrect, 'isTimeout': isTimeout, 'correctAnswer': word.myn, 'userAnswer': isTimeout ? 'Timeout' : options[index]});

    if (currentIndex < 9 && currentIndex < quizQueue.length - 1) { 
      // 還有題目，重置計時器並下一題
      setState(() { currentIndex++; _timerController.duration = const Duration(seconds: 5); _timerController.reverse(from: 1.0); });
      _playCurrentWordAudio();
    } else {
      // 測驗結束，跳轉結果頁
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
      backgroundColor: const Color(0xFF0F172A), // 深色背景專注模式
      body: SafeArea(
        child: Column(
          children: [
            // 進度條
            LinearProgressIndicator(value: (currentIndex) / totalQuestions, backgroundColor: Colors.white10, color: const Color(0xFF38ef7d), minHeight: 6),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [ThreeDButton(onPressed: () => Navigator.pop(context), borderRadius: BorderRadius.circular(20), child: const Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.close, color: Colors.grey))), Text("${currentIndex + 1} / $totalQuestions", style: const TextStyle(color: Colors.grey, fontSize: 16, fontFamily: 'monospace')), const SizedBox(width: 48)])),
            
            // 倒數計時圓環
            Stack(alignment: Alignment.center, children: [SizedBox(width: 60, height: 60, child: CircularProgressIndicator(value: _timerController.value, strokeWidth: 4, color: Colors.white, backgroundColor: Colors.white24)), Text("$timerSeconds", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))]),
            
            // 題目區 (中文大字)
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
            // 選項區 (兩個按鈕)
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
// --- 10. 結果頁面 (ResultPage) ---
// 顯示分數、播放合格/不合格音效、檢討答錯題目
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
  final AudioPlayer _resultAudioPlayer = AudioPlayer(); // 專用於結果音效

  @override
  void initState() {
    super.initState();
    _loadSavedWords();
    _playResultSound(); // 進入頁面時判斷並播放音效
  }

  @override
  void dispose() {
    _resultAudioPlayer.dispose();
    super.dispose();
  }

  // 根據分數播放 Pass (及格) 或 Fail (不及格) 音效
  Future<void> _playResultSound() async {
    // 計算分數
    int correctCount = widget.results.where((r) => r['isCorrect'] as bool).length;
    int total = widget.results.isNotEmpty ? widget.results.length : 1;
    int percentage = ((correctCount / total) * 100).round();

    try {
      if (percentage >= 60) {
        await _resultAudioPlayer.play(AssetSource('audio/pass.mp3'));
      } else {
        await _resultAudioPlayer.play(AssetSource('audio/fail.mp3'));
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

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const SizedBox(height: 40),
                // 分數卡片
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))], border: Border.all(color: Colors.white)),
                  child: Column(children: [const Icon(Icons.emoji_events, size: 60, color: Color(0xFF764ba2)), const SizedBox(height: 16), const Text("Quiz Complete!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)), Text(widget.unitName, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)), const SizedBox(height: 16), Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [Text("$percentage", style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w900, color: Color(0xFF667eea))), const Text("%", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey))]), const Text("ACCURACY SCORE", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey))]),
                ),
                const SizedBox(height: 24),
                // 答案檢討列表
                const Text("Review Answers", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF334155))),
                const SizedBox(height: 12),
                ...widget.results.map((res) {
                  final word = res['word'] as Word;
                  final isCorrect = res['isCorrect'] as bool;
                  final isSaved = savedIds.contains(word.id);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12), 
                    padding: const EdgeInsets.all(16), 
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), 
                    child: Row(
                      children: [
                        Icon(isCorrect ? Icons.check_circle : Icons.cancel, color: isCorrect ? const Color(0xFF38ef7d) : const Color(0xFFF5576C), size: 30),
                        const SizedBox(width: 16),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(word.zh, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), Text(word.pinyin, style: const TextStyle(color: Colors.grey, fontSize: 13)), if (!isCorrect) Text("Ans: ${res['correctAnswer']}", style: const TextStyle(color: Color(0xFF38ef7d), fontWeight: FontWeight.bold))])),
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
          // 底部按鈕：回首頁 / 再次測驗
          Container(
            padding: const EdgeInsets.all(24), color: Colors.white,
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
// --- 11. 單字本頁面 (VocabBookPage) ---
// 列出所有收藏的單字，並提供「隨機測驗」功能
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

  // 讀取並過濾出收藏的單字物件
  Future<void> _loadSavedWords() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIds = (prefs.getStringList('savedWords') ?? []).map(int.parse).toList();
    final allWords = getFullVocabulary();
    setState(() { savedWords = allWords.where((w) => savedIds.contains(w.id)).toList(); isLoading = false; });
  }

  // 移除收藏並刷新列表
  Future<void> _removeWord(int id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedIdStrings = (prefs.getStringList('savedWords') ?? []);
    savedIdStrings.remove(id.toString());
    await prefs.setStringList('savedWords', savedIdStrings);
    _loadSavedWords();
  }

  // 啟動單字本專屬的隨機測驗 (僅針對已收藏單字)
  void _startRandomQuiz() {
    if (savedWords.length < 10) return;
    List<Word> shuffled = List.from(savedWords)..shuffle();
    List<Word> quizSet = shuffled.take(10).toList();
    Navigator.push(context, MaterialPageRoute(builder: (context) => QuizPage(words: quizSet, unitName: "My Vocab Quiz")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
           // Header
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
                // 統計資訊與測驗按鈕
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
                // 提示訊息：需滿10字才能測驗
                if (savedWords.length < 10) Container(width: double.infinity, padding: const EdgeInsets.all(8), color: Colors.orange.shade50, child: const Text("Save 10+ words to unlock quiz!", textAlign: TextAlign.center, style: TextStyle(color: Colors.orange, fontSize: 12))),
                
                // 收藏列表
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