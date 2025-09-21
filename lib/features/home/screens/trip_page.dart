import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart' hide TransportationDetails;
import 'package:triptide/core/common/error_text.dart';
import 'package:triptide/core/common/loader.dart';
import 'package:triptide/features/home/provider/trips_home_provider.dart';
import 'package:triptide/features/home/screens/widgets/accomodation_card_widget.dart';
import 'package:triptide/features/home/screens/widgets/overview_widget.dart';
import 'package:triptide/features/home/screens/widgets/timeline_widget.dart';
import 'package:triptide/features/home/screens/widgets/transport_widget.dart';
import 'package:triptide/features/home/screens/widgets/trip_map_widget.dart';

import '../../weather/provider/weather_provider.dart';
import '../../weather/widgets/weather_widget.dart';

class TripPage extends ConsumerWidget {
  final String travelId;

  const TripPage({super.key, required this.travelId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripAsync = ref.watch(tripByIdProvider(travelId));

    return tripAsync.when(
      data: (trip) {
        if (trip == null) {
          return Scaffold(appBar: AppBar(title: Text('No Trips')));
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              centerTitle: true,
              title: Text(
                'Trip to ${trip.destination}',
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // icon color
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                  onPressed: () => context.goNamed('home'),
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              'Delete Trip',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            content: const Text(
                              'Are you sure you want to delete this trip?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );

                      if (confirm == true) {
                        final result = await ref.read(
                          deleteTripProvider(travelId).future,
                        );
                        result.fold(
                          (failure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Failed to delete trip: ${failure.message}',
                                ),
                              ),
                            );
                          },
                          (_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Trip deleted successfully'),
                              ),
                            );
                            // Pop back to TripHistoryScreen
                            context.pop();
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OverviewCard(
                    route: '${trip.currentLocation} - ${trip.destination}',
                    tripType: trip.tripType!,
                    peopleCount: '${trip.totalPeople} People',
                    duration: '${trip.totalDays} days',
                  ),
                  const SizedBox(height: 26),
                  Text(
                    'Itinerary',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    itemCount: trip.dailyPlan.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return TimeLineWidget(
                        isFirst: index == 0,
                        isLast: index == trip.dailyPlan.length - 1,
                        dayPlan: trip.dailyPlan[index],
                      );
                    },
                  ),

                  const SizedBox(height: 24),
                  AccommodationSuggestionsWidget(
                    accommodationSuggestions: trip.accommodationSuggestions,
                  ),
                  const SizedBox(height: 24),
                  TransportWidget(
                    transportationDetails: trip.transportationDetails,
                  ),
                  //weather card
                  const SizedBox(height: 20),
                  Consumer(
                    builder: (context, ref, _) {
                      final forecastAsync = ref.watch(
                        weatherForecastProvider(
                          trip.destinationLat!,
                          trip.destinationLng!,
                        ),
                      );

                      return forecastAsync.when(
                        data: (forecastList) {
                          if (forecastList.isEmpty) return const SizedBox();
                          final today = forecastList.first;
                          return WeatherCard(
                            destination: trip.destination,
                            forecast: today,
                          );
                        },
                        loading:
                            () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                        error: (err, _) => const Text('Failed to load weather'),
                      );
                    },
                  ),
                  // google map
                  const SizedBox(height: 20),
                  TripMap(
                    currentLat: trip.currentLat ?? 0.0,
                    currentLng: trip.currentLng ?? 0.0,
                    destinationLat: trip.destinationLat ?? 0.0,
                    destinationLng: trip.destinationLng ?? 0.0,
                    destinationName: trip.destination,
                    height: 200
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 36,
                          color: Colors.green.shade700,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Estimated Budget',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade800,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${trip.budget}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.green.shade900,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
      error:
          (error, stackTrace) => Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              centerTitle: true,
              title: Text(
                '',
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // icon color
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                ),
              ),
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            body: ErrorText(error: error.toString()),
          ),
      loading:
          () => Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              centerTitle: true,
              title: Text(
                '',
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // icon color
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                ),
              ),
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            body: const Loader(),
          ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required String content,
    Color? iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor ?? Colors.grey),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
