import 'package:flutter/material.dart';

class AnimatedStepWrapper extends StatelessWidget {
  final Widget child;
  final int index;
  final int currentIndex;

  const AnimatedStepWrapper({
    super.key,
    required this.child,
    required this.index,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == currentIndex;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );

        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.1),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
      child:
          isActive
              ? KeyedSubtree(key: ValueKey(index), child: child)
              : const SizedBox.shrink(),
    );
  }
}
