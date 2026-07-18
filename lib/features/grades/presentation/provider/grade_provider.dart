import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../admin/lecturer_management/data/models/lecturer_model.dart';
import '../../../admin/student_management/data/models/student_model.dart';
import '../../../lecturer/presentation/provider/lecturer_provider.dart';
import '../../data/models/grade_model.dart';

class GradeProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StreamSubscription<QuerySnapshot>? _studentSubscription;
  StreamSubscription<QuerySnapshot>? _gradeSubscription;

  bool _initialized = false;

  bool get initialized => _initialized;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<StudentModel> _students = [];
  List<StudentModel> get students => _students;

  List<GradeModel> _grades = [];
  List<GradeModel> get grades => _grades;

  LecturerModel? _lecturer;

  List<String> availableCourses = [];
  List<String> availableSections = [];

  String lecturerId = "";

  String selectedCourse = "";
  String selectedSection = "";
  String selectedAssessment = "Quiz 1";

  bool isPublished = false;

  final Map<String, double> assessmentMarks = {
    "Quiz 1": 10,
    "Quiz 2": 10,
    "Mid 1": 15,
    "Mid 2": 15,
    "Final Exam": 100,
  };

  double totalMarks = 10;

  String searchQuery = "";

  void initializeForLecturer(
    LecturerProvider lecturerProvider,
  ) {
    if (_initialized) return;

    final lecturer = lecturerProvider.lecturer;

    if (lecturer == null) return;

    _lecturer = lecturer;

    lecturerId = lecturer.id;

    availableCourses.clear();

    for (final assignment in lecturer.teachingAssignments) {
      if (!availableCourses.contains(assignment.course)) {
        availableCourses.add(assignment.course);
      }
    }

    if (availableCourses.isNotEmpty) {
      selectedCourse = availableCourses.first;
    }

    _loadSections();

    _listenStudents();

    _listenGrades();

    _initialized = true;
  }

  void _loadSections() {
    availableSections.clear();

    if (_lecturer == null) return;

    for (final assignment in _lecturer!.teachingAssignments) {
      if (assignment.course == selectedCourse) {
        if (!availableSections.contains(assignment.section)) {
          availableSections.add(assignment.section);
        }
      }
    }

    if (availableSections.isNotEmpty) {
      selectedSection = availableSections.first;
    } else {
      selectedSection = "";
    }
  }

  void _listenStudents() {
    _studentSubscription?.cancel();

    _studentSubscription = _firestore
        .collection("students")
        .snapshots()
        .listen((snapshot) {
      _students = snapshot.docs
          .map(
            (doc) => StudentModel.fromMap(
              doc.id,
              doc.data(),
            ),
          )
          .where(
            (student) => student.section == selectedSection,
          )
          .toList();

      notifyListeners();
    });
  }

  void _listenGrades() {
    _gradeSubscription?.cancel();

    _gradeSubscription = _firestore
        .collection("grades")
        .snapshots()
        .listen((snapshot) {
      _grades = snapshot.docs
          .map(
            (doc) => GradeModel.fromMap(
              doc.id,
              doc.data(),
            ),
          )
          .toList();

      notifyListeners();
    });
  }

  List<StudentModel> get filteredStudents {
    if (searchQuery.isEmpty) {
      return _students;
    }

    return _students.where((student) {
      return student.fullName
              .toLowerCase()
              .contains(searchQuery) ||
          student.registrationNo
              .toLowerCase()
              .contains(searchQuery);
    }).toList();
  }

  GradeModel? gradeOf(StudentModel student) {
    try {
      return _grades.firstWhere(
        (grade) =>
            grade.studentId == student.id &&
            grade.course == selectedCourse &&
            grade.section == selectedSection &&
            grade.assessment == selectedAssessment,
      );
    } catch (_) {
      return null;
    }
  }

  double marksOf(StudentModel student) {
    final grade = gradeOf(student);

    if (grade == null) {
      return 0;
    }

    return grade.obtainedMarks;
  }

    String gradeLetter(StudentModel student) {
    return calculateGrade(
      marksOf(student),
    );
  }

  bool studentPassed(StudentModel student) {
    return marksOf(student) >= (totalMarks * 0.5);
  }

  int get totalStudents => filteredStudents.length;

  int get passCount =>
      filteredStudents.where(studentPassed).length;

  int get failCount =>
      totalStudents - passCount;

  double get classAverage {
    if (filteredStudents.isEmpty) return 0;

    double total = 0;

    for (final student in filteredStudents) {
      total += marksOf(student);
    }

    return total / filteredStudents.length;
  }

  double get highestMarks {
    if (filteredStudents.isEmpty) return 0;

    double highest = 0;

    for (final student in filteredStudents) {
      if (marksOf(student) > highest) {
        highest = marksOf(student);
      }
    }

    return highest;
  }

  double get lowestMarks {
    if (filteredStudents.isEmpty) return 0;

    double lowest = marksOf(filteredStudents.first);

    for (final student in filteredStudents) {
      if (marksOf(student) < lowest) {
        lowest = marksOf(student);
      }
    }

    return lowest;
  }

  void changeCourse(String value) {
    selectedCourse = value;

    _loadSections();

    _listenStudents();

    notifyListeners();
  }

  void changeSection(String value) {
    selectedSection = value;

    _listenStudents();

    notifyListeners();
  }

  void changeAssessment(String value) {
    selectedAssessment = value;

    totalMarks = assessmentMarks[value] ?? 10;

    notifyListeners();
  }

  void searchStudent(String value) {
    searchQuery = value.trim().toLowerCase();

    notifyListeners();
  }

  void changeTotalMarks(String value) {
    totalMarks = double.tryParse(value) ?? totalMarks;

    notifyListeners();
  }

    Future<void> updateMarks(
    StudentModel student,
    double marks,
  ) async {
    final existingGrade = gradeOf(student);

    if (existingGrade == null) {
      await _firestore.collection("grades").add({
        "studentId": student.id,
        "lecturerId": lecturerId,
        "studentName": student.fullName,
        "registrationNo": student.registrationNo,
        "course": selectedCourse,
        "section": selectedSection,
        "assessment": selectedAssessment,
        "obtainedMarks": marks,
        "totalMarks": totalMarks,
        "published": false,
        "createdAt": FieldValue.serverTimestamp(),
      });
    } else {
      await _firestore
          .collection("grades")
          .doc(existingGrade.id)
          .update({
        "obtainedMarks": marks,
        "totalMarks": totalMarks,
      });
    }
  }

