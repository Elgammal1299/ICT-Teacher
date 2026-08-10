import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // Private constructor

  static const Color primary = Color(0xFF2563EB);
  static const Color primarySurface = Color(0xFF60A5FA);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color secondarySuccess = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color quizIncorrectBorder = Color(0xFFF87171);
  static const Color quizIncorrectBg = Color(0xFFFEE2E2);
  static const Color accent = Color(0xFFF59E0B);
  static const Color accentLight = Color(0xFFFBBF24);
  static const Color success = Color(0xFF10B981);
 static const Color textPrimary = Color(
    0xFF111827,
  ); 
  static const Color textSecondary = Color(
    0xFF6B7280,
  );
  static const Color textTertiary = Color(0xFF9CA3AF); // Light gray for hints


  /// -------- Dark Theme Colors --------

  static const Color primaryDark = Color(0xFF3B82F6);
  static const Color primarySurfaceDark = Color(0xFF1D4ED8);

  static const Color cardBackgroundDark = Color(0xFF1E293B);

  static const Color secondaryDark = Color(0xFF34D399);

  static const Color errorDark = Color(0xFFF87171);

  static const Color quizIncorrectBorderDark = Color(0xFFFCA5A5);
  static const Color quizIncorrectBgDark = Color(0xFF450A0A);

  static const Color accenDarkt = Color(0xFFFBBF24);
  static const Color accentLightDark = Color(0xFFFCD34D);

  static const Color successDark = Color(0xFF34D399);
  static const Color textPrimaryDark = Color(
  0xFFF8FAFC,
);

static const Color textSecondaryDark = Color(
  0xFF94A3B8,
);
static const Color textTertiaryDark = Color(
  0xFF64748B,
);
  /// -------- Accent Colors (Engagement & Energy) --------

  // Accent color - Warm orange for energy & motivation
  // Light Amber
  static const Color accentDark = Color(0xFFD97706); // Dark Amber
  static const Color accentSurface = Color(0xFFFEF3C7); // Light amber surface

  /// -------- Status Colors (Feedback & Results) --------

  // Success - Bright green for correct answers
  // Emerald (same as secondary)
  static const Color successLight = Color(0xFF6EE7B7); // Very light green
  // static const Color successDark = Color(0xFF047857); // Deep green
  static const Color successBg = Color(0xFFD1FAE5); // Success background

  // Error - Vibrant red for incorrect answers
  // Modern Red
  static const Color errorLight = Color(0xFFF87171); // Light red
  // static const Color errorDark = Color(0xFFDC2626); // Dark red
  static const Color errorBg = Color(0xFFFEE2E2); // Error background

  // Warning - Orange for attention
  static const Color warningColor = Color(0xFFF59E0B); // Amber (same as accent)
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);
  static const Color warningBg = Color(0xFFFEF3C7);

  // Info - Blue for information
  static const Color info = Color(0xFF3B82F6); // Blue

  static const Color infoDark = Color(0xFF2563EB);
  static const Color infoBg = Color(0xFFDBEAFE);

  /// -------- Backgrounds (Clean & Professional) --------

  static const Color background = Color(0xFFF5F5F5); // Very light gray
  static const Color backgroundSecondary = Color(0xFFF3F4F6); // Light gray
  // Pure white for cards
  static const Color surfaceElevated = Color(
    0xFFFFFFFF,
  ); // White with elevation
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  /// -------- Text Colors (Readable & Clear) --------

  // Medium gray for secondary
  static const Color textDisabled = Color(
    0xFFD1D5DB,
  ); // Very light gray for disabled
  static const Color textOnPrimary = Color(0xFFFFFFFF); // White text on primary
  static const Color textOnDark = Color(
    0xFFFFFFFF,
  ); // White text on dark backgrounds

  /// -------- Border & Divider (Subtle Separation) --------

  static const Color border = Color(0xFFE5E7EB); // Light gray border
  static const Color borderLight = Color(0xFFF3F4F6); // Very light border
  static const Color borderDark = Color(0xFFD1D5DB); // Medium gray border
  static const Color divider = Color(0xFFE5E7EB); // Same as border

  /// -------- Quiz & Learning Specific Colors --------

  // Correct answer styling
  static const Color quizCorrect = Color(0xFF10B981); // Emerald green
  static const Color quizCorrectBg = Color(
    0xFFD1FAE5,
  ); // Light green background

  // Incorrect answer styling
  static const Color quizIncorrect = Color(0xFFEF4444); // Red
  // Light red background
  // Red border

  // Neutral/unselected styling
  static const Color quizNeutral = Color(0xFFF3F4F6); // Light gray
  static const Color quizNeutralBorder = Color(0xFFE5E7EB); // Gray border

  // Selected but not submitted
  static const Color quizSelected = Color(0xFFEEF2FF); // Light indigo
  static const Color quizSelectedBorder = Color(0xFF818CF8); // Indigo border

  /// -------- Legacy Color Mappings (for backward compatibility) --------

  static const Color red = Color(0xFFEF4444); // Maps to new error
  static const Color red2 = Color(0x1AEF4444); // Transparent red
  static const Color grey = Color(0xFF6B7280); // Maps to textSecondary
  static const Color colorUnSelected = Color(
    0xFFEEF2FF,
  ); // Maps to primarySurface
  static const Color green = Color(0xFF10B981); // Maps to success

  /// -------- Dark Theme Colors --------

  static const Color darkBackground = Color(0xFF111827); // Dark gray
  static const Color darkBackgroundSecondary = Color(0xFF1F2937); // Medium dark
  static const Color darkCardBackground = Color(0xFF1F2937); // Card background
  static const Color darkSurface = Color(0xFF374151); // Surface color
  static const Color darkPrimary = Color(0xFF818CF8); // Light indigo
  static const Color darkSecondary = Color(0xFF34D399); // Light emerald
  static const Color darkTextPrimary = Color(0xFFF9FAFB); // Near white
  static const Color darkTextSecondary = Color(0xFFD1D5DB); // Light gray
  static const Color darkTextTertiary = Color(0xFF9CA3AF); // Medium gray
  static const Color darkBorder = Color(0xFF374151); // Dark border
  static const Color darkDivider = Color(0xFF374151); // Dark divider

  /// -------- Gradient Definitions --------

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF818CF8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF34D399)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient errorGradient = LinearGradient(
    colors: [Color(0xFFEF4444), Color(0xFFF87171)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFFBBF24)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// -------- Shadow Colors --------

  static const Color shadowLight = Color(0x0A000000); // 4% black
  static const Color shadowMedium = Color(0x14000000); // 8% black
  static const Color shadowDark = Color(0x29000000); // 16% black
}
