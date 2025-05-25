enum TripType {
  Business,
  Vacation,
  Solo,
  Romantic,
  Adventure,
  Family,
  Roadtrip,
  Other
}

extension TripTypeExtension on TripType {
  String get label {
    switch (this) {
      case TripType.Adventure:
        return 'Adventure';
      case TripType.Vacation:
        return 'Vacation';
      case TripType.Solo:
        return 'Solo';
      case TripType.Romantic:
        return 'Romantic';
      case TripType.Business:
        return 'Business';
      case TripType.Family:
        return 'Family';
      case TripType.Roadtrip:
        return 'Roadtrip';
      case TripType.Other:
        return 'Other';
    }
  }
}
