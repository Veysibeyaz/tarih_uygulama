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

/// Ana vurgu rengi (yeşil) ve modül renkleri
const Color kAccent = Color(0xFF22B14C);
const Color kOrange = Color(0xFFF08A24);
const Color kBlue = Color(0xFF4A6CF7);
const Color kRed = Color(0xFFE5484D);

ThemeData _build(Brightness b) {
  final dark = b == Brightness.dark;
  final surface = dark ? const Color(0xFF1B1E26) : Colors.white;
  final bg = dark ? const Color(0xFF0F1115) : const Color(0xFFEEEEF0);
  final text = dark ? const Color(0xFFF2F3F5) : const Color(0xFF17181C);
  return ThemeData(
    useMaterial3: true,
    brightness: b,
    scaffoldBackgroundColor: bg,
    colorScheme: ColorScheme.fromSeed(
      seedColor: kAccent,
      brightness: b,
    ).copyWith(surface: surface, onSurface: text, primary: kAccent),
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
  );
}

final ThemeData lightTheme = _build(Brightness.light);
final ThemeData darkTheme = _build(Brightness.dark);
