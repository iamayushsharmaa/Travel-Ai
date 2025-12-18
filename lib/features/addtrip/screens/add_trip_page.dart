import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:triptide/features/addtrip/screens/widgets/date_budget_step.dart';
import 'package:triptide/features/addtrip/screens/widgets/destination_step.dart';
import 'package:triptide/features/addtrip/screens/widgets/personal_preference_step.dart';
import 'package:triptide/features/addtrip/screens/widgets/travel_preference_step.dart';

import '../../../core/enums/budget_type.dart';
import '../../../core/enums/currency.dart';
import '../../../core/enums/trip_type.dart';
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
        if (_destinationController.text.isEmpty)
          return 'Please enter a destination';
        if (_selectedTripType == null) return 'Please select a trip type';
        return '';
      case 1:
        if (_startDate == null) return 'Please select a start date';
        if (_endDate == null) return 'Please select an end date';
        if (_budgetController.text.isEmpty) return 'Please enter your budget';
        return '';
      case 2:
        if (_selectedInterests.isEmpty)
          return 'Please select at least one interest';
        if (_selectedCompanion.isEmpty)
          return 'Please select your travel companion';
        return '';
      case 3:
        if (_accommodation.isEmpty) return 'Please select accommodation type';
        if (_transport.isEmpty) return 'Please select transport preference';
        if (_pace.isEmpty) return 'Please select your preferred pace';
        if (_food.isEmpty) return 'Please select food preference';
        return '';
      default:
        return 'Please complete all fields';
    }
  }

  // ============================================================================
  // NAVIGATION
  // ============================================================================

  void _nextStep() {
    FocusScope.of(context).unfocus();

    if (!_isCurrentStepValid()) {
      _showValidationError();
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

  void _showValidationError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_getValidationMessage()),
        backgroundColor: Colors.red.shade400,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create trip: $e'),
            backgroundColor: Colors.red.shade400,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(16),
          ),
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
      backgroundColor: Colors.grey.shade50,
      appBar: _buildAppBar(),
      body: isLoading ? _buildLoadingState() : _buildContent(progress),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black87),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        'Plan Your Trip',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: Colors.grey.shade200, height: 1),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 24),
          Text(
            'Creating your perfect trip...',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(double progress) {
    return SafeArea(
      child: Column(
        children: [
          _buildProgressIndicator(progress),
          _buildStepIndicator(),
          Expanded(child: _buildPageView()),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(double progress) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: Colors.white,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF2196F3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Step ${_currentStep + 1} of $_totalSteps',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '• ${_getStepTitle()}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2196F3),
            ),
          ),
        ],
      ),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Destination';
      case 1:
        return 'Dates & Budget';
      case 2:
        return 'Preferences';
      case 3:
        return 'Travel Details';
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

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
                child: _NavigationButton(
                  label: 'Back',
                  onPressed: _previousStep,
                  isSecondary: true,
                ),
              ),
              const SizedBox(width: 16),
            ],
            Expanded(
              flex: _currentStep == 0 ? 1 : 1,
              child: _NavigationButton(
                label: _currentStep == _totalSteps - 1 ? 'Create Trip' : 'Next',
                onPressed: _nextStep,
                icon:
                    _currentStep == _totalSteps - 1
                        ? Icons.check
                        : Icons.arrow_forward,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isSecondary;
  final IconData? icon;

  const _NavigationButton({
    required this.label,
    required this.onPressed,
    this.isSecondary = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor:
              isSecondary ? Colors.grey.shade100 : const Color(0xFF2196F3),
          foregroundColor: isSecondary ? Colors.black87 : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            if (icon != null) ...[
              const SizedBox(width: 8),
              Icon(icon, size: 20),
            ],
          ],
        ),
      ),
    );
  }
}
