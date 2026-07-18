import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/pdf_service.dart';
import '../../services/print_service.dart';

import '../../../student_management/presentation/provider/student_management_provider.dart';
import '../../../lecturer_management/presentation/provider/lecturer_management_provider.dart';
import '../../../course_management/presentation/provider/course_management_provider.dart';
import '../../../department_management/presentation/provider/department_management_provider.dart';
import '../../../notice_management/presentation/provider/notice_management_provider.dart';

class ExportButtons extends StatelessWidget {
  const ExportButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Export Reports",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 18),

       SizedBox(
  width: double.infinity,
  child: _ExportButton(
    title: "Export PDF",
    subtitle: "Generate PDF Report",
    icon: Icons.picture_as_pdf_rounded,
    color: Colors.red,
    onTap: () async {
      final studentProvider =
          context.read<StudentManagementProvider>();

      final lecturerProvider =
          context.read<LecturerManagementProvider>();

      final courseProvider =
          context.read<CourseManagementProvider>();

      final departmentProvider =
          context.read<DepartmentManagementProvider>();

      final noticeProvider =
          context.read<NoticeManagementProvider>();

      await PdfService.generateReport(
        totalStudents: studentProvider.totalStudents,
        totalLecturers: lecturerProvider.totalLecturers,
        totalCourses: courseProvider.totalCourses,
        totalDepartments:
            departmentProvider.departments.length,
        totalNotices:
            noticeProvider.filteredNotices.length,
      );
    },
  ),
),

        const SizedBox(height: 16),

        SizedBox(
          width: double.infinity,
          child: _ExportButton(
            title: "Print Report",
            subtitle: "Print Complete Analytics Dashboard",
            icon: Icons.print_rounded,
            color: Colors.blue,
           onTap: () async {
  final studentProvider =
      context.read<StudentManagementProvider>();

  final lecturerProvider =
      context.read<LecturerManagementProvider>();

  final courseProvider =
      context.read<CourseManagementProvider>();

  final departmentProvider =
      context.read<DepartmentManagementProvider>();

  final noticeProvider =
      context.read<NoticeManagementProvider>();

  await PrintService.printReport(
    totalStudents: studentProvider.totalStudents,
    totalLecturers: lecturerProvider.totalLecturers,
    totalCourses: courseProvider.totalCourses,
    totalDepartments:
        departmentProvider.departments.length,
    totalNotices:
        noticeProvider.filteredNotices.length,
  );
},
          ),
        ),
      ],
    );
  }
}

class _ExportButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ExportButton({
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
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(20),
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
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: color.withOpacity(.12),
                child: Icon(
                  icon,
                  color: color,
                  size: 30,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}