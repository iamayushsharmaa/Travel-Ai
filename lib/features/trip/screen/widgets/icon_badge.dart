
import 'package:flutter/material.dart';

class IconBadge extends StatelessWidget {
  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? size;

  const IconBadge({
    super.key,
    required this.icon,
    this.backgroundColor,
    this.iconColor,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFF2196F3).withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: iconColor ?? const Color(0xFF2196F3),
        size: size! * 0.5,
      ),
    );
  }
}