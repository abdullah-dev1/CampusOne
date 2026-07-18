import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../student_management/presentation/provider/student_management_provider.dart';
import '../../../lecturer_management/presentation/provider/lecturer_management_provider.dart';
import '../../../course_management/presentation/provider/course_management_provider.dart';
import '../../../department_management/presentation/provider/department_management_provider.dart';

class DepartmentChart extends StatelessWidget {
  const DepartmentChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final studentProvider = context.watch<StudentManagementProvider>();
    final lecturerProvider = context.watch<LecturerManagementProvider>();
    final courseProvider = context.watch<CourseManagementProvider>();
    final departmentProvider = context.watch<DepartmentManagementProvider>();

    final data = studentProvider.studentsByDepartment;

    final maxStudents = data.isEmpty
        ? 1
        : data.values.reduce((a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
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
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.apartment_rounded,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  "Department Analytics",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          const Text(
            "Students by Department",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 18),

          if (data.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text("No Department Data"),
              ),
            )
          else
            ...data.entries.map(
              (department) {
                final progress = department.value / maxStudents;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              department.key,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(
                            department.value.toString(),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 12,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

          const SizedBox(height: 28),

          const Divider(),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  title: "Departments",
                  value: departmentProvider.departments.length.toString(),
                  icon: Icons.apartment_rounded,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SummaryCard(
                  title: "Students",
                  value: studentProvider.totalStudents.toString(),
                  icon: Icons.groups,
                  color: Colors.blue,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  title: "Faculty",
                  value: lecturerProvider.totalLecturers.toString(),
                  icon: Icons.school,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SummaryCard(
                  title: "Courses",
                  value: courseProvider.totalCourses.toString(),
                  icon: Icons.menu_book,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
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
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 26,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}