import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/department_model.dart';
import '../provider/department_management_provider.dart';

class DepartmentStatistics extends StatelessWidget {
  const DepartmentStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DepartmentManagementProvider>(
      builder: (context, provider, child) {

        final departments = provider.departments;

        final total = departments.length;

        final active = departments.where(
          (d) => d.status == DepartmentStatus.active,
        ).length;

        final inactive = departments.where(
          (d) => d.status == DepartmentStatus.inactive,
        ).length;

        final faculty = departments.fold<int>(
          0,
          (sum, d) => sum + d.facultyCount,
        );

        final students = departments.fold<int>(
          0,
          (sum, d) => sum + d.studentCount,
        );

        final courses = departments.fold<int>(
          0,
          (sum, d) => sum + d.courseCount,
        );

        return Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              "Department Statistics",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            GridView.count(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),

              crossAxisCount: 2,
              childAspectRatio: 1.25,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,

              children: [

                _StatCard(
                  "Departments",
                  total.toString(),
                  Icons.account_tree,
                  Colors.orange,
                ),

                _StatCard(
                  "Active",
                  active.toString(),
                  Icons.check_circle,
                  Colors.green,
                ),

                _StatCard(
                  "Inactive",
                  inactive.toString(),
                  Icons.block,
                  Colors.red,
                ),

                _StatCard(
                  "Faculty",
                  faculty.toString(),
                  Icons.person,
                  Colors.indigo,
                ),

                _StatCard(
                  "Students",
                  students.toString(),
                  Icons.groups,
                  Colors.blue,
                ),

                _StatCard(
                  "Courses",
                  courses.toString(),
                  Icons.menu_book,
                  Colors.teal,
                ),

              ],
            ),

          ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard(
    this.title,
    this.value,
    this.icon,
    this.color, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: color.withOpacity(.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          CircleAvatar(
            backgroundColor:
                color.withOpacity(.12),

            child: Icon(
              icon,
              color: color,
            ),
          ),

          const Spacer(),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),

        ],
      ),
    );
  }
}