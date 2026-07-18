import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/student_management_provider.dart';

class StudentSummary extends StatelessWidget {
  const StudentSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudentManagementProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Overview",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 18),

        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 1.35,

          children: [

            _SummaryCard(
              title: "Students",
              value: provider.totalStudents.toString(),
              icon: Icons.people_alt_rounded,
              color: Colors.blue,
            ),

            _SummaryCard(
              title: "Active",
              value: provider.activeStudents.toString(),
              icon: Icons.verified_user_rounded,
              color: Colors.green,
            ),

            _SummaryCard(
              title: "Inactive",
              value: provider.inactiveStudents.toString(),
              icon: Icons.block_rounded,
              color: Colors.red,
            ),

            _SummaryCard(
              title: "Departments",
              value: provider.totalDepartments.toString(),
              icon: Icons.account_balance_rounded,
              color: Colors.deepPurple,
            ),

            _SummaryCard(
              title: "Sections",
              value: provider.totalSections.toString(),
              icon: Icons.groups_rounded,
              color: Colors.orange,
            ),

            _SummaryCard(
              title: "Semesters",
              value: provider.totalSemesters.toString(),
              icon: Icons.school_rounded,
              color: Colors.teal,
            ),

          ],
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),

          const Spacer(),

          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),

        ],
      ),
    );
  }
}