import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/attendance_provider.dart';

class AttendanceHeader extends StatelessWidget {
  const AttendanceHeader({super.key});

  @override
  Widget build(BuildContext context) {
final provider = context.watch<AttendanceProvider>();
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const Text(
            "Today's Attendance",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "${provider.selectedCourse} • ${provider.selectedSection}",
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [

              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_today),
                  label: const Text("Today"),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
  child: OutlinedButton.icon(
    onPressed: () {},
    icon: const Icon(Icons.school),
    label: Text(
      provider.selectedSection.isEmpty
          ? "-"
          : provider.selectedSection,
    ),
  ),
),

            ],
          ),
        ],
      ),
    );
  }
}