import 'package:flutter/material.dart';

import '../../../../core/enums/trip_status.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/extensions/context_theme.dart';

class TripStatusPill extends StatelessWidget {
  final TripStatus status;

  const TripStatusPill({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    late Color color;
    late String label;
    late IconData icon;

    switch (status) {
      case TripStatus.visited:
        color = context.colors.primary;
        label = context.l10n.visited;
        icon = Icons.check_circle_outline;
        break;
      case TripStatus.planned:
      default:
        color = context.colors.secondary;
        label = context.l10n.planned;
        icon = Icons.schedule_outlined;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: context.text.labelMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
