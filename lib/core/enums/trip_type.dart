enum TripType { Business, Vacation, Romantic, Adventure, Roadtrip, Other }

extension TripTypeExtension on TripType {
  String get label {
    switch (this) {
      case TripType.Adventure:
        return 'Adventure';
      case TripType.Vacation:
        return 'Vacation';
      case TripType.Romantic:
        return 'Romantic';
      case TripType.Business:
        return 'Business';
      case TripType.Roadtrip:
        return 'Roadtrip';
      case TripType.Other:
        return 'Other';
    }
  }
}
