import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/core/common/error_text.dart';
import 'package:triptide/core/common/loader.dart';
import 'package:triptide/core/enums/trip_filter.dart';

import '../../home/screens/widgets/trip_view.dart';
import '../provider/trip_history_provider.dart';

class TripHistory extends ConsumerStatefulWidget {
  const TripHistory({super.key});

  @override
  ConsumerState<TripHistory> createState() => _TripHistoryState();
}

class _TripHistoryState extends ConsumerState<TripHistory> {
  void onFitlerSelected(TripFilter filter) {
    ref.read(tripFilterNotifierProvider.notifier).setFilter(filter);
  }

  @override
  Widget build(BuildContext context) {
    final selectedFilter = ref.watch(tripFilterNotifierProvider);
    final userHistoryTrips = ref.watch(userHistoryTripsProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 1,
        title: Text(
          'History',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: TripFilter.values.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final filter = TripFilter.values[index];
                  final isSelected = filter == selectedFilter;
                  return ChoiceChip(
                    label: Text(filter.label),
                    selected: isSelected,
                    onSelected: (_) => onFitlerSelected(filter),
                    selectedColor: Colors.blueAccent,
                    backgroundColor: Colors.grey.shade300,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: userHistoryTrips.when(
                data: (data) {
                  if (data.isEmpty) {
                    return const Center(
                      child: Text(
                        'No Trip Yet!',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black54,
                          fontSize: 18,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final trip = data[index];
                        return TripView(
                          trip: trip,
                          onTripClicked:
                              (trip) => context.pushNamed(
                                'trip',
                                pathParameters: {'travelId': trip.travelId},
                              ),
                        );
                      },
                    );
                  }
                },
                error:
                    (error, stackTrace) => ErrorText(error: error.toString()),
                loading: () => const Loader(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
