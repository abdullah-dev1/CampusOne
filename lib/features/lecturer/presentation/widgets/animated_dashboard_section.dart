import 'package:flutter/material.dart';

class AnimatedDashboardSection extends StatelessWidget {

  final Widget child;
  final Duration delay;

  const AnimatedDashboardSection({
    super.key,
    required this.child,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}