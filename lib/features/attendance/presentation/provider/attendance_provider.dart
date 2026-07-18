import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../admin/student_management/data/models/student_model.dart';
import '../../../lecturer/presentation/provider/lecturer_provider.dart';
import '../../data/models/attendance_model.dart';

class AttendanceProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _subscription;

  final Map<String,
      Map<String, Map<String, List<AttendanceModel>>>>
      _attendanceData = {};

  List<String> availableCourses = [];
  List<String> availableSections = [];

  bool _initialized = false;
  bool get initialized => _initialized;

  String selectedCourse = "";
  String selectedSection = "";
  String lecturerEmail = "";
String lecturerName = "";
  String selectedDate =
      DateFormat('dd MMM yyyy').format(DateTime.now());

  String searchQuery = "";

  void initializeForLecturer(
      LecturerProvider lecturerProvider) {
    final lecturer = lecturerProvider.lecturer;

    if (lecturer == null) return;

    lecturerEmail = lecturer.email;
lecturerName = lecturer.fullName;

    _subscription?.cancel();

    _attendanceData.clear();

    availableCourses = lecturer.teachingAssignments
        .map((e) => e.course)
        .toSet()
        .toList();

    availableSections = lecturer.teachingAssignments
        .map((e) => e.section)
        .toSet()
        .toList();

    if (availableCourses.isNotEmpty) {
      selectedCourse = availableCourses.first;
    }

    if (availableSections.isNotEmpty) {
      selectedSection = availableSections.first;
    }

    selectedDate =
        DateFormat('dd MMM yyyy').format(DateTime.now());

    _listenStudents();

    _initialized = true;
loadAttendance();
    notifyListeners();
  }

  Future<void> loadAttendance() async {
  if (selectedCourse.isEmpty || selectedSection.isEmpty) {
    return;
  }

  final snapshot = await _firestore
      .collection("attendance")
      .where("course", isEqualTo: selectedCourse)
      .where("section", isEqualTo: selectedSection)
      .where("date", isEqualTo: selectedDate)
      .get();

  if (snapshot.docs.isEmpty) {
    return;
  }

  final records = students;

  for (final doc in snapshot.docs) {
    final data = doc.data();

    final index = records.indexWhere(
      (e) => e.student.id == data["studentId"],
    );

    if (index == -1) continue;

    records[index].status =
        AttendanceStatus.values.firstWhere(
      (e) => e.name == data["status"],
      orElse: () => AttendanceStatus.none,
    );
  }

  notifyListeners();
}

  void _listenStudents() {
    _subscription = _firestore
        .collection('students')
        .snapshots()
        .listen((snapshot) {
      final students = snapshot.docs
          .map(
            (e) => StudentModel.fromMap(
              e.id,
              e.data(),
            ),
          )
          .where(
            (student) =>
                student.section == selectedSection,
          )
          .toList();

      _attendanceData
          .putIfAbsent(selectedCourse, () => {})
          .putIfAbsent(selectedSection, () => {})[
              selectedDate] = students
          .map(
            (student) => AttendanceModel(
              student: student,
            ),
          )
          .toList();

      notifyListeners();
    });
  }

  List<AttendanceModel> get students {
    return _attendanceData[selectedCourse]
            ?[selectedSection]?[selectedDate] ??
        [];
  }

  List<AttendanceModel> get filteredStudents {
    if (searchQuery.isEmpty) {
      return students;
    }

    return students.where((student) {
      return student.studentName
              .toLowerCase()
              .contains(searchQuery) ||
          student.registrationNo
              .toLowerCase()
              .contains(searchQuery);
    }).toList();
  }

  void changeCourse(String value) {
    selectedCourse = value;
    loadAttendance();
    notifyListeners();
  }

  void changeSection(String value) {
    selectedSection = value;
    _listenStudents();
    loadAttendance();
    notifyListeners();
  }

  void changeDate(DateTime date) {
    selectedDate =
        DateFormat('dd MMM yyyy').format(date);
        loadAttendance();
    notifyListeners();
  }

  void searchStudent(String value) {
    searchQuery = value.trim().toLowerCase();
    notifyListeners();
  }

  void clearSearch() {
    searchQuery = "";
    notifyListeners();
  }

  void updateAttendance(
    int index,
    AttendanceStatus status,
  ) {
    students[index].status = status;
    notifyListeners();
  }

  void markAllPresent() {
    for (final student in students) {
      student.status = AttendanceStatus.present;
    }
    notifyListeners();
  }

  void markAllAbsent() {
    for (final student in students) {
      student.status = AttendanceStatus.absent;
    }
    notifyListeners();
  }

  void markAllLate() {
    for (final student in students) {
      student.status = AttendanceStatus.late;
    }
    notifyListeners();
  }

  void clearAttendance() {
    for (final student in students) {
      student.status = AttendanceStatus.none;
    }
    notifyListeners();
  }

  Future<bool> saveAttendance() async {
  if (students.isEmpty) return false;

  final collection =
      FirebaseFirestore.instance.collection("attendance");

  final batch = FirebaseFirestore.instance.batch();

  for (final attendance in students) {
    final docId =
    "${selectedDate}_${selectedCourse}_${selectedSection}_${attendance.student.id}";

final doc = collection.doc(docId);

    batch.set(doc, {

      "lecturerEmail": lecturerEmail,
"lecturerName": lecturerName,

"studentEmail": attendance.student.email,

"studentDepartment":
    attendance.student.department,

"studentSemester":
    attendance.student.semester,

"savedAt":
    FieldValue.serverTimestamp(),
      "studentId": attendance.student.id,
      "studentName": attendance.student.fullName,
      "registrationNo":
          attendance.student.registrationNo,

      "department":
          attendance.student.department,

      "semester":
          attendance.student.semester,

      "section":
          attendance.student.section,

      "course": selectedCourse,

      "status": attendance.status.name,

      "date": selectedDate,

      "timestamp":
          FieldValue.serverTimestamp(),
    });
  }

  await batch.commit();

  return true;
}

  int get totalStudents => students.length;

  int get presentCount => students
      .where(
        (e) => e.status == AttendanceStatus.present,
      )
      .length;

  int get absentCount => students
      .where(
        (e) => e.status == AttendanceStatus.absent,
      )
      .length;

  int get lateCount => students
      .where(
        (e) => e.status == AttendanceStatus.late,
      )
      .length;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}