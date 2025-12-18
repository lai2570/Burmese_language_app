import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart'; // 用於播放單字音效
import 'data/vocab_data.dart'; // 匯入單字資料檔

void main() {
  runApp(const MyApp());
}

// --- 主程式入口 ---
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 設定 APP 標題
      title: 'Chin Chin Chinese',
      // 關閉右上角的 debug 標籤
      debugShowCheckedModeBanner: false,
      // 設定整體主題風格
      theme: ThemeData(
        primarySwatch: Colors.indigo, // 主色調：靛藍色
        scaffoldBackgroundColor: const Color(0xFFF1F5F9), // 背景色：淺灰藍
        fontFamily: 'Roboto', // 字體
        useMaterial3: true, // 啟用 Material Design 3
      ),
      // 設定文字縮放比例，避免在不同手機上字體過大跑版
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
      // 設定首頁為歡迎動畫頁面 (SplashScreen)
      home: const SplashScreen(), 
    );
  }
}

// --- 頁面 1：歡迎動畫頁面 (Splash Screen) ---
// 修改說明：已從 VideoPlayer 改為 GIF 圖片顯示，提升相容性與穩定度。
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // 設定倒數計時器
    // 1.5 秒後自動跳轉到主頁面 (HomePage)
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) { // 確保頁面還在，避免跳轉時報錯
        _navigateToHome();
      }
    });
  }

  // 跳轉到主頁面的函式
  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // 背景色設為深藍色，凸顯內容
      body: Center(
        // 直接顯示 GIF 圖片
        // 請確保 assets/intro.gif 檔案存在，且已在 pubspec.yaml 註冊
        child: Image.asset(
          "assets/intro.gif",
          fit: BoxFit.contain, // 保持圖片比例，包含在畫面內
          // width: 300, // 若圖片太大，可解開註解限制寬度
        ),
      ),
    );
  }
}

// --- 資料結構：單元分類 (UnitGroup) ---
// 用於定義首頁的大分類，並透過 ID 區間來篩選單字
class UnitGroup {
  final String title;     // 分類標題 (如：School)
  final IconData icon;    // 分類圖示
  final int startId;      // 該分類的起始單字 ID (如：101)
  final int endId;        // 該分類的結束單字 ID (如：400)
  final List<String> subUnits; // 該分類下的子單元標題列表

  const UnitGroup({
    required this.title,
    required this.icon,
    required this.startId,
    required this.endId,
    required this.subUnits,
  });
}

