import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../lecturer/presentation/provider/lecturer_provider.dart';

import '../provider/grade_provider.dart';
import '../widgets/grade_student_card.dart';
import '../widgets/grades_filters.dart';
import '../widgets/grades_header.dart';
import '../widgets/grades_summary.dart';

class GradesPage extends StatefulWidget {
  const GradesPage({super.key});

  @override
  State<GradesPage> createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) return;

    final lecturerProvider = context.read<LecturerProvider>();

    if (lecturerProvider.lecturer != null) {
      context
          .read<GradeProvider>()
          .initializeForLecturer(lecturerProvider);

      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(
        title: const Text("Grade Management"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Consumer<LecturerProvider>(
          builder: (context, lecturerProvider, child) {
            if (lecturerProvider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (lecturerProvider.lecturer == null) {
              return const Center(
                child: Text("Unable to load lecturer."),
              );
            }

            return Consumer<GradeProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    const GradesHeader(),

                    const SizedBox(height: 24),

                    const GradesSummary(),

                    const SizedBox(height: 24),

                    const GradesFilters(),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: Icon(
                          provider.isPublished
                              ? Icons.lock
                              : Icons.publish,
                        ),
                        label: Text(
                          provider.isPublished
                              ? "Published"
                              : "Publish Results",
                        ),
                        onPressed: provider.isPublished
                            ? null
                            : () async {
                                final confirm =
                                    await showDialog<bool>(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text(
                                      "Publish Results",
                                    ),
                                    content: const Text(
                                       "Published grades will be visible to students.\n\nContinue?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(
                                              context, false);
                                        },
                                        child:
                                            const Text("Cancel"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(
                                              context, true);
                                        },
                                        child:
                                            const Text("Publish"),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirm == true) {
                                  await provider.publishGrades();

                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Grades published successfully.",
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                      ),
                    ),

                    const SizedBox(height: 24),

                    if (provider.filteredStudents.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 50,
                        ),
                        child: Center(
                          child: Text(
                            "No students found.",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(),
                        itemCount:
                            provider.filteredStudents.length,
                        itemBuilder: (context, index) {
                          return GradeStudentCard(
                            index: index,
                          );
                        },
                      ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}