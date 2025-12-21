import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/core/common/error_text.dart';
import 'package:triptide/core/common/loader.dart';
import 'package:triptide/features/search/screens/widgets/app_bar.dart';
import 'package:triptide/features/search/screens/widgets/initial_state.dart';

import '../../../core/common/empty_state.dart';
import '../../../core/extensions/context_l10n.dart';
import '../../../shared/widgets/trip_view.dart';
import '../providers/search_provider.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;
  String _currentQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchTextChanged);
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchTextChanged() {
    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      final query = _searchController.text.trim().toLowerCase();
      if (_currentQuery != query) {
        setState(() => _currentQuery = query);
        ref.invalidate(searchTripProvider);
      }
    });
  }

  void _onClearSearch() {
    setState(() => _currentQuery = '');
    ref.invalidate(searchTripProvider);
  }

  void _onTripTap(dynamic trip) {
    context.pushNamed('trip', pathParameters: {'travelId': trip.travelId});
  }

  @override
  Widget build(BuildContext context) {
    final searchResult = ref.watch(searchTripProvider(_currentQuery));
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: AppSearchBar(
          controller: _searchController,
          hintText: l10n.search_trips_hint,
          onClear: _onClearSearch,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: _buildSearchBody(searchResult),
      ),
    );
  }

  Widget _buildSearchBody(AsyncValue searchResult) {
    final l10n = context.l10n;

    // Initial state
    if (_currentQuery.isEmpty) {
      return SearchInitialState(
        message: l10n.search_initial_message,
        icon: Icons.travel_explore_rounded,
      );
    }

    return searchResult.when(
      data: (trips) {
        if (trips.isEmpty) {
          return EmptyState(
            title: l10n.search_no_results(_currentQuery),
            icon: Icons.search_off_rounded,
          );
        }
        return _buildTripList(trips);
      },
      loading: () => const Loader(),
      error:
          (error, _) => AppErrorState(
            message: error.toString(),
            onRetry: () => ref.invalidate(searchTripProvider),
          ),
    );
  }

  Widget _buildTripList(List trips) {
    return ListView.builder(
      itemCount: trips.length,
      itemBuilder: (context, index) {
        final trip = trips[index];
        return TripView(trip: trip, onTripClicked: _onTripTap);
      },
    );
  }
}