// --- 定義所有單元分類 ---
// 這裡對應 vocab_data.dart 的 ID 規則
final List<UnitGroup> appUnitGroups = [
  UnitGroup(
    title: "School (ကျောင်း)", 
    icon: Icons.school, 
    startId: 101, endId: 400,
    subUnits: ["Campus (ကျောင်းဝင်း)", "Class (အတန်းတက်)", "Classmates (အတန်းဖော်များ)"]
  ),
  UnitGroup(
    title: "Office (ရုံး)", 
    icon: Icons.business_center, 
    startId: 401, endId: 1000,
    subUnits: ["Office (ရုံး)", "Recruitment (ဝန်ထမ်းခေါ်)", "Communication (ဆက်သွယ်မှု)", "Finance (ငွေကြေး)", "Attendance (တက်ရောက်မှု)"]
  ),
  UnitGroup(
    title: "Factory (စက်ရုံ)", 
    icon: Icons.factory, 
    startId: 1001, endId: 1300,
    subUnits: ["Factory (စက်ရုံ)", "Warehouse (ဂိုဒေါင်)"]
  ),
  UnitGroup(
    title: "Restaurant (စားသောက်ဆိုင်)", 
    icon: Icons.restaurant, 
    startId: 1301, endId: 1600,
    subUnits: ["Restaurant (စားသောက်ဆိုင်)", "Tableware (ပန်းကန်ခွက်ယောက်)", "Service (ဝန်ဆောင်မှု)"]
  ),
  UnitGroup(
    title: "Salon (ဆံပင်ဆိုင်)", 
    icon: Icons.content_cut, 
    startId: 1601, endId: 1800,
    subUnits: ["Salon (ဆံပင်ဆိုင်)", "Haircut (ဆံပင်ညှပ်)"]
  ),
  UnitGroup(
    title: "Customs (အကောက်ခွန်)", 
    icon: Icons.local_airport, 
    startId: 1801, endId: 2000, // 修正這裡原本可能是 1200 的筆誤
    subUnits: ["Customs (အကောက်ခွန်)", "Airport (လေဆိပ်)"]
  ),
  UnitGroup(
    title: "ARC (အေအာစီ)", 
    icon: Icons.card_membership, 
    startId: 2001, endId: 2100,
    subUnits: ["ARC (အေအာစီ)"]
  ),
  UnitGroup(
    title: "Majors (မေဂျာ)", 
    icon: Icons.book, 
    startId: 2101, endId: 2300,
    subUnits: ["Majors (မေဂျာ)", "Academics (ပညာရေး)"]
  ),
  UnitGroup(
    title: "Job Titles (အလုပ်အမည်များ)", 
    icon: Icons.badge, 
    startId: 2301, endId: 2500,
    subUnits: ["Job Titles 1 (အလုပ်အမည်များ)", "Job Titles 2 (အလုပ်အမည်များ)"]
  ),
  UnitGroup(
    title: "Weather (ရာသီဥတု)", 
    icon: Icons.wb_sunny, 
    startId: 2501, endId: 2600, 
    subUnits: ["Weather (ရာသီဥတု)"]
  ),
  UnitGroup(
    title: "Hospital (ဆေးရုံ)", 
    icon: Icons.local_hospital, 
    startId: 2601, endId: 2700, 
    subUnits: ["Medical Care(ဆေးကုသမှု)","Symptoms(ရောဂါလက္ခဏာများ)","Clinics(ဆေးခန်းနှင့် ဌာနများ)"]
  ),
  UnitGroup(
    title: "Sports (အားကစား)", 
    icon: Icons.sports_soccer, 
    startId: 2701, endId: 2800, 
    subUnits: ["Sports (အားကစား)"]
  ),
  UnitGroup(
    title: "Food (အစားအစာ)", 
    icon: Icons.fastfood, 
    startId: 2801, endId: 2900, 
    subUnits: ["Food (အစားအစာ)"]
  ),
  UnitGroup(
    title: "Festivals (ပွဲတော်များ)", 
    icon: Icons.celebration, 
    startId: 2901, endId: 3000, 
    subUnits: ["Festivals (ပွဲတော်များ)"]
  ),
  UnitGroup(
    title: "Document (စာရွက်စာတမ်း)", 
    icon: Icons.description, 
    startId: 3001, endId: 3100, 
    subUnits: ["Document (စာရွက်စာတမ်း)"]
  ),
];

