import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart' hide TransportationDetails;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:triptide/core/common/error_text.dart';
import 'package:triptide/core/common/loader.dart';
import 'package:triptide/features/home/provider/trips_home_provider.dart';
import 'package:triptide/features/home/screens/widgets/accomodation_card_widget.dart';
import 'package:triptide/features/home/screens/widgets/overview_widget.dart';
import 'package:triptide/features/home/screens/widgets/timeline_widget.dart';
import 'package:triptide/features/home/screens/widgets/transport_widget.dart';

import '../../weather/provider/weather_provider.dart';

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
                        weatherForecastProvider(77.0, 98.0),
                      );

                      return forecastAsync.when(
                        data: (forecast) {
                          if (forecast.isEmpty) {
                            return SizedBox(); // No forecast data
                          }

                          final today =
                              forecast
                                  .first; // Show first day only (or customize)
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
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
                                  Icons.wb_sunny_rounded,
                                  // Can be dynamic based on condition
                                  size: 40,
                                  color: Colors.orange.shade700,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Weather in ${trip.destination}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue.shade900,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        '${today.condition} | ${today.minTemp}° / ${today.maxTemp}°',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Rain: ${today.rainChance}% | Humidity: ${today.humidity}%',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        loading:
                            () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                        error: (err, _) => Text('Failed to load weather'),
                      );
                    },
                  ),
                  // google map
                  const SizedBox(height: 20),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(77.8, 98.0),
                          // Destination coordinates for now its fake
                          zoom: 12,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId('destination'),
                            position: LatLng(77.8, 98.0),
                            infoWindow: InfoWindow(title: trip.destination),
                          ),
                        },
                        zoomControlsEnabled: false,
                        myLocationButtonEnabled: false,
                        onMapCreated: (GoogleMapController controller) {
                          // Optionally keep a controller reference if needed
                        },
                      ),
                    ),
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
