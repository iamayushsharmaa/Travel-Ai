import 'package:flutter/material.dart';

import '../../../../core/enums/trip_type.dart';

class DestinationStep extends StatelessWidget {
  final TextEditingController destinationController;
  final TripType? selectedTripType;
  final ValueChanged<TripType> onTripTypeChanged;

  DestinationStep({
    super.key,
    required this.destinationController,
    required this.selectedTripType, required this.onTripTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text("Where are you going?", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          TextField(
            controller: destinationController,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: 'City, Country',
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
            ),
          ),
          const SizedBox(height: 20),
          Text('What\'s your trip type?', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children:
                TripType.values.map((type) {
                  final bool isSelected = selectedTripType == type;
                  return ChoiceChip(
                    label: Text(type.label),
                    selected: isSelected,
                    selectedColor: Colors.blueAccent,
                    onSelected: (_)=> onTripTypeChanged(type),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
