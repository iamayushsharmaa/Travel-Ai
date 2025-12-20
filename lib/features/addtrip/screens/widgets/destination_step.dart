import 'package:flutter/material.dart';
import 'package:triptide/features/addtrip/screens/widgets/selectable_chip.dart';
import 'package:triptide/features/addtrip/screens/widgets/step_title.dart';

import '../../../../core/enums/trip_type.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utilities/trip_utils.dart';
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
    final l10n = context.l10n;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StepTitle(
            icon: Icons.place_outlined,
            title: l10n.destination_step_title,
            subtitle: l10n.destination_step_subtitle,
          ),
          const SizedBox(height: 32),

          InputLabel(text: l10n.destination_label),
          const SizedBox(height: 8),
          CustomTextField(
            controller: destinationController,
            hintText: l10n.destination_hint,
            prefixIcon: Icons.location_on_outlined,
          ),
          const SizedBox(height: 24),

          InputLabel(text: l10n.starting_from_label),
          const SizedBox(height: 8),
          CustomTextField(
            controller: currentLocationController,
            hintText: l10n.starting_from_hint,
            prefixIcon: Icons.my_location_outlined,
          ),
          const SizedBox(height: 32),

          InputLabel(text: l10n.trip_type_label),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children:
                TripType.values.map((type) {
                  return SelectableChip(
                    label: type.label,
                    icon: getTripTypeIcon(type.label),
                    isSelected: selectedTripType == type,
                    onTap: () => onTripTypeChanged(type),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