// --- 頁面 2：主頁面 (HomePage) ---
// 顯示所有大分類卡片，以及作者資訊與單字本入口
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  // 彈出視窗：顯示關於作者與版權資訊
  void _showAuthorInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("About"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.verified, color: Colors.indigo),
                title: const Text('Chin Chin Chinese'),
                subtitle: const Text('Version 1.0.0'),
              ),
              const Text(
                '© 2025 YUNG-TSAI LAI\n\n'
                '• Code licensed under MIT.\n'
                '• Assets (Audio/Data) licensed under CC BY-NC-ND 4.0.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              const Text('Credits / ဖန်တီးသူများ:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text('Developer: YUNG-TSAI LAI (賴泳在)'),
              const Text('Translation: ChinQing in Taiwan(林素青)'),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header 區域 (深色背景)
          Container(
            padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 24),
            decoration: const BoxDecoration(
              color: Color(0xFF0F172A),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 左側：Logo 與標題
                Row(
                  children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                      child: const Center(child: Text("C", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)))),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Chin Chin Chinese", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("For Myanmar Learners", style: TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                // 右側：功能按鈕 (資訊 / 單字本)
                Row(
                  children: [
                    GestureDetector(
                      onTap: _showAuthorInfo,
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF334155))),
                        child: const Icon(Icons.info_outline, color: Colors.white70, size: 24),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const VocabBookPage())),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF334155))),
                        child: const Icon(Icons.book, color: Colors.indigoAccent, size: 24),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          // Categories List (分類列表)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(children: [Icon(Icons.category, color: Colors.indigo, size: 20), SizedBox(width: 8), Text("Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)))]),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: appUnitGroups.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) => _buildGroupCard(context, appUnitGroups[index]),
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

  // 建構單一分類卡片
  Widget _buildGroupCard(BuildContext context, UnitGroup group) {
    return GestureDetector(
      onTap: () {
        // 點擊後進入 CategoryPage，傳入該分類設定
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage(group: group)));
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))]),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
              child: Icon(group.icon, size: 32, color: Colors.indigo),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(group.title, style: const TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 4),
                  Text("${group.subUnits.length} Topics Planned", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

// --- 頁面 3：分類詳情頁 (CategoryPage) ---
// 根據 ID 區間篩選單字，並將單字每 10 個切成一個 Unit
class CategoryPage extends StatelessWidget {
  final UnitGroup group;

  const CategoryPage({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    // 1. 取得完整單字庫
    final allWords = getFullVocabulary();
    
    // 2. 根據 ID 區間過濾出屬於這個分類的單字
    final groupWords = allWords.where((w) => w.id >= group.startId && w.id <= group.endId).toList();

    // 3. 計算能組成幾個完整的 10 字單元 (不滿 10 個則捨棄 -> 使用 floor)
    int availableUnitsCount = (groupWords.length / 10).floor();

    // 4. 防呆：顯示的單元數不能超過設定檔(subUnits)的標題數量
    int displayCount = min(availableUnitsCount, group.subUnits.length);

    return Scaffold(
      appBar: AppBar(
        title: Text(group.title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: displayCount == 0 
        ? const Center(child: Text("Coming Soon / No complete units yet", style: TextStyle(color: Colors.grey)))
        : ListView.separated(
            padding: const EdgeInsets.all(24),
            itemCount: displayCount,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              
              // 5. 切割出該單元需要的 10 個單字
              int start = index * 10;
              int end = start + 10;
              final unitWords = groupWords.sublist(start, end);

              // 設定單元標題
              String unitTitle = "UNIT ${index + 1}";
              String subTitle = group.subUnits[index];

              return GestureDetector(
                onTap: () {
                  // 6. 點擊後進入 StudyPage，直接傳遞這 10 個單字的列表
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => StudyPage(
                      unitTitle: unitTitle, 
                      wordList: unitWords
                    )
                  ));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(unitTitle, style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.w900, fontSize: 13)),
                          const SizedBox(height: 4),
                          Text(subTitle, style: const TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                      const Icon(Icons.play_circle_fill, size: 32, color: Colors.indigoAccent),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}

// --- 頁面 4：學習頁面 (StudyPage) ---
// 顯示單字列表，支援發音播放與收藏功能
class StudyPage extends StatefulWidget {
  final String unitTitle;
  final List<Word> wordList; // 接收上頁傳來的 10 個單字

  const StudyPage({
    super.key, 
    required this.unitTitle, 
    required this.wordList
  });

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  List<int> savedIds = []; // 儲存已收藏的單字 ID
  final AudioPlayer _audioPlayer = AudioPlayer(); // 音效播放器

  @override
  void initState() {
    super.initState();
    _loadSavedWords(); // 載入收藏紀錄
  }
  
  @override
  void dispose() {
    _audioPlayer.dispose(); // 釋放播放器資源
    super.dispose();
  }

  // 播放音檔函式
  Future<void> _playAudio(String fileName) async {
    try {
      await _audioPlayer.stop(); // 停止上一首
      await _audioPlayer.play(AssetSource('audio/$fileName')); // 播放新檔案
    } catch (e) {
      debugPrint("播放失敗: $e");
    }
  }

  // 從 SharedPreferences 讀取已收藏的單字
  Future<void> _loadSavedWords() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedIds = (prefs.getStringList('savedWords') ?? []).map(int.parse).toList();
    });
  }

  // 切換收藏狀態 (存/刪)
  Future<void> _toggleSave(int id) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (savedIds.contains(id)) savedIds.remove(id); else savedIds.add(id);
    });
    await prefs.setStringList('savedWords', savedIds.map((e) => e.toString()).toList());
  }

  @override
  Widget build(BuildContext context) {
    final currentList = widget.wordList;

    if (currentList.isEmpty) {
      return Scaffold(appBar: AppBar(), body: const Center(child: Text("Error: No words.")));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, elevation: 0,
        leading: IconButton(icon: const Icon(Icons.chevron_left, color: Colors.black, size: 30), onPressed: () => Navigator.pop(context)),
        title: Column(children: [Text(widget.unitTitle, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), const Text("STUDY MODE", style: TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 1.5))]), centerTitle: true,
      ),
      body: Column(
        children: [
           // 頂部提示欄位 (點擊喇叭發音)
           Container(
             margin: const EdgeInsets.all(16), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
             decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 const Icon(Icons.volume_up, color: Colors.indigo, size: 20),
                 const SizedBox(width: 8), 
                 RichText(
                   text: const TextSpan(
                     style: TextStyle(color: Colors.indigo, fontSize: 13, fontFamily: 'Roboto'),
                     children: [
                       TextSpan(text: "Click "),
                       WidgetSpan(child: Icon(Icons.volume_up, size: 16, color: Colors.indigo), alignment: PlaceholderAlignment.middle),
                       TextSpan(text: " to listen / နားထောင်ရန်နှိပ်ပါ"),
                     ]
                   ),
                 ),
               ],
             ),
           ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: currentList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final word = currentList[index];
                final isSaved = savedIds.contains(word.id);
                
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade100), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 單字標題區塊
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, 
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [                        
                                    Text("${index + 1}. ", style: const TextStyle(color: Colors.grey, fontFamily: 'monospace')), 
                                    // 中文單字
                                    Text(
                                      word.zh, 
                                      style: const TextStyle(
                                        fontSize: 28, 
                                        fontWeight: FontWeight.w900, 
                                        color: Colors.black87
                                      )
                                    ),
                                    const SizedBox(width: 8),
                                    // 喇叭按鈕
                                    InkWell(
                                      onTap: () => _playAudio(word.audioZH),
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.indigo.shade50,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.volume_up, color: Colors.indigo, size: 24),
                                      ),
                                    ),
                                  ]
                                ),
                                // 拼音
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, top: 4), 
                                  child: Text(word.pinyin, style: const TextStyle(color: Colors.indigo, fontSize: 16, fontWeight: FontWeight.w500))
                                )
                              ]
                            ),
                          ),
                          // 收藏星星按鈕
                          IconButton(onPressed: () => _toggleSave(word.id), icon: Icon(isSaved ? Icons.star : Icons.star_border, color: isSaved ? Colors.amber : Colors.grey.shade300, size: 28))
                        ],
                      ),
                      const SizedBox(height: 12),
                      // 緬甸文翻譯
                      Padding(padding: const EdgeInsets.only(left: 20), child: Text(word.myn, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87))),
                      const SizedBox(height: 16),
                      // 例句區塊
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(12), border: Border(left: BorderSide(color: Colors.indigo.shade200, width: 4))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, 
                          children: [
                            _buildSentence(word.sentenceZH, true, null), 
                            const SizedBox(height: 8), 
                            _buildSentence(word.sentenceMYN, false, null)
                          ]
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          // 底部按鈕：開始測驗
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade100))),
            child: SizedBox(width: double.infinity, 
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => QuizPage(
                    words: currentList, 
                    unitName: widget.unitTitle
                  )
                )), 
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 4), 
                icon: const Icon(Icons.play_arrow), 
                label: const Text("Start Quiz", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
              )
            ),
          )
        ],
      ),
    );
  }

  // 建構例句 (處理 **粗體** 格式)
  Widget _buildSentence(String sentence, bool isZh, String? audioFileName) {
    List<String> parts = sentence.split('**');
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.grey.shade700, fontSize: 15, height: 1.4, fontFamily: 'Roboto'),
        children: parts.asMap().entries.map((entry) {
          int idx = entry.key; 
          String text = entry.value; 
          bool isBold = idx % 2 == 1; // 奇數部分為粗體
          
          if (isBold && isZh) {
            return TextSpan(
              text: text,
              style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.indigo),
            );
          }
          
          return TextSpan(
            text: text, 
            style: isBold ? const TextStyle(fontWeight: FontWeight.w900, color: Colors.black87) : null
          );
        }).toList(),
      ),
    );
  }
}

