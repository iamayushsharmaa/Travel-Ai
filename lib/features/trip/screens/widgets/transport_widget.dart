import 'package:flutter/material.dart';
import 'package:triptide/features/addtrip/models/travel_gemini_response.dart';
import 'package:flutter/material.dart';

class TransportWidget extends StatelessWidget {
  final TransportationDetails transportationDetails;

  const TransportWidget({Key? key, required this.transportationDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 14),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.shade200.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transportation Details',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 20),

          // Wrap(
          //   spacing: 8,
          //   runSpacing: 8,
          //   children: transportationDetails.transportModes.map((mode) {
          //     return Chip(
          //       label: Text(
          //         mode,
          //         style: TextStyle(
          //           color: Colors.orange.shade900,
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //       backgroundColor: Colors.orange.shade100,
          //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          //     );
          //   }).toList(),
          // ),

          const SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.directions_car,
                size: 28,
                color: Colors.orange.shade700,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  transportationDetails.localTransport,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.orange.shade900.withOpacity(0.9),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.lightbulb_outline,
                size: 28,
                color: Colors.orange.shade700,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  transportationDetails.tips,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.orange.shade900.withOpacity(0.9),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
