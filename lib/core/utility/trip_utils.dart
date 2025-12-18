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

Color getTripTypeColor(String type) {
  switch (type.toLowerCase()) {
    case 'business':
      return const Color(0xFF5E35B1);
    case 'leisure':
    case 'relaxation':
      return const Color(0xFF00ACC1);
    case 'adventure':
      return const Color(0xFFFF6F00);
    case 'cultural':
      return const Color(0xFFD81B60);
    case 'romantic':
      return const Color(0xFFE91E63);
    case 'family':
      return const Color(0xFF43A047);
    default:
      return const Color(0xFF2196F3);
  }
}
