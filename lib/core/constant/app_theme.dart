import 'package:flutter/material.dart';
import 'package:icd_teacher/core/constant/app_color.dart';

class AppTheme {
  AppTheme._(); // Private constructor

  // ============================================
  // MODERN EDUCATIONAL THEME
  // ============================================
  // Professionally designed for optimal learning experience
  // Features: High contrast, clean design, accessible colors
  // ============================================

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    canvasColor: AppColors.black,
    primaryColor: AppColors.primary,
    cardColor: AppColors.cardBackground,
    dividerColor: AppColors.divider,
    fontFamily: 'Cairo',
    secondaryHeaderColor: AppColors.secondarySuccess,
    hintColor: AppColors.textTertiary,
    primaryColorDark: AppColors.primaryDark,
    // splashColor: AppColors.primaryLight.withValues(alpha: 0.1),
    // highlightColor: AppColors.primaryLight.withValues(alpha: 0.05),
    useMaterial3: true,

    // AppBar Theme - Modern elevated design
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(fontFamily: 'IBMPlexSansArabic', fontSize: 20),
      iconTheme: IconThemeData(color: AppColors.backgroundSecondary),
    ),

    // Card Theme - Clean with subtle shadow
    cardTheme: CardThemeData(
      color: AppColors.cardBackground,
      elevation: 2,
      shadowColor: AppColors.shadowLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),
    // Slider Theme - Modern interactive design
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.primary,
      inactiveTrackColor: AppColors.border,
      thumbColor: AppColors.primary,
      overlayColor: AppColors.primary.withValues(alpha: 0.15),
      trackHeight: 4,
      valueIndicatorColor: AppColors.primary,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
    ),

    // Input Decoration Theme - Clean and accessible
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

      // Label styling
      labelStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14),
      floatingLabelStyle: TextStyle(color: AppColors.primary, fontSize: 14),
      hintStyle: TextStyle(color: AppColors.textTertiary, fontSize: 14),

      // Border styling - Modern with rounded corners
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.border, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.border, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.error, width: 2),
      ),
      errorStyle: TextStyle(color: AppColors.error, fontSize: 12),
    ),

    // Elevated Button Theme - Modern with gradient-ready design
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 2,
        shadowColor: AppColors.shadowMedium,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          inherit: true,
          fontFamily: 'Cairo',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        textStyle: const TextStyle(
          inherit: true,
          fontFamily: 'Cairo',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          inherit: true,
          fontFamily: 'Cairo',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    // Text Theme - Clear hierarchy and readability
    textTheme: TextTheme(
      // Display styles - For large headers
      displayLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        height: 1.2,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        height: 1.2,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        height: 1.2,
      ),

      // Headline styles - For section headers
      headlineLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),

      // Title styles - For card titles, list titles
      titleLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.5,
        color: AppColors.textPrimary,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      ),

      // Body styles - For regular content
      bodyLarge: TextStyle(
        fontFamily: 'IBMPlexSansArabic',
        fontSize: 16,
        color: AppColors.textPrimary,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'IBMPlexSansArabic',
        fontSize: 14,
        color: AppColors.textPrimary,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        fontFamily: 'IBMPlexSansArabic',
        fontSize: 12,
        color: AppColors.textSecondary,
        height: 1.4,
      ),

      // Label styles - For buttons, tabs
      labelLarge: TextStyle(
        fontFamily: 'IBMPlexSansArabic',
        color: AppColors.textPrimary,
        // fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        fontFamily: 'IBMPlexSansArabic',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      labelSmall: TextStyle(
        fontFamily: 'IBMPlexSansArabic',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
    ),

    // Icon Theme - Consistent sizing
    iconTheme: IconThemeData(color: AppColors.textPrimary, size: 24),

    // Bottom Navigation Bar Theme - Modern and clean

    // Floating Action Button Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textOnPrimary,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      // backgroundColor: AppColors.primarySurface,
      selectedColor: AppColors.primary,
      labelStyle: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 13,
        color: AppColors.textPrimary,
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),

    // Dialog Theme
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.cardBackground,
      elevation: 8,
      shadowColor: AppColors.shadowMedium,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      contentTextStyle: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 14,
        color: AppColors.textSecondary,
        height: 1.5,
      ),
    ),

    // Snackbar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.textPrimary,
      contentTextStyle: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 14,
        color: AppColors.white,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
    ),

    // Color Scheme - Modern educational palette
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    canvasColor: AppColors.white,

    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.primaryDark,
    cardColor: AppColors.darkCardBackground,
    dividerColor: AppColors.darkDivider,
    fontFamily: 'Cairo',

    secondaryHeaderColor: AppColors.secondarySuccess,
    hintColor: AppColors.textTertiaryDark,
    primaryColorDark: AppColors.primaryDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryDark,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'IBMPlexSansArabic',
        fontSize: 20,
        color: AppColors.black,
      ),
      iconTheme: IconThemeData(color: AppColors.black),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.secondarySuccess,
      floatingLabelStyle: const TextStyle(color: AppColors.black),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      labelStyle: const TextStyle(color: AppColors.primary),
      hintStyle: const TextStyle(color: AppColors.primary),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.red, width: 2),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.white,
        elevation: 2,
        shadowColor: AppColors.shadowMedium,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          inherit: true,
          fontFamily: 'Cairo',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryDark,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        textStyle: const TextStyle(
          inherit: true,
          fontFamily: 'Cairo',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.white,
        side: const BorderSide(color: AppColors.primaryDark, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          inherit: true,
          fontFamily: 'Cairo',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        inherit: true,
        color: AppColors.darkTextPrimary,
        fontSize: 16,
        fontFamily: 'IBMPlexSansArabic',
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        inherit: true,
        color: AppColors.darkTextSecondary,
        fontSize: 14,
        fontFamily: 'IBMPlexSansArabic',
        height: 1.5,
      ),
      bodySmall: TextStyle(
        inherit: true,
        color: AppColors.textSecondary,
        fontSize: 14,
        fontFamily: 'IBMPlexSansArabic',
        height: 1.5,
      ),
      titleMedium: TextStyle(
        inherit: true,
        color: AppColors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      titleLarge: TextStyle(
        inherit: true,
        color: AppColors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      labelLarge: TextStyle(
        inherit: true,
        fontFamily: "IBMPlexSansArabic",
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: AppColors.white,
      ),
    ),

    iconTheme: const IconThemeData(color: AppColors.accent),
  );
}
