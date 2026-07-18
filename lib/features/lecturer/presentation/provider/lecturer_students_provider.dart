import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../admin/student_management/data/models/student_model.dart';
import 'lecturer_provider.dart';

class LecturerStudentsProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _subscription;

  List<StudentModel> _students = [];

  bool _isLoading = false;

  String _searchQuery = "";

  List<StudentModel> get students => _students;

  bool get isLoading => _isLoading;

  int get totalStudents => filteredStudents.length;

  void initialize(LecturerProvider lecturerProvider) {
    _subscription?.cancel();

    final lecturer = lecturerProvider.lecturer;

    if (lecturer == null) return;

    _isLoading = true;
    notifyListeners();

    final allowedSections = lecturer.teachingAssignments
    .map((e) => e.section)
    .toSet();

    _subscription = _firestore
        .collection('students')
        .snapshots()
        .listen((snapshot) {
      final allStudents = snapshot.docs
          .map(
            (doc) => StudentModel.fromMap(
              doc.id,
              doc.data(),
            ),
          )
          .toList();

      _students = allStudents.where((student) {
        return allowedSections.contains(student.section);
      }).toList();

      _isLoading = false;
      notifyListeners();
    });
  }

  void searchStudent(String value) {
    _searchQuery = value.trim().toLowerCase();
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = "";
    notifyListeners();
  }

  List<StudentModel> get filteredStudents {
    if (_searchQuery.isEmpty) {
      return _students;
    }

    return _students.where((student) {
      return student.fullName
              .toLowerCase()
              .contains(_searchQuery) ||
          student.registrationNo
              .toLowerCase()
              .contains(_searchQuery) ||
          student.email
              .toLowerCase()
              .contains(_searchQuery);
    }).toList();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}