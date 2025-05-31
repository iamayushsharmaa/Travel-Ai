enum TripFilter { all, favorite, thisMonth, lastMonth }

extension TripFilterExtension on TripFilter {
  String get label {
    switch (this) {
      case TripFilter.all:
        return 'All';
        case TripFilter.favorite:
        return 'Favorite';
      case TripFilter.thisMonth:
        return 'This Month';
      case TripFilter.lastMonth:
        return 'Last Month';
    }
  }
}
