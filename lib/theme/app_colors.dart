import 'package:flutter/material.dart';

class AppColors {
  // Brand
  static const Color primary = Color(0xFF667eea);
  static const Color primaryDark = Color(0xFF764ba2);

  // Semantic
  static const Color success = Color(0xFF38ef7d);
  static const Color error = Color(0xFFF5576C);
  static const Color accent = Color(0xFFff9a9e);

  // Text
  static const Color textDark = Color(0xFF1E293B);
  static const Color textMedium = Color(0xFF334155);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color textLightOnDark = Color(0xFFF1F5F9);
  static const Color textMediumOnDark = Color(0xFFCBD5E1);

  // Surface / Background
  static const Color scaffoldLight = Color(0xFFF5F7FA);
  static const Color scaffoldDark = Color(0xFF111827);
  static const Color cardDark = Color(0xFF1F2937);
  static const Color quizBackground = Color(0xFF0F172A);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Colors.white, Color(0xFFF8F9FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    colors: [Color(0xFF2D3748), Color(0xFF1A202C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
