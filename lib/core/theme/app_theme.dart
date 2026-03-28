import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────
//  iBuild Design System — Cores e Tipografia
// ─────────────────────────────────────────────

class IBuildColors {
  IBuildColors._();

  // Marca
  static const primary     = Color(0xFFA51C30); // vermelho iBuild
  static const primaryDark = Color(0xFF7A1424);
  static const primaryLight= Color(0xFFF8E8EA);

  // Neutros
  static const black       = Color(0xFF111111);
  static const gray900     = Color(0xFF1C1C1E);
  static const gray700     = Color(0xFF3A3A3C);
  static const gray500     = Color(0xFF636366);
  static const gray300     = Color(0xFFAEAEB2);
  static const gray100     = Color(0xFFF2F2F7);
  static const white       = Color(0xFFFFFFFF);

  // Semânticas
  static const success     = Color(0xFF34C759);
  static const warning     = Color(0xFFFF9F0A);
  static const error       = Color(0xFFFF3B30);
  static const info        = Color(0xFF007AFF);

  // Status de apontamento
  static const pendente    = Color(0xFFFF9F0A);
  static const sincronizado= Color(0xFF34C759);
  static const reprovado   = Color(0xFFFF3B30);
  static const rascunho    = Color(0xFFAEAEB2);

  // Campo (fundo de telas de campo - mais escuro para uso ao sol)
  static const fieldBg     = Color(0xFF1C1C1E);
  static const fieldCard   = Color(0xFF2C2C2E);
  static const fieldText   = Color(0xFFFFFFFF);
}

class IBuildTheme {
  IBuildTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: IBuildColors.primary,
        brightness: Brightness.light,
      ).copyWith(
        primary:    IBuildColors.primary,
        onPrimary:  IBuildColors.white,
        surface:    IBuildColors.white,
        onSurface:  IBuildColors.black,
        error:      IBuildColors.error,
      ),
    );

    return base.copyWith(
      scaffoldBackgroundColor: IBuildColors.gray100,
      textTheme: _textTheme(Brightness.light),
      appBarTheme: _appBarTheme(),
      cardTheme: _cardTheme(),
      inputDecorationTheme: _inputTheme(),
      elevatedButtonTheme: _elevatedButtonTheme(),
      outlinedButtonTheme: _outlinedButtonTheme(),
      bottomNavigationBarTheme: _bottomNavTheme(Brightness.light),
      chipTheme: _chipTheme(),
    );
  }

  static ThemeData get dark {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: IBuildColors.primary,
        brightness: Brightness.dark,
      ).copyWith(
        primary:    IBuildColors.primary,
        onPrimary:  IBuildColors.white,
        surface:    IBuildColors.fieldCard,
        onSurface:  IBuildColors.white,
        error:      IBuildColors.error,
      ),
    );

    return base.copyWith(
      scaffoldBackgroundColor: IBuildColors.fieldBg,
      textTheme: _textTheme(Brightness.dark),
      appBarTheme: _appBarTheme(dark: true),
      cardTheme: _cardTheme(dark: true),
      inputDecorationTheme: _inputTheme(dark: true),
      elevatedButtonTheme: _elevatedButtonTheme(),
      outlinedButtonTheme: _outlinedButtonTheme(dark: true),
      bottomNavigationBarTheme: _bottomNavTheme(Brightness.dark),
      chipTheme: _chipTheme(dark: true),
    );
  }

  // ── Tipografia ──────────────────────────────
  static TextTheme _textTheme(Brightness brightness) {
    final color = brightness == Brightness.light
        ? IBuildColors.black
        : IBuildColors.white;

    return GoogleFonts.interTextTheme().copyWith(
      displayLarge:  GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w700, color: color),
      displayMedium: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w600, color: color),
      headlineLarge: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, color: color),
      headlineMedium:GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w500, color: color),
      titleLarge:    GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: color),
      titleMedium:   GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: color),
      bodyLarge:     GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, color: color),
      bodyMedium:    GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: color),
      bodySmall:     GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400,
                       color: color.withOpacity(0.6)),
      labelLarge:    GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: color),
      labelSmall:    GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500,
                       color: color.withOpacity(0.6),
                       letterSpacing: 0.5),
    );
  }

  // ── AppBar ──────────────────────────────────
  static AppBarTheme _appBarTheme({bool dark = false}) => AppBarTheme(
    backgroundColor: dark ? IBuildColors.fieldCard : IBuildColors.white,
    foregroundColor: dark ? IBuildColors.white : IBuildColors.black,
    elevation: 0,
    centerTitle: false,
    titleTextStyle: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: dark ? IBuildColors.white : IBuildColors.black,
    ),
    iconTheme: IconThemeData(
      color: dark ? IBuildColors.white : IBuildColors.gray700,
    ),
    actionsIconTheme: IconThemeData(
      color: dark ? IBuildColors.white : IBuildColors.primary,
    ),
  );

  // ── Cards ───────────────────────────────────
  static CardTheme _cardTheme({bool dark = false}) => CardTheme(
    color: dark ? IBuildColors.fieldCard : IBuildColors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: dark
            ? IBuildColors.gray700.withOpacity(0.3)
            : IBuildColors.gray100,
        width: 1,
      ),
    ),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
  );

  // ── Inputs ──────────────────────────────────
  static InputDecorationTheme _inputTheme({bool dark = false}) => InputDecorationTheme(
    filled: true,
    fillColor: dark ? IBuildColors.gray900 : IBuildColors.gray100,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: dark ? IBuildColors.gray700 : IBuildColors.gray300,
        width: 0.5,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: IBuildColors.primary, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: IBuildColors.error, width: 1),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    labelStyle: GoogleFonts.inter(
      fontSize: 14,
      color: dark ? IBuildColors.gray300 : IBuildColors.gray500,
    ),
    hintStyle: GoogleFonts.inter(
      fontSize: 14,
      color: dark ? IBuildColors.gray500 : IBuildColors.gray300,
    ),
  );

  // ── Botões ──────────────────────────────────
  static ElevatedButtonThemeData _elevatedButtonTheme() => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: IBuildColors.primary,
      foregroundColor: IBuildColors.white,
      minimumSize: const Size(double.infinity, 52),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
      elevation: 0,
    ),
  );

  static OutlinedButtonThemeData _outlinedButtonTheme({bool dark = false}) =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: dark ? IBuildColors.white : IBuildColors.primary,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          side: BorderSide(
            color: dark ? IBuildColors.gray500 : IBuildColors.primary,
            width: 1.5,
          ),
          textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      );

  // ── Bottom Nav ──────────────────────────────
  static BottomNavigationBarThemeData _bottomNavTheme(Brightness brightness) =>
      BottomNavigationBarThemeData(
        backgroundColor: brightness == Brightness.light
            ? IBuildColors.white
            : IBuildColors.fieldCard,
        selectedItemColor: IBuildColors.primary,
        unselectedItemColor: IBuildColors.gray300,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 11),
      );

  // ── Chips ───────────────────────────────────
  static ChipThemeData _chipTheme({bool dark = false}) => ChipThemeData(
    backgroundColor: dark ? IBuildColors.gray700 : IBuildColors.gray100,
    selectedColor: IBuildColors.primaryLight,
    labelStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  );
}
