import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/features/trip/test_screen/widgets/accomodation_section.dart';
import 'package:triptide/features/trip/test_screen/widgets/budget_card.dart';
import 'package:triptide/features/trip/test_screen/widgets/map_section.dart';
import 'package:triptide/features/trip/test_screen/widgets/overview_card.dart';
import 'package:triptide/features/trip/test_screen/widgets/section_header.dart';
import 'package:triptide/features/trip/test_screen/widgets/transport_section.dart';
import 'package:triptide/features/trip/test_screen/widgets/trip_hero_image.dart';
import 'package:triptide/features/trip/test_screen/widgets/trip_timeline.dart';
import 'package:triptide/features/trip/test_screen/widgets/weather_section.dart';

import '../provider/trips_home_provider.dart';

class TripDetailPage extends ConsumerWidget {
  final String travelId;

  const TripDetailPage({super.key, required this.travelId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripAsync = ref.watch(tripByIdProvider(travelId));

    return tripAsync.when(
      data: (trip) {
        if (trip == null) {
          return _buildEmptyState(context);
        }
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
                    tripType: trip.tripType ?? 'Adventure',
                    peopleCount: trip.totalPeople ?? 1,
                    duration: trip.totalDays ?? 1,
                  ),

                  const SizedBox(height: 32),

                  // Section Header
                  const SectionHeader(
                    icon: Icons.calendar_today_outlined,
                    title: 'Daily Itinerary',
                  ),
                  const SizedBox(height: 16),

                  // Timeline
                  TripTimeline(dailyPlans: trip.dailyPlan ?? []),

                  const SizedBox(height: 32),

                  // Accommodation
                  if (trip.accommodationSuggestions != null &&
                      trip.accommodationSuggestions.isNotEmpty)
                    AccommodationSection(
                      suggestions: trip.accommodationSuggestions,
                    ),

                  const SizedBox(height: 24),

                  // Transportation
                  if (trip.transportationDetails != null)
                    TransportationSection(details: trip.transportationDetails),

                  const SizedBox(height: 24),

                  // Weather
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

                  // Budget
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
            title: const Text(
              'Delete Trip?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            content: Text(
              'Are you sure you want to delete your trip to ${trip.destination}? This action cannot be undone.',
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
                  'Cancel',
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
                  'Delete',
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
      final result = await ref.read(deleteTripProvider(travelId).future);

      result.fold(
        (failure) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to delete trip: ${failure.message}'),
                backgroundColor: Colors.red.shade400,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(16),
              ),
            );
          }
        },
        (_) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Trip deleted successfully'),
                backgroundColor: Colors.green.shade400,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(16),
              ),
            );
            context.pop();
          }
        },
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
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
        title: const Text(
          'Trip Details',
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
              'No trip found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This trip may have been deleted',
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
        title: const Text('Error', style: TextStyle(color: Colors.black87)),
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
                'Something went wrong',
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
        title: const Text(
          'Loading...',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}
