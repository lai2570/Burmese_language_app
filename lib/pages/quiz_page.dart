import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:chin/data/vocab_data.dart';
import 'package:chin/core/global_settings.dart';
import 'package:chin/widgets/three_d_button.dart';
import 'package:chin/theme/app_colors.dart';
import 'package:chin/theme/app_durations.dart';
import 'result_page.dart';

class QuizPage extends StatefulWidget {
  final List<Word> words;
  final String unitName;
  final String? groupTitle;

  const QuizPage({super.key, required this.words, required this.unitName, this.groupTitle});
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  late List<Map<String, dynamic>> quizQueue;
  int currentIndex = 0;
  List<Map<String, dynamic>> results = [];
  late AnimationController _timerController;
  int timerSeconds = 5;
  final AudioPlayer _audioPlayer = AudioPlayer();

  int? _selectedOptionIndex;
  bool _isAnswerProcessing = false;
  bool? _isLastCorrect;

  @override
  void initState() {
    super.initState();
    _prepareQuiz();
    _timerController = AnimationController(vsync: this, duration: AppDurations.quizTimer);
    _timerController.reverse(from: 1.0);
    _timerController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) _handleAnswer(null);
    });
    _timerController.addListener(() {
      setState(() {
        timerSeconds = (_timerController.value * 5).ceil();
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playCurrentWordAudio();
    });
  }

  Future<void> _playCurrentWordAudio() async {
    if (currentIndex < quizQueue.length) {
      final word = quizQueue[currentIndex]['word'] as Word;
      try {
        await _audioPlayer.stop();
        await _audioPlayer.play(AssetSource('audio/${word.audioZH}'), volume: GlobalSettings.voiceVolume);
      } catch (e) {
        debugPrint("Quiz audio error: $e");
      }
    }
  }

  void _prepareQuiz() {
    final random = Random();
    final allWords = getFullVocabulary();
    List<Word> shuffledWords = List.from(widget.words)..shuffle();
    quizQueue = shuffledWords.map((word) {
      Word distractor;
      if (allWords.length <= 1) {
        distractor = Word(id: -1, zh: "錯誤", pinyin: "cuò", myn: "Wrong", sentenceZH: "", sentencePINYIN: "", sentenceMYN: "", audioZH: "");
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

  Future<void> _handleAnswer(int? index) async {
    if (_isAnswerProcessing) return;
    _timerController.stop();

    final currentQ = quizQueue[currentIndex];
    final word = currentQ['word'] as Word;
    final options = currentQ['options'] as List<String>;
    final correctIndex = currentQ['correctIndex'] as int;

    bool isTimeout = index == null;
    bool isCorrect = !isTimeout && index == correctIndex;

    if (!isTimeout) {
      setState(() {
        _isAnswerProcessing = true;
        _selectedOptionIndex = index;
        _isLastCorrect = isCorrect;
      });
      await Future.delayed(AppDurations.shortDelay);
    }

    results.add({
      'word': word,
      'isCorrect': isCorrect,
      'isTimeout': isTimeout,
      'correctAnswer': word.myn,
      'userAnswer': isTimeout ? 'Timeout' : options[index]
    });

    if (currentIndex < 9 && currentIndex < quizQueue.length - 1) {
      setState(() {
        currentIndex++;
        _selectedOptionIndex = null;
        _isAnswerProcessing = false;
        _isLastCorrect = null;
        _timerController.duration = AppDurations.quizTimer;
        _timerController.reverse(from: 1.0);
      });
      _playCurrentWordAudio();
    } else {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ResultPage(
            results: results,
            unitName: widget.unitName,
            originalWords: widget.words,
            groupTitle: widget.groupTitle,
          )),
        );
      }
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
      backgroundColor: AppColors.quizBackground,
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(value: (currentIndex) / totalQuestions, backgroundColor: Colors.white10, color: AppColors.success, minHeight: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                ThreeDButton(onPressed: () => Navigator.pop(context), borderRadius: BorderRadius.circular(20), child: const Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.close, color: Colors.grey))),
                Text("${currentIndex + 1} / $totalQuestions", style: const TextStyle(color: Colors.grey, fontSize: 16, fontFamily: 'monospace')),
                const SizedBox(width: 48),
              ]),
            ),
            Stack(alignment: Alignment.center, children: [
              SizedBox(width: 60, height: 60, child: CircularProgressIndicator(value: _timerController.value, strokeWidth: 4, color: Colors.white, backgroundColor: Colors.white24)),
              Text("$timerSeconds", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            ]),
            Expanded(
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  ThreeDButton(
                    onPressed: _playCurrentWordAudio,
                    borderRadius: BorderRadius.circular(20),
                    child: Text(word.zh, style: const TextStyle(color: Colors.white, fontSize: 64, fontWeight: FontWeight.w900)),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(word.pinyin, style: const TextStyle(color: AppColors.primary, fontSize: 24, fontWeight: FontWeight.w500)),
                      const SizedBox(width: 10),
                      ThreeDButton(
                        onPressed: _playCurrentWordAudio,
                        borderRadius: BorderRadius.circular(20),
                        child: const Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.volume_up, color: Colors.white70)),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: List.generate(2, (idx) {
                  Color btnColor = Colors.white;
                  Color textColor = AppColors.quizBackground;
                  if (_isAnswerProcessing && _selectedOptionIndex == idx) {
                    if (_isLastCorrect == true) {
                      btnColor = AppColors.success;
                      textColor = Colors.white;
                    } else {
                      btnColor = AppColors.error;
                      textColor = Colors.white;
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ThreeDButton(
                      onPressed: () => _handleAnswer(idx),
                      borderRadius: BorderRadius.circular(16),
                      child: AnimatedContainer(
                        duration: AppDurations.answerReveal,
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(color: btnColor, borderRadius: BorderRadius.circular(16)),
                        alignment: Alignment.center,
                        child: Text(options[idx], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor)),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
