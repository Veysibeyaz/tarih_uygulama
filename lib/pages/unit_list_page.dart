import 'package:flutter/material.dart';

import '../models/topic.dart';
import 'unit_detail_page.dart';

class UnitListPage extends StatefulWidget {
  const UnitListPage({super.key});

  @override
  State<UnitListPage> createState() => _UnitListPageState();
}

class _UnitListPageState extends State<UnitListPage> {
  late final Future<List<UnitInfo>> _future = UnitInfo.loadAll();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konu Özetleri'), centerTitle: true),
      body: FutureBuilder<List<UnitInfo>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('Üniteler yüklenemedi 😕'));
          }
          final units = snapshot.data!;
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: units.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) => _UnitCard(unit: units[index]),
          );
        },
      ),
    );
  }
}

class _UnitCard extends StatelessWidget {
  final UnitInfo unit;
  const _UnitCard({required this.unit});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Opacity(
      // Henüz hazır olmayan üniteler soluk görünür
      opacity: unit.isAvailable ? 1 : 0.55,
      child: Card(
        elevation: 1,
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: scheme.primaryContainer,
            child: Text(unit.emoji, style: const TextStyle(fontSize: 22)),
          ),
          title: Text(
            unit.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(unit.subtitle),
          trailing: unit.isAvailable
              ? const Icon(Icons.chevron_right)
              : const Text(
                  'Yakında',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
          onTap: () {
            if (!unit.isAvailable) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bu ünite yakında eklenecek.'),
                  duration: Duration(seconds: 2),
                ),
              );
              return;
            }
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => UnitDetailPage(unit: unit)),
            );
          },
        ),
      ),
    );
  }
}
