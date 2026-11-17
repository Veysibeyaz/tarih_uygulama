import 'package:flutter/material.dart';

import 'settings_page.dart';
import 'unit_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KPSS Tarih'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Ayarlar',
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const SettingsPage()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '🎯 2027 KPSS Lisans\'a 320 Gün Kaldı',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(height: 24),

            _ModuleButton(
              icon: Icons.menu_book,
              title: 'Konu Özetleri',
              subtitle: 'Kısa, net ve akılda kalıcı notlar',
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const UnitListPage()));
              },
            ),

            const SizedBox(height: 12),

            _ModuleButton(
              icon: Icons.bolt,
              title: 'Flashcard\'lar',
              subtitle: 'Hızlı aktif hatırlama kartları',
            ),
            const SizedBox(height: 12),

            _ModuleButton(
              icon: Icons.edit_note,
              title: 'Testler',
              subtitle: 'Konu bazlı denemeler ve çözümler',
            ),
            const SizedBox(height: 12),

            _ModuleButton(
              icon: Icons.replay_circle_filled,
              title: 'Tekrar & Yanlışlar',
              subtitle: 'Zayıf noktaları eritme havuzu',
            ),
          ],
        ),
      ),
    );
  }
}

class _ModuleButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _ModuleButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Icon(
          icon,
          size: 32,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}
