import 'package:flutter/material.dart';

import '../enums/trip_type.dart';

IconData getTripTypeIcon(String type) {
  switch (type.toLowerCase()) {
    case 'business':
      return Icons.business_center_outlined;
    case 'leisure':
    case 'relaxation':
      return Icons.spa_outlined;
    case 'adventure':
      return Icons.hiking_outlined;
    case 'cultural':
      return Icons.museum_outlined;
    case 'romantic':
      return Icons.favorite_outline;
    case 'family':
      return Icons.family_restroom_outlined;
    default:
      return Icons.explore_outlined;
  }
}