import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../grades/data/models/grade_model.dart';
import '../../../student/presentation/provider/student_grade_provider.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<StudentGradeProvider>().loadGrades();
    });
  }

  Color _standingColor(double cgpa) {
    if (cgpa >= 3.70) {
      return Colors.green;
    }

    if (cgpa >= 3.30) {
      return Colors.blue;
    }

    if (cgpa >= 3.00) {
      return Colors.orange;
    }

    return Colors.red;
  }

  String _standingText(double cgpa) {
    if (cgpa >= 3.70) {
      return "Excellent";
    }

    if (cgpa >= 3.30) {
      return "Very Good";
    }

    if (cgpa >= 3.00) {
      return "Good";
    }

    return "Needs Improvement";
  }

  Widget _topCard(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.12),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white24,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(.85),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudentGradeProvider>();

    if (provider.loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final grades = provider.grades;

    final courses = grades.map((e) => e.course).toSet().toList()..sort();

    return Scaffold(
      backgroundColor: const Color(0xffF4F7FC),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          "Academic Results",
          style: TextStyle(
            color: Color(0xff0F172A),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: grades.isEmpty
          ? const Center(
              child: Text(
                "No Published Results",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                //---------------------------------------
                // HERO CARD
                //---------------------------------------

                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xff2563EB),
                        Color(0xff1D4ED8),
                        Color(0xff1E40AF),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff2563EB).withOpacity(.30),
                        blurRadius: 30,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.15),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          _standingText(provider.cgpa),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 120,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "CGPA",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 1),
                              Text(
                                provider.cgpa.toStringAsFixed(2),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Expanded(
                            child: _topCard(
                              Icons.menu_book_rounded,
                              "Credits",
                              provider.totalCredits.toString(),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: _topCard(
                              Icons.school_rounded,
                              "Courses",
                              provider.completedCourses.toString(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: _standingColor(provider.cgpa).withOpacity(.18),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.workspace_premium_rounded,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Academic Standing : ${_standingText(provider.cgpa)}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                const Text(
                  "Course Performance",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 18),

                ...courses.map((course) {
                  final courseGrades =
                      grades.where((g) => g.course == course).toList();

                  double obtained = 0;
                  double total = 0;

                  for (final grade in courseGrades) {
                    obtained += grade.obtainedMarks;
                    total += grade.totalMarks;
                  }

                  final percentage =
                      total == 0 ? 0.0 : (obtained / total) * 100;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 26),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.05),
                          blurRadius: 22,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xff2563EB),
                                      Color(0xff60A5FA),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: const Icon(
                                  Icons.menu_book_rounded,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      course,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${courseGrades.length} Assessments",
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xff2563EB).withOpacity(.10),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  "${percentage.toStringAsFixed(1)}%",
                                  style: const TextStyle(
                                    color: Color(0xff2563EB),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              minHeight: 10,
                              value: percentage / 100,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: const AlwaysStoppedAnimation(
                                Color(0xff2563EB),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          ...courseGrades.map(
                            (GradeModel grade) {
                              final gradePercentage = grade.totalMarks == 0
                                  ? 0.0
                                  : (grade.obtainedMarks / grade.totalMarks) *
                                      100;

                              return Container(
                                margin: const EdgeInsets.only(bottom: 14),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(0xffF8FAFC),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      grade.assessment,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${grade.obtainedMarks}/${grade.totalMarks} (${gradePercentage.toStringAsFixed(1)}%)",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
    );
  }
}