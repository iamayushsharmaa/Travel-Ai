import 'package:flutter/material.dart';
import 'package:triptide/features/trip/screen/widgets/section_header.dart';

import 'detail_row.dart';

class AccommodationSection extends StatelessWidget {
  final List<dynamic> suggestions;

  const AccommodationSection({
    super.key,
    required this.suggestions,
  });

  @override
  Widget build(BuildContext context) {
    if (suggestions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          icon: Icons.hotel_outlined,
          title: 'Accommodation',
        ),
        const SizedBox(height: 16),
        ...suggestions.map((suggestion) {
          return AccommodationCard(
            name: suggestion.name ?? 'N/A',
            type: suggestion.type ?? 'N/A',
            location: suggestion.location ?? 'N/A',
            priceRange: suggestion.priceRange ?? 'N/A',
          );
        }).toList(),
      ],
    );
  }
}

class AccommodationCard extends StatelessWidget {
  final String name;
  final String type;
  final String location;
  final String priceRange;

  const AccommodationCard({
    super.key,
    required this.name,
    required this.type,
    required this.location,
    required this.priceRange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF2196F3).withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.apartment,
                  color: Color(0xFF2196F3),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      type,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DetailRow(
            icon: Icons.location_on_outlined,
            label: 'Location',
            value: location,
          ),
          const SizedBox(height: 8),
          DetailRow(
            icon: Icons.attach_money,
            label: 'Price Range',
            value: priceRange,
          ),
        ],
      ),
    );
  }
}
