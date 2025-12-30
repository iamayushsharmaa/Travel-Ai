import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:triptide/core/common/loader.dart';
import 'package:triptide/features/addtrip/screens/trip_creation_data.dart';
import 'package:triptide/features/addtrip/screens/widgets/date_budget_step.dart';
import 'package:triptide/features/addtrip/screens/widgets/destination_step.dart';
import 'package:triptide/features/addtrip/screens/widgets/navigation_button.dart';
import 'package:triptide/features/addtrip/screens/widgets/personal_preference_step.dart';
import 'package:triptide/features/addtrip/screens/widgets/stepper_header.dart';
import 'package:triptide/features/addtrip/screens/widgets/travel_preference_step.dart';

import '../../../core/common/app_snackbar.dart';
import '../../../core/enums/trip_step.dart';
import '../../../core/extensions/context_l10n.dart';
import '../../../core/extensions/context_theme.dart';
import '../../../core/utilities/trip_step_titiles.dart';
import '../../../core/utilities/trip_step_validator.dart';
import '../models/TripPlanRequest.dart';
import '../providers/travel_provider.dart';

class AddTripPage extends ConsumerStatefulWidget {
  const AddTripPage({super.key});

  @override
  ConsumerState<AddTripPage> createState() => _AddTripPageState();
}

class _AddTripPageState extends ConsumerState<AddTripPage> {
  final _pageController = PageController();
  final _data = TripCreationData();

  TripStep _currentStep = TripStep.destination;

  static final int _totalSteps = TripStep.values.length;

  @override
  void dispose() {
    _pageController.dispose();
    _data.dispose();
    super.dispose();
  }

  void _nextStep() {
    FocusScope.of(context).unfocus();

    final isValid = TripStepValidator.isValid(step: _currentStep, data: _data);

    if (!isValid) {
      AppSnackBar.show(
        context,
        message: context.l10n.failedCreateTrip,
        type: SnackType.error,
      );
      return;
    }

    if (_currentStep.index < _totalSteps - 1) {
      setState(() {
        _currentStep = TripStep.values[_currentStep.index + 1];
      });

      _pageController.animateToPage(
        _currentStep.index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _submitTrip();
    }
  }

  void _previousStep() {
    if (_currentStep.index == 0) return;

    setState(() {
      _currentStep = TripStep.values[_currentStep.index - 1];
    });

    _pageController.animateToPage(
      _currentStep.index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _submitTrip() async {
    final loading = ref.read(submitLoadingProvider.notifier);
    loading.setLoading(true);

    try {
      final budget =
          double.tryParse(_data.budget.text.replaceAll(',', '')) ?? 0.0;

      final request = TripPlanRequest(
        currentLocation: _data.currentLocation.text.trim(),
        destination: _data.destination.text.trim(),
        startDate: _data.startDate!,
        endDate: _data.endDate!,
        tripType: _data.tripType.toString(),
        budget: budget,
        budgetType: _data.budgetType.toString(),
        interests: _data.interests,
        companions: _data.companion,
        accommodationType: _data.accommodation,
        transportPreferences: _data.transport,
        pace: _data.pace,
        food: _data.food,
      );

      final travelId = await ref.read(
        generateAndStoreTripProvider(request).future,
      );

      if (mounted) {
        context.pushReplacementNamed(
          'trip',
          pathParameters: {'travelId': travelId},
          extra: {'fromCreation': true},
        );
      }
    } finally {
      loading.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(submitLoadingProvider);
    final progress = (_currentStep.index + 1) / _totalSteps;
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        backgroundColor: context.colors.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(context.l10n.planYourTrip),
      ),
      body:
          isLoading
              ? Loader(
                withScaffold: false,
                title: context.l10n.creatingPerfectTrip,
              )
              : SafeArea(
                child: Column(
                  children: [
                    StepperHeader(
                      progress: progress,
                      stepText: context.l10n.stepOf(
                        _currentStep.index + 1,
                        _totalSteps,
                      ),
                      stepTitle: TripStepTitles.title(context, _currentStep),
                    ),
                    Expanded(child: _buildPageView()),

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child:
                          keyboardOpen
                              ? const SizedBox.shrink()
                              : _buildNavigationButtons(),
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildPageView() {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        DestinationStep(
          currentLocationController: _data.currentLocation,
          destinationController: _data.destination,
          selectedTripType: _data.tripType,
          onTripTypeChanged: (v) => setState(() => _data.tripType = v),
        ),
        DateBudgetStep(
          startDateController: _data.startDateText,
          endDateController: _data.endDateText,
          budgetController: _data.budget,
          startDate: _data.startDate,
          endDate: _data.endDate,
          selectedCurrency: _data.currency,
          selectedBudgetType: _data.budgetType,
          onCurrencyChanged: (v) => setState(() => _data.currency = v),
          onBudgetTypeChanged: (v) => setState(() => _data.budgetType = v),
          onStartDateChanged: (d) {
            setState(() {
              _data.startDate = d;
              _data.startDateText.text = DateFormat.yMMMd().format(d);
            });
          },
          onEndDateChanged: (d) {
            setState(() {
              _data.endDate = d;
              _data.endDateText.text = DateFormat.yMMMd().format(d);
            });
          },
        ),
        PersonalPreferencesStep(
          selectedInterests: _data.interests,
          selectedCompanion: _data.companion,
          onInterestsChanged: (v) => setState(() => _data.interests = v),
          onCompanionChanged: (v) => setState(() => _data.companion = v),
        ),
        TravelPreferencesStep(
          accommodation: _data.accommodation,
          transport: _data.transport,
          pace: _data.pace,
          food: _data.food,
          onAccommodationChanged:
              (v) => setState(() => _data.accommodation = v),
          onTransportChanged: (v) => setState(() => _data.transport = v),
          onPaceChanged: (v) => setState(() => _data.pace = v),
          onFoodChanged: (v) => setState(() => _data.food = v),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    final cs = context.colors;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cs.surface,
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (_currentStep.index > 0) ...[
              Expanded(
                child: NavigationButton(
                  label: context.l10n.back,
                  onPressed: _previousStep,
                  isSecondary: true,
                ),
              ),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: NavigationButton(
                label:
                    _currentStep.index == _totalSteps - 1
                        ? context.l10n.createTrip
                        : context.l10n.next,
                icon:
                    _currentStep.index == _totalSteps - 1
                        ? Icons.check
                        : Icons.arrow_forward,
                onPressed: _nextStep,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
