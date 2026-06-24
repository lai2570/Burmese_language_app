import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chin/data/vocab_data.dart';
import 'package:chin/core/global_settings.dart';
import 'package:chin/widgets/three_d_button.dart';
import 'study_page.dart';

class ResultPage extends StatefulWidget {
  final List<Map<String, dynamic>> results;
  final String unitName;
  final List<Word> originalWords;
  final String? groupTitle;

  const ResultPage({
    super.key,
    required this.results,
    required this.unitName,
    required this.originalWords,
    this.groupTitle,
  });

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
    _playResultSound();
    _saveScore();
  }

  Future<void> _saveScore() async {
    if (widget.groupTitle != null) {
      int correctCount = widget.results.where((r) => r['isCorrect'] as bool).length;
      int total = widget.results.length;
      int scoreOnTen = ((correctCount / total) * 10).round();
      final prefs = await SharedPreferences.getInstance();
      String key = 'score_${widget.groupTitle}_${widget.unitName}';
      await prefs.setInt(key, scoreOnTen);
    }
  }

  @override
  void dispose() {
    _resultAudioPlayer.dispose();
    super.dispose();
  }

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
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(32), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))]),
                  child: Column(children: [const Icon(Icons.emoji_events, size: 60, color: Color(0xFF764ba2)), const SizedBox(height: 16), Text("Quiz Complete!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: textColor)), Text(widget.unitName, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)), const SizedBox(height: 16), Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [Text("$percentage", style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w900, color: Color(0xFF667eea))), const Text("%", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey))]), const Text("ACCURACY SCORE", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey))]),
                ),
                const SizedBox(height: 24),
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
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24), color: cardColor,
            child: Row(children: [
              Expanded(
                child: ThreeDButton(
                  onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(padding: const EdgeInsets.symmetric(vertical: 16), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(16)), alignment: Alignment.center, child: const Text("Home", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ThreeDButton(
                  onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StudyPage(
                    unitTitle: widget.unitName,
                    wordList: widget.originalWords,
                    themeColor: const Color(0xFF667eea),
                    groupTitle: widget.groupTitle ?? "",
                  ))),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(padding: const EdgeInsets.symmetric(vertical: 16), decoration: BoxDecoration(color: const Color(0xFF667eea), borderRadius: BorderRadius.circular(16)), alignment: Alignment.center, child: const Text("Study Again", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
