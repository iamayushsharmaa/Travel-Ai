import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:triptide/core/common/loader.dart';
import 'package:triptide/features/addtrip/screens/widgets/date_budget_step.dart';
import 'package:triptide/features/addtrip/screens/widgets/destination_step.dart';
import 'package:triptide/features/addtrip/screens/widgets/navigation_button.dart';
import 'package:triptide/features/addtrip/screens/widgets/personal_preference_step.dart';
import 'package:triptide/features/addtrip/screens/widgets/stepper_header.dart';
import 'package:triptide/features/addtrip/screens/widgets/travel_preference_step.dart';

import '../../../core/common/app_snackbar.dart';
import '../../../core/enums/budget_type.dart';
import '../../../core/enums/currency.dart';
import '../../../core/enums/trip_type.dart';
import '../../../core/extensions/context_l10n.dart';
import '../../../core/extensions/context_theme.dart';
import '../models/TripPlanRequest.dart';
import '../providers/travel_provider.dart';

class AddTripPage extends ConsumerStatefulWidget {
  const AddTripPage({super.key});

  @override
  ConsumerState<AddTripPage> createState() => _AddTripPageState();
}

class _AddTripPageState extends ConsumerState<AddTripPage> {
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();

  final _currentLocationController = TextEditingController();
  final _destinationController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _budgetController = TextEditingController();

  int _currentStep = 0;
  static const int _totalSteps = 4;

  DateTime? _startDate;
  DateTime? _endDate;
  TripType? _selectedTripType;
  Currency _selectedCurrency = Currency.usd;
  BudgetType _selectedBudgetType = BudgetType.total;
  List<String> _selectedInterests = [];
  String _selectedCompanion = '';
  String _accommodation = '';
  String _transport = '';
  String _pace = '';
  String _food = '';

  @override
  void dispose() {
    _pageController.dispose();
    _currentLocationController.dispose();
    _destinationController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  bool _isCurrentStepValid() {
    switch (_currentStep) {
      case 0:
        return _destinationController.text.isNotEmpty &&
            _selectedTripType != null;
      case 1:
        return _startDate != null &&
            _endDate != null &&
            _budgetController.text.isNotEmpty;
      case 2:
        return _selectedInterests.isNotEmpty && _selectedCompanion.isNotEmpty;
      case 3:
        return _accommodation.isNotEmpty &&
            _transport.isNotEmpty &&
            _pace.isNotEmpty &&
            _food.isNotEmpty;
      default:
        return false;
    }
  }

  String _getValidationMessage() {
    switch (_currentStep) {
      case 0:
        if (_destinationController.text.isEmpty) {
          return context.l10n.validationEnterDestination;
        }
        if (_selectedTripType == null) {
          return context.l10n.validationSelectTripType;
        }
        return '';
      case 1:
        if (_startDate == null) return context.l10n.validationSelectStartDate;
        if (_endDate == null) return context.l10n.validationSelectEndDate;
        if (_budgetController.text.isEmpty) {
          return context.l10n.validationEnterBudget;
        }
        return '';
      case 2:
        if (_selectedInterests.isEmpty) {
          return context.l10n.validationSelectInterest;
        }
        if (_selectedCompanion.isEmpty) {
          return context.l10n.validationSelectCompanion;
        }
        return '';
      case 3:
        if (_accommodation.isEmpty) {
          return context.l10n.validationSelectAccommodation;
        }
        if (_transport.isEmpty) return context.l10n.validationSelectTransport;
        if (_pace.isEmpty) return context.l10n.validationSelectPace;
        if (_food.isEmpty) return context.l10n.validationSelectFood;
        return '';
      default:
        return context.l10n.validationCompleteAll;
    }
  }

  void _nextStep() {
    FocusScope.of(context).unfocus();

    if (!_isCurrentStepValid()) {
      AppSnackBar.show(
        context,
        message: context.l10n.failedCreateTrip,
        type: SnackType.error,
      );
      return;
    }

    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _submitTrip();
    }
  }

