import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_my.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('my'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Chin Chin Chinese'**
  String get appName;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'For Myanmar Learners'**
  String get appSubtitle;

  /// No description provided for @navCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get navCategories;

  /// Number of sub-topics in a category
  ///
  /// In en, this message translates to:
  /// **'{count} Topics'**
  String topicsCount(int count);

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'ပြင်ဆင်မှုများ'**
  String get settingsSubtitle;

  /// No description provided for @voiceVolume.
  ///
  /// In en, this message translates to:
  /// **'Voice Volume'**
  String get voiceVolume;

  /// No description provided for @voiceVolumeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'အသံ အတိုးအကျယ်'**
  String get voiceVolumeSubtitle;

  /// No description provided for @soundEffects.
  ///
  /// In en, this message translates to:
  /// **'Sound Effects'**
  String get soundEffects;

  /// No description provided for @soundEffectsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'အသံ အထူးပြုလုပ်ချက်'**
  String get soundEffectsSubtitle;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @darkModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'အမှောင်စနစ်'**
  String get darkModeSubtitle;

  /// No description provided for @watchTutorial.
  ///
  /// In en, this message translates to:
  /// **'Watch Tutorial'**
  String get watchTutorial;

  /// No description provided for @watchTutorialSubtitle.
  ///
  /// In en, this message translates to:
  /// **'လမ်းညွှန် ကြည့်ရန်'**
  String get watchTutorialSubtitle;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @aboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'အကြောင်းအရာ'**
  String get aboutSubtitle;

  /// No description provided for @btnClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get btnClose;

  /// No description provided for @aboutAppVersion.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get aboutAppVersion;

  /// No description provided for @aboutDeveloper.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get aboutDeveloper;

  /// No description provided for @aboutTranslation.
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get aboutTranslation;

  /// No description provided for @aboutLicense.
  ///
  /// In en, this message translates to:
  /// **'• Code: MIT License\n• Assets: CC BY-NC-ND 4.0\n© 2025 All Rights Reserved.'**
  String get aboutLicense;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsConditions;

  /// No description provided for @tutorialStep1.
  ///
  /// In en, this message translates to:
  /// **'1. Click a unit icon to start learning.\nသင်ခန်းစာပုံကို နှိပ်ပြီး စတင်လေ့လာပါ။'**
  String get tutorialStep1;

  /// No description provided for @tutorialStep2.
  ///
  /// In en, this message translates to:
  /// **'2. Take quizzes & Star words to save.\nပဟေဠိဖြေပါ၊ မသိသော စကားလုံးများကို Star နှိပ်ပြီး မှတ်သားပါ။'**
  String get tutorialStep2;

  /// No description provided for @tutorialStep3.
  ///
  /// In en, this message translates to:
  /// **'3. Collect 10+ words to unlock review quiz!\nစကားလုံး ၁၀ လုံးကျော်ပါက ပြန်လည်လေ့ကျင့်နိုင်ပါပြီ။'**
  String get tutorialStep3;

  /// No description provided for @btnNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get btnNext;

  /// No description provided for @btnStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get btnStart;

  /// No description provided for @studyMode.
  ///
  /// In en, this message translates to:
  /// **'STUDY MODE'**
  String get studyMode;

  /// No description provided for @listenBefore.
  ///
  /// In en, this message translates to:
  /// **'Click '**
  String get listenBefore;

  /// No description provided for @listenAfter.
  ///
  /// In en, this message translates to:
  /// **' to listen / နားထောင်ရန်နှိပ်ပါ'**
  String get listenAfter;

  /// No description provided for @btnStartQuiz.
  ///
  /// In en, this message translates to:
  /// **'Start Quiz'**
  String get btnStartQuiz;

  /// No description provided for @quizComplete.
  ///
  /// In en, this message translates to:
  /// **'Quiz Complete!'**
  String get quizComplete;

  /// No description provided for @accuracyScore.
  ///
  /// In en, this message translates to:
  /// **'ACCURACY SCORE'**
  String get accuracyScore;

  /// No description provided for @reviewAnswers.
  ///
  /// In en, this message translates to:
  /// **'Review Answers'**
  String get reviewAnswers;

  /// No description provided for @answerPrefix.
  ///
  /// In en, this message translates to:
  /// **'Ans: '**
  String get answerPrefix;

  /// No description provided for @btnHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get btnHome;

  /// No description provided for @btnStudyAgain.
  ///
  /// In en, this message translates to:
  /// **'Study Again'**
  String get btnStudyAgain;

  /// No description provided for @myVocabulary.
  ///
  /// In en, this message translates to:
  /// **'My Vocabulary'**
  String get myVocabulary;

  /// No description provided for @savedWords.
  ///
  /// In en, this message translates to:
  /// **'Saved Words'**
  String get savedWords;

  /// No description provided for @myVocabQuiz.
  ///
  /// In en, this message translates to:
  /// **'My Vocab Quiz'**
  String get myVocabQuiz;

  /// No description provided for @btnQuiz10.
  ///
  /// In en, this message translates to:
  /// **'Quiz (10)'**
  String get btnQuiz10;

  /// No description provided for @unlockQuizHint.
  ///
  /// In en, this message translates to:
  /// **'Save 10+ words to unlock quiz!'**
  String get unlockQuizHint;

  /// No description provided for @noWordsYet.
  ///
  /// In en, this message translates to:
  /// **'No words yet.'**
  String get noWordsYet;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get comingSoon;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'my'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'my':
      return AppLocalizationsMy();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
