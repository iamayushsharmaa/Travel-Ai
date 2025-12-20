// import 'package:flutter/material.dart';
// import 'package:triptide/shared/models/travel_db_model.dart';
//
// class TripCard extends StatelessWidget {
//   final TravelDbModel trip;
//   final VoidCallback onTap;
//   final String? highlightQuery;
//
//   const TripCard({
//     super.key,
//     required this.trip,
//     required this.onTap,
//     this.highlightQuery,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return Card(
//       clipBehavior: Clip.antiAlias,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(16),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildHeader(context, theme),
//               const SizedBox(height: 12),
//               _buildDestination(context, theme),
//               if (trip.description?.isNotEmpty ?? false) ...[
//                 const SizedBox(height: 8),
//                 _buildDescription(context, theme),
//               ],
//               const SizedBox(height: 12),
//               _buildMetadata(context, theme),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader(BuildContext context, ThemeData theme) {
//     return Row(
//       children: [
//         _TripTypeIndicator(tripType: trip.tripType),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Text(
//             trip.title,
//             style: theme.textTheme.titleMedium,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//         if (trip.isFavorite ?? false)
//           Icon(
//             Icons.favorite_rounded,
//             size: 20,
//             color: theme.colorScheme.error,
//           ),
//       ],
//     );
//   }
//
//   Widget _buildDestination(BuildContext context, ThemeData theme) {
//     return Row(
//       children: [
//         Icon(
//           Icons.location_on_rounded,
//           size: 16,
//           color: theme.colorScheme.primary,
//         ),
//         const SizedBox(width: 4),
//         Expanded(
//           child: Text(
//             trip.destination,
//             style: theme.textTheme.bodyMedium?.copyWith(
//               color: theme.colorScheme.onSurface.withOpacity(0.8),
//             ),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildDescription(BuildContext context, ThemeData theme) {
//     return Text(
//       trip.description!,
//       style: theme.textTheme.bodySmall,
//       maxLines: 2,
//       overflow: TextOverflow.ellipsis,
//     );
//   }
//
//   Widget _buildMetadata(BuildContext context, ThemeData theme) {
//     final l10n = context.l10n;
//
//     return Row(
//       children: [
//         _MetadataChip(
//           icon: Icons.calendar_today_rounded,
//           label: _formatDateRange(trip.startDate, trip.endDate, l10n),
//           theme: theme,
//         ),
//         const SizedBox(width: 8),
//         _MetadataChip(
//           icon: Icons.schedule_rounded,
//           label: _formatDuration(trip.duration, l10n),
//           theme: theme,
//         ),
//         if (trip.budget != null) ...[
//           const SizedBox(width: 8),
//           _MetadataChip(
//             icon: Icons.payments_rounded,
//             label: _formatBudget(trip.budget!, l10n),
//             theme: theme,
//           ),
//         ],
//       ],
//     );
//   }
//
//   String _formatDateRange(DateTime start, DateTime end, AppLocalizations l10n) {
//     // Implement your date formatting logic
//     return "${start.day}/${start.month} - ${end.day}/${end.month}";
//   }
//
//   String _formatDuration(int days, AppLocalizations l10n) {
//     return l10n.days_count(days);
//   }
//
//   String _formatBudget(double budget, AppLocalizations l10n) {
//     return l10n.currency_format(budget);
//   }
// }
//
