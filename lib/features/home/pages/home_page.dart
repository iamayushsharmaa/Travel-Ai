import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/features/home/pages/widgets/month_widget.dart';
import 'package:triptide/features/home/pages/widgets/trip_view.dart';

import '../provider/trips_home_provider.dart';
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ['hello sululu'];

    final usersTrip = ref.watch(userTripsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trave AI',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 19, top: 8),
            child: GestureDetector(
              onTap: () {
                // Profile tapped
              },
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                child: const Icon(Icons.person, color: Colors.black),
              ),
            ),
          ),
        ],
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            SizedBox(height: 20),
            Expanded(
              child:
                  // usersTrip.when(
                  //   data: (data) {
                  //
                  //   },
                  //   error: (error, stackTrace) => ErrorText(error: error.toString()),
                  //   loading: () => const Loader(),
                  // ),
                  list.isEmpty
                      ? Center(
                        child: Text(
                          'No Trip Yet!',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                      )
                      : ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return TripView(
                            onTripClicked:
                                (travelId) => context.pushNamed(
                                  'trip',
                                  pathParameters: {'travelId': travelId},
                                ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
