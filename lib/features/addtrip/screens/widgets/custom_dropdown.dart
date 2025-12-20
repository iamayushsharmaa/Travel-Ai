import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import 'input_label.dart';

class CustomDropdown extends StatefulWidget {
  final String label;
  final String value;
  final IconData icon;
  final List<String> options;
  final ValueChanged<String> onChanged;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.options,
    required this.onChanged,
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
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputLabel(text: widget.label),
        const SizedBox(height: 8),

        DropdownButtonFormField<String>(
          focusNode: _focusNode,
          value: widget.value.isNotEmpty ? widget.value : null,

          items:
              widget.options.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option, style: textTheme.bodyMedium),
                );
              }).toList(),

          onChanged: (value) {
            if (value != null) widget.onChanged(value);
          },

          decoration: InputDecoration(
            hintText: '${context.l10n.select} ${widget.label.toLowerCase()}',

            // ONLY dynamic things here 👇
            prefixIcon: Icon(
              widget.icon,
              color: _isFocused ? cs.primary : theme.iconTheme.color,
            ),
          ),

          dropdownColor: cs.surface,

          icon: Icon(
            Icons.keyboard_arrow_down,
            color: _isFocused ? cs.primary : theme.iconTheme.color,
          ),
        ),
      ],
    );
  }
}
