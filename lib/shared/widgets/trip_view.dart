import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:triptide/core/theme/app_colors.dart';

import '../../core/enums/trip_type.dart';
import '../models/travel_db_model.dart';

class TripView extends StatelessWidget {
  final TravelDbModel trip;
  final void Function(TravelDbModel trip) onTripClicked;

  const TripView({super.key, required this.onTripClicked, required this.trip});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onTripClicked(trip),
      child: Container(
        height: 160,
        margin: const EdgeInsets.symmetric(vertical: 7),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildTripImage(),
            const SizedBox(width: 14),
            Expanded(child: _buildTripDetails(theme, context)),
          ],
        ),
      ),
    );
  }

  Widget _buildTripImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        'assets/images/travel.jpg',
        height: double.infinity,
        width: 130,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildTripDetails(ThemeData theme, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TripMetadata(
          days: trip.totalDays,
          startDate: trip.startDate,
          endDate: trip.endDate,
        ),
        const SizedBox(height: 8),
        _TripDestination(destination: trip.destination),
        const SizedBox(height: 12),
        _TripBudget(budget: trip.budget),
        const Spacer(),
        _TripTypeTag(tripType: trip.tripType.label(context)),
      ],
    );
  }
}

class _TripMetadata extends StatelessWidget {
  final int days;
  final DateTime startDate;
  final DateTime endDate;

  const _TripMetadata({
    required this.days,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Text('$days days', style: theme.textTheme.labelMedium),
        const Spacer(),
        Flexible(
          child: Text(
            '${DateFormat('MMM d').format(startDate)} - ${DateFormat('MMM d').format(endDate)}',
            style: theme.textTheme.labelMedium,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _TripDestination extends StatelessWidget {
  final String destination;

  const _TripDestination({required this.destination});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      destination,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _TripBudget extends StatelessWidget {
  final String? budget;

  const _TripBudget({this.budget});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (budget == null) return const SizedBox.shrink();

    return Row(
      children: [
        Text('Budget: ', style: theme.textTheme.bodySmall),
        Expanded(
          child: Text(
            budget!,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _TripTypeTag extends StatelessWidget {
  final String tripType;

  const _TripTypeTag({required this.tripType});

  @override
  Widget build(BuildContext context) {
    final tripTypeEnum = TripType.fromString(tripType);

    final tripTypeColor = AppColors.getTripTypeColor(tripTypeEnum);

    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: tripTypeColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: tripTypeColor.withOpacity(0.4),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          tripType,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
