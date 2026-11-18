import 'package:flutter/material.dart';

import '../models/topic.dart';

class TopicDetailPage extends StatelessWidget {
  final Topic topic;
  const TopicDetailPage({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(topic.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: topic.sections
            .map(
              (s) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _SectionCard(section: s),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final TopicSection section;
  const _SectionCard({required this.section});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;

    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              section.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: scheme.primary,
              ),
            ),
            const SizedBox(height: 12),

            // Madde madde bilgiler (başlık varsa kalın yazılır)
            ...section.bullets.map(
              (b) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7, right: 10),
                      child: Icon(Icons.circle, size: 6, color: scheme.primary),
                    ),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.4,
                            color: textColor,
                          ),
                          children: [
                            if (b.label != null)
                              TextSpan(
                                text: '${b.label}: ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            TextSpan(text: b.text),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Tablo
            if (section.tableHeaders != null && section.tableRows != null)
              _buildTable(context),

            // Anahtar kelimeler
            if (section.keywords.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: section.keywords
                    .map(
                      (k) => Chip(
                        label: Text(k, style: const TextStyle(fontSize: 12)),
                        visualDensity: VisualDensity.compact,
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTable(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final headers = section.tableHeaders!;
    final rows = section.tableRows!;

    return Table(
      // Uzun açıklamalar alt satıra insin diye iki sütun oransal bölünür
      columnWidths: const {0: FlexColumnWidth(1), 1: FlexColumnWidth(2.2)},
      border: TableBorder.all(color: scheme.outlineVariant, width: 0.8),
      children: [
        TableRow(
          decoration: BoxDecoration(color: scheme.primaryContainer),
          children: headers
              .map(
                (h) => Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    h,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: scheme.onPrimaryContainer,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        ...rows.map(
          (r) => TableRow(
            children: [
              for (int i = 0; i < r.length; i++)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    r[i],
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.35,
                      fontWeight: i == 0 ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
