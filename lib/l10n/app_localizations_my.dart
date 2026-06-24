// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get appName => 'Chin Chin Chinese';

  @override
  String get appSubtitle => 'မြန်မာလေ့လာသူများအတွက်';

  @override
  String get navCategories => 'အမျိုးအစားများ';

  @override
  String topicsCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString ခေါင်းစဉ်';
  }

  @override
  String get settingsTitle => 'ပြင်ဆင်မှုများ';

  @override
  String get settingsSubtitle => 'Settings';

  @override
  String get voiceVolume => 'အသံ အတိုးအကျယ်';

  @override
  String get voiceVolumeSubtitle => 'Voice Volume';

  @override
  String get soundEffects => 'အသံ အထူးပြုလုပ်ချက်';

  @override
  String get soundEffectsSubtitle => 'Sound Effects';

  @override
  String get darkMode => 'အမှောင်စနစ်';

  @override
  String get darkModeSubtitle => 'Dark Mode';

  @override
  String get watchTutorial => 'လမ်းညွှန် ကြည့်ရန်';

  @override
  String get watchTutorialSubtitle => 'Watch Tutorial';

  @override
  String get about => 'အကြောင်းအရာ';

  @override
  String get aboutSubtitle => 'About';

  @override
  String get btnClose => 'ပိတ်မည်';

  @override
  String get aboutAppVersion => 'ဗားရှင်း 1.0.0';

  @override
  String get aboutDeveloper => 'ဆော့ဖ်ဝဲ ဖန်တီးသူ';

  @override
  String get aboutTranslation => 'ဘာသာပြန်';

  @override
  String get aboutLicense =>
      '• Code: MIT License\n• Assets: CC BY-NC-ND 4.0\n© 2025 All Rights Reserved.';

  @override
  String get privacyPolicy => 'ကိုယ်ရေးကာကွယ်မှုမူဝါဒ';

  @override
  String get termsConditions => 'စည်းကမ်းချက်များ';

  @override
  String get tutorialStep1 =>
      '1. ယူနစ်ပုံကို နှိပ်ပြီး လေ့လာပါ။\nသင်ခန်းစာပုံကို နှိပ်ပြီး စတင်လေ့လာပါ။';

  @override
  String get tutorialStep2 =>
      '2. ပဟေဠိဖြေပါ၊ Star နှိပ်ပြီး မှတ်သားပါ။\nTake quizzes & Star words to save.';

  @override
  String get tutorialStep3 =>
      '3. စကားလုံး ၁၀ လုံးကျော်ပါက ပြန်လည်လေ့ကျင့်နိုင်ပါပြီ။\nCollect 10+ words to unlock review quiz!';

  @override
  String get btnNext => 'ရှေ့ဆက်';

  @override
  String get btnStart => 'စတင်';

  @override
  String get studyMode => 'လေ့လာမှုစနစ်';

  @override
  String get listenBefore => 'နှိပ်ပါ ';

  @override
  String get listenAfter => ' နားထောင်ရန်';

  @override
  String get btnStartQuiz => 'ပဟေဠိ စတင်';

  @override
  String get quizComplete => 'ပဟေဠိ ပြီးဆုံးပြီ!';

  @override
  String get accuracyScore => 'မှန်ကန်မှုရာခိုင်နှုန်း';

  @override
  String get reviewAnswers => 'အဖြေများ ပြန်ကြည့်';

  @override
  String get answerPrefix => 'အဖြေ: ';

  @override
  String get btnHome => 'ပင်မစာမျက်နှာ';

  @override
  String get btnStudyAgain => 'ထပ်လေ့လာ';

  @override
  String get myVocabulary => 'ကျွန်ုပ်၏ဝေါဟာရ';

  @override
  String get savedWords => 'သိမ်းဆည်းထားသော စကားလုံး';

  @override
  String get myVocabQuiz => 'ကျွန်ုပ်ဝေါဟာရ ပဟေဠိ';

  @override
  String get btnQuiz10 => 'ပဟေဠိ (၁၀)';

  @override
  String get unlockQuizHint => 'ပဟေဠိဖြေရန် စကားလုံး ၁၀ လုံးသိမ်းပါ!';

  @override
  String get noWordsYet => 'မသိမ်းရသေးပါ။';

  @override
  String get comingSoon => 'မကြာမီ ရောက်မည်';
}
