import 'package:flutter/material.dart';

class AppColors {
  static const ink = Color(0xFF070D19);
  static const inkSoft = Color(0xFF0B1220);
  static const surface = Color(0xFF111B2E);
  static const surfaceElevated = Color(0xFF16233B);
  static const mint = Color(0xFF6EE7B7);
  static const sky = Color(0xFF7DD3FC);
  static const amber = Color(0xFFFBBF77);
  static const violet = Color(0xFFC4B5FD);
  static const text = Color(0xFFF8FAFC);
  static const textMuted = Color(0xFF9FB0C9);
  static const border = Color(0xFF23324D);
  static const borderHover = Color(0xFF3E567E);
}

class AppTheme {
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.ink,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.mint,
        brightness: Brightness.dark,
        surface: AppColors.surface,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.mint,
        selectionColor: AppColors.mint.withValues(alpha: 0.25),
        selectionHandleColor: AppColors.mint,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surfaceElevated,
        contentTextStyle: const TextStyle(
          color: AppColors.text,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: AppColors.borderHover),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 58,
          fontWeight: FontWeight.w800,
          height: 1.04,
          letterSpacing: -2.2,
          color: AppColors.text,
        ),
        headlineMedium: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w700,
          height: 1.14,
          letterSpacing: -0.9,
          color: AppColors.text,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          height: 1.25,
          color: AppColors.text,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.3,
          color: AppColors.text,
        ),
        bodyLarge: TextStyle(
          fontSize: 17,
          height: 1.6,
          color: AppColors.textMuted,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.5,
          height: 1.55,
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}
