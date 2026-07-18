import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../lecturer/presentation/provider/lecturer_provider.dart';
import '../provider/attendance_provider.dart';

import '../widgets/attendance_filters.dart';
import '../widgets/attendance_header.dart';
import '../widgets/attendance_student_card.dart';
import '../widgets/attendance_summary.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) return;

    final lecturerProvider = context.read<LecturerProvider>();

    if (lecturerProvider.lecturer != null) {
      context
          .read<AttendanceProvider>()
          .initializeForLecturer(lecturerProvider);

      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(
        title: const Text("Take Attendance"),
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
                child: Text(
                  "Unable to load lecturer.",
                ),
              );
            }

            if (!_initialized) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context
                    .read<AttendanceProvider>()
                    .initializeForLecturer(lecturerProvider);

                setState(() {
                  _initialized = true;
                });
              });
            }

            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const AttendanceHeader(),

                const SizedBox(height: 24),

                const AttendanceSummary(),

                const SizedBox(height: 24),

                const AttendanceFilters(),

                const SizedBox(height: 20),

                Consumer<AttendanceProvider>(
                  builder: (context, provider, child) {
                    return Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        ElevatedButton.icon(
                          onPressed: provider.markAllPresent,
                          icon: const Icon(Icons.check_circle),
                          label: const Text("All Present"),
                        ),
                        ElevatedButton.icon(
                          onPressed: provider.markAllAbsent,
                          icon: const Icon(Icons.cancel),
                          label: const Text("All Absent"),
                        ),
                        ElevatedButton.icon(
                          onPressed: provider.markAllLate,
                          icon: const Icon(Icons.schedule),
                          label: const Text("All Late"),
                        ),
                        OutlinedButton.icon(
                          onPressed: provider.clearAttendance,
                          icon: const Icon(Icons.refresh),
                          label: const Text("Clear"),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: Consumer<AttendanceProvider>(
                    builder: (context, provider, child) {
                      return ElevatedButton.icon(
                        icon: const Icon(Icons.save_rounded),
                        label: const Text(
                          "Save Attendance",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {
                         final success =
    await provider.saveAttendance();

                          if (success) {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(18),
                                  ),
                                  title: const Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),
                                      SizedBox(width: 10),
                                      Text("Attendance Saved"),
                                    ],
                                  ),
                                  content: const Text(
                                    "Attendance has been saved successfully.",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        provider.clearSearch();
                                        Navigator.pop(context);
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Please complete attendance first.",
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                Consumer<AttendanceProvider>(
                  builder: (context, provider, child) {
                    if (provider.filteredStudents.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: Text(
                            "No students found.",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      itemCount: provider.filteredStudents.length,
                      itemBuilder: (context, index) {
                        return AttendanceStudentCard(
                          index: provider.students.indexOf(
                            provider.filteredStudents[index],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}