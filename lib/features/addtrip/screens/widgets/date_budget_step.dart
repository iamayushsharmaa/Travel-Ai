import 'package:flutter/material.dart';
import 'package:triptide/features/addtrip/screens/widgets/selectable_chip.dart';
import 'package:triptide/features/addtrip/screens/widgets/step_title.dart';

import '../../../../core/enums/budget_type.dart';
import '../../../../core/enums/currency.dart';
import 'budget_field.dart';
import 'date_field.dart';
import 'duration_chip.dart';
import 'input_label.dart';

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

  const DateBudgetStep({
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StepTitle(
            icon: Icons.calendar_today_outlined,
            title: 'When & How Much?',
            subtitle: 'Set your dates and budget',
          ),
          const SizedBox(height: 32),

          // Date selection
          InputLabel(text: 'Travel dates'),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: DateField(
                  controller: startDateController,
                  hintText: 'Start date',
                  onTap: () => _selectStartDate(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
              ),
              Expanded(
                child: DateField(
                  controller: endDateController,
                  hintText: 'End date',
                  onTap: () => _selectEndDate(context),
                ),
              ),
            ],
          ),

          if (startDate != null && endDate != null) ...[
            const SizedBox(height: 12),
            DurationChip(days: endDate!.difference(startDate!).inDays + 1),
          ],

          const SizedBox(height: 32),

          // Budget input
          InputLabel(text: 'Budget'),
          const SizedBox(height: 8),
          BudgetField(
            controller: budgetController,
            selectedCurrency: selectedCurrency,
            onCurrencyChanged: onCurrencyChanged,
          ),
          const SizedBox(height: 16),

          // Budget type
          InputLabel(text: 'Budget type'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children:
                BudgetType.values.map((type) {
                  final isSelected = selectedBudgetType == type;
                  return SelectableChip(
                    label: type.label,
                    icon:
                        type == BudgetType.total
                            ? Icons.account_balance_wallet_outlined
                            : Icons.person_outline,
                    isSelected: isSelected,
                    onTap: () => onBudgetTypeChanged(type),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 730)),
      builder:
          (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(primary: const Color(0xFF2196F3)),
            ),
            child: child!,
          ),
    );

    if (date != null) {
      onStartDateChanged(date);
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    if (startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select a start date first'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
      return;
    }

    final date = await showDatePicker(
      context: context,
      initialDate: endDate ?? startDate!.add(const Duration(days: 1)),
      firstDate: startDate!,
      lastDate: DateTime.now().add(const Duration(days: 730)),
      builder:
          (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(primary: const Color(0xFF2196F3)),
            ),
            child: child!,
          ),
    );

    if (date != null) {
      onEndDateChanged(date);
    }
  }
}
