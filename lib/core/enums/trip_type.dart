enum TripType {
  adventure,
  relaxation,
  cultural,
  business,
  romantic,
  family;

  String get label {
    switch (this) {
      case TripType.adventure:
        return 'Adventure';
      case TripType.relaxation:
        return 'Relaxation';
      case TripType.cultural:
        return 'Cultural';
      case TripType.business:
        return 'Business';
      case TripType.romantic:
        return 'Romantic';
      case TripType.family:
        return 'Family';
    }
  }
}
