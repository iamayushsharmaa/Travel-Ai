import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/core/common/app_error_state.dart';
import 'package:triptide/core/common/empty_state.dart';
import 'package:triptide/core/common/loader.dart';
import 'package:triptide/core/enums/trip_filter.dart';
import 'package:triptide/core/extensions/context_theme.dart';
import 'package:triptide/features/history/screen/widgets/trip_filter_chip.dart';

import '../../../core/extensions/context_l10n.dart';
import '../../../shared/widgets/trip_card.dart';
import '../provider/trip_history_provider.dart';

class TripHistory extends ConsumerStatefulWidget {
  const TripHistory({super.key});

  @override
  ConsumerState<TripHistory> createState() => _TripHistoryState();
}

class _TripHistoryState extends ConsumerState<TripHistory> {
  @override
  Widget build(BuildContext context) {
    final selectedFilter = ref.watch(tripHistoryNotifierProvider);
    final tripsAsync = ref.watch(historyTripsProvider);

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildFilterSection(context, selectedFilter),
                const SizedBox(height: 8),
              ],
            ),
          ),
          _buildTripsList(tripsAsync),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    final cs = context.theme.colorScheme;
    final l10n = context.l10n;

    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: cs.background,
      elevation: 0,
      expandedHeight: 100,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [cs.background, cs.primary.withOpacity(0.05)],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: cs.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.history_rounded,
                      color: cs.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(l10n.travelHistory, style: context.text.headlineLarge),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context, TripFilter selectedFilter) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(l10n.filterBy, style: theme.textTheme.labelMedium),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: TripFilter.values.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final filter = TripFilter.values[index];
                return TripFilterChip(
                  label: filter.label,
                  isSelected: filter == selectedFilter,
                  onTap: () {
                    ref
                        .read(tripHistoryNotifierProvider.notifier)
                        .changeFilter(filter);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripsList(AsyncValue tripsAsync) {
    return tripsAsync.when(
      loading: () => const SliverFillRemaining(child: Loader()),
      error:
          (error, _) => SliverFillRemaining(
            child: AppErrorState(message: error.toString()),
          ),
      data: (trips) {
        if (trips.isEmpty) {
          return SliverFillRemaining(
            child: EmptyState(
              icon: Icons.explore_off_rounded,
              title: context.l10n.noTripsYet,
              subtitle: context.l10n.noTripsMessage,
            ),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final trip = trips[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TripCard(
                  trip: trip,
                  onTap:
                      () => context.pushNamed(
                        'trip',
                        pathParameters: {'travelId': trip.travelId},
                      ),
                ),
              );
            }, childCount: trips.length),
          ),
        );
      },
    );
  }
}
