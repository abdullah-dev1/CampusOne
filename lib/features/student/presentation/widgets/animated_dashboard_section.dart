import 'package:flutter/material.dart';

class AnimatedDashboardSection extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const AnimatedDashboardSection({
    super.key,
    required this.child,
    required this.delay,
  });

  @override
  State<AnimatedDashboardSection> createState() =>
      _AnimatedDashboardSectionState();
}

class _AnimatedDashboardSectionState
    extends State<AnimatedDashboardSection> {
  bool visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() {
          visible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOut,
      opacity: visible ? 1 : 0,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeOutCubic,
        offset: visible ? Offset.zero : const Offset(0, .06),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 650),
          curve: Curves.easeOutCubic,
          scale: visible ? 1 : .96,
          child: widget.child,
        ),
      ),
    );
  }
}