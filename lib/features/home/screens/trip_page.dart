import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/core/utils.dart';
import 'package:triptide/features/home/screens/widgets/timeline_widget.dart';

class TripPage extends StatelessWidget {
  final String travelId;

  const TripPage({super.key, required this.travelId});

  @override
  Widget build(BuildContext context) {
    final List<String> itinerary = [
      'Day 1: Arrival & Beach Visit',
      'Day 2: Sightseeing',
      'Day 3: Arrival & Beach Visit',
      'Day 4: Sightseeing',
      'Day 5: Arrival & Beach Visit',
      'Day 6: Sightseeing',
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Trip to Goa',
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    IconTextDesign(
                      text: 'Delhi - Goa',
                      icon: Icon(Icons.flight, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    IconTextDesign(
                      text: 'Business',
                      icon: Icon(
                        getTripTypeIcon('Business'),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    IconTextDesign(
                      text: '4 people',
                      icon: Icon(Icons.people, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    IconTextDesign(
                      text: '10 days',
                      icon: Icon(Icons.access_time, color: Colors.white),
                    ),
                  ],
                ),
              ),
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
            Expanded(
              child: ListView.builder(
                itemCount: itinerary.length,
                itemBuilder: (context, index) {
                  return TimeLineWidget(
                    isFirst: index == 0,
                    isLast: index == itinerary.length - 1,
                    dayText: itinerary[index],
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

class IconTextDesign extends StatelessWidget {
  final String text;
  final Icon icon;

  const IconTextDesign({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon,
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
