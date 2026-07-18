import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/course_model.dart';
import '../pages/add_edit_course_page.dart';
import '../pages/course_details_page.dart';
import '../provider/course_management_provider.dart';

class CourseCard extends StatelessWidget {
  final CourseModel course;

  const CourseCard({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseManagementProvider>();

    return InkWell(
  borderRadius: BorderRadius.circular(18),

  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CourseDetailsPage(
          course: course,
        ),
      ),
    );
  },

  child: AnimatedContainer(
  duration: const Duration(milliseconds: 250),
  curve: Curves.easeInOut,
  margin: const EdgeInsets.only(bottom: 24),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(28),
    border: Border.all(
      color: const Color(0xffE8ECF4),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(.04),
        blurRadius: 28,
        offset: const Offset(0, 12),
      ),
      BoxShadow(
        color: Colors.blue.withOpacity(.04),
        blurRadius: 40,
        offset: const Offset(0, 18),
      ),
    ],
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(28),
    child: Padding(
          padding: const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Row(
                children: [
                  Container(
  height: 60,
  width: 60,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(22),
    gradient: const LinearGradient(
      colors: [
        Color(0xff2563EB),
        Color(0xff1D4ED8),
      ],
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.blue.withOpacity(.30),
        blurRadius: 20,
        offset: const Offset(0, 8),
      ),
    ],
  ),
  child: const Icon(
    Icons.menu_book_rounded,
    color: Colors.white,
    size: 28,
  ),
),

                  const SizedBox(width: 18),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          course.courseTitle,
                          style: const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                           fontSize: 18,
letterSpacing: -.3,
                          ),
                        ),

                        const SizedBox(height: 4),

                        const SizedBox(height: 10),

Container(
  padding: const EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 6,
  ),
  decoration: BoxDecoration(
    color: Colors.blue.shade50,
    borderRadius: BorderRadius.circular(30),
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [

      const Icon(
        Icons.badge_outlined,
        size: 10,
        color: Colors.blue,
      ),

      const SizedBox(width: 6),

      Text(
        course.courseCode,
        style: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
),
                       

                       const SizedBox(height: 12),

Row(
  children: [

    const Icon(
      Icons.person_outline,
      size: 18,
      color: Colors.grey,
    ),

    const SizedBox(width: 8),

    Expanded(
      child: Text(
        course.assignedLecturer.isEmpty
            ? "No Lecturer Assigned"
            : course.assignedLecturer,
        style: TextStyle(
          color: Colors.grey.shade700,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  ],
),

                      ],
                    ),
                  ),

                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),

                    decoration: BoxDecoration(
                      color: course.status ==
                              CourseStatus.active
                          ? Colors.green.shade100
                          : Colors.red.shade100,

                      borderRadius:
                          BorderRadius.circular(
                              20),
                    ),

                    child: Text(
                      course.status ==
                              CourseStatus.active
                          ? "Active"
                          : "Inactive",

                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        color: course.status ==
                                CourseStatus
                                    .active
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 18),

              Row(
                children: [

                  Expanded(
                    child: _InfoTile(
                      title: "Department",
                      value: course.department,
                    ),
                  ),

                  Expanded(
                    child: _InfoTile(
                      title: "Semester",
                      value: course.semester,
                    ),
                  ),

                  Expanded(
                    child: _InfoTile(
                      title: "Credits",
                      value: course.creditHours
                          .toString(),
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 16),

              Row(
                children: [

                  Expanded(
                    child: _InfoTile(
                      title: "Type",
                      value:
                          course.type.name
                              .toUpperCase(),
                    ),
                  ),

                  Expanded(
                    child: _InfoTile(
                      title: "Sections",
                      value: course
                          .assignedSections
                          .length
                          .toString(),
                    ),
                  ),

                  Expanded(
                    child: _InfoTile(
                      title: "Students",
                      value: course
                          .totalStudents
                          .toString(),
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 20),

              Row(
                children: [

                  Expanded(
                    child:
                       OutlinedButton.icon(
  icon: const Icon(
    Icons.edit_rounded,
    size: 20,
  ),
  label: const Text(
    "Edit Course",
    style: TextStyle(
      fontWeight: FontWeight.w600,
    ),
  ),
  style: OutlinedButton.styleFrom(
    foregroundColor: const Color(0xff2563EB),
    side: const BorderSide(
      color: Color(0xff2563EB),
      width: 1.4,
    ),
    padding: const EdgeInsets.symmetric(
      vertical: 18,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(
          value: provider,
          child: AddEditCoursePage(
            course: course,
          ),
        ),
      ),
    );
  },
)
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child:
                      FilledButton.icon(
  icon: Icon(
    course.status == CourseStatus.active
        ? Icons.block_rounded
        : Icons.check_circle_rounded,
  ),
  label: Text(
    course.status == CourseStatus.active
        ? "Deactivate"
        : "Activate",
    style: const TextStyle(
      fontWeight: FontWeight.w600,
    ),
  ),
  style: FilledButton.styleFrom(
    backgroundColor:
        course.status == CourseStatus.active
            ? Colors.red.shade600
            : Colors.green.shade600,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(
      vertical: 18,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 0,
  ),
  onPressed: () {
    provider.toggleStatus(course.id);
  },
)
                  ),

                ],
              ),

              const SizedBox(height: 10),

             SizedBox(
  width: double.infinity,
  child: OutlinedButton.icon(
    icon: const Icon(
      Icons.delete_outline_rounded,
      color: Colors.red,
    ),

    label: const Text(
      "Delete Course",
      style: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),

    style: OutlinedButton.styleFrom(
      side: BorderSide(
        color: Colors.red.shade300,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 18,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    onPressed: () async {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Delete Course"),
          content: Text(
            "Delete ${course.courseTitle}?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel"),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Delete"),
            ),
          ],
        ),
      );

      if (confirm == true) {
        provider.deleteCourse(course.id);
      }
    },
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

class _InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const _InfoTile({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

      ],
    );
  }
}