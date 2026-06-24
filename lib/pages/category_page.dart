import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chin/data/vocab_data.dart';
import 'package:chin/data/unit_group.dart';
import 'package:chin/widgets/three_d_button.dart';
import 'package:chin/theme/app_colors.dart';
import 'package:chin/theme/app_dimensions.dart';
import 'study_page.dart';

class CategoryPage extends StatefulWidget {
  final UnitGroup group;
  const CategoryPage({super.key, required this.group});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Map<String, int> unitScores = {};

  @override
  void initState() {
    super.initState();
    _loadScores();
  }

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

  void _enterUnit(BuildContext context, String unitTitle, List<Word> unitWords) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudyPage(
          unitTitle: unitTitle,
          wordList: unitWords,
          themeColor: widget.group.color,
          groupTitle: widget.group.title,
        ),
      ),
    ).then((_) {
      _loadScores();
    });
  }

  @override
  Widget build(BuildContext context) {
    final allWords = getFullVocabulary();
    final groupWords = allWords.where((w) => w.id >= widget.group.startId && w.id <= widget.group.endId).toList();

    int availableUnitsCount = (groupWords.length / 10).floor();
    int displayCount = min(availableUnitsCount, widget.group.subUnits.length);

    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? AppColors.textDark;

    return Scaffold(
      body: Column(
        children: [
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
                  borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
                  child: const Padding(padding: AppDimensions.paddingXs, child: Icon(Icons.arrow_back_ios, color: Colors.white)),
                ),
                Expanded(child: Text(widget.group.title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          Expanded(
            child: displayCount == 0
                ? const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.construction, size: 80, color: Colors.grey), SizedBox(height: 16), Text("Coming Soon", style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold))]))
                : ListView.separated(
                    padding: AppDimensions.paddingXl,
                    itemCount: displayCount,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      int start = index * 10;
                      int end = start + 10;
                      final unitWords = groupWords.sublist(start, end);
                      String unitTitle = "UNIT ${index + 1}";
                      String subTitle = widget.group.subUnits[index];
                      int? score = unitScores[unitTitle];

                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
                          boxShadow: [BoxShadow(color: widget.group.color.withOpacity(0.2), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: ThreeDButton(
                          onPressed: () => _enterUnit(context, unitTitle, unitWords),
                          borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
                          child: Container(
                            decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(AppDimensions.radiusXl)),
                            child: Padding(
                              padding: AppDimensions.paddingSm,
                              child: Row(
                                children: [
                                  Container(
                                    width: 64, height: 64,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [widget.group.color, widget.group.color.withOpacity(0.7)]),
                                      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                                      boxShadow: [BoxShadow(color: widget.group.color.withOpacity(0.3), offset: const Offset(2, 2), blurRadius: 4)],
                                    ),
                                    child: Icon(widget.group.icon, size: 32, color: Colors.white),
                                  ),
                                  const SizedBox(width: 16),
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
                                  if (score != null)
                                    Container(
                                      margin: const EdgeInsets.only(left: 8),
                                      child: score == 10
                                          ? const Icon(Icons.check_circle, color: Colors.green, size: 32)
                                          : Text("$score/10", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey.shade400)),
                                    ),
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
