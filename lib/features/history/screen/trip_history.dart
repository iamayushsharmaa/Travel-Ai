import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enums/trip_filter.dart';
import '../../home/screens/widgets/trip_view.dart';

class TripHistory extends ConsumerStatefulWidget {
  const TripHistory({super.key});

  @override
  ConsumerState<TripHistory> createState() => _TripHistoryState();
}

class _TripHistoryState extends ConsumerState<TripHistory> {

  final list = [' ', ' '];
  TripFilter selectedFilter = TripFilter.all;

  final List<Map<String, dynamic>> allTrips = [
    {
      'id': '1',
      'title': 'Trip to Paris',
      'date': DateTime.now(),
    },
    {
      'id': '2',
      'title': 'Trip to Tokyo',
      'date': DateTime.now().subtract(Duration(days: 30)),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: Text(
          'History',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
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
                            color: Colors.black54,
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
