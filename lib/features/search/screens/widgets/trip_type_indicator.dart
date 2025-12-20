// import 'package:flutter/material.dart';
//
// import '../../../../core/extensions/context_l10n.dart';
// import '../../../../core/theme/app_colors.dart';
//
// class TripTypeIndicator extends StatelessWidget {
//   final String tripType;
//
//   const TripTypeIndicator({super.key, required this.tripType});
//
//   @override
//   Widget build(BuildContext context) {
//     final color = AppColors.getTripTypeColor(tripType);
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.15),
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: color.withOpacity(0.3), width: 1),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(_getTripTypeIcon(tripType), size: 14, color: color),
//           const SizedBox(width: 4),
//           Text(
//             _getTripTypeLabel(context, tripType),
//             style: Theme.of(context).textTheme.labelSmall?.copyWith(
//               color: color,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   IconData _getTripTypeIcon(String type) {
//     switch (type.toLowerCase()) {
//       case 'business':
//         return Icons.business_center_rounded;
//       case 'leisure':
//       case 'relaxation':
//         return Icons.beach_access_rounded;
//       case 'adventure':
//         return Icons.terrain_rounded;
//       case 'cultural':
//         return Icons.museum_rounded;
//       case 'romantic':
//         return Icons.favorite_rounded;
//       case 'family':
//         return Icons.family_restroom_rounded;
//       default:
//         return Icons.card_travel_rounded;
//     }
//   }
//
//   String _getTripTypeLabel(BuildContext context, String type) {
//     final l10n = context.l10n;
//     switch (type.toLowerCase()) {
//       case 'business':
//         return l10n.trip_type_business;
//       case 'leisure':
//       case 'relaxation':
//         return l10n.trip_type_leisure;
//       case 'adventure':
//         return l10n.trip_type_adventure;
//       case 'cultural':
//         return l10n.trip_type_cultural;
//       case 'romantic':
//         return l10n.trip_type_romantic;
//       case 'family':
//         return l10n.trip_type_family;
//       default:
//         return type;
//     }
//   }
// }
