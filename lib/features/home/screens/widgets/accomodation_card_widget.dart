import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../../../addtrip/models/travel_gemini_response.dart';

class AccommodationSuggestionsWidget extends StatelessWidget {
  final List<AccommodationSuggestion> accommodationSuggestions;

  const AccommodationSuggestionsWidget({
    Key? key,
    required this.accommodationSuggestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 14),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Accommodation Suggestions',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 20),
          ...accommodationSuggestions.map((a) => AccommodationCard(
            name: a.name,
            type: a.type,
            location: a.location,
            priceRange: a.priceRange,
          )),
        ],
      ),
    );
  }
}

class AccommodationCard extends StatelessWidget {
  final String name;
  final String type;
  final String location;
  final String priceRange;

  const AccommodationCard({
    Key? key,
    required this.name,
    required this.type,
    required this.location,
    required this.priceRange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Main blue accent for icons & highlight
    final Color accentColor = Colors.blue.shade700;

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.apartment, color: accentColor),
                const SizedBox(width: 8),
                Text(type,
                    style: const TextStyle(
                        fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.location_on, color: accentColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(location,
                      style: const TextStyle(
                          fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.attach_money, color: accentColor),
                const SizedBox(width: 8),
                Text(priceRange,
                    style: const TextStyle(
                        fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
