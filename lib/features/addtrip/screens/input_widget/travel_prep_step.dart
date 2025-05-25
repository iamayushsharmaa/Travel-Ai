import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildDropdown(
            "Accommodation Type",
            accommodation,
            onAccommodationChanged,
            ["Hotel", "Hostel", "Airbnb", "Resort"],
          ),
          const SizedBox(height: 16),
          _buildDropdown(
            "Transport Preferences",
            transport,
            onTransportChanged,
            ["Public Transport", "Rental Car", "Taxi", "Walking"],
          ),
          const SizedBox(height: 16),
          _buildDropdown("Preferred Pace", pace, onPaceChanged, [
            "Relaxed",
            "Moderate",
            "Busy",
          ]),
          const SizedBox(height: 16),
          _buildDropdown("Food Preference", food, onFoodChanged, [
            "Local Cuisine",
            "Vegetarian",
            "Fast Food",
            "Fine Dining",
          ]),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String value,
    Function(String) onChanged,
    List<String> options,
  ) {
    return DropdownButtonFormField<String>(
      value: value.isNotEmpty ? value : null,
      items:
          options.map((option) {
            return DropdownMenuItem(value: option, child: Text(option));
          }).toList(),
      onChanged: (val) {
        if (val != null) onChanged(val);
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.blueAccent, // Red when focused
            width: 2,
          ),
        ),
        hintText: "Select companion",
      ),
    );
  }
}
