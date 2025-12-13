import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/gestures.dart';

// 匯入資料檔 (請確認您的檔案路徑正確)
import 'data/vocab_data.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Work Chinese (Myanmar)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF1F5F9),
        fontFamily: 'Roboto', 
        useMaterial3: true,
      ),
      // 強制鎖定文字縮放比例為 1.0 (解決大螢幕跑版問題)
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
      home: const HomePage(),
    );
  }
}

// --- 資料結構：單元分類 (改為 ID 區間控制) ---
class UnitGroup {
  final String title;
  final IconData icon;
  // 移除 startIndex，改用 ID 區間來過濾
  final int startId; 
  final int endId;   
  final List<String> subUnits; 

  const UnitGroup({
    required this.title,
    required this.icon,
    required this.startId,
    required this.endId,
    required this.subUnits,
  });
}

// 定義所有單元分類 (根據 vocab_data.dart 的 ID 規則設定)
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
    startId: 1801, endId: 1200,
    subUnits: ["Customs (အကောက်ခွန်)", "Airport (လေဆိပ်)"]
  ),
  UnitGroup(title: "ARC (အေအာစီ)", icon: Icons.card_membership, startId: 2001, endId: 2100,subUnits: ["ARC (အေအာစီ)"]),
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
  UnitGroup(title: "Weather (ရာသီဥတု)", icon: Icons.wb_sunny, startId: 2501, endId: 2600, subUnits: ["Weather (ရာသီဥတု)"]),
  UnitGroup(
    title: "Hospital (ဆေးရုံ)", 
    icon: Icons.local_hospital, 
    startId: 2601, endId: 2700, 
    subUnits: ["Medical Care(ဆေးကုသမှု)","Symptoms(ရောဂါလက္ခဏာများ)","Clinics(ဆေးခန်းနှင့် ဌာနများ)"]),

  UnitGroup(title: "Sports (အားကစား)", icon: Icons.sports_soccer, startId: 2701, endId: 2800, subUnits: ["Sports (အားကစား)"]),
  UnitGroup(title: "Food (အစားအစာ)", icon: Icons.fastfood, startId: 2801, endId: 2900, subUnits: ["Food (အစားအစာ)"]),
  UnitGroup(title: "Festivals (ပွဲတော်များ)", icon: Icons.celebration, startId: 2901, endId: 3000, subUnits: ["Festivals (ပွဲတော်များ)"]),
  UnitGroup(title: "Document (စာရွက်စာတမ်း)", icon: Icons.description, startId: 3001, endId: 3100, subUnits: ["Document (စာရွက်စာတမ်း)"]),
];

