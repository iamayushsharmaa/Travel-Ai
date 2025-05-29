import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart' hide TransportationDetails;
import 'package:triptide/features/home/pages/widgets/accomodation_card_widget.dart';
import 'package:triptide/features/home/pages/widgets/overview_widget.dart';
import 'package:triptide/features/home/pages/widgets/timeline_widget.dart';
import 'package:triptide/features/home/pages/widgets/transport_widget.dart';

import '../../addtrip/models/travel_gemini_model.dart';

class TripPage extends StatelessWidget {
  final String travelId;

  const TripPage({super.key, required this.travelId});

  @override
  Widget build(BuildContext context) {
    List<DayPlan> itinerary = [
      DayPlan(
        day: 1,
        date: "29 Jun 25",
        activities: [
          Activity(description: "Arrive at Goa Airport", time: ''),
          Activity(description: "Check-in to hotel", time: ''),
          Activity(description: "Evening beach walk and dinner", time: ''),
        ],
      ),
      DayPlan(
        day: 2,
        date: "30 Jun 25",
        activities: [
          Activity(description: "Breakfast at hotel", time: ''),
          Activity(description: "Visit Fort Aguada", time: ''),
          Activity(description: "Lunch at local restaurant", time: ''),
        ],
      ),
      DayPlan(
        day: 3,
        date: "29 Jun 25",
        activities: [
          Activity(description: "Arrive at Goa Airport", time: ''),
          Activity(description: "Check-in to hotel", time: ''),
          Activity(description: "Evening beach walk and dinner", time: ''),
        ],
      ),
      DayPlan(
        day: 4,
        date: "30 Jun 25",
        activities: [
          Activity(description: "Breakfast at hotel", time: ''),
          Activity(description: "Visit Fort Aguada", time: ''),
          Activity(description: "Lunch at local restaurant", time: ''),
        ],
      ),
    ];

    final transportationDetails = TransportationDetails(
      transportModes: ['Bus', 'Taxi', 'Train'],
      localTransport: 'Local buses and taxis are widely available...',
      tips: 'Try to avoid peak hours for better experience.',
    );

    final List<AccommodationSuggestion> accommodationSuggestions = [
      AccommodationSuggestion(
        name: 'Palm Beach Resort',
        type: 'Resort',
        location: 'Candolim Beach, Goa',
        priceRange: '₹3,000 – ₹5,000 per night',
      ),
      AccommodationSuggestion(
        name: 'Goa Backpackers Hostel',
        type: 'Hostel',
        location: 'Anjuna, Goa',
        priceRange: '₹500 – ₹1,200 per night',
      ),
      AccommodationSuggestion(
        name: 'The Sunset Villa',
        type: 'Homestay',
        location: 'Arambol, Goa',
        priceRange: '₹1,800 – ₹2,500 per night',
      ),
      AccommodationSuggestion(
        name: 'Bayview Business Hotel',
        type: 'Hotel',
        location: 'Panaji, Goa',
        priceRange: '₹2,500 – ₹4,000 per night',
      ),
      AccommodationSuggestion(
        name: 'Tropical Treehouse Stay',
        type: 'Treehouse',
        location: 'South Goa Hills',
        priceRange: '₹4,000 – ₹6,000 per night',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        // soft shadow for separation
        centerTitle: true,
        title: Text(
          'Trip to Goa',
          style: const TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OverviewCard(
              route: 'Delhi - Goa',
              tripType: 'Adventure',
              peopleCount: '4 People',
              duration: '4 days',
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
            ...List.generate(itinerary.length, (index) {
              return TimeLineWidget(
                isFirst: index == 0,
                isLast: index == itinerary.length - 1,
                dayPlan: itinerary[index],
              );
            }),

            const SizedBox(height: 24),
            AccommodationSuggestionsWidget(
              accommodationSuggestions: accommodationSuggestions,
            ),
            const SizedBox(height: 24),
            TransportWidget(transportationDetails: transportationDetails),
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
                          '\$ 40,000',
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
