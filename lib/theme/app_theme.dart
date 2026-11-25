import 'package:flutter/material.dart';

class EditorialPalette extends ThemeExtension<EditorialPalette> {
  const EditorialPalette({
    required this.canvas,
    required this.surface,
    required this.surfaceCrisp,
    required this.ink,
    required this.inkMuted,
    required this.hairline,
    required this.borderStrong,
    required this.accent,
    required this.onAccent,
    required this.invertedBg,
    required this.invertedInk,
    required this.invertedMuted,
    required this.invertedBorder,
  });

  final Color canvas;
  final Color surface;
  final Color surfaceCrisp;
  final Color ink;
  final Color inkMuted;
  final Color hairline;
  final Color borderStrong;
  final Color accent;
  final Color onAccent;
  final Color invertedBg;
  final Color invertedInk;
  final Color invertedMuted;
  final Color invertedBorder;

  static const light = EditorialPalette(
    canvas: Color(0xFFF7F4EE),
    surface: Color(0xFFEFEAE0),
    surfaceCrisp: Color(0xFFFFFFFF),
    ink: Color(0xFF171614),
    inkMuted: Color(0xFF524D46),
    hairline: Color(0xFFD8D1C5),
    borderStrong: Color(0xFF7D756A),
    accent: Color(0xFFB83B0A),
    onAccent: Color(0xFFFFFFFF),
    invertedBg: Color(0xFF171614),
    invertedInk: Color(0xFFF7F4EE),
    invertedMuted: Color(0xFFC9C2B6),
    invertedBorder: Color(0xFF3E3A34),
  );

  static const dark = EditorialPalette(
    canvas: Color(0xFF151412),
    surface: Color(0xFF1F1D1A),
    surfaceCrisp: Color(0xFF292622),
    ink: Color(0xFFF3EFE7),
    inkMuted: Color(0xFFB8B0A4),
    hairline: Color(0xFF332F2A),
    borderStrong: Color(0xFF8E867B),
    accent: Color(0xFFF07847),
    onAccent: Color(0xFF151412),
    invertedBg: Color(0xFF1F1D1A),
    invertedInk: Color(0xFFF3EFE7),
    invertedMuted: Color(0xFFB8B0A4),
    invertedBorder: Color(0xFF47423B),
  );

  static EditorialPalette of(BuildContext context) {
    return Theme.of(context).extension<EditorialPalette>() ?? light;
  }

  @override
  EditorialPalette copyWith({
    Color? canvas,
    Color? surface,
    Color? surfaceCrisp,
    Color? ink,
    Color? inkMuted,
    Color? hairline,
    Color? borderStrong,
    Color? accent,
    Color? onAccent,
    Color? invertedBg,
    Color? invertedInk,
    Color? invertedMuted,
    Color? invertedBorder,
  }) {
    return EditorialPalette(
      canvas: canvas ?? this.canvas,
      surface: surface ?? this.surface,
      surfaceCrisp: surfaceCrisp ?? this.surfaceCrisp,
      ink: ink ?? this.ink,
      inkMuted: inkMuted ?? this.inkMuted,
      hairline: hairline ?? this.hairline,
      borderStrong: borderStrong ?? this.borderStrong,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      invertedBg: invertedBg ?? this.invertedBg,
      invertedInk: invertedInk ?? this.invertedInk,
      invertedMuted: invertedMuted ?? this.invertedMuted,
      invertedBorder: invertedBorder ?? this.invertedBorder,
    );
  }