// --- HomePage (第一層：顯示大分類) ---
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  // 顯示關於資訊
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
                title: const Text('Work Chinese'),
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
          // Header
          Container(
            padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 24),
            decoration: const BoxDecoration(
              color: Color(0xFF0F172A),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                        Text("Work Chinese", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        Text("For Myanmar Learners", style: TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
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
          // Categories List
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

  Widget _buildGroupCard(BuildContext context, UnitGroup group) {
    return GestureDetector(
      onTap: () {
        // 進入 CategoryPage，由它負責過濾與切割單字
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
                  // 不再顯示 Topics 數量，避免誤導，或者可以顯示 "Tap to view units"
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

// --- CategoryPage (第二層：邏輯重寫核心) ---
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
              int end = start + 10; // 因為前面已經 floor 過了，所以這裡絕對安全
              final unitWords = groupWords.sublist(start, end);

              // 顯示標題
              String unitTitle = "UNIT ${index + 1}";
              String subTitle = group.subUnits[index];

              return GestureDetector(
                onTap: () {
                  // 6. 直接傳遞切好的單字列表 (List<Word>) 給 StudyPage
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

// --- StudyPage (接收 List<Word> 而非 Index) ---
class StudyPage extends StatefulWidget {
  final String unitTitle;
  final List<Word> wordList;

  const StudyPage({
    super.key, 
    required this.unitTitle, 
    required this.wordList
  });

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  // 不再需要 studyList 變數，直接用 widget.wordList
  List<int> savedIds = [];
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    // 這裡不需要再 getUnitWords 了，因為資料是從上一頁傳進來的
    _loadSavedWords();
  }
  
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playAudio(String fileName) async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource('audio/$fileName'));
    } catch (e) {
      debugPrint("播放失敗: $e");
    }
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
           Container(
             margin: const EdgeInsets.all(16), padding: const EdgeInsets.all(12),
             decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
             child: const Row(children: [Icon(Icons.volume_up, color: Colors.indigo, size: 18), SizedBox(width: 8), Expanded(child: Text("Click bold words to listen / စာလုံးမည်းကိုနှိပ်ပါ", style: TextStyle(color: Colors.indigo, fontSize: 13)))]),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => _playAudio(word.audioZH),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [                        
                              Text("${index + 1}. ", style: const TextStyle(color: Colors.grey, fontFamily: 'monospace')), 
                              Text(word.zh, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, decoration: TextDecoration.underline, decorationStyle: TextDecorationStyle.dotted, decorationColor: Colors.indigoAccent))
                            ]), Padding(padding: const EdgeInsets.only(left: 20), child: Text(word.pinyin, style: const TextStyle(color: Colors.indigo, fontSize: 16, fontWeight: FontWeight.w500)))]),
                          ),
                          IconButton(onPressed: () => _toggleSave(word.id), icon: Icon(isSaved ? Icons.star : Icons.star_border, color: isSaved ? Colors.amber : Colors.grey.shade300, size: 28))
                        ],
                      ),
                      const SizedBox(height: 12),
                      Padding(padding: const EdgeInsets.only(left: 20), child: Text(word.myn, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87))),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(12), border: Border(left: BorderSide(color: Colors.indigo.shade200, width: 4))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, 
                          children: [
                            _buildSentence(word.sentenceZH, true, word.audioZH), 
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
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade100))),
            child: SizedBox(width: double.infinity, 
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => QuizPage(
                    words: currentList, // 傳入當前列表
                    unitName: widget.unitTitle // 傳入標題
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

  Widget _buildSentence(String sentence, bool isZh, String? audioFileName) {
    List<String> parts = sentence.split('**');
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.grey.shade700, fontSize: 15, height: 1.4, fontFamily: 'Roboto'),
        children: parts.asMap().entries.map((entry) {
          int idx = entry.key; 
          String text = entry.value; 
          bool isBold = idx % 2 == 1;
          
          if (isBold && isZh && audioFileName != null) {
            return TextSpan(
              text: text,
              style: TextStyle(fontWeight: FontWeight.w900, color: Colors.indigo, backgroundColor: Colors.indigo.shade50),
              recognizer: TapGestureRecognizer()..onTap = () {
                _playAudio(audioFileName);
              },
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

// --- QuizPage  ---
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
  late AnimationController _timerController;
  int timerSeconds = 5;

  @override
  void initState() {
    super.initState();
    _prepareQuiz();
    _timerController = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _timerController.reverse(from: 1.0);
    _timerController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) _handleAnswer(null);
    });
    _timerController.addListener(() {
      setState(() { timerSeconds = (_timerController.value * 5).ceil(); });
    });
  }

  void _prepareQuiz() {
    final random = Random();
    final allWords = getFullVocabulary(); 

    quizQueue = widget.words.map((word) {
      Word distractor;
      if (allWords.length <= 1) {
         distractor = Word(id: -1, zh: "錯誤", pinyin: "cuò", myn: "Wrong", sentenceZH: "", sentenceMYN: "", audioZH: "");
      } else {
        do {
          distractor = allWords[random.nextInt(allWords.length)];
        } while (distractor.myn == word.myn);
      }

      bool correctIsTop = random.nextBool();
      return {
        'word': word,
        'options': correctIsTop ? [word.myn, distractor.myn] : [distractor.myn, word.myn],
        'correctIndex': correctIsTop ? 0 : 1
      };
    }).toList();
  }

  void _handleAnswer(int? index) {
    _timerController.stop();
    final currentQ = quizQueue[currentIndex];
    final word = currentQ['word'] as Word;
    final options = currentQ['options'] as List<String>;
    final correctIndex = currentQ['correctIndex'] as int;
    
    bool isTimeout = index == null;
    bool isCorrect = !isTimeout && index == correctIndex;
    
    results.add({'word': word, 'isCorrect': isCorrect, 'isTimeout': isTimeout, 'correctAnswer': word.myn, 'userAnswer': isTimeout ? 'Timeout' : options[index]});

    if (currentIndex < 9 && currentIndex < quizQueue.length - 1) { // 防呆：確保不超過題目數量
      setState(() {
        currentIndex++;
        _timerController.duration = const Duration(seconds: 5);
        _timerController.reverse(from: 1.0);
      });
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ResultPage(results: results, unitName: widget.unitName, originalWords: widget.words)));
    }
  }

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (quizQueue.isEmpty || currentIndex >= quizQueue.length) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    final currentQ = quizQueue[currentIndex];
    final word = currentQ['word'] as Word;
    final options = currentQ['options'] as List<String>;
    
    // 總題數可能會少於10題(如果單元字數少)
    final totalQuestions = quizQueue.length;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(value: (currentIndex) / totalQuestions, backgroundColor: Colors.white10, color: Colors.green, minHeight: 6),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [IconButton(icon: const Icon(Icons.close, color: Colors.grey), onPressed: () => Navigator.pop(context)), Text("${currentIndex + 1} / $totalQuestions", style: const TextStyle(color: Colors.grey, fontSize: 16, fontFamily: 'monospace')), const IconButton(icon: Icon(Icons.star_border, color: Colors.grey), onPressed: null)])),
            Stack(alignment: Alignment.center, children: [SizedBox(width: 60, height: 60, child: CircularProgressIndicator(value: _timerController.value, strokeWidth: 4, color: Colors.white, backgroundColor: Colors.white24)), Text("$timerSeconds", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))]),
            Expanded(child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text(word.zh, style: const TextStyle(color: Colors.white, fontSize: 64, fontWeight: FontWeight.w900)), const SizedBox(height: 12), Text(word.pinyin, style: const TextStyle(color: Colors.indigoAccent, fontSize: 24, fontWeight: FontWeight.w500))]))),
            Padding(padding: const EdgeInsets.all(24.0), child: Column(children: List.generate(2, (idx) => Padding(padding: const EdgeInsets.only(bottom: 16), child: SizedBox(width: double.infinity, height: 80, child: ElevatedButton(onPressed: () => _handleAnswer(idx), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF0F172A), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 0), child: Text(options[idx], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))))))))
          ],
        ),
      ),
    );
  }
}