// --- 頁面 5：測驗頁面 (QuizPage) ---
// 功能：隨機出題、倒數計時、自動播放題目發音
class QuizPage extends StatefulWidget {
  final List<Word> words;
  final String unitName;
  const QuizPage({super.key, required this.words, required this.unitName});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  late List<Map<String, dynamic>> quizQueue; // 題目佇列
  int currentIndex = 0; // 當前題號
  List<Map<String, dynamic>> results = []; // 測驗結果
  late AnimationController _timerController; // 計時器動畫
  int timerSeconds = 5; // 剩餘秒數
  
  final AudioPlayer _audioPlayer = AudioPlayer(); // 音效播放器

  @override
  void initState() {
    super.initState();
    _prepareQuiz(); // 準備題目
    
    // 初始化計時器 (5秒倒數)
    _timerController = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _timerController.reverse(from: 1.0);
    _timerController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) _handleAnswer(null); // 時間到，視為答錯
    });
    _timerController.addListener(() {
      setState(() { timerSeconds = (_timerController.value * 5).ceil(); });
    });

    // 進入測驗後，播放第一題的聲音
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playCurrentWordAudio();
    });
  }

  // 播放當前題目單字的聲音
  Future<void> _playCurrentWordAudio() async {
    if (currentIndex < quizQueue.length) {
      final word = quizQueue[currentIndex]['word'] as Word;
      try {
        await _audioPlayer.stop(); 
        await _audioPlayer.play(AssetSource('audio/${word.audioZH}'));
      } catch (e) {
        debugPrint("Quiz audio error: $e");
      }
    }
  }

  // 準備題目：打亂順序並產生選項
  void _prepareQuiz() {
    final random = Random();
    final allWords = getFullVocabulary(); 

    // 將傳入的單字列表進行隨機打亂 (Shuffle)
    List<Word> shuffledWords = List.from(widget.words)..shuffle();

    quizQueue = shuffledWords.map((word) {
      Word distractor;
      // 產生干擾項 (確保不與正確答案相同)
      if (allWords.length <= 1) {
         distractor = Word(id: -1, zh: "錯誤", pinyin: "cuò", myn: "Wrong", sentenceZH: "", sentenceMYN: "", audioZH: "");
      } else {
        do {
          distractor = allWords[random.nextInt(allWords.length)];
        } while (distractor.myn == word.myn); 
      }

      // 隨機決定正確答案的位置 (上或下)
      bool correctIsTop = random.nextBool();
      return {
        'word': word,
        'options': correctIsTop ? [word.myn, distractor.myn] : [distractor.myn, word.myn],
        'correctIndex': correctIsTop ? 0 : 1
      };
    }).toList();
  }

  // 處理作答邏輯
  void _handleAnswer(int? index) {
    _timerController.stop();
    final currentQ = quizQueue[currentIndex];
    final word = currentQ['word'] as Word;
    final options = currentQ['options'] as List<String>;
    final correctIndex = currentQ['correctIndex'] as int;
    
    bool isTimeout = index == null;
    bool isCorrect = !isTimeout && index == correctIndex;
    
    // 紀錄結果
    results.add({'word': word, 'isCorrect': isCorrect, 'isTimeout': isTimeout, 'correctAnswer': word.myn, 'userAnswer': isTimeout ? 'Timeout' : options[index]});

    // 判斷是否還有下一題
    if (currentIndex < 9 && currentIndex < quizQueue.length - 1) { 
      setState(() {
        currentIndex++;
        _timerController.duration = const Duration(seconds: 5);
        _timerController.reverse(from: 1.0); // 重置計時器
      });
      _playCurrentWordAudio(); // 播放下一題聲音
    } else {
      // 測驗結束，前往結果頁
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ResultPage(results: results, unitName: widget.unitName, originalWords: widget.words)));
    }
  }

  @override
  void dispose() {
    _timerController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (quizQueue.isEmpty || currentIndex >= quizQueue.length) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    final currentQ = quizQueue[currentIndex];
    final word = currentQ['word'] as Word;
    final options = currentQ['options'] as List<String>;
    final totalQuestions = quizQueue.length;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Column(
          children: [
            // 進度條
            LinearProgressIndicator(value: (currentIndex) / totalQuestions, backgroundColor: Colors.white10, color: Colors.green, minHeight: 6),
            // 頂部導覽列
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [IconButton(icon: const Icon(Icons.close, color: Colors.grey), onPressed: () => Navigator.pop(context)), Text("${currentIndex + 1} / $totalQuestions", style: const TextStyle(color: Colors.grey, fontSize: 16, fontFamily: 'monospace')), const IconButton(icon: Icon(Icons.star_border, color: Colors.grey), onPressed: null)])),
            
            // 倒數計時圈圈
            Stack(alignment: Alignment.center, children: [SizedBox(width: 60, height: 60, child: CircularProgressIndicator(value: _timerController.value, strokeWidth: 4, color: Colors.white, backgroundColor: Colors.white24)), Text("$timerSeconds", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))]),
            
            // 題目區域 (點擊文字或喇叭可重播聲音)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min, 
                  children: [
                    GestureDetector(
                      onTap: _playCurrentWordAudio,
                      child: Text(word.zh, style: const TextStyle(color: Colors.white, fontSize: 64, fontWeight: FontWeight.w900))
                    ),
                    const SizedBox(height: 12), 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(word.pinyin, style: const TextStyle(color: Colors.indigoAccent, fontSize: 24, fontWeight: FontWeight.w500)),
                         const SizedBox(width: 10),
                         IconButton(
                           icon: const Icon(Icons.volume_up, color: Colors.white70),
                           onPressed: _playCurrentWordAudio,
                         )
                      ],
                    )
                  ]
                )
              )
            ),
            // 選項按鈕
            Padding(padding: const EdgeInsets.all(24.0), child: Column(children: List.generate(2, (idx) => Padding(padding: const EdgeInsets.only(bottom: 16), child: SizedBox(width: double.infinity, height: 80, child: ElevatedButton(onPressed: () => _handleAnswer(idx), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF0F172A), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 0), child: Text(options[idx], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))))))))
          ],
        ),
      ),
    );
  }
}

