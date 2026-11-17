import 'package:flutter/material.dart';

import '../models/topic.dart';
import '../widgets/section_card.dart';

class UnitDetailPage extends StatefulWidget {
  final UnitInfo unit;
  const UnitDetailPage({super.key, required this.unit});

  @override
  State<UnitDetailPage> createState() => _UnitDetailPageState();
}

class _UnitDetailPageState extends State<UnitDetailPage> {
  late final Future<TopicUnit> _future = TopicUnit.load(widget.unit.file!);

  // Her konu başlığına bir anahtar: çipe basınca oraya kaydırmak için
  final Map<String, GlobalKey> _topicKeys = {};

  bool _allExpanded = false;
  int _version = 0; // değişince bölümler yeniden kurulur (aç/kapat için)

  GlobalKey _keyFor(String id) => _topicKeys.putIfAbsent(id, () => GlobalKey());

  void _jumpTo(Topic topic) {
    final ctx = _keyFor(topic.id).currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      alignment: 0.0,
    );
  }

  void _toggleAll() {
    setState(() {
      _allExpanded = !_allExpanded;
      _version++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.unit.title),
        actions: [
          IconButton(
            icon: Icon(_allExpanded ? Icons.unfold_less : Icons.unfold_more),
            tooltip: _allExpanded ? 'Tümünü kapat' : 'Tümünü aç',
            onPressed: _toggleAll,
          ),
        ],
      ),
      body: FutureBuilder<TopicUnit>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('İçerik yüklenemedi 😕'));
          }

          final topics = snapshot.data!.topics;

          return Column(
            children: [
              _TopicChips(topics: topics, onSelected: _jumpTo),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int t = 0; t < topics.length; t++) ...[
                        _TopicHeader(
                          key: _keyFor(topics[t].id),
                          topic: topics[t],
                        ),
                        for (int s = 0; s < topics[t].sections.length; s++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: SectionCard(
                              key: ValueKey('${topics[t].id}_${s}_$_version'),
                              section: topics[t].sections[s],
                              // İlk konunun ilk bölümü açık gelir
                              initiallyExpanded:
                                  _allExpanded || (t == 0 && s == 0),
                            ),
                          ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Üstte sabit duran, yatay kaydırılan konu şeridi
class _TopicChips extends StatelessWidget {
  final List<Topic> topics;
  final ValueChanged<Topic> onSelected;

  const _TopicChips({required this.topics, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: topics.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final topic = topics[index];
          return ActionChip(
            label: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 180),
              child: Text(
                topic.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            onPressed: () => onSelected(topic),
          );
        },
      ),
    );
  }
}

/// Konu başlığı: sol çizgili ara başlık
class _TopicHeader extends StatelessWidget {
  final Topic topic;
  const _TopicHeader({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 12),
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: scheme.primary, width: 4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              topic.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (topic.subtitle.isNotEmpty)
              Text(
                topic.subtitle,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
