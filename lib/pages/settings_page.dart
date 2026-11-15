import 'package:flutter/material.dart';

import '../state/app_settings.dart';
import '../widgets/ui.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final muted = cs.onSurface.withValues(alpha: .55);

    return Scaffold(
      appBar: AppBar(title: const Text('Ayarlar')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          const SectionHeader('Sınav grubu'),
          ValueListenableBuilder<String>(
            valueListenable: examGroupNotifier,
            builder: (context, selected, _) {
              return AppCard(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  children: examGroupOptions.map((group) {
                    final isSel = group == selected;
                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => examGroupNotifier.value = group,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                group,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: isSel
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: cs.onSurface,
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSel ? kAccent : Colors.transparent,
                                border: Border.all(
                                  color: isSel
                                      ? kAccent
                                      : cs.onSurface.withValues(alpha: .25),
                                  width: 1.5,
                                ),
                              ),
                              child: isSel
                                  ? const Icon(
                                      Icons.check_rounded,
                                      size: 15,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
          const SectionHeader('Görünüm'),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeModeNotifier,
            builder: (context, mode, _) {
              final isDark =
                  mode == ThemeMode.dark ||
                  (mode == ThemeMode.system &&
                      MediaQuery.of(context).platformBrightness ==
                          Brightness.dark);
              return AppCard(
                padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
                child: Row(
                  children: [
                    IconTile(
                      icon: isDark
                          ? Icons.dark_mode_rounded
                          : Icons.light_mode_rounded,
                      color: kBlue,
                      size: 40,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Karanlık mod',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: cs.onSurface,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            mode == ThemeMode.system
                                ? 'Sistem ayarını takip ediyor'
                                : (isDark ? 'Açık' : 'Kapalı'),
                            style: TextStyle(fontSize: 12, color: muted),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: isDark,
                      activeColor: kAccent,
                      onChanged: (v) => themeModeNotifier.value = v
                          ? ThemeMode.dark
                          : ThemeMode.light,
                    ),
                  ],
                ),
              );
            },
          ),
          const SectionHeader('Uygulama hakkında'),
          AppCard(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            child: Row(
              children: [
                const IconTile(
                  icon: Icons.info_outline_rounded,
                  color: kAccent,
                  size: 40,
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'KPSS Tarih',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: cs.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Versiyon 0.1.0 (Geliştirme sürümü)',
                      style: TextStyle(fontSize: 12, color: muted),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
