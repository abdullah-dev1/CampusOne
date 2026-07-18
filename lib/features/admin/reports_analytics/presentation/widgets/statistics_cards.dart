import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../student_management/presentation/provider/student_management_provider.dart';
import '../../../lecturer_management/presentation/provider/lecturer_management_provider.dart';
import '../../../course_management/presentation/provider/course_management_provider.dart';
import '../../../department_management/presentation/provider/department_management_provider.dart';
import '../../../notice_management/presentation/provider/notice_management_provider.dart';

class StatisticsCards extends StatelessWidget {
  const StatisticsCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final studentProvider =
    context.watch<StudentManagementProvider>();

final lecturerProvider =
    context.watch<LecturerManagementProvider>();

final courseProvider =
    context.watch<CourseManagementProvider>();

final departmentProvider =
    context.watch<DepartmentManagementProvider>();

final noticeProvider =
    context.watch<NoticeManagementProvider>();
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.05,
      children:  [
        _StatisticCard(
          title: "Students",
          value: studentProvider.totalStudents.toString(),
          icon: Icons.groups_rounded,
          color: Colors.blue,
        ),
        _StatisticCard(
          title: "Lecturers",
          value:
    lecturerProvider.totalLecturers.toString(),
          icon: Icons.school_rounded,
          color: Colors.deepPurple,
        ),
        _StatisticCard(
          title: "Courses",
         value:
    courseProvider.totalCourses.toString(),
          icon: Icons.menu_book_rounded,
          color: Colors.orange,
        ),
        _StatisticCard(
          title: "Departments",
         value:
    departmentProvider.totalDepartments.toString(),
          icon: Icons.apartment_rounded,
          color: Colors.teal,
        ),
        _StatisticCard(
          title: "Notices",
         value:
    noticeProvider.totalNotices.toString(),
          icon: Icons.campaign_rounded,
          color: Colors.red,
        ),
        _StatisticCard(
  title: "Pinned",
  value: noticeProvider.pinnedNotices.length.toString(),
  icon: Icons.push_pin_rounded,
  color: Colors.green,
),
      ],
    );
  }
}

class _StatisticCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatisticCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              Icon(
                Icons.trending_up,
                color: color,
                size: 18,
              ),
            ],
          ),

          const Spacer(),

          Text(
            value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}