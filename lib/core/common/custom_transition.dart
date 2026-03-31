import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppTransition {
  static CustomTransitionPage<T> slideFade<T>({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final slide = Tween(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
        ).animate(animation);

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(position: slide, child: child),
        );
      },
    );
  }
}
