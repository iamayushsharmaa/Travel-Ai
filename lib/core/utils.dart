import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));
}

class NumberInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.decimalPattern();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text.replaceAll(',', '');

    if (newText.isEmpty) return newValue;

    final number = int.tryParse(newText);
    if (number == null) return oldValue;

    final newFormatted = _formatter.format(number);
    final selectionIndex = newFormatted.length;

    return TextEditingValue(
      text: newFormatted,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

IconData getTripTypeIcon(String tripType) {
  switch (tripType.toLowerCase()) {
    case 'business':
      return Icons.business_center;
    case 'vacation':
      return Icons.beach_access;
    case 'romantic':
      return Icons.favorite;
    case 'adventure':
      return Icons.terrain;
    case 'roadtrip':
      return Icons.route;
    case 'other':
    default:
      return Icons.travel_explore;
  }
}