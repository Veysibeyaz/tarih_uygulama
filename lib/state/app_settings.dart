import 'package:flutter/material.dart';

/// Uygulama genelindeki tema modunu (açık/koyu/sistem) tutan global değişken.
/// Bu değer her değiştiğinde, dinleyen widget'lar otomatik güncellenir.
final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(ThemeMode.system);

/// Kullanıcının seçtiği sınav grubunu tutar.
final ValueNotifier<String> examGroupNotifier = ValueNotifier('KPSS Lisans');

const List<String> examGroupOptions = [
  'KPSS Lisans',
  'KPSS Önlisans',
  'KPSS Ortaöğretim',
];

/// Açık mod renk paleti
final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorSchemeSeed: Colors.indigo,
  scaffoldBackgroundColor: const Color(0xFFF6F7FB),
);

/// Koyu mod renk paleti — göz yormayan, tam siyah değil lacivert tonları
final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorSchemeSeed: Colors.indigo,
  scaffoldBackgroundColor: const Color(0xFF13161F),
  cardColor: const Color(0xFF1C2030),
);