// --- 頁面 6：結果頁面 (ResultPage) ---
// 顯示測驗分數與答題詳情
class ResultPage extends StatefulWidget {
  final List<Map<String, dynamic>> results;
  final String unitName;
  final List<Word> originalWords; // 用於 "Study Again" 功能

  const ResultPage({super.key, required this.results, required this.unitName, required this.originalWords});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<int> savedIds = [];

  @override
  void initState() {
    super.initState();
    _loadSavedWords();
  }

  Future<void> _loadSavedWords() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedIds = (prefs.getStringList('savedWords') ?? []).map(int.parse).toList();
    });
  }

  Future<void> _toggleSave(int id) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (savedIds.contains(id)) savedIds.remove(id); else savedIds.add(id);
    });
    await prefs.setStringList('savedWords', savedIds.map((e) => e.toString()).toList());
  }

  @override
  Widget build(BuildContext context) {
    // 計算分數
    int correctCount = widget.results.where((r) => r['isCorrect'] as bool).length;
    int total = widget.results.isNotEmpty ? widget.results.length : 1;
    int percentage = ((correctCount / total) * 100).round();

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
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
                  child: Column(children: [const Icon(Icons.emoji_events, size: 60, color: Colors.indigo), const SizedBox(height: 16), const Text("Quiz Complete!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)), Text(widget.unitName, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)), const SizedBox(height: 16), Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [Text("$percentage", style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w900, color: Colors.indigo)), const Text("%", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey))]), const Text("ACCURACY SCORE", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey))]),
                ),
                const SizedBox(height: 24),
                const Text("Review Answers", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF334155))),
                const SizedBox(height: 12),
                // 答題詳情列表
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
                        Icon(isCorrect ? Icons.check_circle : Icons.cancel, color: isCorrect ? Colors.green : Colors.redAccent, size: 30),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, 
                            children: [
                              Text(word.zh, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), 
                              Text(word.pinyin, style: const TextStyle(color: Colors.grey, fontSize: 13)), 
                              if (!isCorrect) Text("Ans: ${res['correctAnswer']}", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
                            ]
                          )
                        ),
                        IconButton(
                          onPressed: () => _toggleSave(word.id),
                          icon: Icon(
                            isSaved ? Icons.star : Icons.star_border, 
                            color: isSaved ? Colors.amber : Colors.grey.shade300, 
                            size: 28
                          )
                        )
                      ]
                    )
                  );
                }),
              ],
            ),
          ),
          // 底部按鈕 (Home / Study Again)
          Container(
            padding: const EdgeInsets.all(24), color: Colors.white,
            child: Row(children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.popUntil(context, (route) => route.isFirst), 
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade100, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 16)), 
                  child: const Text("Home")
                )
              ), 
              const SizedBox(width: 16), 
              Expanded(
                child: ElevatedButton(
                  // 重新學習：返回 StudyPage 並帶入原始單字列表
                  onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => StudyPage(
                      unitTitle: widget.unitName, 
                      wordList: widget.originalWords
                    )
                  )), 
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16)), 
                  child: const Text("Study Again")
                )
              )
            ]),
          )
        ],
      ),
    );
  }
}

