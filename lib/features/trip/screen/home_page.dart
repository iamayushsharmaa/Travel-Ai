import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/core/common/loader.dart';
import 'package:triptide/core/extensions/context_l10n.dart';
import 'package:triptide/features/trip/screen/widgets/month_widget.dart';

import '../../../core/common/error_text.dart';
import '../../../core/extensions/context_theme.dart';
import '../../../shared/widgets/trip_view.dart';
import '../provider/user_trips_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final usersTrip = ref.watch(userTripsProvider);
    final monthCountAsync = ref.watch(monthTripCountProvider);

    return Scaffold(
      backgroundColor: context.colors.background,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, theme),
          _buildHeader(context, theme, monthCountAsync),
          _buildTripsList(context, usersTrip),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context, ThemeData theme) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      backgroundColor: theme.colorScheme.background,
      elevation: 0.5,
      expandedHeight: 76,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16, bottom: 14),
        title: Text(context.l10n.appName, style: theme.textTheme.displaySmall),
      ),
      actions: [
        _AppBarAction(
          icon: Icons.search,
          onTap: () => context.pushNamed('search'),
        ),
        // _AppBarAction(
        //   icon: Icons.person,
        //   onTap: () => context.pushNamed('profile'),
        //   isLast: true,
        // ),
      ],
    );
  }

  Widget _buildHeader(
    BuildContext context,
    ThemeData theme,
    AsyncValue monthCountAsync,
  ) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            monthCountAsync.when(
              data: (count) => MonthWidget(count.thisMonth, count.lastMonth),
              error: (error, stackTrace) => ErrorText(error: error.toString()),
              loading: () => const Loader(),
            ),
            const SizedBox(height: 20),
            Text(context.l10n.yourTrips, style: theme.textTheme.displaySmall),
          ],
        ),
      ),
    );
  }

  Widget _buildTripsList(BuildContext context, AsyncValue usersTrip) {
    return usersTrip.when(
      data: (data) {
        if (data.isEmpty) {
          return _buildEmptyState(context);
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(childCount: data.length, (
            context,
            index,
          ) {
            final trip = data[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TripView(
                trip: trip,
                onTripClicked:
                    (trip) => context.pushNamed(
                      'trip',
                      pathParameters: {'travelId': trip.travelId},
                    ),
              ),
            );
          }),
        );
      },
      error:
          (error, stackTrace) => SliverToBoxAdapter(
            child: Center(child: ErrorText(error: error.toString())),
          ),
      loading: () => const SliverToBoxAdapter(child: Center(child: Loader())),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            context.l10n.noTripsYet,
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBarAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isLast;

  const _AppBarAction({
    required this.icon,
    required this.onTap,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(top: 8, right: isLast ? 19 : 12),
      child: GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          backgroundColor: theme.colorScheme.surfaceVariant,
          child: Icon(icon, color: theme.colorScheme.onSurface),
        ),
      ),
    );
  }
}
