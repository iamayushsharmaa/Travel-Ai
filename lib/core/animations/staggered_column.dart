import 'package:flutter/material.dart';

class StaggeredColumn extends StatelessWidget {
  final List<Widget> children;

  const StaggeredColumn({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(children.length, (index) {
        return TweenAnimationBuilder(
          duration: Duration(milliseconds: 400 + (index * 120)),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: child,
              ),
            );
          },
          child: children[index],
        );
      }),
    );
  }
}
