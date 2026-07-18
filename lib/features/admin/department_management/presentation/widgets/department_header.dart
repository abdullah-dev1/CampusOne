import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/department_management_provider.dart';

class DepartmentHeader extends StatelessWidget {
  const DepartmentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DepartmentManagementProvider>(
      builder: (context, provider, child) {
        final departments = provider.departments;

        final totalDepartments = departments.length;

        final totalFaculty = departments.fold<int>(
          0,
          (sum, department) => sum + department.facultyCount,
        );

        final totalStudents = departments.fold<int>(
          0,
          (sum, department) => sum + department.studentCount,
        );

        final totalCourses = departments.fold<int>(
          0,
          (sum, department) => sum + department.courseCount,
        );

        return Container(
          width: double.infinity,

          padding: const EdgeInsets.all(24),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),

            gradient: const LinearGradient(
              colors: [
                Color(0xffF59E0B),
                Color(0xffD97706),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(.18),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [

                  Container(
                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.15),
                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: const Icon(
                      Icons.account_tree_rounded,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),

                  const SizedBox(width: 18),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        const Text(
                          "Department Management",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "$totalDepartments Departments",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                          ),
                        ),

                      ],
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 28),

              Row(
                children: [

                  Expanded(
                    child: _HeaderTile(
                      title: "Faculty",
                      value: totalFaculty.toString(),
                    ),
                  ),

                  Expanded(
                    child: _HeaderTile(
                      title: "Students",
                      value: totalStudents.toString(),
                    ),
                  ),

                  Expanded(
                    child: _HeaderTile(
                      title: "Courses",
                      value: totalCourses.toString(),
                    ),
                  ),

                ],
              ),

            ],
          ),
        );
      },
    );
  }
}

class _HeaderTile extends StatelessWidget {
  final String title;
  final String value;

  const _HeaderTile({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
          ),
        ),

      ],
    );
  }
}