import 'package:flutter/material.dart';

import '../../../../core/extensions/context_theme.dart';

class StepperHeader extends StatelessWidget {
  final double progress;
  final String stepText;
  final String stepTitle;

  const StepperHeader({
    super.key,
    required this.progress,
    required this.stepText,
    required this.stepTitle,
  });

  @override
  Widget build(BuildContext context) {
    final cs = context.colors;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          color: cs.surface,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: cs.surfaceVariant,
              valueColor: AlwaysStoppedAnimation(cs.primary),
            ),
          ),
        ),

        // Step indicator
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          color: cs.surface,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                stepText,
                style: context.text.labelMedium?.copyWith(
                  color: cs.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '• $stepTitle',
                style: context.text.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: cs.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
