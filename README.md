# Chin Chin Chinese (Myanmar Edition)

**A professional, gamified vocabulary learning application specifically designed to help Myanmar speakers master workplace Chinese.**

![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-2.17%2B-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-Dual-red)

## 📱 Overview

**Chin Chin Chinese** is a cross-platform Flutter application tailored for Myanmar learners. It combines high-quality educational content with a gamified user experience, featuring 3D button interactions, immersive audio feedback, and industry-specific vocabulary.

The app is built with a **"Dual License" strategy** to foster open-source learning for the code structure while strictly protecting the creators' specific educational intellectual property (audio, translations, and curriculum).

---

## ✨ Key Features

### 🎓 Comprehensive Curriculum
Structured learning covering **15+ industry scenarios** tailored for migrant workers and students:
* **Life & Basics:** School, Weather, Sports, Food, Festivals.
* **Workplace:** Office, Factory, Recruitment, Documents, Job Titles.
* **Service Industry:** Restaurant, Salon.
* **Specialized:** Customs (Airport), ARC (Immigration), Hospital (Medical), Majors.

### 🛠️ Rich Learning Modes
* **Bilingual Interface:** Full support for Traditional Chinese (Traditional) and Myanmar (Burmese).
* **Study Mode:**
    * Native audio pronunciation for every word.
    * Pinyin support.
    * **Bilingual Example Sentences:** Contextual learning with bold keyword highlighting.
* **Smart Quiz System:**
    * Fast-paced 5-second timer challenge per question.
    * Randomized distractors to ensure true learning.
    * Instant audio feedback (Pass/Fail sounds).
    * Accuracy score calculation.

### 🎨 Immersive UX/UI
* **3D Tactile Buttons:** Custom-built buttons with depress animations and sound effects.
* **Theme Customization:**
    * **Dark Mode / Light Mode** support (Auto-save preference).
    * Dynamic gradient backgrounds.
* **Video Splash Screen:** High-quality intro video on startup.
* **Settings Hub:** Adjustable Voice Volume and Sound Effects (SFX) volume.

### ⭐ Personalization
* **Vocabulary Book:** "Star" difficult words to save them to your personal list.
* **Review Mode:** Unlock a custom "My Vocab Quiz" once you collect 10+ words.
* **Onboarding:** Visual tutorial for first-time users.

---

## ⚖️ Licensing (Dual License Model)

This project operates under a strictly defined dual-license model. **Please read carefully before using or forking this repository.**

### 1. Source Code - MIT License 🟢
The underlying software logic, UI widgets (e.g., `ThreeDButton`, `GlobalSettings`), and application architecture are licensed under the **MIT License**.

> ✅ You are free to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the **Software logic**.

### 2. Creative Assets - CC BY-NC-ND 4.0 🔴
The specific educational content, including but not limited to:
* **Vocabulary Data** (Chinese-Myanmar pairs in `vocab_data.dart`)
* **Example Sentences**
* **Audio Recordings** (`.mp3` files)
* **Curriculum Structure**

...are licensed under the **Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)** license.

**What this means for you:**
* ✅ **You CAN:** Download and use the app for personal learning.
* ✅ **You CAN:** Study the code to learn Flutter development.
* ❌ **You CANNOT:** Extract the audio/text data to build a competing product.
* ❌ **You CANNOT:** Modify the translations or audio and redistribute them without permission.
* ❌ **You CANNOT:** Sell the content or the app containing this specific content.

---

## 🏗️ Tech Stack & Architecture

The project follows a modular Flutter architecture:

* **Framework:** Flutter & Dart
* **State Management:** `ValueNotifier` (for Themes), `setState` (Local UI state)
* **Local Storage:** `shared_preferences` (Persisting Dark Mode, Volume, Saved Words, Tutorial status)
* **Media:**
    * `audioplayers`: For pronunciation and SFX.
    * `video_player`: For the intro splash screen.

### Folder Structure
```text
/Burmese_language_app
├── /android           # Android native build config
├── /ios               # iOS native build config
├── /lib               # Main Dart source code
│   ├── /data          # Vocabulary data models (Protected Content)
│   └── main.dart      # Application entry point & UI Logic
├── /assets            # Static resources
│   ├── /audio         # Audio files (Protected Content)
│   ├── /icons         # App icons
│   └── intro.mp4      # Splash video
└── pubspec.yaml       # Dependencies


## 🚀 Getting Started

Since this repository includes the necessary assets, you can run the app directly:

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/your-username/chin-chin-chinese.git](https://github.com/your-username/chin-chin-chinese.git)
    ```
2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Run the app:**
    ```bash
    flutter run
    ```

*Note: While the source code is MIT licensed, please remember that the audio files and vocabulary data included in this repository are under **CC BY-NC-ND 4.0**. You may use them for personal study/development, but do not extract or redistribute them for commercial purposes.*