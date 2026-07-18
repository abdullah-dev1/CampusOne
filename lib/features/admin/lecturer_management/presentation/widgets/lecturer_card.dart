import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/lecturer_model.dart';
import '../provider/lecturer_management_provider.dart';
import '../pages/add_edit_lecturer_page.dart';
import '../pages/lecturer_details_page.dart';

class LecturerCard extends StatelessWidget {
  final LecturerModel lecturer;

  const LecturerCard({
    super.key,
    required this.lecturer,
  });

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<LecturerManagementProvider>();

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LecturerDetailsPage(
              lecturer: lecturer,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
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

                  CircleAvatar(
  radius: 28,
  backgroundColor: Colors.deepPurple.shade100,
  child: ClipOval(
    child: Image.asset(
      lecturer.profileImage,
      width: 56,
      height: 56,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) {
        return Center(
          child: Text(
            lecturer.fullName[0].toUpperCase(),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    ),
  ),
),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Text(
                          lecturer.fullName,
                          style: const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(lecturer.employeeId),

                        Text(lecturer.email),

                      ],
                    ),
                  ),

                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: lecturer.status ==
                              LecturerStatus.active
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: Text(
                      lecturer.status ==
                              LecturerStatus.active
                          ? "Active"
                          : "Inactive",
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        color: lecturer.status ==
                                LecturerStatus.active
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 20),

              Row(
                children: [

                  Expanded(
                    child: _InfoTile(
                      title: "Department",
                      value: lecturer.department,
                    ),
                  ),

                  Expanded(
                    child: _InfoTile(
                      title: "Designation",
                      value: lecturer.designation
                          .name,
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 16),

              const Text(
                "Assigned Courses",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              
              Wrap(
  spacing: 8,
  runSpacing: 8,
  children: lecturer.teachingAssignments
      .map((e) => e.course)
      .toSet()
      .map(
        (course) => Chip(
          label: Text(course),
        ),
      )
      .toList(),
),

              const SizedBox(height: 16),

              const Text(
                "Assigned Sections",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

             Wrap(
  spacing: 8,
  runSpacing: 8,
  children: lecturer.teachingAssignments
      .map((e) => e.section)
      .toSet()
      .map(
        (section) => Chip(
          backgroundColor: Colors.blue.shade50,
          label: Text(section),
        ),
      )
      .toList(),
),

              const SizedBox(height: 20),

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
                                ChangeNotifierProvider.value(
                              value: provider,
                              child:
                                  AddEditLecturerPage(
                                lecturer:
                                    lecturer,
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
                        lecturer.status ==
                                LecturerStatus
                                    .active
                            ? Icons.block
                            : Icons.check_circle,
                      ),
                      label: Text(
                        lecturer.status ==
                                LecturerStatus
                                    .active
                            ? "Deactivate"
                            : "Activate",
                      ),
                      onPressed: () {
                        provider.toggleStatus(
                          lecturer.id,
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
                    "Delete Lecturer",
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
                            "Delete Lecturer",
                          ),
                          content:
                              const Text(
                            "Are you sure you want to delete this lecturer?",
                          ),
                          actions: [

                            TextButton(
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                  false,
                                );
                              },
                              child: const Text(
                                  "Cancel"),
                            ),

                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                  true,
                                );
                              },
                              child: const Text(
                                  "Delete"),
                            ),

                          ],
                        );
                      },
                    );

                    if (delete == true) {
                      provider.deleteLecturer(
                        lecturer.id,
                      );
                    }
                  },
                ),
              ),

            ],
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