  void _previousStep() {
    FocusScope.of(context).unfocus();
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _submitTrip() async {
    final loadingNotifier = ref.read(submitLoadingProvider.notifier);
    loadingNotifier.setLoading(true);

    try {
      final budgetRaw = _budgetController.text.replaceAll(',', '');
      final budget = double.tryParse(budgetRaw) ?? 0.0;

      final tripPlanRequest = TripPlanRequest(
        currentLocation: _currentLocationController.text.trim(),
        destination: _destinationController.text.trim(),
        startDate: _startDate!,
        endDate: _endDate!,
        tripType: _selectedTripType.toString(),
        budget: budget,
        budgetType: _selectedBudgetType.toString(),
        interests: _selectedInterests,
        companions: _selectedCompanion,
        accommodationType: _accommodation,
        transportPreferences: _transport,
        pace: _pace,
        food: _food,
      );

      final travelId = await ref.read(
        generateAndStoreTripProvider(tripPlanRequest).future,
      );

      if (mounted) {
        context.pushReplacementNamed(
          'trip',
          pathParameters: {'travelId': travelId},
          extra: {'fromCreation': true},
        );
      }
    } catch (e) {
      if (mounted) {
        AppSnackBar.show(
          context,
          message: context.l10n.failedCreateTrip,
          type: SnackType.error,
        );
      }
    } finally {
      loadingNotifier.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(submitLoadingProvider);
    final progress = (_currentStep + 1) / _totalSteps;

    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: _buildAppBar(context),
      body:
          isLoading
              ? Loader(
                withScaffold: false,
                title: context.l10n.creatingPerfectTrip,
              )
              : _buildContent(context, progress),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final cs = context.colors;

    return AppBar(
      elevation: 0,
      backgroundColor: cs.surface,
      surfaceTintColor: cs.surface,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: cs.onSurface),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(context.l10n.planYourTrip, style: context.text.titleLarge),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(height: 1, color: cs.outlineVariant),
      ),
    );
  }

  Widget _buildContent(BuildContext context, double progress) {
    return SafeArea(
      child: Column(
        children: [
          StepperHeader(
            progress: progress,
            stepText: context.l10n.stepOf(_currentStep + 1, _totalSteps),
            stepTitle: _getStepTitle(),
          ),
          Expanded(child: _buildPageView()),
          _buildNavigationButtons(context),
        ],
      ),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return context.l10n.destination;
      case 1:
        return context.l10n.datesAndBudget;
      case 2:
        return context.l10n.preferences;
      case 3:
        return context.l10n.travelDetails;
      default:
        return '';
    }
  }

  Widget _buildPageView() {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        DestinationStep(
          currentLocationController: _currentLocationController,
          destinationController: _destinationController,
          selectedTripType: _selectedTripType,
          onTripTypeChanged: (type) => setState(() => _selectedTripType = type),
        ),
        DateBudgetStep(
          startDateController: _startDateController,
          endDateController: _endDateController,
          budgetController: _budgetController,
          startDate: _startDate,
          endDate: _endDate,
          selectedCurrency: _selectedCurrency,
          selectedBudgetType: _selectedBudgetType,
          onCurrencyChanged:
              (currency) => setState(() => _selectedCurrency = currency),
          onBudgetTypeChanged:
              (type) => setState(() => _selectedBudgetType = type),
          onStartDateChanged: (date) {
            setState(() {
              _startDate = date;
              _startDateController.text = DateFormat.yMMMd().format(date);
            });
          },
          onEndDateChanged: (date) {
            setState(() {
              _endDate = date;
              _endDateController.text = DateFormat.yMMMd().format(date);
            });
          },
        ),
        PersonalPreferencesStep(
          selectedInterests: _selectedInterests,
          selectedCompanion: _selectedCompanion,
          onInterestsChanged:
              (interests) => setState(() => _selectedInterests = interests),
          onCompanionChanged:
              (companion) => setState(() => _selectedCompanion = companion),
        ),
        TravelPreferencesStep(
          accommodation: _accommodation,
          transport: _transport,
          pace: _pace,
          food: _food,
          onAccommodationChanged:
              (value) => setState(() => _accommodation = value),
          onTransportChanged: (value) => setState(() => _transport = value),
          onPaceChanged: (value) => setState(() => _pace = value),
          onFoodChanged: (value) => setState(() => _food = value),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
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
            if (_currentStep > 0) ...[
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
                    _currentStep == _totalSteps - 1
                        ? context.l10n.createTrip
                        : context.l10n.next,
                icon:
                    _currentStep == _totalSteps - 1
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
