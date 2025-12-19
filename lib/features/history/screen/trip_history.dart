import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/core/common/error_text.dart';
import 'package:triptide/core/common/loader.dart';
import 'package:triptide/core/enums/trip_filter.dart';

import '../../../shared/widgets/trip_card.dart';
import '../provider/trip_history_provider.dart';
import '../widgets/trip_filter_chip.dart';

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
      backgroundColor: const Color(0xFFF8F9FD),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildFilterSection(selectedFilter),
                const SizedBox(height: 8),
              ],
            ),
          ),
          _buildTripsList(tripsAsync),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: const Color(0xFFF8F9FD),
      elevation: 0,
      expandedHeight: 100,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFF8F9FD), Color(0xFFEEF2FF)],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.history_rounded,
                          color: Color(0xFF6366F1),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Travel History',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection(TripFilter selectedFilter) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Filter by',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF64748B),
                letterSpacing: 0.5,
              ),
            ),
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
                final isSelected = filter == selectedFilter;
                return TripFilterChip(
                  label: filter.label,
                  isSelected: isSelected,
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
          (error, _) =>
              SliverFillRemaining(child: ErrorText(error: error.toString())),
      data: (trips) {
        if (trips.isEmpty) {
          return SliverFillRemaining(child: _buildEmptyState());
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.explore_off_rounded,
              size: 64,
              color: const Color(0xFF6366F1).withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No trips yet',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your travel history will appear here',
            style: TextStyle(fontSize: 15, color: Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }
}
