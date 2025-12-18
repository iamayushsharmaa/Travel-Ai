import 'package:flutter/material.dart';
import 'package:triptide/features/addtrip/screens/widgets/selectable_chip.dart';
import 'package:triptide/features/addtrip/screens/widgets/step_title.dart';

import '../../../../core/enums/trip_type.dart';
import '../../../../core/utility/trip_utils.dart';
import 'input_label.dart';

class DestinationStep extends StatelessWidget {
  final TextEditingController currentLocationController;
  final TextEditingController destinationController;
  final TripType? selectedTripType;
  final ValueChanged<TripType> onTripTypeChanged;

  const DestinationStep({
    super.key,
    required this.currentLocationController,
    required this.destinationController,
    required this.selectedTripType,
    required this.onTripTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StepTitle(
            icon: Icons.place_outlined,
            title: 'Where are you headed?',
            subtitle: 'Tell us about your destination',
          ),
          const SizedBox(height: 32),

          InputLabel(text: 'Destination'),
          const SizedBox(height: 8),
          CustomTextField(
            controller: destinationController,
            hintText: 'e.g., Paris, France',
            prefixIcon: Icons.location_on_outlined,
          ),
          const SizedBox(height: 24),

          InputLabel(text: 'Starting from'),
          const SizedBox(height: 8),
          CustomTextField(
            controller: currentLocationController,
            hintText: 'e.g., New York, USA',
            prefixIcon: Icons.my_location_outlined,
          ),
          const SizedBox(height: 32),

          InputLabel(text: 'Type of trip'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children:
                TripType.values.map((type) {
                  final isSelected = selectedTripType == type;
                  return SelectableChip(
                    label: type.label,
                    icon: getTripTypeIcon(type.label),
                    isSelected: isSelected,
                    onTap: () => onTripTypeChanged(type),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
