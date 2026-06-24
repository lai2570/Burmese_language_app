// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Chin Chin Chinese';

  @override
  String get appSubtitle => 'For Myanmar Learners';

  @override
  String get navCategories => 'Categories';

  @override
  String topicsCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString Topics';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSubtitle => 'ပြင်ဆင်မှုများ';

  @override
  String get voiceVolume => 'Voice Volume';

  @override
  String get voiceVolumeSubtitle => 'အသံ အတိုးအကျယ်';

  @override
  String get soundEffects => 'Sound Effects';

  @override
  String get soundEffectsSubtitle => 'အသံ အထူးပြုလုပ်ချက်';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get darkModeSubtitle => 'အမှောင်စနစ်';

  @override
  String get watchTutorial => 'Watch Tutorial';

  @override
  String get watchTutorialSubtitle => 'လမ်းညွှန် ကြည့်ရန်';

  @override
  String get about => 'About';

  @override
  String get aboutSubtitle => 'အကြောင်းအရာ';

  @override
  String get btnClose => 'Close';

  @override
  String get aboutAppVersion => 'Version 1.0.0';

  @override
  String get aboutDeveloper => 'Developer';

  @override
  String get aboutTranslation => 'Translation';

  @override
  String get aboutLicense =>
      '• Code: MIT License\n• Assets: CC BY-NC-ND 4.0\n© 2025 All Rights Reserved.';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsConditions => 'Terms & Conditions';

  @override
  String get tutorialStep1 =>
      '1. Click a unit icon to start learning.\nသင်ခန်းစာပုံကို နှိပ်ပြီး စတင်လေ့လာပါ။';

  @override
  String get tutorialStep2 =>
      '2. Take quizzes & Star words to save.\nပဟေဠိဖြေပါ၊ မသိသော စကားလုံးများကို Star နှိပ်ပြီး မှတ်သားပါ။';

  @override
  String get tutorialStep3 =>
      '3. Collect 10+ words to unlock review quiz!\nစကားလုံး ၁၀ လုံးကျော်ပါက ပြန်လည်လေ့ကျင့်နိုင်ပါပြီ။';

  @override
  String get btnNext => 'Next';

  @override
  String get btnStart => 'Start';

  @override
  String get studyMode => 'STUDY MODE';

  @override
  String get listenBefore => 'Click ';

  @override
  String get listenAfter => ' to listen / နားထောင်ရန်နှိပ်ပါ';

  @override
  String get btnStartQuiz => 'Start Quiz';

  @override
  String get quizComplete => 'Quiz Complete!';

  @override
  String get accuracyScore => 'ACCURACY SCORE';

  @override
  String get reviewAnswers => 'Review Answers';

  @override
  String get answerPrefix => 'Ans: ';

  @override
  String get btnHome => 'Home';

  @override
  String get btnStudyAgain => 'Study Again';

  @override
  String get myVocabulary => 'My Vocabulary';

  @override
  String get savedWords => 'Saved Words';

  @override
  String get myVocabQuiz => 'My Vocab Quiz';

  @override
  String get btnQuiz10 => 'Quiz (10)';

  @override
  String get unlockQuizHint => 'Save 10+ words to unlock quiz!';

  @override
  String get noWordsYet => 'No words yet.';

  @override
  String get comingSoon => 'Coming Soon';
}
