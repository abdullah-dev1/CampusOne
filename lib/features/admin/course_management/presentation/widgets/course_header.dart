import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/course_management_provider.dart';

class CourseHeader extends StatelessWidget {
  const CourseHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseManagementProvider>(
      builder: (context, provider, child) {
        return Container(
          width: double.infinity,

          padding: const EdgeInsets.all(24),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),

            gradient: const LinearGradient(
              colors: [
                Color(0xff2563EB),
                Color(0xff1D4ED8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(.20),
                blurRadius: 20,
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
                      Icons.menu_book_rounded,
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
                          "Course Management",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "${provider.allCourses.length} Courses Available",
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
                      title: "Departments",
                      value: provider.departments.length.toString(),
                    ),
                  ),

                  Expanded(
                    child: _HeaderTile(
                      title: "Semesters",
                      value: "8",
                    ),
                  ),

                  Expanded(
                    child: _HeaderTile(
                      title: "Courses",
                      value: provider.allCourses.length.toString(),
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