import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:triptide/core/enums/budget_type.dart';

import '../../../../core/enums/currency.dart';

class DateBudgetStep extends StatelessWidget {
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final TextEditingController budgetController;
  final DateTime? startDate;
  final DateTime? endDate;
  final Currency selectedCurrency;
  final ValueChanged<Currency> onCurrencyChanged;
  final BudgetType selectedBudgetType;
  final ValueChanged<BudgetType> onBudgetTypeChanged;
  final Function(DateTime) onStartDateChanged;
  final Function(DateTime) onEndDateChanged;

  DateBudgetStep({
    super.key,
    required this.startDateController,
    required this.endDateController,
    required this.budgetController,
    required this.startDate,
    required this.endDate,
    required this.selectedCurrency,
    required this.onCurrencyChanged,
    required this.selectedBudgetType,
    required this.onBudgetTypeChanged,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Select your travel dates",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: startDateController,
            readOnly: true,
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (date != null) {
                onStartDateChanged(date);
                startDateController.text = DateFormat.yMMMd().format(date);
              }
            },
            decoration: InputDecoration(
              hintText: "Start Date",
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
              suffixIcon: Icon(Icons.calendar_month),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: endDateController,
            readOnly: true,
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (date != null) {
                onEndDateChanged(date);
                endDateController.text = "${DateFormat.yMMMd().format(date)}";
              }
            },
            decoration: InputDecoration(
              hintText: "End Date",
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
              suffixIcon: Icon(Icons.calendar_month),
            ),
          ),
          const SizedBox(height: 20),
          Text('What\'s your budget?', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          TextField(
            controller: budgetController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Budget",
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
              suffixIcon: PopupMenuButton<Currency>(
                icon: Text(
                  selectedCurrency.symbol,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onSelected: (Currency currency) {
                  onCurrencyChanged(currency);
                },
                itemBuilder: (context) {
                  return Currency.values.map((Currency currency) {
                    return PopupMenuItem<Currency>(
                      value: currency,
                      child: Text("${currency.label} (${currency.symbol})"),
                    );
                  }).toList();
                },
              ),
            ),
            maxLines: 1,
          ),
          const SizedBox(height: 20),
          Text(
            'Budget type',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children:
                BudgetType.values.map((value) {
                  final isSelected = selectedBudgetType == value;
                  return ChoiceChip(
                    label: Text(value.label),
                    selected: isSelected,
                    selectedColor: Colors.blueAccent,
                    onSelected: (_) {
                      onBudgetTypeChanged(value);
                      },
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
