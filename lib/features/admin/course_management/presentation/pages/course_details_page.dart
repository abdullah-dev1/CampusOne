import 'package:flutter/material.dart';

import '../../data/models/course_model.dart';

class CourseDetailsPage extends StatelessWidget {
  final CourseModel course;

  const CourseDetailsPage({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        title: const Text("Course Details"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              child: Padding(
                padding: const EdgeInsets.all(24),

                child: Column(
                  children: [

                    CircleAvatar(
                      radius: 42,
                      backgroundColor: Colors.blue.shade100,

                      child: const Icon(
                        Icons.menu_book_rounded,
                        size: 42,
                        color: Colors.blue,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      course.courseTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      course.courseCode,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),

                      decoration: BoxDecoration(
                        color: course.status ==
                                CourseStatus.active
                            ? Colors.green.shade100
                            : Colors.red.shade100,

                        borderRadius:
                            BorderRadius.circular(30),
                      ),

                      child: Text(
                        course.status ==
                                CourseStatus.active
                            ? "ACTIVE"
                            : "INACTIVE",

                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: course.status ==
                                  CourseStatus.active
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            _sectionTitle("Course Information"),

            _infoCard(
              children: [

                _infoTile(
                  "Department",
                  course.department,
                ),

                _infoTile(
                  "Semester",
                  course.semester,
                ),

                _infoTile(
                  "Credit Hours",
                  course.creditHours.toString(),
                ),

                _infoTile(
                  "Course Type",
                  course.type.name.toUpperCase(),
                ),
              ],
            ),

            const SizedBox(height: 20),

            _sectionTitle("Instructor"),

            _infoCard(
              children: [

                _infoTile(
                  "Assigned Lecturer",
                  course.assignedLecturer.isEmpty
                      ? "Not Assigned"
                      : course.assignedLecturer,
                ),

              ],
            ),

            const SizedBox(height: 20),

            _sectionTitle("Enrollment"),

            _infoCard(
              children: [

                _infoTile(
                  "Students",
                  course.totalStudents.toString(),
                ),

                _infoTile(
                  "Assigned Sections",
                  course.assignedSections.isEmpty
                      ? "No Sections"
                      : course.assignedSections.join(", "),
                ),

              ],
            ),

            const SizedBox(height: 20),

            _sectionTitle("Prerequisites"),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),

                child: course.prerequisites.isEmpty
                    ? const Text("No prerequisites")
                    : Column(
                        children: course.prerequisites
                            .map(
                              (courseName) => ListTile(
                                dense: true,
                                leading: const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                                title: Text(courseName),
                              ),
                            )
                            .toList(),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            _sectionTitle("Description"),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Text(
                  course.description.isEmpty
                      ? "No description available."
                      : course.description,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 35),

          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,

      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),

        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _infoCard({
    required List<Widget> children,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget _infoTile(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),

      child: Row(
        children: [

          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        ],
      ),
    );
  }
}