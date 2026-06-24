import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chin/data/unit_group.dart';
import 'package:chin/widgets/three_d_button.dart';
import 'package:chin/widgets/tutorial_dialog.dart';
import 'package:chin/widgets/settings_dialog.dart';
import 'package:chin/theme/app_colors.dart';
import 'package:chin/theme/app_durations.dart';
import 'vocab_book_page.dart';
import 'category_page.dart';

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
    _animationController = AnimationController(vsync: this, duration: AppDurations.listAnimation);
    _animationController.forward();

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

  void _showSettings() {
    showDialog(context: context, builder: (context) => const SettingsDialog());
  }

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
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))],
          ),
          child: Icon(icon, color: color, size: 24),
        ),
      ),
    );
  }

  Widget _buildGroupCard(BuildContext context, UnitGroup group) {
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? AppColors.textDark;
    const double iconSize = 64;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(2, 2))],
      ),
      child: ThreeDButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage(group: group))),
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(24)),
          child: Row(
            children: [
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(group.title, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: group.color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                      child: Text("${group.subUnits.length} Topics", style: TextStyle(color: group.color, fontSize: 12, fontWeight: FontWeight.w600)),
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
          Container(
            padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 32),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
              boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
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
                    Row(
                      children: [
                        _buildFlatHeaderIcon(icon: Icons.settings, color: AppColors.primary, onTap: _showSettings),
                        const SizedBox(width: 12),
                        _buildFlatHeaderIcon(icon: Icons.menu_book, color: AppColors.accent, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const VocabBookPage()))),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
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
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: appUnitGroups.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
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
