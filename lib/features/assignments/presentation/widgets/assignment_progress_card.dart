import 'package:flutter/material.dart';

class AssignmentProgressCard extends StatelessWidget {
  final double progress;

  const AssignmentProgressCard({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (progress * 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Completion",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13.5,
                color: Color(0xff475569),
                letterSpacing: 0.1,
              ),
            ),
            const Spacer(),
            Text(
              "$percentage%",
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14.5,
                color: Color(0xff2563EB),
                letterSpacing: -0.1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutCubic,
                    height: 8,
                    width: constraints.maxWidth * progress.clamp(0, 1),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xff2563EB),
                          Color(0xff60A5FA),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}