Future<void> publishGrades() async {

  final docs = _grades.where(
    (grade) =>
        grade.course == selectedCourse &&
        grade.section == selectedSection,
  );

  for (final grade in docs) {

    await _firestore
        .collection("grades")
        .doc(grade.id)
        .update({
          "published": true,
        });

  }

  isPublished = true;

  notifyListeners();
}

Future<void> unPublishGrades() async {

  final docs = _grades.where(
    (grade) =>
        grade.course == selectedCourse &&
        grade.section == selectedSection,
  );

  for(final grade in docs){

    await _firestore
        .collection("grades")
        .doc(grade.id)
        .update({
          "published": false,
        });

  }

  isPublished=false;

  notifyListeners();
}

  String calculateGrade(double marks) {
    final percentage = calculatePercentage(marks);

    if (percentage >= 90) return "A+";
    if (percentage >= 85) return "A";
    if (percentage >= 80) return "B+";
    if (percentage >= 75) return "B";
    if (percentage >= 70) return "C+";
    if (percentage >= 65) return "C";
    if (percentage >= 60) return "D";

    return "F";
  }
    double calculatePercentage(double marks) {
    if (totalMarks == 0) {
      return 0;
    }

    return (marks / totalMarks) * 100;
  }

  bool isPass(double marks) {
    return calculatePercentage(marks) >= 50;
  }

  @override
  void dispose() {
    _studentSubscription?.cancel();
    _gradeSubscription?.cancel();
    super.dispose();
  }
}