import 'package:flutter/material.dart';
import 'package:triptide/features/addtrip/models/travel_db_model.dart';

class TripView extends StatelessWidget {
  final TravelDbModel trip;
  final void Function(TravelDbModel trip) onTripClicked;

  const TripView({super.key, required this.onTripClicked, required this.trip});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTripClicked(trip),
      child: Container(
        height: 160,
        margin: const EdgeInsets.symmetric(vertical: 7),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/travel.jpg',
                height: double.infinity,
                width: 130,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${trip.totalDays}',
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                      Text(
                        '${trip.startDate} - ${trip.endDate}',
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Text(
                    trip.destination,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Text(
                        'Budget: ',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      Text(
                        '${trip.budget}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      trip.tripType,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
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
}
