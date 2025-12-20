import 'package:flutter/material.dart';

class ThemeModeTile extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggle;

  const ThemeModeTile({
    super.key,
    required this.isDarkMode,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
              color: const Color(0xFF6366F1),
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Theme Mode',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                    letterSpacing: -0.2,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Switch between light and dark mode',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          _ThemeSwitch(isDarkMode: isDarkMode, onToggle: onToggle),
        ],
      ),
    );
  }
}

class _ThemeSwitch extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggle;

  const _ThemeSwitch({required this.isDarkMode, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: 56,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors:
                isDarkMode
                    ? [const Color(0xFF1E293B), const Color(0xFF334155)]
                    : [const Color(0xFF6366F1), const Color(0xFF8B5CF6)],
          ),
          boxShadow: [
            BoxShadow(
              color: (isDarkMode
                      ? const Color(0xFF1E293B)
                      : const Color(0xFF6366F1))
                  .withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              left: isDarkMode ? 26 : 2,
              top: 2,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  isDarkMode ? Icons.nightlight_round : Icons.wb_sunny_rounded,
                  size: 14,
                  color:
                      isDarkMode
                          ? const Color(0xFF1E293B)
                          : const Color(0xFF6366F1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
