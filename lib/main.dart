import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/vocab_data.dart';
import 'core/global_settings.dart';
import 'widgets/three_d_button.dart';
import 'widgets/tutorial_dialog.dart';
import 'widgets/settings_dialog.dart';
import 'theme/app_colors.dart';
import 'data/unit_group.dart';
import 'pages/splash_page.dart';
import 'pages/vocab_book_page.dart';
import 'pages/study_page.dart';

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

  // 修改：建立分類卡片 (現在整張卡片都可點擊且有縮放效果)
  Widget _buildGroupCard(BuildContext context, UnitGroup group) {
    // 根據深色/淺色模式取得對應顏色
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? const Color(0xFF1E293B);
    const double iconSize = 64;

    return Container(
      // 1. 外層 Container 只負責陰影，避免陰影跟著內容一起被裁切
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8, 
            offset: const Offset(2, 2)
          )
        ],
      ),
      // 2. 使用 ThreeDButton 包覆整個內容
      child: ThreeDButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage(group: group))),
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cardColor, // 卡片背景色
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              // 3. 圖示部分 (移除原本的按鈕邏輯，只保留視覺)
              Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [group.color.withOpacity(0.7), group.color, group.color.withOpacity(0.9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(iconSize * 0.35),
                  boxShadow: [
                    BoxShadow(color: Colors.white.withOpacity(0.4), offset: const Offset(-1, -1), blurRadius: 3),
                    BoxShadow(color: group.color.withOpacity(0.8), offset: const Offset(1.0, 1.0), blurRadius: 2, spreadRadius: 1),
                  ],
                ),
                child: Center(
                  child: Icon(group.icon, size: iconSize * 0.5, color: Colors.white, shadows: [Shadow(offset: const Offset(1, 1), blurRadius: 2, color: Colors.black.withOpacity(0.3))]),
                ),
              ),
              const SizedBox(width: 16),
              // 文字區域
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
        ),
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
// --- 8. 分類頁面 (CategoryPage) ---
// 顯示某個大分類底下的子單元 (Topics)，包含分數顯示與全區域點擊+縮放
// ==========================================
class CategoryPage extends StatefulWidget {
  final UnitGroup group;
  const CategoryPage({super.key, required this.group});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Map<String, int> unitScores = {}; // 儲存單元分數

  @override
  void initState() {
    super.initState();
    _loadScores();
  }

  // 讀取該分類下所有 Unit 的分數
  Future<void> _loadScores() async {
    final prefs = await SharedPreferences.getInstance();
    final allWords = getFullVocabulary(); 
    final groupWords = allWords.where((w) => w.id >= widget.group.startId && w.id <= widget.group.endId).toList();
    int availableUnitsCount = (groupWords.length / 10).floor();
    int displayCount = min(availableUnitsCount, widget.group.subUnits.length);

    Map<String, int> loadedScores = {};
    for (int i = 0; i < displayCount; i++) {
      String unitTitle = "UNIT ${i + 1}";
      String key = 'score_${widget.group.title}_$unitTitle';
      int? score = prefs.getInt(key);
      if (score != null) {
        loadedScores[unitTitle] = score;
      }
    }

    if (mounted) {
      setState(() {
        unitScores = loadedScores;
      });
    }
  }

  // 進入單元
  void _enterUnit(BuildContext context, String unitTitle, List<Word> unitWords) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudyPage(
          unitTitle: unitTitle,
          wordList: unitWords,
          themeColor: widget.group.color,
          groupTitle: widget.group.title, 
        )
      ),
    ).then((_) {
      _loadScores(); // 返回時刷新分數
    });
  }

  @override
  Widget build(BuildContext context) {
    final allWords = getFullVocabulary();
    final groupWords = allWords.where((w) => w.id >= widget.group.startId && w.id <= widget.group.endId).toList();
    
    int availableUnitsCount = (groupWords.length / 10).floor();
    int displayCount = min(availableUnitsCount, widget.group.subUnits.length);
    
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? const Color(0xFF1E293B);

    return Scaffold(
      body: Column(
        children: [
          // 頂部導覽列
          Container(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [widget.group.color, widget.group.color.withOpacity(0.8)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            ),
            child: Row(
              children: [
                ThreeDButton(
                  onPressed: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(30),
                  child: const Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.arrow_back_ios, color: Colors.white)),
                ),
                Expanded(child: Text(widget.group.title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          
          // 列表內容
          Expanded(
            child: displayCount == 0
                ? const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.construction, size: 80, color: Colors.grey), SizedBox(height: 16), Text("Coming Soon", style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold))]))
                : ListView.separated(
                    padding: const EdgeInsets.all(24),
                    itemCount: displayCount,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      int start = index * 10;
                      int end = start + 10;
                      final unitWords = groupWords.sublist(start, end);
                      String unitTitle = "UNIT ${index + 1}";
                      String subTitle = widget.group.subUnits[index];
                      int? score = unitScores[unitTitle];

                      // 這裡使用 Container 僅負責繪製「外部陰影」
                      // 因為 ThreeDButton 會裁切內容 (Clip)，陰影如果寫在裡面會被切掉
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [BoxShadow(color: widget.group.color.withOpacity(0.2), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: ThreeDButton(
                          // 1. 現在整個按鈕都具備縮放功能
                          onPressed: () => _enterUnit(context, unitTitle, unitWords),
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            decoration: BoxDecoration(
                              color: cardColor, // 卡片背景色
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  // 2. 圖示部分：移除內層的按鈕邏輯，只保留視覺裝飾
                                  // 這樣點擊這裡也會觸發外層的縮放
                                  Container(
                                    width: 64, height: 64,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [widget.group.color, widget.group.color.withOpacity(0.7)]), 
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        // 內部的小陰影
                                        BoxShadow(color: widget.group.color.withOpacity(0.3), offset: const Offset(2, 2), blurRadius: 4)
                                      ]
                                    ),
                                    child: Icon(widget.group.icon, size: 32, color: Colors.white),
                                  ),
                                  
                                  const SizedBox(width: 16),
                                  
                                  // 文字區域
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(unitTitle, style: TextStyle(color: widget.group.color, fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1.2)),
                                        const SizedBox(height: 6),
                                        Text(subTitle, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                  
                                  // 分數顯示
                                  if (score != null)
                                    Container(
                                      margin: const EdgeInsets.only(left: 8),
                                      child: score == 10
                                          ? const Icon(Icons.check_circle, color: Colors.green, size: 32)
                                          : Text(
                                              "$score/10", 
                                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey.shade400)
                                            ),
                                    )
                                ],
                              ),
                            ),
                          ),
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





