import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/enums/currency.dart';
import '../../../../core/extensions/context_theme.dart';
import '../../../../core/utils.dart';

class BudgetField extends StatelessWidget {
  final TextEditingController controller;
  final Currency selectedCurrency;
  final ValueChanged<Currency> onCurrencyChanged;

  const BudgetField({
    super.key,
    required this.controller,
    required this.selectedCurrency,
    required this.onCurrencyChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = context.colors;
    final textTheme = context.text;

    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        NumberInputFormatter(),
      ],
      style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        hintText: '0',
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: cs.onSurface.withOpacity(0.4),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(14),
          child: Icon(Icons.attach_money, color: cs.onSurface.withOpacity(0.6)),
        ),
        suffixIcon: _CurrencySelector(
          selectedCurrency: selectedCurrency,
          onCurrencyChanged: onCurrencyChanged,
        ),
        filled: true,
        fillColor: cs.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}

class _CurrencySelector extends StatelessWidget {
  final Currency selectedCurrency;
  final ValueChanged<Currency> onCurrencyChanged;

  const _CurrencySelector({
    required this.selectedCurrency,
    required this.onCurrencyChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = context.colors;
    final textTheme = context.text;

    return PopupMenuButton<Currency>(
      icon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: cs.surfaceVariant,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedCurrency.symbol,
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: cs.onSurface,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              color: cs.onSurface.withOpacity(0.6),
              size: 20,
            ),
          ],
        ),
      ),
      onSelected: onCurrencyChanged,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: cs.surface,
      itemBuilder: (context) {
        return Currency.values.map((currency) {
          return PopupMenuItem<Currency>(
            value: currency,
            child: Row(
              children: [
                Text(
                  currency.symbol,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12),
                Text(currency.label, style: textTheme.bodyMedium),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}
