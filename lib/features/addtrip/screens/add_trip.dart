import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/core/common/loader.dart';
import 'package:triptide/core/enums/trip_type.dart';
import 'package:triptide/features/addtrip/providers/travel_provider.dart';
import 'package:triptide/features/addtrip/screens/widget/date_budget_step.dart';
import 'package:triptide/features/addtrip/screens/widget/destination_step.dart';
import 'package:triptide/features/addtrip/screens/widget/personal_exp_step.dart';
import 'package:triptide/features/addtrip/screens/widget/travel_prep_step.dart';

import '../../../core/enums/budget_type.dart';
import '../../../core/enums/currency.dart';
import '../models/TripPlanRequest.dart';

class AddTripPage extends ConsumerStatefulWidget {
  const AddTripPage({super.key});

  @override
  ConsumerState createState() => _AddTripPageState();
}

class _AddTripPageState extends ConsumerState<AddTripPage> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final int _totalSteps = 4;

  final TextEditingController currentLocationController =
      TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  TripType? selectedTripType;
  DateTime? startDate;
  DateTime? endDate;
  Currency selectedCurrency = Currency.usd;
  BudgetType selectedBudgetType = BudgetType.total;

  List<String> selectedInterest = [];
  String selectedCompanion = '';
  String accommodation = '';
  String transport = '';
  String pace = '';
  String food = '';

  void onSubmitClick() async {
    FocusScope.of(context).unfocus();
    final isLoading = ref.read(submitLoadingProvider.notifier);
    isLoading.setLoading(true);
    if (startDate == null || endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select both start and end dates."),
        ),
      );
      return;
    }

    if (selectedTripType == null || selectedCompanion == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select trip type and companion.")),
      );
      return;
    }

    final budgetRaw = budgetController.text.replaceAll(',', '');
    final double budget = double.tryParse(budgetRaw) ?? 0.0;

    final tripPlanRequest = TripPlanRequest(
      currentLocation: currentLocationController.text.trim(),
      destination: destinationController.text.trim(),
      startDate: startDate!,
      endDate: endDate!,
      tripType: selectedTripType.toString(),
      budget: budget,
      budgetType: selectedBudgetType.toString(),
      interests: selectedInterest,
      companions: selectedCompanion,
      accommodationType: selectedCompanion,
      transportPreferences: transport,
      pace: pace,
      food: food,
    );

    try {
      final travelId = await ref.watch(
        generateAndStoreTripProvider(tripPlanRequest).future,
      );
      context.pushReplacementNamed(
        'trip',
        pathParameters: {'travelId': travelId},
        extra: {'fromCreation': true}, // Pass flag to indicate trip creation
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to create trip: $e")));
    } finally {
      isLoading.setLoading(false);
    }
  }

  void onTripTypeChanged(TripType type) {
    setState(() {
      selectedTripType = type;
    });
  }

  void onCurrencyChanged(Currency currency) {
    setState(() {
      selectedCurrency = currency;
    });
  }

  void onBudgetTypeChanged(BudgetType budgetType) {
    setState(() {
      selectedBudgetType = budgetType;
    });
  }

  void onStartDateChanged(DateTime date) {
    setState(() {
      startDate = date;
    });
  }

  void onEndDateChanged(DateTime date) {
    setState(() {
      endDate = date;
    });
  }

  void onInterestsChanged(List<String> interest) {
    setState(() {
      selectedInterest = interest;
    });
  }

  void onCompaionChanged(String companion) {
    setState(() {
      selectedCompanion = companion;
    });
  }

  void onAccommodationChanged(String value) {
    setState(() {
      accommodation = value;
    });
  }

  void onTransportChanged(String value) {
    setState(() {
      transport = value;
    });
  }

  void onPaceChanged(String value) {
    setState(() {
      pace = value;
    });
  }

  void onFoodChanged(String value) {
    setState(() {
      food = value;
    });
  }

  bool _isStepValid() {
    switch (_currentStep) {
      case 0:
        return destinationController.text.isNotEmpty;
      case 1:
        return startDateController.text.isNotEmpty &&
            endDateController.text.isNotEmpty;
      case 2:
        return budgetController.text.isNotEmpty && selectedTripType != null;
      case 3:
        return selectedInterest.isNotEmpty &&
            selectedCompanion.isNotEmpty &&
            accommodation.isNotEmpty &&
            transport.isNotEmpty &&
            pace.isNotEmpty &&
            food.isNotEmpty;
      default:
        return false;
    }
  }

  void _nextStep() {
    FocusScope.of(context).unfocus();
    if (!_isStepValid()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    } else {
      onSubmitClick();
    }
  }

  void _previousStep() {
    FocusScope.of(context).unfocus();
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
  void dispose() {
    super.dispose();
    _pageController.dispose();
    destinationController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    budgetController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_currentStep + 1) / _totalSteps;
    final isLoading = ref.watch(submitLoadingProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Plan Your Trip',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey.shade100,
        centerTitle: false,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child:
            isLoading
                ? const Loader()
                : Column(
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
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          DestinationStep(
                            currentLocationController:
                                currentLocationController,
                            destinationController: destinationController,
                            selectedTripType: selectedTripType,
                            onTripTypeChanged:
                                (value) => onTripTypeChanged(value),
                          ),
                          DateBudgetStep(
                            startDateController: startDateController,
                            endDateController: endDateController,
                            budgetController: budgetController,
                            startDate: startDate,
                            endDate: endDate,
                            selectedCurrency: selectedCurrency,
                            onCurrencyChanged:
                                (value) => onCurrencyChanged(value),
                            selectedBudgetType: selectedBudgetType,
                            onBudgetTypeChanged:
                                (value) => onBudgetTypeChanged(value),
                            onStartDateChanged:
                                (date) => onStartDateChanged(date),
                            onEndDateChanged: (date) => onEndDateChanged(date),
                          ),
                          PersonalPreferencesStep(
                            selectedInterests: selectedInterest,
                            onInterestsChanged:
                                (value) => onInterestsChanged(value),
                            selectedCompanion: selectedCompanion,
                            onCompanionChanged:
                                (value) => onCompaionChanged(value),
                          ),
                          TravelPreferencesStep(
                            accommodation: accommodation,
                            onAccommodationChanged: onAccommodationChanged,
                            transport: transport,
                            onTransportChanged: onTransportChanged,
                            pace: pace,
                            onPaceChanged: onPaceChanged,
                            food: food,
                            onFoodChanged: onFoodChanged,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 55,
                            child: ElevatedButton(
                              onPressed:
                                  _currentStep > 0 ? _previousStep : null,
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
                              onPressed: () => _nextStep(),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide.none,
                                ),
                                backgroundColor: Colors.blueAccent,
                                foregroundColor: Colors.white,
                              ),
                              child: Text(
                                _currentStep == _totalSteps - 1
                                    ? "Submit"
                                    : "Next",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
      ),
    );
  }
}