// --- 頁面 7：單字本頁面 (VocabBookPage) ---
// 顯示使用者收藏的所有單字，並提供隨機測驗功能
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

  // 載入收藏的單字
  Future<void> _loadSavedWords() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIds = (prefs.getStringList('savedWords') ?? []).map(int.parse).toList();
    final allWords = getFullVocabulary();
    
    setState(() {
      savedWords = allWords.where((w) => savedIds.contains(w.id)).toList();
      isLoading = false;
    });
  }

  // 移除單字
  Future<void> _removeWord(int id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedIdStrings = (prefs.getStringList('savedWords') ?? []);
    savedIdStrings.remove(id.toString());
    await prefs.setStringList('savedWords', savedIdStrings);
    _loadSavedWords(); // 重新載入列表
  }

  // 開始隨機測驗 (僅限收藏單字超過 10 個時)
  void _startRandomQuiz() {
    if (savedWords.length < 10) return;
    List<Word> shuffled = List.from(savedWords)..shuffle();
    List<Word> quizSet = shuffled.take(10).toList();
    Navigator.push(context, MaterialPageRoute(builder: (context) => QuizPage(words: quizSet, unitName: "My Vocab Quiz")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Vocabulary"), centerTitle: true, backgroundColor: Colors.white, elevation: 0, iconTheme: const IconThemeData(color: Colors.black), titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
      body: isLoading ? const Center(child: CircularProgressIndicator()) : Column(
        children: [
          // 頂部統計區塊
          Container(
            padding: const EdgeInsets.all(16), color: Colors.grey.shade50,
            child: Row(
              children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("${savedWords.length}", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.indigo)), const Text("Saved Words", style: TextStyle(color: Colors.grey))])),
                ElevatedButton.icon(
                  onPressed: savedWords.length >= 10 ? _startRandomQuiz : null,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text("Quiz (10)"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white, disabledBackgroundColor: Colors.grey.shade300),
                )
              ],
            ),
          ),
          // 提示訊息 (如果單字不足 10 個)
          if (savedWords.length < 10) Container(width: double.infinity, padding: const EdgeInsets.all(8), color: Colors.orange.shade50, child: const Text("Save 10+ words to unlock quiz!", textAlign: TextAlign.center, style: TextStyle(color: Colors.orange, fontSize: 12))),
          // 單字列表
          Expanded(
            child: savedWords.isEmpty ? const Center(child: Text("No words yet.", style: TextStyle(color: Colors.grey))) : ListView.separated(
              padding: const EdgeInsets.all(16), itemCount: savedWords.length, separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final word = savedWords[index];
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4, offset: const Offset(0, 2))]),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(word.zh, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), Text(word.pinyin, style: const TextStyle(color: Colors.indigo, fontSize: 14))]),
                    Row(children: [Text(word.myn, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)), const SizedBox(width: 16), IconButton(onPressed: () => _removeWord(word.id), icon: const Icon(Icons.delete_outline, color: Colors.grey))])
                  ]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}