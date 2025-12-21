import 'package:flutter/material.dart';

import '../extensions/context_theme.dart';

enum SnackType { success, error, info }

class AppSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    SnackType type = SnackType.info,
  }) {
    final cs = context.colors;

    Color backgroundColor;
    IconData icon;

    switch (type) {
      case SnackType.success:
        backgroundColor = cs.primary;
        icon = Icons.check_circle_outline;
        break;
      case SnackType.error:
        backgroundColor = cs.error;
        icon = Icons.error_outline;
        break;
      case SnackType.info:
      default:
        backgroundColor = cs.surface;
        icon = Icons.info_outline;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: backgroundColor,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Row(
            children: [
              Icon(icon, color: cs.onPrimary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: context.text.bodyMedium?.copyWith(
                    color: cs.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
