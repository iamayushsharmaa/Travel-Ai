
import 'package:flutter/material.dart';

class LoadingShimmer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;

  const LoadingShimmer({
    super.key,
    this.height = 100,
    this.width = double.infinity,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(borderRadius!),
      ),
    );
  }
}