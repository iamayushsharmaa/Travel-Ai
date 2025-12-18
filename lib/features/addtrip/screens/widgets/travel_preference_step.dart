import 'package:flutter/material.dart';
import 'package:triptide/features/addtrip/screens/widgets/step_title.dart';

import 'custom_dropdown.dart';

class TravelPreferencesStep extends StatelessWidget {
  final String accommodation;
  final Function(String) onAccommodationChanged;
  final String transport;
  final Function(String) onTransportChanged;
  final String pace;
  final Function(String) onPaceChanged;
  final String food;
  final Function(String) onFoodChanged;

  const TravelPreferencesStep({
    super.key,
    required this.accommodation,
    required this.onAccommodationChanged,
    required this.transport,
    required this.onTransportChanged,
    required this.pace,
    required this.onPaceChanged,
    required this.food,
    required this.onFoodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StepTitle(
            icon: Icons.tune_outlined,
            title: 'Travel Style',
            subtitle: 'Finalize your preferences',
          ),
          const SizedBox(height: 32),

          CustomDropdown(
            label: 'Accommodation',
            value: accommodation,
            icon: Icons.hotel_outlined,
            options: const ['Hotel', 'Hostel', 'Airbnb', 'Resort', 'Camping'],
            onChanged: onAccommodationChanged,
          ),
          const SizedBox(height: 20),

          CustomDropdown(
            label: 'Transportation',
            value: transport,
            icon: Icons.directions_car_outlined,
            options: const [
              'Public Transport',
              'Rental Car',
              'Taxi/Uber',
              'Walking',
              'Bicycle',
            ],
            onChanged: onTransportChanged,
          ),
          const SizedBox(height: 20),

          CustomDropdown(
            label: 'Trip Pace',
            value: pace,
            icon: Icons.speed_outlined,
            options: const ['Relaxed', 'Moderate', 'Fast-paced'],
            onChanged: onPaceChanged,
          ),
          const SizedBox(height: 20),

          CustomDropdown(
            label: 'Food Preference',
            value: food,
            icon: Icons.restaurant_menu_outlined,
            options: const [
              'Local Cuisine',
              'Vegetarian',
              'Vegan',
              'Fast Food',
              'Fine Dining',
            ],
            onChanged: onFoodChanged,
          ),
        ],
      ),
    );
  }
}
