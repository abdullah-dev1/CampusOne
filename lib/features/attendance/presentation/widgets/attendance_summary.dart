import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/attendance_provider.dart';

class AttendanceSummary extends StatelessWidget {
  const AttendanceSummary({super.key});

  @override
  Widget build(BuildContext context) {

    final provider =
        context.watch<AttendanceProvider>();

    return Row(
      children: [

        Expanded(
          child: _card(
            "Present",
            provider.presentCount.toString(),
            Colors.green,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _card(
            "Absent",
            provider.absentCount.toString(),
            Colors.red,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _card(
            "Late",
            provider.lateCount.toString(),
            Colors.orange,
          ),
        ),

      ],
    );
  }

  Widget _card(
    String title,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        children: [

          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),

          const SizedBox(height: 6),

          Text(title),

        ],
      ),
    );
  }
}