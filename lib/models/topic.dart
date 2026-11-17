import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

/// Ünite listesindeki tek bir satır (units.json).
class UnitInfo {
  final String id;
  final String title;
  final String subtitle;
  final String emoji;

  /// İçerik dosyasının yolu. null ise ünite henüz hazır değil ("Yakında").
  final String? file;

  const UnitInfo({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.emoji,
    this.file,
  });

  bool get isAvailable => file != null;

  factory UnitInfo.fromJson(Map<String, dynamic> json) {
    return UnitInfo(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String? ?? '',
      emoji: json['emoji'] as String? ?? '📘',
      file: json['file'] as String?,
    );
  }

  /// Tüm ünitelerin listesini okur.
  /// İleride uzak veritabanına geçilirse sadece bu fonksiyonun içi değişecek.
  static Future<List<UnitInfo>> loadAll() async {
    final raw = await rootBundle.loadString('assets/data/units.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return (json['units'] as List)
        .map((u) => UnitInfo.fromJson(u as Map<String, dynamic>))
        .toList();
  }
}

/// Madde işareti: isteğe bağlı kalın başlık (label) + metin.
class TopicBullet {
  final String? label;
  final String text;

  const TopicBullet({this.label, required this.text});

  /// JSON'da hem düz metin hem {"label": "...", "text": "..."} kabul edilir.
  factory TopicBullet.fromJson(dynamic json) {
    if (json is String) return TopicBullet(text: json);
    final map = json as Map<String, dynamic>;
    return TopicBullet(
      label: map['label'] as String?,
      text: map['text'] as String,
    );
  }
}

class TopicSection {
  final String title;
  final List<TopicBullet> bullets;
  final List<String> keywords;
  final List<String>? tableHeaders;
  final List<List<String>>? tableRows;

  TopicSection({
    required this.title,
    this.bullets = const [],
    this.keywords = const [],
    this.tableHeaders,
    this.tableRows,
  });

  factory TopicSection.fromJson(Map<String, dynamic> json) {
    final table = json['table'] as Map<String, dynamic>?;
    return TopicSection(
      title: json['title'] as String,
      bullets: ((json['bullets'] ?? const []) as List)
          .map((b) => TopicBullet.fromJson(b))
          .toList(),
      keywords: List<String>.from(json['keywords'] ?? const []),
      tableHeaders: table == null
          ? null
          : List<String>.from(table['headers'] as List),
      tableRows: table == null
          ? null
          : (table['rows'] as List)
                .map((r) => List<String>.from(r as List))
                .toList(),
    );
  }
}

class Topic {
  final String id;
  final String title;
  final String subtitle;
  final List<TopicSection> sections;

  Topic({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.sections,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String? ?? '',
      sections: (json['sections'] as List)
          .map((s) => TopicSection.fromJson(s as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Bir ünitenin tüm içeriği (konular + bölümler).
class TopicUnit {
  final String unit;
  final List<Topic> topics;

  TopicUnit({required this.unit, required this.topics});

  /// Verilen JSON dosyasını okur (örn. assets/data/islamiyet_oncesi.json).
  static Future<TopicUnit> load(String assetPath) async {
    final raw = await rootBundle.loadString(assetPath);
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return TopicUnit(
      unit: json['unit'] as String,
      topics: (json['topics'] as List)
          .map((t) => Topic.fromJson(t as Map<String, dynamic>))
          .toList(),
    );
  }
}
