import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../grades/data/models/grade_model.dart';

class StudentGradeProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _loading = false;
  bool get loading => _loading;

  List<GradeModel> _grades = [];
  List<GradeModel> get grades => _grades;

  double _cgpa = 0.0;
  double get cgpa => _cgpa;

  int _completedCourses = 0;
  int get completedCourses => _completedCourses;

  int _totalCredits = 0;
  int get totalCredits => _totalCredits;

  // ==========================
  // COURSES
  // ==========================

  /// Distinct course names found in loaded grades.
  List<String> get courses {
    return _grades.map((e) => e.course).toSet().toList()..sort();
  }

  /// All grade entries belonging to a given course.
  List<GradeModel> resultsOfCourse(String course) {
    return _grades.where((g) => g.course == course).toList();
  }

  /// Percentage (0-100) for a given course, based on obtained/total marks
  /// across all its assessments.
  double percentageOfCourse(String course) {
    final results = resultsOfCourse(course);

    if (results.isEmpty) return 0;

    double obtained = 0;
    double total = 0;

    for (final g in results) {
      obtained += g.obtainedMarks;
      total += g.totalMarks;
    }

    return total == 0 ? 0 : (obtained / total) * 100;
  }

  // ==========================
  // Load Grades
  // ==========================

  Future<void> loadGrades() async {
    _loading = true;
    notifyListeners();

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        _grades = [];
        _resetStatistics();
        _loading = false;
        notifyListeners();
        return;
      }

      final studentDoc = await _firestore
          .collection("students")
          .where("email", isEqualTo: user.email)
          .limit(1)
          .get();

      if (studentDoc.docs.isEmpty) {
        _grades = [];
        _resetStatistics();
        _loading = false;
        notifyListeners();
        return;
      }

      final studentId = studentDoc.docs.first.id;

      final gradesSnapshot = await _firestore
          .collection("grades")
          .where("studentId", isEqualTo: studentId)
          .where("published", isEqualTo: true)
          .get();

      _grades = gradesSnapshot.docs
          .map(
            (doc) => GradeModel.fromMap(
              doc.id,
              doc.data(),
            ),
          )
          .toList();

      _grades.sort((a, b) {
        final c = a.course.compareTo(b.course);
        if (c != 0) return c;
        return a.assessment.compareTo(b.assessment);
      });

      _calculateCGPA();
    } catch (e) {
      debugPrint("Student Grades Error: $e");

      _grades = [];
      _resetStatistics();
    }

    _loading = false;
    notifyListeners();
  }

  // ==========================
  // GPA Calculation
  // ==========================

  void _calculateCGPA() {
    if (_grades.isEmpty) {
      _resetStatistics();
      return;
    }

    // Final Exam represents one completed course.
    final finals = _grades.where((e) => e.assessment == "Final Exam").toList();

    if (finals.isEmpty) {
      _resetStatistics();
      return;
    }

    double totalGradePoints = 0;

    for (final grade in finals) {
      totalGradePoints += _gradePoint(grade.obtainedMarks, grade.totalMarks);
    }

    _completedCourses = finals.length;

    // Temporary assumption:
    // Every course = 3 credit hours.
    _totalCredits = finals.length * 3;

    _cgpa = totalGradePoints / finals.length;
  }

  double _gradePoint(double obtained, double total) {
    final percentage = total == 0 ? 0 : (obtained / total) * 100;

    if (percentage >= 90) return 4.00;
    if (percentage >= 85) return 3.67;
    if (percentage >= 80) return 3.33;
    if (percentage >= 75) return 3.00;
    if (percentage >= 70) return 2.67;
    if (percentage >= 65) return 2.33;
    if (percentage >= 60) return 2.00;
    if (percentage >= 55) return 1.67;
    if (percentage >= 50) return 1.00;

    return 0.0;
  }

  void _resetStatistics() {
    _cgpa = 0.0;
    _completedCourses = 0;
    _totalCredits = 0;
  }
}