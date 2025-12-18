import 'package:flutter/material.dart';

import 'input_label.dart';

class CustomDropdown extends StatefulWidget {
  final String label;
  final String value;
  final IconData icon;
  final List<String> options;
  final Function(String) onChanged;

  const CustomDropdown({
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
                return DropdownMenuItem(value: option, child: Text(option));
              }).toList(),
          onChanged: (value) {
            if (value != null) widget.onChanged(value);
          },
          decoration: InputDecoration(
            hintText: 'Select ${widget.label.toLowerCase()}',
            hintStyle: TextStyle(color: Colors.grey.shade400),
            prefixIcon: Icon(
              widget.icon,
              color:
                  _isFocused ? const Color(0xFF2196F3) : Colors.grey.shade400,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2196F3), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          dropdownColor: Colors.white,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: _isFocused ? const Color(0xFF2196F3) : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
