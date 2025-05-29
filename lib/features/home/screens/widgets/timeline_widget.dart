import 'package:flutter/material.dart';

class TimeLineWidget extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final String dayText;

  const TimeLineWidget({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.dayText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          child: Column(
            children: [
              Container(
                width: 2,
                height: isFirst ? 12 : 24,
                color: isFirst ? Colors.transparent : Colors.grey,
              ),
              // Circle
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent,
                ),
              ),
              // Bottom connector line
              Container(
                width: 2,
                height: isLast ? 0 : 145,
                color: isLast ? Colors.transparent : Colors.grey,
              ),
            ],
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 24),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dayText,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                _buildBulletPoint('Arrive at Goa Airport'),
                _buildBulletPoint('Check-in to hotel'),
                _buildBulletPoint('Evening beach walk and dinner'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(color: Colors.black, fontSize: 18)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
