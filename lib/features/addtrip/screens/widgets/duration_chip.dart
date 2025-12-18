import 'package:flutter/material.dart';

class DurationChip extends StatelessWidget {
  final int days;

  const DurationChip({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2196F3).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.calendar_today, size: 16, color: Color(0xFF2196F3)),
          const SizedBox(width: 6),
          Text(
            '$days ${days == 1 ? 'day' : 'days'}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2196F3),
            ),
          ),
        ],
      ),
    );
  }
}
