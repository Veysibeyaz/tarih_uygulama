import 'package:flutter/material.dart';

import '../widgets/ui.dart';

class PerformancePage extends StatelessWidget {
  const PerformancePage({super.key});

  // ÖRNEK VERİ — gerçek istatistikler bağlanınca değiştirilecek.
  static const _weekDays = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];
  static const _weekly = [24, 18, 9, 21, 33, 27, 12];
  static const _topics = [
    ('İslamiyet Öncesi Türk Tarihi', 0.72),
    ('Osmanlı Devleti Kuruluş', 0.55),
    ('Kurtuluş Savaşı', 0.38),
    ('Atatürk İlkeleri', 0.20),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final muted = cs.onSurfaceVariant;
    final maxV = _weekly.reduce((a, b) => a > b ? a : b);

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
        children: [
          Text(
            'Performans',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: 'Çözülen soru',
                  value: '144',
                  icon: Icons.check_circle_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  label: 'Başarı oranı',
                  value: '%68',
                  icon: Icons.trending_up_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AppCard(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Haftalık çalışma',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Günlük çözülen soru sayısı',
                  style: TextStyle(fontSize: 13, color: muted),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: 160,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(_weekly.length, (i) {
                      final top = _weekly[i] == maxV;
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 22,
                              height: 120 * _weekly[i] / maxV,
                              decoration: BoxDecoration(
                                color: top
                                    ? cs.primary
                                    : cs.onSurface.withValues(alpha: .14),
                                borderRadius: BorderRadius.circular(99),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              _weekDays[i],
                              style: TextStyle(fontSize: 12, color: muted),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          const SectionHeader('Konu başarıları'),
          AppCard(
            child: Column(
              children: [
                for (var i = 0; i < _topics.length; i++) ...[
                  if (i > 0) const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          _topics[i].$1,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: cs.onSurface,
                          ),
                        ),
                      ),
                      Text(
                        '%${(_topics[i].$2 * 100).round()}',
                        style: TextStyle(fontSize: 13, color: muted),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SlimProgress(value: _topics[i].$2),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconTile(icon: icon, size: 40),
          const SizedBox(height: 14),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
