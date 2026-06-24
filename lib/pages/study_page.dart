import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chin/data/vocab_data.dart';
import 'package:chin/core/global_settings.dart';
import 'package:chin/widgets/three_d_button.dart';
import 'quiz_page.dart';

class StudyPage extends StatefulWidget {
  final String unitTitle;
  final List<Word> wordList;
  final Color themeColor;
  final String groupTitle;

  const StudyPage({
    super.key,
    required this.unitTitle,
    required this.wordList,
    this.themeColor = const Color(0xFF667eea),
    required this.groupTitle,
  });

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  List<int> savedIds = [];
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
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
      await _audioPlayer.play(AssetSource('audio/$fileName'), volume: GlobalSettings.voiceVolume);
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
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black87;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Column(
        children: [
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
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
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
                                ]),
                                Padding(padding: const EdgeInsets.only(left: 20, top: 4), child: Text(word.pinyin, style: TextStyle(color: widget.themeColor, fontSize: 16, fontWeight: FontWeight.w500))),
                              ],
                            ),
                          ),
                          ThreeDButton(
                            onPressed: () => _toggleSave(word.id),
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(isSaved ? Icons.star : Icons.star_border, color: isSaved ? Colors.amber : Colors.grey.shade300, size: 28),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Padding(padding: const EdgeInsets.only(left: 20), child: Text(word.myn, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor))),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.black26 : const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(12),
                          border: Border(left: BorderSide(color: widget.themeColor.withOpacity(0.5), width: 4)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSentence(word.sentenceZH, true, widget.themeColor, textColor),
                            const SizedBox(height: 4),
                            _buildSentence(word.sentencePINYIN, false, widget.themeColor, Colors.grey),
                            const SizedBox(height: 8),
                            _buildSentence(word.sentenceMYN, false, widget.themeColor, textColor),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: cardColor, border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.1)))),
            child: ThreeDButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuizPage(
                words: widget.wordList,
                unitName: widget.unitTitle,
                groupTitle: widget.groupTitle,
              ))),
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
          ),
        ],
      ),
    );
  }

  Widget _buildSentence(String sentence, bool isZh, Color highlightColor, Color baseColor) {
    List<String> parts = sentence.split('**');
    return RichText(
      text: TextSpan(
        style: TextStyle(color: baseColor.withOpacity(isZh ? 0.8 : 1.0), fontSize: 15, height: 1.4, fontFamily: 'Roboto'),
        children: parts.asMap().entries.map((entry) {
          int idx = entry.key; String text = entry.value; bool isBold = idx % 2 == 1;
          if (isBold) return TextSpan(text: text, style: TextStyle(fontWeight: FontWeight.w900, color: isZh ? highlightColor : baseColor));
          return TextSpan(text: text, style: null);
        }).toList(),
      ),
    );
  }
}
