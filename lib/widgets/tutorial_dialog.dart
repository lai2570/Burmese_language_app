import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_durations.dart';
import '../theme/app_dimensions.dart';
import 'three_d_button.dart';

class TutorialDialog extends StatefulWidget {
  const TutorialDialog({super.key});
  @override
  State<TutorialDialog> createState() => _TutorialDialogState();
}

class _TutorialDialogState extends State<TutorialDialog> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final List<Map<String, dynamic>> steps = [
      {"icon": Icons.category, "color": AppColors.primary, "text": l10n.tutorialStep1},
      {"icon": Icons.star, "color": Colors.amber, "text": l10n.tutorialStep2},
      {"icon": Icons.menu_book, "color": AppColors.accent, "text": l10n.tutorialStep3},
    ];
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusXl)),
      backgroundColor: Colors.transparent,
      child: Container(
        height: 420,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(AppDimensions.radiusXl)),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) => setState(() => _currentPage = page),
                itemCount: steps.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: AppDimensions.paddingXl,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: AppDimensions.paddingLg,
                          decoration: BoxDecoration(color: steps[index]['color'].withOpacity(0.1), shape: BoxShape.circle),
                          child: Icon(steps[index]['icon'], size: 60, color: steps[index]['color']),
                        ),
                        const SizedBox(height: 24),
                        Text(steps[index]['text'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.5, color: Colors.black87)),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: AppDimensions.paddingLg,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(steps.length, (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8, height: 8,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: _currentPage == index ? AppColors.primary : Colors.grey.shade300),
                    )),
                  ),
                  ThreeDButton(
                    onPressed: () {
                      if (_currentPage < steps.length - 1) {
                        _pageController.nextPage(duration: AppDurations.pageTransition, curve: Curves.ease);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(AppDimensions.radiusLg)),
                      child: Text(_currentPage == steps.length - 1 ? l10n.btnStart : l10n.btnNext, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
