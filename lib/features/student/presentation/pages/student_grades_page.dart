import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/student_grade_provider.dart';

class StudentGradesPage extends StatefulWidget {
  const StudentGradesPage({super.key});

  @override
  State<StudentGradesPage> createState() =>
      _StudentGradesPageState();
}

class _StudentGradesPageState
    extends State<StudentGradesPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<StudentGradeProvider>()
          .loadGrades();
    });
  }

  Color _gradeColor(String grade) {
    switch (grade) {
      case "A+":
      case "A":
        return Colors.green;
      case "B+":
      case "B":
        return Colors.blue;
      case "C+":
      case "C":
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  String _calculateGrade(
    double obtained,
    double total,
  ) {
    final percentage = (obtained / total) * 100;

    if (percentage >= 90) return "A+";
    if (percentage >= 85) return "A";
    if (percentage >= 80) return "B+";
    if (percentage >= 75) return "B";
    if (percentage >= 70) return "C+";
    if (percentage >= 65) return "C";
    if (percentage >= 60) return "D";

    return "F";
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<StudentGradeProvider>();

    if (provider.loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (provider.grades.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("My Grades"),
        ),
        body: const Center(
          child: Text(
            "No Grades Available",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    final Map<String, List<dynamic>> grouped = {};

    for (final grade in provider.grades) {
      grouped.putIfAbsent(
        grade.course,
        () => [],
      );

      grouped[grade.course]!.add(grade);
    }

    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Grades",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(18),
        itemCount: grouped.length,
        itemBuilder: (context, index) {
          final course =
              grouped.keys.elementAt(index);

          final grades = grouped[course]!;

          return Container(
            margin: const EdgeInsets.only(
              bottom: 22,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(
                    .05,
                  ),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: const Color(
                            0xff2563EB,
                          ).withOpacity(.12),
                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                        ),
                        child: const Icon(
                          Icons.menu_book_rounded,
                          color: Color(
                            0xff2563EB,
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Text(
                          course,
                          style:
                              const TextStyle(
                            fontSize: 15,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green
                              .withOpacity(.12),
                          borderRadius:
                              BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: const Text(
                          "Published",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 2),

                  const Divider(),

                  const SizedBox(height: 10),

                                    ...grades.map(
                    (grade) {
                      final letter =
                          _calculateGrade(
                        grade.obtainedMarks,
                        grade.totalMarks,
                      );

                      return Padding(
                        padding:
                            const EdgeInsets.only(
                          bottom: 14,
                        ),
                        child: Container(
                          padding:
                              const EdgeInsets.all(
                            14,
                          ),
                          decoration:
                              BoxDecoration(
                            color:
                                Colors.grey.shade50,
                            borderRadius:
                                BorderRadius
                                    .circular(16),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  grade.assessment,
                                  style:
                                      const TextStyle(
                                    fontSize: 12,
                                    fontWeight:
                                        FontWeight
                                            .w600,
                                  ),
                                ),
                              ),

                              Expanded(
                                flex: 2,
                                child: Text(
                                  "${grade.obtainedMarks.toStringAsFixed(0)} / ${grade.totalMarks.toStringAsFixed(0)}",
                                  textAlign:
                                      TextAlign
                                          .center,
                                  style:
                                      const TextStyle(
                                    fontSize: 12,
                                    fontWeight:
                                        FontWeight
                                            .w600,
                                  ),
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
                                  color:
                                      _gradeColor(
                                    letter,
                                  ).withOpacity(
                                    .12,
                                  ),
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    20,
                                  ),
                                ),
                                child: Text(
                                  letter,
                                  style:
                                      TextStyle(
                                    color:
                                        _gradeColor(
                                      letter,
                                    ),
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(
                        Icons.verified_rounded,
                        color: Colors.green,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Total Assessments: ${grades.length}",
                        style: TextStyle(
                          color:
                              Colors.grey.shade700,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}