// --- ResultPage ---
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
    // 避免除以零
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
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))], border: Border.all(color: Colors.white)),
                  child: Column(children: [const Icon(Icons.emoji_events, size: 60, color: Colors.indigo), const SizedBox(height: 16), const Text("Quiz Complete!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)), Text(widget.unitName, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)), const SizedBox(height: 16), Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [Text("$percentage", style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w900, color: Colors.indigo)), const Text("%", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey))]), const Text("ACCURACY SCORE", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey))]),
                ),
                const SizedBox(height: 24),
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
                  // 這裡修改：重新學習時，直接將原本的單字列表 (widget.originalWords) 傳回去 StudyPage
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

// --- VocabBookPage (我的單字本) ---
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

  Future<void> _loadSavedWords() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIds = (prefs.getStringList('savedWords') ?? []).map(int.parse).toList();
    final allWords = getFullVocabulary();
    
    setState(() {
      savedWords = allWords.where((w) => savedIds.contains(w.id)).toList();
      isLoading = false;
    });
  }

  Future<void> _removeWord(int id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedIdStrings = (prefs.getStringList('savedWords') ?? []);
    savedIdStrings.remove(id.toString());
    await prefs.setStringList('savedWords', savedIdStrings);
    _loadSavedWords(); 
  }

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
          if (savedWords.length < 10) Container(width: double.infinity, padding: const EdgeInsets.all(8), color: Colors.orange.shade50, child: const Text("Save 10+ words to unlock quiz!", textAlign: TextAlign.center, style: TextStyle(color: Colors.orange, fontSize: 12))),
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