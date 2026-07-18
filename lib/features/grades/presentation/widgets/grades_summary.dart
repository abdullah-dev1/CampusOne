import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/grade_provider.dart';

class GradesSummary extends StatelessWidget {
  const GradesSummary({super.key});

  Widget _card(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.grey.shade100,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(.08),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withOpacity(.16),
                    color.withOpacity(.08),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                icon,
                color: color,
                size: 22,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 21,
                color: Color(0xff0F172A),
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GradeProvider>();

    return Column(
      children: [
        Row(
          children: [
            _card(
              "Students",
              provider.totalStudents.toString(),
              Icons.groups_rounded,
              const Color(0xff2563EB),
            ),
            const SizedBox(width: 12),
            _card(
              "Average",
              provider.classAverage.toStringAsFixed(1),
              Icons.bar_chart_rounded,
              const Color(0xff8B5CF6),
            ),
          ],
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            _card(
              "Highest",
              provider.highestMarks.toStringAsFixed(1),
              Icons.emoji_events_rounded,
              const Color(0xff0EA5E9),
            ),
            const SizedBox(width: 12),
            _card(
              "Lowest",
              provider.lowestMarks.toStringAsFixed(1),
              Icons.trending_down_rounded,
              const Color(0xffF59E0B),
            ),
          ],
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            _card(
              "Pass",
              provider.passCount.toString(),
              Icons.check_circle_rounded,
              const Color(0xff22C55E),
            ),
            const SizedBox(width: 12),
            _card(
              "Fail",
              provider.failCount.toString(),
              Icons.cancel_rounded,
              const Color(0xffEF4444),
            ),
          ],
        ),
      ],
    );
  }
}