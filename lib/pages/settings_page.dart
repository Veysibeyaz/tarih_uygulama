import 'package:flutter/material.dart';
import '../state/app_settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ayarlar')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _SectionTitle('Sınav Grubu'),
          ValueListenableBuilder<String>(
            valueListenable: examGroupNotifier,
            builder: (context, selected, _) {
              return Card(
                child: Column(
                  children: examGroupOptions.map((group) {
                    return RadioListTile<String>(
                      title: Text(group),
                      value: group,
                      groupValue: selected,
                      onChanged: (value) {
                        if (value != null) {
                          examGroupNotifier.value = value;
                        }
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
          const SizedBox(height: 24),

          const _SectionTitle('Görünüm'),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeModeNotifier,
            builder: (context, mode, _) {
              final isDark = mode == ThemeMode.dark ||
                  (mode == ThemeMode.system &&
                      MediaQuery.of(context).platformBrightness == Brightness.dark);
              return Card(
                child: SwitchListTile(
                  secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
                  title: const Text('Karanlık Mod'),
                  subtitle: Text(
                    mode == ThemeMode.system
                        ? 'Şu an sistem ayarını takip ediyor'
                        : (isDark ? 'Açık' : 'Kapalı'),
                  ),
                  value: isDark,
                  onChanged: (value) {
                    themeModeNotifier.value =
                        value ? ThemeMode.dark : ThemeMode.light;
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 24),

          const _SectionTitle('Uygulama Hakkında'),
          const Card(
            child: ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('KPSS Tarih'),
              subtitle: Text('Versiyon 0.1.0 (Geliştirme sürümü)'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
    );
  }
}