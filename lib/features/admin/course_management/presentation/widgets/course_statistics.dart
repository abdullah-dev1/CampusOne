import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/course_model.dart';
import '../provider/course_management_provider.dart';

class CourseStatistics extends StatelessWidget {
  const CourseStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseManagementProvider>(
      builder: (context, provider, child) {
        final courses = provider.allCourses;

        final totalCourses = courses.length;

        final activeCourses = courses
            .where(
              (c) => c.status == CourseStatus.active,
            )
            .length;

        final coreCourses = courses
            .where(
              (c) => c.type == CourseType.core,
            )
            .length;

        final electiveCourses = courses
            .where(
              (c) => c.type == CourseType.elective,
            )
            .length;

        final totalStudents = courses.fold<int>(
          0,
          (sum, course) => sum + course.totalStudents,
        );

        final totalCredits = courses.fold<int>(
          0,
          (sum, course) => sum + course.creditHours,
        );

        return Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              "Course Statistics",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xff0F172A),
              ),
            ),

            const SizedBox(height: 18),

            GridView.count(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),

              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.25,

              children: [

                _StatCard(
                  title: "Total Courses",
                  value: totalCourses.toString(),
                  icon: Icons.menu_book,
                  color: Colors.blue,
                ),

                _StatCard(
                  title: "Active Courses",
                  value: activeCourses.toString(),
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),

                _StatCard(
                  title: "Core Courses",
                  value: coreCourses.toString(),
                  icon: Icons.school,
                  color: Colors.orange,
                ),

                _StatCard(
                  title: "Electives",
                  value: electiveCourses.toString(),
                  icon: Icons.auto_awesome,
                  color: Colors.purple,
                ),

                _StatCard(
                  title: "Students",
                  value: totalStudents.toString(),
                  icon: Icons.groups,
                  color: Colors.indigo,
                ),

                _StatCard(
                  title: "Credit Hours",
                  value: totalCredits.toString(),
                  icon: Icons.calculate,
                  color: Colors.teal,
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

  const _StatCard({
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
            radius: 24,
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
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 13,
            ),
          ),

        ],
      ),
    );
  }
}