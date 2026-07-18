import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/course_model.dart';
import '../provider/course_management_provider.dart';

class AddEditCoursePage extends StatefulWidget {
  final CourseModel? course;

  const AddEditCoursePage({
    super.key,
    this.course,
  });

  @override
  State<AddEditCoursePage> createState() =>
      _AddEditCoursePageState();
}

class _AddEditCoursePageState
    extends State<AddEditCoursePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController codeController;
  late TextEditingController titleController;
  late TextEditingController creditsController;
  late TextEditingController lecturerController;
  late TextEditingController studentsController;
  late TextEditingController descriptionController;
  late TextEditingController prerequisiteController;

  String department = "BS Computer Science";
  String semester = "1";

  CourseType type = CourseType.core;

  final List<String> sections = [];

  final List<String> prerequisites = [];

  @override
  void initState() {
    super.initState();

    final course = widget.course;

    codeController = TextEditingController(
      text: course?.courseCode ?? "",
    );

    titleController = TextEditingController(
      text: course?.courseTitle ?? "",
    );

    creditsController = TextEditingController(
      text: course?.creditHours.toString() ?? "",
    );

    lecturerController = TextEditingController(
      text: course?.assignedLecturer ?? "",
    );

    studentsController = TextEditingController(
      text: course?.totalStudents.toString() ?? "",
    );

    descriptionController = TextEditingController(
      text: course?.description ?? "",
    );

    prerequisiteController = TextEditingController();

    if (course != null) {
      department = course.department;
      semester = course.semester;
      type = course.type;

      sections.addAll(course.assignedSections);
      prerequisites.addAll(course.prerequisites);
    }
  }

  @override
  void dispose() {
    codeController.dispose();
    titleController.dispose();
    creditsController.dispose();
    lecturerController.dispose();
    studentsController.dispose();
    descriptionController.dispose();
    prerequisiteController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.read<CourseManagementProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.course == null
              ? "Add Course"
              : "Edit Course",
        ),
      ),

      body: Form(
        key: _formKey,

        child: ListView(
          padding: const EdgeInsets.all(20),

          children: [

            _field(
              codeController,
              "Course Code",
            ),

            const SizedBox(height: 18),

            _field(
              titleController,
              "Course Title",
            ),

            const SizedBox(height: 18),

            DropdownButtonFormField<String>(
              value: department,

              decoration:
                  const InputDecoration(
                labelText: "Department",
                border:
                    OutlineInputBorder(),
              ),

              items: const [

                DropdownMenuItem(
                  value:
                      "BS Computer Science",
                  child:
                      Text("Computer Science"),
                ),

                DropdownMenuItem(
                  value:
                      "BS Software Engineering",
                  child: Text(
                      "Software Engineering"),
                ),

                DropdownMenuItem(
                  value:
                      "BS Artificial Intelligence",
                  child: Text(
                      "Artificial Intelligence"),
                ),

                DropdownMenuItem(
                  value:
                      "BS Information Technology",
                  child: Text(
                      "Information Technology"),
                ),
              ],

              onChanged: (value) {
                setState(() {
                  department = value!;
                });
              },
            ),

            const SizedBox(height: 18),

            DropdownButtonFormField<String>(
              value: semester,

              decoration:
                  const InputDecoration(
                labelText: "Semester",
                border:
                    OutlineInputBorder(),
              ),

              items: List.generate(
                8,
                (index) => DropdownMenuItem(
                  value: "${index + 1}",
                  child: Text(
                    "Semester ${index + 1}",
                  ),
                ),
              ),

              onChanged: (value) {
                setState(() {
                  semester = value!;
                });
              },
            ),

            const SizedBox(height: 18),

            _field(
              creditsController,
              "Credit Hours",
              keyboard:
                  TextInputType.number,
            ),

            const SizedBox(height: 18),

            DropdownButtonFormField<CourseType>(
              value: type,

              decoration:
                  const InputDecoration(
                labelText: "Course Type",
                border:
                    OutlineInputBorder(),
              ),

              items: const [

                DropdownMenuItem(
                  value: CourseType.core,
                  child: Text("Core"),
                ),

                DropdownMenuItem(
                  value:
                      CourseType.elective,
                  child: Text("Elective"),
                ),

              ],

              onChanged: (value) {
                setState(() {
                  type = value!;
                });
              },
            ),

            const SizedBox(height: 18),

            _field(
              lecturerController,
              "Assigned Lecturer",
            ),

            const SizedBox(height: 18),

            _field(
              studentsController,
              "Total Students",
              keyboard:
                  TextInputType.number,
            ),

            const SizedBox(height: 18),

            _field(
              descriptionController,
              "Description",
              maxLines: 4,
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: 55,

              child: ElevatedButton(

                onPressed: () {

                  if (!_formKey.currentState!
                      .validate()) {
                    return;
                  }

                  final now = DateTime.now();

                  final course = CourseModel(
                    id: widget.course?.id ??
                        now.millisecondsSinceEpoch.toString(),
                    courseCode: codeController.text,
                    courseTitle: titleController.text,
                    department: department,
                    semester: semester,
                    creditHours: int.tryParse(creditsController.text) ?? 3,
                    type: type,
                    description: descriptionController.text,
                    prerequisites: prerequisites,
                    assignedLecturer: lecturerController.text,
                    assignedSections: sections,
                    totalStudents:
                        int.tryParse(studentsController.text) ?? 0,
                    status: widget.course?.status ?? CourseStatus.active,
                    createdAt: widget.course?.createdAt ?? now,
                    updatedAt: now,
                  );

                  if (widget.course ==
                      null) {
                    provider.addCourse(
                        course);
                  } else {
                    provider
                        .updateCourse(
                            course);
                  }

                  Navigator.pop(
                      context);
                },

                child: Text(
                  widget.course == null
                      ? "Add Course"
                      : "Update Course",
                ),
              ),
            ),

            const SizedBox(height: 30),

          ],
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    TextInputType keyboard =
        TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,

      keyboardType: keyboard,

      maxLines: maxLines,

      decoration: InputDecoration(
        labelText: label,
        border:
            const OutlineInputBorder(),
      ),

      validator: (value) {
        if (value == null ||
            value.isEmpty) {
          return "Required";
        }
        return null;
      },
    );
  }
}