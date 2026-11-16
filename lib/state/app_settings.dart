import 'package:flutter/material.dart';

/// Tema modu (açık/koyu/sistem). Değişince dinleyen widget'lar güncellenir.
final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(
  ThemeMode.system,
);

/// Kullanıcının seçtiği sınav grubu.
final ValueNotifier<String> examGroupNotifier = ValueNotifier('KPSS Lisans');

const List<String> examGroupOptions = [
  'KPSS Lisans',
  'KPSS Önlisans',
  'KPSS Ortaöğretim',
];

/// TODO: ÖSYM resmi takvimi açıklandığında gerçek tarihlerle güncelle.
/// Şimdilik yer tutucu tarihlerdir.
final Map<String, DateTime> examDates = {
  'KPSS Lisans': DateTime(2027, 10, 3, 10, 15),
  'KPSS Önlisans': DateTime(2027, 10, 17, 10, 15),
  'KPSS Ortaöğretim': DateTime(2027, 10, 24, 10, 15),
};

/// Test geri bildirim renkleri (her iki modda ortak)
const Color kCorrect = Color(0xFF10B981); // Zümrüt yeşili
const Color kWrong = Color(0xFFEF4444); // Canlı kırmızı

ThemeData _build(Brightness b) {
  final dark = b == Brightness.dark;

  final bg = dark ? const Color(0xFF0F172A) : const Color(0xFFF8F6F0);
  final surface = dark ? const Color(0xFF1E293B) : Colors.white;
  final text = dark ? const Color(0xFFF1F5F9) : const Color(0xFF1E293B);
  final muted = dark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
  final accent = dark ? const Color(0xFFF59E0B) : const Color(0xFFC25E38);
  final onAccent = dark ? const Color(0xFF0F172A) : Colors.white;
  final outline = dark ? const Color(0xFF334155) : const Color(0xFFEBE6D8);

  final scheme = ColorScheme.fromSeed(seedColor: accent, brightness: b)
      .copyWith(
        primary: accent,
        onPrimary: onAccent,
        surface: surface,
        onSurface: text,
        onSurfaceVariant: muted,
        outlineVariant: outline,
        error: kWrong,
      );

  return ThemeData(
    useMaterial3: true,
    brightness: b,
    colorScheme: scheme,
    scaffoldBackgroundColor: bg,
    cardColor: surface,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      foregroundColor: text,
      titleTextStyle: TextStyle(
        color: text,
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? onAccent : muted,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? accent : outline,
      ),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    ),
  );
}

final ThemeData lightTheme = _build(Brightness.light);
final ThemeData darkTheme = _build(Brightness.dark);
