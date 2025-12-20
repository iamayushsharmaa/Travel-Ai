import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_l10n.dart';
import 'empty_state.dart';

class TripTimeline extends StatelessWidget {
  final List<dynamic> dailyPlans;

  const TripTimeline({super.key, required this.dailyPlans});

  @override
  Widget build(BuildContext context) {
    if (dailyPlans.isEmpty) {
      return EmptyState(
        icon: Icons.event_busy_outlined,
        title: context.l10n.noItinerayAvailable,
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dailyPlans.length,
      itemBuilder: (context, index) {
        final dayPlan = dailyPlans[index];
        return TimelineItem(
          isFirst: index == 0,
          isLast: index == dailyPlans.length - 1,
          dayNumber: dayPlan.day ?? index + 1,
          date: dayPlan.date ?? DateTime.now(),
          activities: dayPlan.activities ?? [],
        );
      },
    );
  }
}

class TimelineItem extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final int dayNumber;
  final DateTime date;
  final List<dynamic> activities;

  const TimelineItem({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.dayNumber,
    required this.date,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2196F3);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator
        SizedBox(
          width: 50,
          child: Column(
            children: [
              // Top line
              Container(
                width: 2,
                height: isFirst ? 0 : 24,
                color:
                    isFirst
                        ? Colors.transparent
                        : primaryColor.withOpacity(0.3),
              ),
              // Circle with day number
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '$dayNumber',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              // Bottom line
              Container(
                width: 2,
                height: isLast ? 0 : 100 + (activities.length * 35),
                color:
                    isLast ? Colors.transparent : primaryColor.withOpacity(0.3),
              ),
            ],
          ),
        ),

        const SizedBox(width: 16),

        // Content
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 32),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: primaryColor.withOpacity(0.1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 18, color: primaryColor),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat('EEEE, MMM d, yyyy').format(date),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Day $dayNumber',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                if (activities.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  ...activities.map((activity) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.only(top: 7),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor.withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              activity.description ?? context.l10n.activity,
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.5,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
