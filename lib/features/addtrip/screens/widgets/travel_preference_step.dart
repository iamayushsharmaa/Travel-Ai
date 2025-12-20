import 'package:flutter/material.dart';
import 'package:triptide/features/addtrip/screens/widgets/step_title.dart';

import '../../../../core/extensions/context_l10n.dart';
import 'custom_dropdown.dart';

class TravelPreferencesStep extends StatelessWidget {
  final String accommodation;
  final ValueChanged<String> onAccommodationChanged;
  final String transport;
  final ValueChanged<String> onTransportChanged;
  final String pace;
  final ValueChanged<String> onPaceChanged;
  final String food;
  final ValueChanged<String> onFoodChanged;

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
    final l10n = context.l10n;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StepTitle(
            icon: Icons.tune_outlined,
            title: l10n.travel_preferences_title,
            subtitle: l10n.travel_preferences_subtitle,
          ),
          const SizedBox(height: 32),

          CustomDropdown(
            label: l10n.accommodation,
            value: accommodation,
            icon: Icons.hotel_outlined,
            options: [
              l10n.accommodation_hotel,
              l10n.accommodation_hostel,
              l10n.accommodation_airbnb,
              l10n.accommodation_resort,
              l10n.accommodation_camping,
            ],
            onChanged: onAccommodationChanged,
          ),
          const SizedBox(height: 20),

          CustomDropdown(
            label: l10n.transportation,
            value: transport,
            icon: Icons.directions_car_outlined,
            options: [
              l10n.transport_public,
              l10n.transport_rental,
              l10n.transport_taxi,
              l10n.transport_walking,
              l10n.transport_bicycle,
            ],
            onChanged: onTransportChanged,
          ),
          const SizedBox(height: 20),

          CustomDropdown(
            label: l10n.trip_pace,
            value: pace,
            icon: Icons.speed_outlined,
            options: [l10n.pace_relaxed, l10n.pace_moderate, l10n.pace_fast],
            onChanged: onPaceChanged,
          ),
          const SizedBox(height: 20),

          CustomDropdown(
            label: l10n.food_preference,
            value: food,
            icon: Icons.restaurant_menu_outlined,
            options: [
              l10n.food_local,
              l10n.food_vegetarian,
              l10n.food_vegan,
              l10n.food_fast_food,
              l10n.food_fine_dining,
            ],
            onChanged: onFoodChanged,
          ),
        ],
      ),
    );
  }
}