  @override
  EditorialPalette lerp(ThemeExtension<EditorialPalette>? other, double t) {
    if (other is! EditorialPalette) return this;
    return EditorialPalette(
      canvas: Color.lerp(canvas, other.canvas, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceCrisp: Color.lerp(surfaceCrisp, other.surfaceCrisp, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      inkMuted: Color.lerp(inkMuted, other.inkMuted, t)!,
      hairline: Color.lerp(hairline, other.hairline, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      invertedBg: Color.lerp(invertedBg, other.invertedBg, t)!,
      invertedInk: Color.lerp(invertedInk, other.invertedInk, t)!,
      invertedMuted: Color.lerp(invertedMuted, other.invertedMuted, t)!,
      invertedBorder: Color.lerp(invertedBorder, other.invertedBorder, t)!,
    );
  }
}

class AppTheme {
  static const displayFont = 'Newsreader';
  static const bodyFont = 'IBMPlexSans';

  static ThemeData light() => _build(EditorialPalette.light, Brightness.light);
  static ThemeData dark() => _build(EditorialPalette.dark, Brightness.dark);

  static ThemeData _build(EditorialPalette palette, Brightness brightness) {
    final baseScheme = ColorScheme(
      brightness: brightness,
      primary: palette.accent,
      onPrimary: palette.onAccent,
      secondary: palette.ink,
      onSecondary: palette.canvas,
      error: const Color(0xFFB91C1C),
      onError: Colors.white,
      surface: palette.surface,
      onSurface: palette.ink,
      outline: palette.borderStrong,
      outlineVariant: palette.hairline,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: bodyFont,
      scaffoldBackgroundColor: palette.canvas,
      colorScheme: baseScheme,
      extensions: [palette],
      dividerColor: palette.hairline,
      focusColor: palette.accent.withValues(alpha: 0.22),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: palette.accent,
        selectionColor: palette.accent.withValues(alpha: 0.2),
        selectionHandleColor: palette.accent,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: palette.invertedBg,
        contentTextStyle: TextStyle(
          fontFamily: bodyFont,
          color: palette.invertedInk,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: palette.invertedBorder),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(44, 46)),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return Color.alphaBlend(
                Colors.black.withValues(alpha: 0.14),
                palette.accent,
              );
            }
            if (states.contains(WidgetState.hovered)) {
              return Color.alphaBlend(
                Colors.black.withValues(alpha: 0.08),
                palette.accent,
              );
            }
            return palette.accent;
          }),
          foregroundColor: WidgetStatePropertyAll(palette.onAccent),
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return BorderSide(color: palette.ink, width: 2);
            }
            return BorderSide.none;
          }),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(
              fontFamily: bodyFont,
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(44, 46)),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          foregroundColor: WidgetStatePropertyAll(palette.ink),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return palette.ink.withValues(alpha: 0.1);
            }
            if (states.contains(WidgetState.hovered)) {
              return palette.ink.withValues(alpha: 0.05);
            }
            return Colors.transparent;
          }),
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return BorderSide(color: palette.accent, width: 2);
            }
            if (states.contains(WidgetState.hovered)) {
              return BorderSide(color: palette.ink, width: 1.2);
            }
            return BorderSide(color: palette.borderStrong);
          }),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(
              fontFamily: bodyFont,
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(44, 44)),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.focused)) {
              return palette.accent;
            }
            return palette.ink;
          }),
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return BorderSide(color: palette.accent, width: 2);
            }
            return BorderSide.none;
          }),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(
              fontFamily: bodyFont,
              fontSize: 14.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: displayFont,
          fontSize: 52,
          fontWeight: FontWeight.w500,
          height: 1.08,
          letterSpacing: -1.1,
          color: palette.ink,
        ),
        headlineMedium: TextStyle(
          fontFamily: displayFont,
          fontSize: 34,
          fontWeight: FontWeight.w500,
          height: 1.16,
          letterSpacing: -0.6,
          color: palette.ink,
        ),
        titleLarge: TextStyle(
          fontFamily: displayFont,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          height: 1.22,
          letterSpacing: -0.3,
          color: palette.ink,
        ),
        titleMedium: TextStyle(
          fontFamily: bodyFont,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.35,
          color: palette.ink,
        ),
        bodyLarge: TextStyle(
          fontFamily: bodyFont,
          fontSize: 17,
          height: 1.62,
          color: palette.inkMuted,
        ),
        bodyMedium: TextStyle(
          fontFamily: bodyFont,
          fontSize: 15,
          height: 1.6,
          color: palette.inkMuted,
        ),
        labelLarge: TextStyle(
          fontFamily: bodyFont,
          fontSize: 13.5,
          fontWeight: FontWeight.w600,
          color: palette.ink,
        ),
      ),
    );
  }
}
