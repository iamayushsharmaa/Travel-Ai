import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/core/common/app_error_state.dart';
import 'package:triptide/core/common/loader.dart';
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
import '../../../core/extensions/context_snackbar.dart';
import '../../../core/extensions/context_theme.dart';
import '../provider/user_trips_provider.dart';

class TripDetailPage extends ConsumerWidget {
  final String travelId;

  const TripDetailPage({super.key, required this.travelId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripAsync = ref.watch(tripByIdProvider(travelId));

    return tripAsync.when(
      data: (trip) => _buildTripContent(context, ref, trip),
      error:
          (error, _) => AppErrorState(
            title: context.l10n.somethingWentWrong,
            message: error.toString(),
            showIcon: true,
            onRetry: () => ref.invalidate(tripByIdProvider(travelId)),
          ),
      loading:
          () => Loader(
            withScaffold: true,
            title: context.l10n.loading,
            onBack: () => context.pop(),
          ),
    );
  }

  Widget _buildTripContent(BuildContext context, WidgetRef ref, dynamic trip) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: _buildAppBar(context, ref, trip),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (trip.images != null && trip.images.isNotEmpty)
              TripHeroImage(images: trip.images, destination: trip.destination),

            Padding(
              padding: const EdgeInsets.all(20),
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

                  if (trip.accommodationSuggestions?.isNotEmpty == true)
                    AccommodationSection(
                      suggestions: trip.accommodationSuggestions,
                    ),

                  const SizedBox(height: 24),

                  if (trip.transportationDetails != null)
                    TransportationSection(details: trip.transportationDetails),

                  const SizedBox(height: 24),

                  WeatherSection(
                    destination: trip.destination,
                    latitude: trip.destinationLat ?? 0,
                    longitude: trip.destinationLng ?? 0,
                  ),

                  const SizedBox(height: 24),

                  MapSection(
                    currentLat: trip.currentLat ?? 0,
                    currentLng: trip.currentLng ?? 0,
                    destinationLat: trip.destinationLat ?? 0,
                    destinationLng: trip.destinationLng ?? 0,
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
      backgroundColor: context.colors.surface,
      elevation: 0,
      systemOverlayStyle:
          context.isDark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
      centerTitle: true,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: context.colors.surfaceVariant,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: context.colors.onSurface,
          ),
        ),
        onPressed: () => context.pop(),
      ),
      title: Text(trip.destination, style: context.text.titleLarge),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.colors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.delete_outline,
              size: 20,
              color: context.colors.error,
            ),
          ),
          onPressed: () => _showDeleteDialog(context, ref, trip),
        ),
        const SizedBox(width: 12),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(height: 1),
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
          (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(context.l10n.deleteTrip),
            content: Text(
              '${context.l10n.deleteConfirmation} ${trip.destination}. '
              '${context.l10n.actionUndone}',
              style: context.text.bodyMedium,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(context.l10n.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(
                  backgroundColor: context.colors.error.withOpacity(0.1),
                ),
                child: Text(
                  context.l10n.delete,
                  style: TextStyle(color: context.colors.error),
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
      context.showSuccessSnack(context.l10n.deleteSuccess);
      context.pop();
    } catch (_) {
      if (!context.mounted) return;
      context.showErrorSnack(context.l10n.failedDeleteTrip);
    }
  }
}
