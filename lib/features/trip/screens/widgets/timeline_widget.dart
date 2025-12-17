import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../addtrip/models/travel_gemini_response.dart';


class TimeLineWidget extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final DayPlan dayPlan;

  const TimeLineWidget({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.dayPlan,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.blue.shade700;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 40,
          child: Column(
            children: [
              Container(
                width: 3,
                height: isFirst ? 20 : 36,
                color: isFirst ? Colors.transparent : baseColor.withOpacity(0.5),
              ),
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: baseColor,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${dayPlan.day}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                width: 3,
                height: isLast ? 0 : 90 + dayPlan.activities.length * 30,
                color: isLast ? Colors.transparent : baseColor.withOpacity(0.5),
              ),
            ],
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 28),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: baseColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Day ${dayPlan.day} - ${DateFormat('d MMM yyyy').format(dayPlan.date)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: baseColor,
                  ),
                ),
                const SizedBox(height: 14),
                ...dayPlan.activities.map((activity) => _buildActivityItem(activity.description, baseColor)).toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(String text, Color baseColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_rounded, size: 20, color: baseColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 16,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
