import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/models/student_model.dart';
import '../../domain/repository/student_repository.dart';

class StudentManagementProvider extends ChangeNotifier {
  final StudentRepository _repository;

  StudentManagementProvider(this._repository) {
    _subscribe();
  }

  List<StudentModel> students = [];
  final Set<String> selectedStudents = {};

  bool isLoading = true;

  String searchQuery = "";
  String selectedDepartment = "All";
  String selectedSemester = "All";
  String selectedSection = "All";
  String selectedStatus = "All";

  StreamSubscription<List<StudentModel>>? _subscription;

  void _subscribe() {
    _subscription = _repository.watchStudents().listen((data) {
      students = data;
      isLoading = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  List<StudentModel> get filteredStudents {
    List<StudentModel> filtered = List.from(students);

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((student) {
        return student.fullName.toLowerCase().contains(searchQuery) ||
            student.registrationNo.toLowerCase().contains(searchQuery) ||
            student.email.toLowerCase().contains(searchQuery);
      }).toList();
    }

    if (selectedDepartment != "All") {
      filtered = filtered
          .where((student) => student.department == selectedDepartment)
          .toList();
    }

    if (selectedSemester != "All") {
      filtered = filtered
          .where((student) => student.semester == selectedSemester)
          .toList();
    }

    if (selectedSection != "All") {
      filtered = filtered
          .where((student) => student.section == selectedSection)
          .toList();
    }

    if (selectedStatus != "All") {
      filtered = filtered.where((student) {
        if (selectedStatus == "Active") {
          return student.status == StudentStatus.active;
        }
        return student.status == StudentStatus.inactive;
      }).toList();
    }

    return filtered;
  }

  //---------------- SELECTION ----------------//

  bool isSelected(String studentId) => selectedStudents.contains(studentId);

  int get selectedCount => selectedStudents.length;

  bool get hasSelection => selectedStudents.isNotEmpty;

  void toggleSelection(String studentId) {
    if (selectedStudents.contains(studentId)) {
      selectedStudents.remove(studentId);
    } else {
      selectedStudents.add(studentId);
    }
    notifyListeners();
  }

  void toggleSelectAll() {
    if (isAllSelected) {
      clearSelection();
    } else {
      selectAll();
    }
  }

  void clearSelection() {
    selectedStudents.clear();
    notifyListeners();
  }

  bool get isAllSelected {
    if (filteredStudents.isEmpty) return false;
    return selectedStudents.length == filteredStudents.length;
  }

  void selectAll() {
    selectedStudents.clear();
    for (final student in filteredStudents) {
      selectedStudents.add(student.id);
    }
    notifyListeners();
  }

  //---------------- SEARCH / FILTERS ----------------//

  void searchStudent(String value) {
    searchQuery = value.trim().toLowerCase();
    notifyListeners();
  }

  void changeDepartment(String value) {
    selectedDepartment = value;
    notifyListeners();
  }

  void changeSemester(String value) {
    selectedSemester = value;
    notifyListeners();
  }

  void changeSection(String value) {
    selectedSection = value;
    notifyListeners();
  }

  void changeStatus(String value) {
    selectedStatus = value;
    notifyListeners();
  }

  //---------------- CRUD ----------------//

  /// Returns the generated temporary password for the admin to share.
  Future<String> addStudent(StudentModel student) async {
    return await _repository.createStudent(student);
  }

  Future<void> updateStudent(StudentModel updatedStudent) async {
    await _repository.updateStudent(updatedStudent);
  }

  Future<void> deleteStudent(String id) async {
    await _repository.deleteStudent(id);
  }

  //---------------- BULK ACTIONS ----------------//

  Future<void> deleteSelectedStudents() async {
    await _repository.bulkDelete(selectedStudents.toList());
    selectedStudents.clear();
    notifyListeners();
  }

  Future<void> activateSelectedStudents() async {
    await _repository.bulkUpdateStatus(
      selectedStudents.toList(),
      StudentStatus.active,
    );
    selectedStudents.clear();
    notifyListeners();
  }

  Future<void> deactivateSelectedStudents() async {
    await _repository.bulkUpdateStatus(
      selectedStudents.toList(),
      StudentStatus.inactive,
    );
    selectedStudents.clear();
    notifyListeners();
  }

  Future<void> toggleStatus(String id) async {
    final student = students.firstWhere((e) => e.id == id);
    final newStatus = student.status == StudentStatus.active
        ? StudentStatus.inactive
        : StudentStatus.active;

    await _repository.updateStatus(id, newStatus);
  }

  //---------------- DASHBOARD ----------------//

  int get totalStudents => students.length;

  int get activeStudents =>
      students.where((e) => e.status == StudentStatus.active).length;

  int get inactiveStudents =>
      students.where((e) => e.status == StudentStatus.inactive).length;

  int get totalDepartments =>
      students.map((e) => e.department).toSet().length;

  int get totalSections => students.map((e) => e.section).toSet().length;

  int get totalSemesters => students.map((e) => e.semester).toSet().length;

  Map<String, int> get studentsByDepartment {
    final Map<String, int> data = {};

    for (final student in students) {
      data.update(
        student.department,
        (value) => value + 1,
        ifAbsent: () => 1,
      );
    }

    return data;
  }
}