import 'package:flutter/material.dart';
import 'package:triptide/features/addtrip/screens/widgets/selectable_chip.dart';
import 'package:triptide/features/addtrip/screens/widgets/step_title.dart';

import 'input_label.dart';

class PersonalPreferencesStep extends StatelessWidget {
  final List<String> selectedInterests;
  final Function(List<String>) onInterestsChanged;
  final String selectedCompanion;
  final Function(String) onCompanionChanged;

  const PersonalPreferencesStep({
    super.key,
    required this.selectedInterests,
    required this.onInterestsChanged,
    required this.selectedCompanion,
    required this.onCompanionChanged,
  });

  static const interestsOptions = [
    {'label': 'Nature', 'icon': Icons.forest_outlined},
    {'label': 'History', 'icon': Icons.museum_outlined},
    {'label': 'Adventure', 'icon': Icons.hiking_outlined},
    {'label': 'Shopping', 'icon': Icons.shopping_bag_outlined},
    {'label': 'Food', 'icon': Icons.restaurant_outlined},
    {'label': 'Art', 'icon': Icons.palette_outlined},
  ];

  static const companionOptions = [
    {'label': 'Solo', 'icon': Icons.person_outline},
    {'label': 'Partner', 'icon': Icons.favorite_outline},
    {'label': 'Family', 'icon': Icons.family_restroom_outlined},
    {'label': 'Friends', 'icon': Icons.groups_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StepTitle(
            icon: Icons.favorite_outline,
            title: 'Your Preferences',
            subtitle: 'Help us personalize your trip',
          ),
          const SizedBox(height: 32),

          // Companion selection
          InputLabel(text: 'Traveling with'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children:
                companionOptions.map((option) {
                  final label = option['label'] as String;
                  final icon = option['icon'] as IconData;
                  final isSelected = selectedCompanion == label;
                  return SelectableChip(
                    label: label,
                    icon: icon,
                    isSelected: isSelected,
                    onTap: () => onCompanionChanged(label),
                  );
                }).toList(),
          ),
          const SizedBox(height: 32),

          // Interests selection
          InputLabel(text: 'Interests'),
          Text(
            'Select all that apply',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children:
                interestsOptions.map((option) {
                  final label = option['label'] as String;
                  final icon = option['icon'] as IconData;
                  final isSelected = selectedInterests.contains(label);
                  return SelectableChip(
                    label: label,
                    icon: icon,
                    isSelected: isSelected,
                    onTap: () {
                      final newList = List<String>.from(selectedInterests);
                      if (isSelected) {
                        newList.remove(label);
                      } else {
                        newList.add(label);
                      }
                      onInterestsChanged(newList);
                    },
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
