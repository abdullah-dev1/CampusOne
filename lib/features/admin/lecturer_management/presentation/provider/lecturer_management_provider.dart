import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/models/lecturer_model.dart';
import '../../domain/repository/lecturer_repository.dart';

class LecturerManagementProvider extends ChangeNotifier {
  final LecturerRepository _repository;

  LecturerManagementProvider(this._repository) {
    _subscribe();
  }

  List<LecturerModel> lecturers = [];

  final Set<String> selectedLecturers = {};

  bool isLoading = true;

  String searchQuery = "";
  String selectedDepartment = "All";
 LecturerDesignation? selectedDesignation;
LecturerStatus? selectedStatus;

  StreamSubscription<List<LecturerModel>>? _subscription;

  void _subscribe() {
    _subscription = _repository.watchLecturers().listen((data) {
      lecturers = data;
      isLoading = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  //================ FILTER =================//

  List<LecturerModel> get filteredLecturers {
    List<LecturerModel> filtered = List.from(lecturers);

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((lecturer) {
        return lecturer.fullName.toLowerCase().contains(searchQuery) ||
            lecturer.employeeId.toLowerCase().contains(searchQuery) ||
            lecturer.email.toLowerCase().contains(searchQuery);
      }).toList();
    }

    if (selectedDepartment != "All") {
      filtered = filtered
          .where((e) => e.department == selectedDepartment)
          .toList();
    }

    if (selectedDesignation != null) {
  filtered = filtered.where((lecturer) {
    return lecturer.designation ==
        selectedDesignation;
  }).toList();
}

    if (selectedStatus != null) {
  filtered = filtered.where((lecturer) {
    return lecturer.status ==
        selectedStatus;
  }).toList();
}

    return filtered;
  }

  //================ SEARCH =================//

  void searchLecturers(String value) {
    searchQuery = value.trim().toLowerCase();
    notifyListeners();
  }
void filterDepartment(String value) {
  selectedDepartment = value;
  notifyListeners();
}
 

  void filterDesignation(
    LecturerDesignation? value) {
  selectedDesignation = value;
  notifyListeners();
}

 void filterStatus(
    LecturerStatus? value) {
  selectedStatus = value;
  notifyListeners();
}

  //================ CRUD =================//

  Future<String> addLecturer(LecturerModel lecturer) async {
    return await _repository.createLecturer(lecturer);
  }

  Future<void> updateLecturer(LecturerModel lecturer) async {
    await _repository.updateLecturer(lecturer);
  }

  Future<void> deleteLecturer(String id) async {
    await _repository.deleteLecturer(id);
  }

  //================ SELECTION =================//

  bool isSelected(String id) => selectedLecturers.contains(id);

  bool get hasSelection => selectedLecturers.isNotEmpty;

  int get selectedCount => selectedLecturers.length;

  void toggleSelection(String id) {
    if (selectedLecturers.contains(id)) {
      selectedLecturers.remove(id);
    } else {
      selectedLecturers.add(id);
    }
    notifyListeners();
  }

  void clearSelection() {
    selectedLecturers.clear();
    notifyListeners();
  }

  bool get isAllSelected {
    if (filteredLecturers.isEmpty) return false;
    return selectedLecturers.length == filteredLecturers.length;
  }

  void selectAll() {
    selectedLecturers.clear();

    for (final lecturer in filteredLecturers) {
      selectedLecturers.add(lecturer.id);
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

  //================ BULK =================//

  Future<void> activateSelectedLecturers() async {
    await _repository.bulkUpdateStatus(
      selectedLecturers.toList(),
      LecturerStatus.active,
    );

    clearSelection();
  }

  Future<void> deactivateSelectedLecturers() async {
    await _repository.bulkUpdateStatus(
      selectedLecturers.toList(),
      LecturerStatus.inactive,
    );

    clearSelection();
  }

  Future<void> deleteSelectedLecturers() async {
    await _repository.bulkDelete(
      selectedLecturers.toList(),
    );

    clearSelection();
  }

  Future<void> toggleStatus(String id) async {
    final lecturer = lecturers.firstWhere((e) => e.id == id);

    final newStatus = lecturer.status == LecturerStatus.active
        ? LecturerStatus.inactive
        : LecturerStatus.active;

    await _repository.updateStatus(id, newStatus);
  }

  //================ DASHBOARD =================//

  int get totalLecturers => lecturers.length;

  int get activeLecturers =>
      lecturers.where((e) => e.status == LecturerStatus.active).length;

  int get inactiveLecturers =>
      lecturers.where((e) => e.status == LecturerStatus.inactive).length;

  int get totalDepartments =>
      lecturers.map((e) => e.department).toSet().length;

  Map<String, int> get lecturersByDepartment {
    final Map<String, int> data = {};

    for (final lecturer in lecturers) {
      data.update(
        lecturer.department,
        (value) => value + 1,
        ifAbsent: () => 1,
      );
    }

    return data;
  }
  int get departmentCount => totalDepartments;

int get maxDepartmentLecturers {
  if (lecturersByDepartment.isEmpty) {
    return 0;
  }

  return lecturersByDepartment.values.reduce(
    (a, b) => a > b ? a : b,
  );
}
}