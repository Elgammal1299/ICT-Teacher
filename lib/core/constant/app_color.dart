import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // Private constructor

  /// -------- Base Color --------
  static const Color primary = Color(0xFF1565C0); // الأزرق الإسلامي الرئيسي
  // static const Color primary2 = Colors.teal;
  static const Color red = Color(0xFFE53935);

  /// -------- Supporting Colors --------
  static const Color secondary = Color(0xFF4FC3F7);
  static const Color accent = Color(0xFFFF7043); // لون ذهبي دافئ (مكمل راقي)

  /// -------- Backgrounds --------
  static const Color background = Color(0xFFF8F9FA);
  static const Color cardBackground = Color(0xFFFFFFFF); // أبيض ناصع (للبطاقات)
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  /// -------- Text Colors --------
  static const Color textPrimary = Color(0xFF1E2D2F); // رمادي غامق مائل للأزرق
  static const Color textSecondary = Color(0xFF6B7B7C); // رمادي هادي

  /// -------- Border/Divider --------
  static const Color divider = Color(0xFFE0E0E0); // رمادي فاتح

  /// -------- Status Colors --------
  static const Color success = Color(0xFF4CAF50); // أخضر للإشعارات الإيجابية
  static const Color error = Color(0xFFE53935); // أحمر للأخطاء
  static const Color warningColor = Color(0xFFFF9800);

  /// -------- Dark Theme Colors --------
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkCardBackground = Color(0xFF1E1E1E);
  static const Color darkPrimary = Color(0xFFE0E0E0);
  static const Color darkTextPrimary = Color(0xFFE1E1E1);
  static const Color darkTextSecondary = Color(0xFFAAAAAA);
  static const Color darkDivider = Color(0xFF2C2C2C);
}
