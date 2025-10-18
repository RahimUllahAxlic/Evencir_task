import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get dark {
    const bg = Color(0xFF0F1216);
    const surface = Color(0xFF171A20);
    const primary = Color(0xFF4FD1C5); // teal-ish accent
    const onBg = Color(0xFFE8EAED);

    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        background: bg,
        surface: surface,
        surfaceVariant: Color(0xFF1F232B),
        primary: primary,
        onBackground: onBg,
        onSurface: onBg,
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(fontSize: 14),
        labelMedium: TextStyle(
            fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: .3),
        labelSmall: TextStyle(fontSize: 11, letterSpacing: .2),
        headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
      scaffoldBackgroundColor: bg,
      useMaterial3: true,
    );
  }
}
