import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/student_model.dart';
import '../provider/student_management_provider.dart';
import '../pages/add_edit_student_page.dart';
import '../pages/student_details_page.dart';

class StudentCard extends StatelessWidget {
  final StudentModel student;

  const StudentCard({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudentManagementProvider>();

    final bool isSelected =
        provider.isSelected(student.id);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.only(bottom: 16),

      decoration: BoxDecoration(
        color: isSelected
            ? Colors.blue.shade50
            : Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isSelected
              ? Colors.blue
              : Colors.transparent,
          width: 2,
        ),
      ),

      child: InkWell(
        borderRadius: BorderRadius.circular(18),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => StudentDetailsPage(
                student: student,
              ),
            ),
          );
        },

        child: Card(
          margin: EdgeInsets.zero,
          elevation: 1,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),

          child: Padding(
            padding: const EdgeInsets.all(18),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Row(
                  children: [

                    Checkbox(
                      value: isSelected,
                      onChanged: (_) {
                        provider.toggleSelection(
                          student.id,
                        );
                      },
                    ),

                    CircleAvatar(
                      radius: 28,
                      backgroundColor:
                          Colors.blue.shade100,
                      child: Text(
                        student.fullName[0],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [

                          Text(
                            student.fullName,
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),

                          const SizedBox(
                              height: 4),

                          Text(
                            student
                                .registrationNo,
                          ),

                          Text(student.email),
                        ],
                      ),
                    ),

                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),

                      decoration:
                          BoxDecoration(
                        color: student.status ==
                                StudentStatus
                                    .active
                            ? Colors
                                .green.shade100
                            : Colors
                                .red.shade100,

                        borderRadius:
                            BorderRadius
                                .circular(20),
                      ),

                      child: Text(
                        student.status ==
                                StudentStatus
                                    .active
                            ? "Active"
                            : "Inactive",

                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          color: student.status ==
                                  StudentStatus
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
                        value:
                            student.department,
                      ),
                    ),

                    Expanded(
                      child: _InfoTile(
                        title: "Semester",
                        value:
                            student.semester,
                      ),
                    ),

                    Expanded(
                      child: _InfoTile(
                        title: "Section",
                        value: student.section,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                Row(
                  children: [

                    Expanded(
                      child:
                          OutlinedButton.icon(
                        icon:
                            const Icon(Icons.edit),
                        label:
                            const Text("Edit"),

                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ChangeNotifierProvider
                                      .value(
                                value: provider,
                                child:
                                    AddEditStudentPage(
                                  student:
                                      student,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child:
                          FilledButton.icon(
                        icon: Icon(
                          student.status ==
                                  StudentStatus
                                      .active
                              ? Icons.block
                              : Icons
                                  .check_circle,
                        ),

                        label: Text(
                          student.status ==
                                  StudentStatus
                                      .active
                              ? "Deactivate"
                              : "Activate",
                        ),

                        onPressed: () {
                          provider.toggleStatus(
                            student.id,
                          );
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,

                  child: TextButton.icon(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),

                    label: const Text(
                      "Delete Student",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),

                    onPressed: () async {

                      final delete =
                          await showDialog<bool>(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text(
                              "Delete Student",
                            ),

                            content:
                                const Text(
                              "Are you sure you want to delete this student?",
                            ),

                            actions: [

                              TextButton(
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                    false,
                                  );
                                },
                                child:
                                    const Text(
                                        "Cancel"),
                              ),

                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                    true,
                                  );
                                },
                                child:
                                    const Text(
                                        "Delete"),
                              ),
                            ],
                          );
                        },
                      );

                      if (delete == true) {
                        provider.deleteStudent(
                          student.id,
                        );
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