import 'package:flutter/material.dart';

class PersonalPreferencesStep extends StatelessWidget {
  final List<String> selectedInterests;
  final Function(List<String>) onInterestsChanged;
  final String? selectedCompanion;
  final Function(String) onCompanionChanged;

  const PersonalPreferencesStep({
    super.key,
    required this.selectedInterests,
    required this.onInterestsChanged,
    required this.selectedCompanion,
    required this.onCompanionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final interestsOptions = [
      "Nature",
      "History",
      "Adventure",
      "Shopping",
      "Food",
      "Other",
    ];
    final companionsOptions = ["Solo", "Partner", "Family", "Friends"];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Who are you traveling with?",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value:
                companionsOptions.contains(selectedCompanion)
                    ? selectedCompanion
                    : null,
            items:
                companionsOptions.map((companion) {
                  return DropdownMenuItem(
                    value: companion,
                    child: Text(companion),
                  );
                }).toList(),
            onChanged: (value) {
              if (value != null) onCompanionChanged(value);
            },
            decoration: InputDecoration(
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
          ),
          const SizedBox(height: 16),
          const Text("Select Your Interests", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children:
                interestsOptions.map((interest) {
                  final isSelected = selectedInterests.contains(interest);
                  return FilterChip(
                    label: Text(interest),
                    selected: isSelected,
                    selectedColor: Colors.blueAccent,
                    onSelected: (value) {
                      final newList = List<String>.from(selectedInterests);
                      value ? newList.add(interest) : newList.remove(interest);
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
