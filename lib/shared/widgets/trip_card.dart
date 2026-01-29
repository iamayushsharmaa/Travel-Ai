import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/travel_db_model.dart';

class TripCard extends StatelessWidget {
  final TravelDbModel trip;
  final VoidCallback onTap;

  const TripCard({super.key, required this.trip, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6366F1).withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Row(
            children: [
              _buildImageSection(),
              Expanded(child: _buildContentSection(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        Hero(
          tag: 'trip_compact_${trip.travelId}',
          child: Container(
            width: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF6366F1).withOpacity(0.2),
                  const Color(0xFF8B5CF6).withOpacity(0.2),
                ],
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset('assets/images/travel.jpg', fit: BoxFit.cover),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (trip.isFavorite ?? false)
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: const Icon(
                Icons.favorite,
                color: Color(0xFFEF4444),
                size: 14,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildContentSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  trip.destination,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                    letterSpacing: -0.3,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 14,
                  color: Color(0xFF6366F1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(
                Icons.calendar_today_rounded,
                size: 12,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  '${DateFormat('MMM d').format(trip.startDate)} - ${DateFormat('MMM d, y').format(trip.endDate)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: _buildInfoChip(
                  icon: Icons.access_time_rounded,
                  value: '${trip.totalDays}d',
                  color: const Color(0xFF6366F1),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildInfoChip(
                  icon: Icons.account_balance_wallet_rounded,
                  value: trip.budget ?? 'N/A',
                  color: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildTripTypeChip(context),
        ],
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.15), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripTypeChip(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF6366F1).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: Color(0xFF6366F1),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            trip.tripType.label(context),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6366F1),
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

// class TripCard extends StatelessWidget {
//   final TravelDbModel trip;
//   final VoidCallback onTap;
//
//   const TripCard({super.key, required this.trip, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFF6366F1).withOpacity(0.08),
//               blurRadius: 24,
//               offset: const Offset(0, 8),
//               spreadRadius: 0,
//             ),
//             BoxShadow(
//               color: Colors.black.withOpacity(0.04),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//               spreadRadius: 0,
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [_buildImageSection(), _buildContentSection()],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildImageSection() {
//     return Stack(
//       children: [
//         Hero(
//           tag: 'trip_${trip.travelId}',
//           child: Container(
//             height: 200,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   const Color(0xFF6366F1).withOpacity(0.3),
//                   const Color(0xFF8B5CF6).withOpacity(0.3),
//                 ],
//               ),
//             ),
//             child: Stack(
//               fit: StackFit.expand,
//               children: [
//                 Image.asset('assets/images/travel.jpg', fit: BoxFit.cover),
//                 Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Colors.transparent,
//                         Colors.black.withOpacity(0.3),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Positioned(top: 12, right: 12, child: _buildTripTypeChip()),
//         if (trip.isFavorite ?? false)
//           Positioned(
//             top: 12,
//             left: 12,
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.95),
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 8,
//                   ),
//                 ],
//               ),
//               child: const Icon(
//                 Icons.favorite,
//                 color: Color(0xFFEF4444),
//                 size: 18,
//               ),
//             ),
//           ),
//       ],
//     );
//   }
//
//   Widget _buildTripTypeChip() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.95),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: const Color(0xFF6366F1).withOpacity(0.2),
//           width: 1,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 6,
//             height: 6,
//             decoration: const BoxDecoration(
//               color: Color(0xFF6366F1),
//               shape: BoxShape.circle,
//             ),
//           ),
//           const SizedBox(width: 6),
//           Text(
//             trip.tripType ?? 'Adventure',
//             style: const TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//               color: Color(0xFF1E293B),
//               letterSpacing: 0.3,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildContentSection() {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildDestinationRow(),
//           const SizedBox(height: 12),
//           _buildDateRow(),
//           const SizedBox(height: 16),
//           _buildInfoGrid(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDestinationRow() {
//     return Row(
//       children: [
//         Expanded(
//           child: Text(
//             trip.destination,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF1E293B),
//               letterSpacing: -0.3,
//             ),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Container(
//           padding: const EdgeInsets.all(6),
//           decoration: BoxDecoration(
//             color: const Color(0xFF6366F1).withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: const Icon(
//             Icons.arrow_forward_rounded,
//             size: 18,
//             color: Color(0xFF6366F1),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildDateRow() {
//     return Row(
//       children: [
//         Icon(
//           Icons.calendar_today_rounded,
//           size: 14,
//           color: Colors.grey.shade600,
//         ),
//         const SizedBox(width: 6),
//         Text(
//           '${DateFormat('MMM d').format(trip.startDate)} - ${DateFormat('MMM d, y').format(trip.endDate)}',
//           style: TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.w500,
//             color: Colors.grey.shade600,
//             letterSpacing: 0.2,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildInfoGrid() {
//     return Row(
//       children: [
//         Expanded(
//           child: _buildInfoCard(
//             icon: Icons.access_time_rounded,
//             label: 'Duration',
//             value: '${trip.totalDays} days',
//             color: const Color(0xFF6366F1),
//           ),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: _buildInfoCard(
//             icon: Icons.account_balance_wallet_rounded,
//             label: 'Budget',
//             value: trip.budget ?? 'N/A',
//             color: const Color(0xFF10B981),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildInfoCard({
//     required IconData icon,
//     required String label,
//     required String value,
//     required Color color,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.06),
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: color.withOpacity(0.1), width: 1),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(icon, size: 16, color: color),
//               const SizedBox(width: 6),
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 11,
//                   fontWeight: FontWeight.w600,
//                   color: color,
//                   letterSpacing: 0.5,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 6),
//           Text(
//             value,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF1E293B),
//               letterSpacing: -0.2,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
