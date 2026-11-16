import 'package:flutter/material.dart';

/// Yumuşak köşeli, gölgesiz, ince çerçeveli sade kart.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double radius;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = 22,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: child,
    );
  }
}

/// Başlık + (opsiyonel) sağ tarafta küçük metin
class SectionHeader extends StatelessWidget {
  final String title;
  final String? trailing;
  const SectionHeader(this.title, {super.key, this.trailing});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
          if (trailing != null)
            Text(
              trailing!,
              style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
            ),
        ],
      ),
    );
  }
}

/// Vurgu renginde ikon kutusu
class IconTile extends StatelessWidget {
  final IconData icon;
  final double size;
  const IconTile({super.key, required this.icon, this.size = 44});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: color, size: size * .5),
    );
  }
}

/// İnce ilerleme çubuğu
class SlimProgress extends StatelessWidget {
  final double value; // 0..1
  final Color? color;
  const SlimProgress({super.key, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(99),
      child: LinearProgressIndicator(
        value: value,
        minHeight: 5,
        color: color ?? cs.primary,
        backgroundColor: cs.outlineVariant,
      ),
    );
  }
}
