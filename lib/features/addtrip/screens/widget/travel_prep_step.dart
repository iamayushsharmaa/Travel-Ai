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
          CustomDropdown(
            label: "Accommodation Type",
            value: accommodation,
            onChanged: onAccommodationChanged,
            options: ["Hotel", "Hostel", "Airbnb", "Resort"],
            hintText: 'Select Accommodation Type',
          ),
          const SizedBox(height: 16),
          CustomDropdown(
            label: "Transport Preferences",
            value: transport,
            onChanged: onTransportChanged,
            options: ["Public Transport", "Rental Car", "Taxi", "Walking"],
            hintText: 'Select Transport Preference',
          ),
          const SizedBox(height: 20),
          CustomDropdown(
            label: "Preferred Pace",
            value: pace,
            onChanged: onPaceChanged,
            options: ["Relaxed", "Moderate", "Busy"],
            hintText: 'Select Preferred Pace',
          ),
          const SizedBox(height: 20),
          CustomDropdown(
            label: "Food Preference",
            value: food,
            onChanged: onFoodChanged,
            options: [
              "Local Cuisine",
              "Vegetarian",
              "Fast Food",
              "Fine Dining",
            ],
            hintText: 'Select Food Preference',
          ),
        ],
      ),
    );
  }
}

class CustomDropdown extends StatefulWidget {
  final String label;
  final String value;
  final List<String> options;
  final String hintText;
  final Function(String) onChanged;

  const CustomDropdown({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    this.hintText = "Select an option",
    super.key,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: DropdownButtonFormField<String>(

        focusNode: _focusNode,
        value: widget.value.isNotEmpty ? widget.value : null,
        items:
            widget.options.map((option) {
              return DropdownMenuItem(value: option, child: Text(option));
            }).toList(),
        onChanged: (val) {
          if (val != null) widget.onChanged(val);
        },
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: _isFocused ? Colors.blueAccent : Colors.grey,
          ),
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blueAccent, width: 2),
          ),
        ),
        dropdownColor: Colors.white,
        iconEnabledColor: _isFocused ? Colors.blueAccent : Colors.grey,
      ),
    );
  }
}
