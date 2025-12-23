import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/features/trip/screen/widgets/accomodation_section.dart';
import 'package:triptide/features/trip/screen/widgets/budget_card.dart';
import 'package:triptide/features/trip/screen/widgets/map_section.dart';
import 'package:triptide/features/trip/screen/widgets/mark_visited_button.dart';
import 'package:triptide/features/trip/screen/widgets/overview_card.dart';
import 'package:triptide/features/trip/screen/widgets/section_header.dart';
import 'package:triptide/features/trip/screen/widgets/transport_section.dart';
import 'package:triptide/features/trip/screen/widgets/trip_hero_image.dart';
import 'package:triptide/features/trip/screen/widgets/trip_timeline.dart';
import 'package:triptide/features/trip/screen/widgets/weather_section.dart';
import 'package:triptide/shared/models/travel_db_model.dart';

import '../../../core/common/app_dialog.dart';
import '../../../core/common/async_view.dart';
import '../../../core/enums/trip_status.dart';
import '../../../core/extensions/context_l10n.dart';
import '../../../core/extensions/context_snackbar.dart';
import '../../../core/extensions/context_theme.dart';
import '../../settings/provider/settings_provider.dart';
import '../provider/user_trips_provider.dart';

class TripDetailPage extends ConsumerStatefulWidget {
  final String travelId;

  const TripDetailPage({super.key, required this.travelId});

  @override
  ConsumerState<TripDetailPage> createState() => _TripDetailPageState();
}

class _TripDetailPageState extends ConsumerState<TripDetailPage> {
  bool _languageDialogShown = false;

  @override
  Widget build(BuildContext context) {
    final tripAsync = ref.watch(tripByIdProvider(widget.travelId));

    return AsyncView(
      value: tripAsync,
      builder: (trip) {
        _checkAndShowLanguageDialog(trip);
        return _buildTripContent(context, ref, trip);
      },
    );
  }

  void _checkAndShowLanguageDialog(TravelDbModel trip) async {
    if (_languageDialogShown) return;

    final locale = await ref.read(languageNotifierProvider.future);
    final currentLang = locale.languageCode;

    if (trip.language == currentLang) return;

    _languageDialogShown = true;

    final shouldRegenerate = await AppDialog.confirm(
      context,
      title: context.l10n.tripDifferentLanguageTitle,
      message: context.l10n.tripDifferentLanguageMessage(
        trip.language.toUpperCase(),
        currentLang.toUpperCase(),
      ),
      confirmText: context.l10n.regenerate,
      cancelText: context.l10n.keepOriginal,
    );

    if (shouldRegenerate == true && mounted) {
      ref.read(regenerateTripInCurrentLanguageProvider(widget.travelId));
    }
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
                  const SizedBox(height: 24),

                  MarkVisitedButton(
                    isVisited: trip.status == TripStatus.visited,
                    onPressed: () async {
                      try {
                        await ref
                            .read(tripStatusNotifierProvider.notifier)
                            .markAsVisited(widget.travelId);

                        if (!context.mounted) return;
                        context.showSuccessSnack(context.l10n.mark_as_visited);
                        ref.invalidate(tripByIdProvider(widget.travelId));
                      } catch (_) {
                        if (!context.mounted) return;
                        context.showErrorSnack(context.l10n.somethingWentWrong);
                      }
                    },
                  ),

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
    final confirmed = await AppDialog.confirm(
      context,
      title: context.l10n.deleteTrip,
      message: context.l10n.deleteConfirmation,
      confirmText: context.l10n.delete,
      cancelText: context.l10n.cancel,
      destructive: true,
    );

    if (confirmed == true && context.mounted) {
      await _deleteTrip(context, ref);
    }
  }

  Future<void> _deleteTrip(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(deleteTripProvider(widget.travelId).future);

      if (!context.mounted) return;
      context.showSuccessSnack(context.l10n.deleteSuccess);
      context.pop();
    } catch (_) {
      if (!context.mounted) return;
      context.showErrorSnack(context.l10n.failedDeleteTrip);
    }
  }
}
