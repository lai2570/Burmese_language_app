Work Chinese (Myanmar Edition)

A professional vocabulary learning application specifically designed to help Myanmar speakers master workplace Chinese.

📱 Overview

Work Chinese is a Flutter-based mobile application that helps users learn essential Chinese vocabulary for various industries, including offices, factories, restaurants, and salons. The app is designed with a "Dual License" strategy to foster open-source learning while protecting the creators' specific intellectual property.

Key Features:

Industry-Specific Units: Structured curriculum covering School, Office, Factory, Restaurant, and Salon scenarios.

Bilingual Interface: Full support for Traditional Chinese and Myanmar (Burmese) languages.

Audio Pronunciation: High-quality audio integration for correct pronunciation learning.

Smart Quiz System: Interactive 10-question quizzes with instant feedback.

Personal Vocabulary Book: Save difficult words and generate custom quizzes for review.

⚖️ Licensing (Dual License Model)

This project operates under a strictly defined dual-license model. Please read carefully before using or forking this repository.

1. Source Code - MIT License 🟢

The underlying software logic, UI widgets, and application architecture (Dart files excluding data) are licensed under the MIT License.

You are free to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software logic.

2. Creative Assets - CC BY-NC-ND 4.0 🔴

The specific educational content, including but not limited to:

Vocabulary Lists (Chinese-Myanmar pairs)

Example Sentences

Audio Recordings (.mp3 files)

Curriculum Structure

...are licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0) license.

What this means for you:

✅ You CAN: Download and use the app for personal learning.

✅ You CAN: Study the code to learn Flutter development.

❌ You CANNOT: Extract the audio/text data to build a competing product.

❌ You CANNOT: Modify the translations or audio and redistribute them without permission.

❌ You CANNOT: Sell the content or the app containing this specific content.

🏗️ Project Structure

The project follows a standard cross-platform Flutter architecture:

/Burmese_language_app
├── /android           # Android native build configuration
├── /ios               # iOS native build configuration (Xcode project)
├── /lib               # Main Dart source code
│   ├── /data          # Vocabulary data models (Protected Content)
│   └── main.dart      # Application entry point & logic
├── /assets            # Static resources
│   ├── /audio         # Audio files (Protected Content)
│   └── /icons         # App icons
├── pubspec.yaml       # Dependencies & asset declaration
└── README.md          # This documentation


Why are /android and /ios folders separate?

Flutter renders its own UI, but it relies on the native operating system "shells" to run.

/android: Contains the Gradle build scripts and Kotlin/Java code to generate the .apk or .aab file.

/ios: Contains the Runner project and CocoaPods configuration required to build the .ipa file for iPhones.

👥 Credits

Lead Developer: YUNG-TSAI LAI (賴泳在)

Language Specialist: ChinQing in Taiwan

© 2025 YUNG-TSAI LAI. All Rights Reserved.