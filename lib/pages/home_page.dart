import 'dart:async';

import 'package:flutter/material.dart';

import '../state/app_settings.dart';
import '../widgets/ui.dart';
import 'settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'KPSS Tarih',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
                ),
              ),
              _RoundIconButton(
                icon: Icons.settings_outlined,
                tooltip: 'Ayarlar',
                onTap: () => Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const SettingsPage())),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const _CountdownCard(),
          const SectionHeader('Çalışma alanın'),
          const _ModuleCard(
            icon: Icons.menu_book_rounded,
            title: 'Konu Özetleri',
            subtitle: 'Kısa, net ve akılda kalıcı notlar',
          ),
          const SizedBox(height: 12),
          const _ModuleCard(
            icon: Icons.bolt_rounded,
            title: 'Flashcard\'lar',
            subtitle: 'Hızlı aktif hatırlama kartları',
          ),
          const SizedBox(height: 12),
          const _ModuleCard(
            icon: Icons.edit_note_rounded,
            title: 'Testler',
            subtitle: 'Konu bazlı denemeler ve çözümler',
          ),
          const SizedBox(height: 12),
          const _ModuleCard(
            icon: Icons.replay_circle_filled_rounded,
            title: 'Tekrar & Yanlışlar',
            subtitle: 'Zayıf noktaları eritme havuzu',
          ),
        ],
      ),
    );
  }
}

/// Koyu gradyanlı geri sayım kartı — saniyede bir güncellenir.
class _CountdownCard extends StatefulWidget {
  const _CountdownCard();

  @override
  State<_CountdownCard> createState() => _CountdownCardState();
}

class _CountdownCardState extends State<_CountdownCard> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _two(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: examGroupNotifier,
      builder: (context, group, _) {
        final target = examDates[group] ?? examDates.values.first;
        var diff = target.difference(DateTime.now());
        if (diff.isNegative) diff = Duration.zero;
        final days = diff.inDays;
        final h = diff.inHours % 24;
        final m = diff.inMinutes % 60;
        final s = diff.inSeconds % 60;

        final cs = Theme.of(context).colorScheme;
        final dark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: dark
                  ? const [Color(0xFF2B3A55), Color(0xFF1E293B)]
                  : const [Color(0xFF334155), Color(0xFF1E293B)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .18),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .08),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.flag_rounded, size: 16, color: cs.primary),
                    const SizedBox(width: 8),
                    Text(
                      '2027 $group',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Sınava kalan süre',
                style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '$days',
                    style: const TextStyle(
                      color: Color(0xFFF1F5F9),
                      fontSize: 52,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'gün',
                    style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                '${_two(h)} sa  ${_two(m)} dk  ${_two(s)} sn',
                style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 14,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ModuleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // Şimdilik boş — ileride her modül kendi sayfasına yönlendirecek
        },
        child: Row(
          children: [
            IconTile(icon: icon, size: 48),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: cs.onSurface,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: cs.outlineVariant),
              ),
              child: Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: cs.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  const _RoundIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Tooltip(
      message: tooltip,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: cs.surface,
            shape: BoxShape.circle,
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Icon(icon, size: 22, color: cs.onSurface),
        ),
      ),
    );
  }
}
