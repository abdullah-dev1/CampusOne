import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/lecturer_model.dart';
import '../provider/lecturer_management_provider.dart';

class LecturerStatistics extends StatelessWidget {
  const LecturerStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LecturerManagementProvider>();

    final lecturers = provider.filteredLecturers;

    final active =
        lecturers.where((e) => e.status == LecturerStatus.active).length;

    final inactive = lecturers.length - active;

    final totalCourses = lecturers.fold<int>(
      0,
      (sum, lecturer) => sum + lecturer.teachingAssignments.length,
    );

    final avgCourses = lecturers.isEmpty ? 0.0 : totalCourses / lecturers.length;

    final departments = lecturers.map((e) => e.department).toSet().length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xff2563EB).withOpacity(.16),
                    const Color(0xff2563EB).withOpacity(.08),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(11),
              ),
              child: const Icon(
                Icons.insights_rounded,
                color: Color(0xff2563EB),
                size: 19,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              "Statistics",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xff0F172A),
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          childAspectRatio: 1.05,
          children: [
            _StatCard(
              title: "Departments",
              value: departments.toString(),
              icon: Icons.account_tree_rounded,
              color: const Color(0xff6366F1),
            ),
            _StatCard(
              title: "Courses",
              value: totalCourses.toString(),
              icon: Icons.menu_book_rounded,
              color: const Color(0xff22C55E),
            ),
            _StatCard(
              title: "Avg Courses",
              value: avgCourses.toStringAsFixed(1),
              icon: Icons.analytics_rounded,
              color: const Color(0xffF59E0B),
            ),
            _StatCard(
              title: "Active Faculty",
              value: "$active / ${lecturers.length}",
              icon: Icons.people_alt_rounded,
              color: const Color(0xff8B5CF6),
            ),
          ],
        ),

        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.03),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Faculty Status",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16.5,
                  color: Color(0xff0F172A),
                  letterSpacing: -0.2,
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: _StatusTile(
                      label: "Active",
                      value: active,
                      color: const Color(0xff22C55E),
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 1,
                    color: Colors.grey.shade100,
                  ),
                  Expanded(
                    child: _StatusTile(
                      label: "Inactive",
                      value: inactive,
                      color: const Color(0xffEF4444),
                    ),
                  ),
                ],
              ),

              if (lecturers.isNotEmpty) ...[
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: active / lecturers.length,
                    minHeight: 8,
                    backgroundColor: const Color(0xffEF4444).withOpacity(0.15),
                    valueColor: const AlwaysStoppedAnimation(Color(0xff22C55E)),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}


class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: color.withOpacity(.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: color.withOpacity(.12),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),

            const SizedBox(height: 10),

            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff0F172A),
                ),
              ),
            ),

            const SizedBox(height: 6),

            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class _StatusTile extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _StatusTile({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.5),
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: Color(0xff0F172A),
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}