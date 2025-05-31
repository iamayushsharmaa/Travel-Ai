import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/core/utils.dart';
import 'package:triptide/features/home/screens/widgets/month_widget.dart';
import 'package:triptide/features/home/screens/widgets/trip_view.dart';

import '../provider/trips_home_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = [' ', ' ', ' ', ' ', ' ', ' '];

    final usersTrip = ref.watch(userTripsProvider);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            backgroundColor: Colors.grey.shade100,
            elevation: 0.5,
            expandedHeight: 76,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 14),
              title: Text(
                'Travel AI',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 12),
                child: GestureDetector(
                  onTap: () {
                    context.pushNamed('search');
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    child: const Icon(Icons.search, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 19, top: 8),
                child: GestureDetector(
                  onTap: () {
                    context.pushNamed('profile');
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    child: const Icon(Icons.person, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  MonthWidget(),
                  const SizedBox(height: 20),
                  Text(
                    'Your Trips',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (list.isEmpty)
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'No Trip Yet!',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(childCount: list.length, (
                context,
                index,
              ) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TripView(
                    onTripClicked:
                        (travelId) => context.pushNamed(
                          'trip',
                          pathParameters: {'travelId': travelId},
                        ),
                  ),
                );
              }),
            ),
        ],
      ),
    );
  }
}
