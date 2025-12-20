import 'package:flutter/material.dart';
import 'package:triptide/core/extensions/context_l10n.dart';

class DurationChip extends StatelessWidget {
  final int days;

  const DurationChip({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: cs.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.calendar_today, size: 16, color: cs.primary),
          const SizedBox(width: 6),
          Text(
            '$days ${days == 1 ? context.l10n.day : context.l10n.days}',
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: cs.primary,
            ),
          ),
        ],
      ),
    );
  }
}
