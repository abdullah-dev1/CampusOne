import 'package:flutter/material.dart';

class StudentStatistics extends StatelessWidget {
  final int totalStudents;
  final String section;

  const StudentStatistics({
    super.key,
    required this.totalStudents,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Text("$totalStudents Students"),
          const Spacer(),
          Text(section),
        ],
      ),
    );
  }
}