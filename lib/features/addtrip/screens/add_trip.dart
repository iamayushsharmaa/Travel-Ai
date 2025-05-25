import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:triptide/core/enums/trip_type.dart';

import '../../../core/enums/currency.dart';

class AddTripPage extends StatefulWidget {
  const AddTripPage({super.key});

  @override
  State<AddTripPage> createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  final PageController _pageController = PageController();
  int _currentStep = 1;
  final int _totalSteps = 4;

  final TextEditingController destinationController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  TripType? selectedTripType;
  DateTime? startDate;
  DateTime? endDate;
  final TextEditingController budgetController = TextEditingController();
  Currency selectedCurrency = Currency.usd;

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
        _pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_currentStep + 1) / _totalSteps;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Plan Your Trip',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 17,
                borderRadius: BorderRadius.circular(10),
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Colors.blueAccent,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _stepDestination(),
                  _stepDates(),
                  _stepBudget(),
                  _stepInterest(),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _currentStep > 0 ? _previousStep : null,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide.none,
                        ),
                        backgroundColor: Colors.white.withOpacity(0.8),
                        foregroundColor: Colors.blueAccent,
                      ),
                      child: const Text('Back'),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _nextStep,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide.none,
                        ),
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        _currentStep == _totalSteps - 1 ? "Submit" : "Next",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _stepDestination() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text("Where are you going?", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          TextField(
            controller: destinationController,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: 'City, Country',
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
            ),
          ),
          const SizedBox(height: 20),
          Text('What\'s your trip type?', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children:
                TripType.values.map((type) {
                  final bool isSelected = selectedTripType == type;
                  return ChoiceChip(
                    label: Text(type.label),
                    selected: isSelected,
                    selectedColor: Colors.blueAccent,
                    onSelected: (_) {
                      setState(() => selectedTripType = type);
                    },
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _stepDates() {
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
                setState(() {
                  startDate = date;
                  startDateController.text =
                      "${DateFormat.yMMMd().format(date)}";
                });
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
                setState(() {
                  endDate = date;
                  endDateController.text = "${DateFormat.yMMMd().format(date)}";
                });
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
                  setState(() {
                    selectedCurrency = currency;
                  });
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
        ],
      ),
    );
  }

  Widget _stepBudget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("What's your budget?", style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  Widget _stepInterest() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("What's your budget?", style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
