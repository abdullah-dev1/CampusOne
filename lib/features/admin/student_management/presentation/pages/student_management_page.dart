import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/student_management_provider.dart';

import '../widgets/student_header.dart';
import '../widgets/student_summary.dart';
import '../widgets/student_filters.dart';
import '../widgets/student_card.dart';

import 'add_edit_student_page.dart';
import '../../../../../core/services/service_locator.dart';
import '../../domain/repository/student_repository.dart';

class StudentManagementPage extends StatelessWidget {
  const StudentManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StudentManagementProvider(sl<StudentRepository>()),
      child: Consumer<StudentManagementProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: const Color(0xffF8FAFC),
            appBar: AppBar(
              centerTitle: true,
              title: Consumer<StudentManagementProvider>(
                builder: (context, provider, child) {
                  return Text(
                    provider.hasSelection
                        ? "${provider.selectedCount} Selected"
                        : "Student Management",
                  );
                },
              ),
              actions: [
                Consumer<StudentManagementProvider>(
                  builder: (context, provider, child) {
                    if (!provider.hasSelection) {
                      return const SizedBox();
                    }

                    return IconButton(
                      icon: const Icon(Icons.select_all),
                      tooltip: provider.isAllSelected
                          ? "Clear Selection"
                          : "Select All",
                      onPressed: () {
                        provider.toggleSelectAll();
                      },
                    );
                  },
                ),
                Consumer<StudentManagementProvider>(
                  builder: (context, provider, child) {
                    if (!provider.hasSelection) {
                      return const SizedBox();
                    }

                    return IconButton(
                      icon: const Icon(Icons.clear),
                      tooltip: "Clear Selection",
                      onPressed: () {
                        provider.clearSelection();
                      },
                    );
                  },
                ),
                Consumer<StudentManagementProvider>(
                  builder: (context, provider, child) {
                    if (!provider.hasSelection) {
                      return const SizedBox();
                    }

                    return IconButton(
                      tooltip: "Activate",
                      icon: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        provider.activateSelectedStudents();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Selected students activated.",
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                Consumer<StudentManagementProvider>(
                  builder: (context, provider, child) {
                    if (!provider.hasSelection) {
                      return const SizedBox();
                    }

                    return IconButton(
                      tooltip: "Deactivate",
                      icon: const Icon(
                        Icons.block,
                        color: Colors.orange,
                      ),
                      onPressed: () {
                        provider.deactivateSelectedStudents();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Selected students deactivated.",
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                Consumer<StudentManagementProvider>(
                  builder: (context, provider, child) {
                    if (!provider.hasSelection) {
                      return const SizedBox();
                    }

                    return IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                      tooltip: "Delete Selected",
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: const Text("Delete Students"),
                              content: Text(
                                "Delete ${provider.selectedCount} selected students?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: const Text("Cancel"),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text("Delete"),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirm == true) {
                          provider.deleteSelectedStudents();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Students deleted successfully.",
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              icon: const Icon(Icons.person_add),
              label: const Text("Add Student"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider.value(
                      value: provider,
                      child: const AddEditStudentPage(),
                    ),
                  ),
                );
              },
            ),
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const StudentHeader(),
                  const SizedBox(height: 24),
                  const StudentSummary(),
                  const SizedBox(height: 24),
                  const StudentFilters(),
                  const SizedBox(height: 24),
                  if (provider.filteredStudents.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(40),
                      child: const Center(
                        child: Text(
                          "No students found.",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    )
                  else
                    ...provider.filteredStudents.map(
                      (student) => StudentCard(student: student),
                    ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}