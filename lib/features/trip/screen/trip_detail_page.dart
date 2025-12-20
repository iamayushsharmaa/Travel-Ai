import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/features/trip/screen/widgets/accomodation_section.dart';
import 'package:triptide/features/trip/screen/widgets/budget_card.dart';
import 'package:triptide/features/trip/screen/widgets/map_section.dart';
import 'package:triptide/features/trip/screen/widgets/overview_card.dart';
import 'package:triptide/features/trip/screen/widgets/section_header.dart';
import 'package:triptide/features/trip/screen/widgets/transport_section.dart';
import 'package:triptide/features/trip/screen/widgets/trip_hero_image.dart';
import 'package:triptide/features/trip/screen/widgets/trip_timeline.dart';
import 'package:triptide/features/trip/screen/widgets/weather_section.dart';

import '../../../core/extensions/context_l10n.dart';
import '../provider/user_trips_provider.dart';

class TripDetailPage extends ConsumerWidget {
  final String travelId;

  const TripDetailPage({super.key, required this.travelId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripAsync = ref.watch(tripByIdProvider(travelId));

    return tripAsync.when(
      data: (trip) {
        return _buildTripContent(context, ref, trip);
      },
      error: (error, stackTrace) => _buildErrorState(context, error),
      loading: () => _buildLoadingState(context),
    );
  }

  Widget _buildTripContent(BuildContext context, WidgetRef ref, dynamic trip) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: _buildAppBar(context, ref, trip),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (trip.images != null && trip.images.isNotEmpty)
              TripHeroImage(images: trip.images, destination: trip.destination),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TripOverviewCard(
                    route: '${trip.currentLocation} → ${trip.destination}',
                    tripType: trip.tripType,
                    peopleCount: trip.totalPeople ?? 1,
                    duration: trip.totalDays ?? 1,
                  ),

                  const SizedBox(height: 32),

                  SectionHeader(
                    icon: Icons.calendar_today_outlined,
                    title: context.l10n.dailyItinerary,
                  ),
                  const SizedBox(height: 16),

                  TripTimeline(dailyPlans: trip.dailyPlan ?? []),

                  const SizedBox(height: 32),

                  if (trip.accommodationSuggestions != null &&
                      trip.accommodationSuggestions.isNotEmpty)
                    AccommodationSection(
                      suggestions: trip.accommodationSuggestions,
                    ),

                  const SizedBox(height: 24),

                  if (trip.transportationDetails != null)
                    TransportationSection(details: trip.transportationDetails),

                  const SizedBox(height: 24),

                  WeatherSection(
                    destination: trip.destination,
                    latitude: trip.destinationLat ?? 0.0,
                    longitude: trip.destinationLng ?? 0.0,
                  ),

                  const SizedBox(height: 24),

                  // Map
                  MapSection(
                    currentLat: trip.currentLat ?? 0.0,
                    currentLng: trip.currentLng ?? 0.0,
                    destinationLat: trip.destinationLat ?? 0.0,
                    destinationLng: trip.destinationLng ?? 0.0,
                    destinationName: trip.destination,
                  ),

                  const SizedBox(height: 24),

                  BudgetCard(budget: trip.budget?.toString() ?? '0'),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    WidgetRef ref,
    dynamic trip,
  ) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Colors.black87,
          ),
        ),
        onPressed: () => context.pop(),
      ),
      title: Text(
        trip.destination,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.delete_outline,
              size: 20,
              color: Colors.red.shade400,
            ),
          ),
          onPressed: () => _showDeleteDialog(context, ref, trip),
        ),
        const SizedBox(width: 12),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: Colors.grey.shade200, height: 1),
      ),
    );
  }

  Future<void> _showDeleteDialog(
    BuildContext context,
    WidgetRef ref,
    dynamic trip,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              context.l10n.deleteTrip,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            content: Text(
              '${context.l10n.deleteConfirmation} ${trip.destination}? ${context.l10n.actionUndone}',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  context.l10n.cancel,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red.shade50,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  context.l10n.delete,
                  style: TextStyle(
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
    );

    if (confirmed == true && context.mounted) {
      await _deleteTrip(context, ref);
    }
  }

  Future<void> _deleteTrip(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(deleteTripProvider(travelId).future);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.deleteSuccess),
          backgroundColor: Colors.green.shade400,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );

      context.pop();
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.failedDeleteTrip),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  Widget _buildEmptyState(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        title: Text(
          context.l10n.tripDetail,
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.travel_explore_outlined,
              size: 80,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.noTripFound,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.tripMayHaveBeenDeleted,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, Object error) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        title: Text(
          context.l10n.error,
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 80, color: Colors.red.shade300),
              const SizedBox(height: 16),
              Text(
                context.l10n.somethingWentWrong,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        title: Text(
          context.l10n.loading,
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}
