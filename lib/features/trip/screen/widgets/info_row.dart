
import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? iconColor;
  final Color? textColor;
  final double? iconSize;
  final double? fontSize;
  final FontWeight? fontWeight;

  const InfoRow({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor,
    this.textColor,
    this.iconSize = 20,
    this.fontSize = 15,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor ?? Colors.white,
          size: iconSize,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ],
    );
  }
}
