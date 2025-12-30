import 'package:flutter/material.dart';
import 'package:triptide/core/extensions/context_l10n.dart';
import 'package:triptide/core/theme/app_colors.dart';

import '../../../../core/enums/trip_type.dart';
import '../../../../core/utilities/trip_utils.dart';
import 'info_row.dart';

class TripOverviewCard extends StatelessWidget {
  final String route;
  final TripType tripType;
  final int peopleCount;
  final int duration;

  const TripOverviewCard({
    super.key,
    required this.route,
    required this.tripType,
    required this.peopleCount,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.getTripTypeColor(tripType);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  getTripTypeIcon(tripType),
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.tripOverview,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      tripType.label(context),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          InfoRow(
            icon: Icons.route_outlined,
            text: route,
            iconColor: Colors.white,
            textColor: Colors.white,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: InfoRow(
                  icon: Icons.people_outline,
                  text:
                      '$peopleCount ${peopleCount == 1 ? context.l10n.person : context.l10n.people}',
                  iconColor: Colors.white,
                  textColor: Colors.white,
                ),
              ),
              Expanded(
                child: InfoRow(
                  icon: Icons.calendar_today_outlined,
                  text:
                      '$duration ${duration == 1 ? context.l10n.day : context.l10n.days}',
                  iconColor: Colors.white,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
