import 'package:flutter/material.dart';
import 'package:triptide/core/extensions/context_l10n.dart';
import 'package:triptide/features/addtrip/screens/widgets/selectable_chip.dart';
import 'package:triptide/features/addtrip/screens/widgets/step_title.dart';

import 'input_label.dart';

class PersonalPreferencesStep extends StatelessWidget {
  final List<String> selectedInterests;
  final ValueChanged<List<String>> onInterestsChanged;
  final String selectedCompanion;
  final ValueChanged<String> onCompanionChanged;

  const PersonalPreferencesStep({
    super.key,
    required this.selectedInterests,
    required this.onInterestsChanged,
    required this.selectedCompanion,
    required this.onCompanionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    final interestsOptions = [
      (l10n.interest_nature, Icons.forest_outlined),
      (l10n.interest_history, Icons.museum_outlined),
      (l10n.interest_adventure, Icons.hiking_outlined),
      (l10n.interest_shopping, Icons.shopping_bag_outlined),
      (l10n.interest_food, Icons.restaurant_outlined),
      (l10n.interest_art, Icons.palette_outlined),
    ];

    final companionOptions = [
      (l10n.companion_solo, Icons.person_outline),
      (l10n.companion_partner, Icons.favorite_outline),
      (l10n.companion_family, Icons.family_restroom_outlined),
      (l10n.companion_friends, Icons.groups_outlined),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StepTitle(
            icon: Icons.favorite_outline,
            title: l10n.personal_preferences_title,
            subtitle: l10n.personal_preferences_subtitle,
          ),
          const SizedBox(height: 32),

          InputLabel(text: l10n.traveling_with),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children:
                companionOptions.map((option) {
                  final label = option.$1;
                  final icon = option.$2;
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

          InputLabel(text: l10n.interests),
          const SizedBox(height: 4),
          Text(l10n.select_all_that_apply, style: theme.textTheme.labelSmall),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children:
                interestsOptions.map((option) {
                  final label = option.$1;
                  final icon = option.$2;
                  final isSelected = selectedInterests.contains(label);

                  return SelectableChip(
                    label: label,
                    icon: icon,
                    isSelected: isSelected,
                    onTap: () {
                      final updated = List<String>.from(selectedInterests);
                      isSelected ? updated.remove(label) : updated.add(label);
                      onInterestsChanged(updated);
                    },
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
