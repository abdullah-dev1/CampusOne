import 'package:flutter/material.dart';
import '../../student_management/presentation/pages/student_management_page.dart';
import '../../lecturer_management/presentation/pages/lecturer_management_page.dart';
import '../../course_management/presentation/pages/course_management_page.dart';
import '../../department_management/presentation/pages/department_management_page.dart';
import '../../notice_management/presentation/pages/notice_management_page.dart';
import '../../reports_analytics/presentation/pages/reports_analytics_page.dart';

class AdminQuickActions extends StatelessWidget {
  const AdminQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Quick Actions",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff0F172A),
          ),
        ),

        const SizedBox(height: 18),

        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          childAspectRatio: 1.12,
          children: [
            _ActionCard(
              title: "Students",
              subtitle: "Manage Students",
              icon: Icons.groups,
              color: const Color(0xff2563EB),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const StudentManagementPage(),
                  ),
                );
              },
            ),
           _ActionCard(
  title: "Lecturers",
  subtitle: "Manage Faculty",
  icon: Icons.person_outline_rounded,
  color: const Color(0xff8B5CF6),

  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LecturerManagementPage(),
      ),
    );
  },
),
          _ActionCard(
  title: "Courses",
  subtitle: "Manage Courses",
  icon: Icons.menu_book_rounded,
  color: const Color(0xff059669),

  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CourseManagementPage(),
      ),
    );
  },
),
           _ActionCard(
  title: "Departments",
  subtitle: "Manage Departments",
  icon: Icons.account_tree_rounded,
  color: const Color(0xffF59E0B),

  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const DepartmentManagementPage(),
      ),
    );
  },
),
            _ActionCard(
  title: "Notices",
  subtitle: "University Notices",
  icon: Icons.campaign_rounded,
  color: const Color(0xffDC2626),

  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const NoticeManagementPage(),
      ),
    );
  },
),
            _ActionCard(
              title: "Reports",
              subtitle: "Analytics",
              icon: Icons.bar_chart_rounded,
              color: const Color(0xffDC2626),
              onTap: () {
                Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ReportsAnalyticsPage(),
      ),
    );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(.08),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: color.withOpacity(.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: color),
                ),
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}