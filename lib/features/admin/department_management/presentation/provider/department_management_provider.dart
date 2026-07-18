import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/models/department_model.dart';
import '../../domain/repository/department_repository.dart';

class DepartmentManagementProvider extends ChangeNotifier {
  final DepartmentRepository _repository;

  DepartmentManagementProvider(this._repository) {
    _subscribe();
  }

  List<DepartmentModel> departments = [];

  bool isLoading = true;

  String searchQuery = "";
  String selectedStatus = "All";

  final Set<String> selectedDepartments = {};

  StreamSubscription<List<DepartmentModel>>? _subscription;

  //---------------- FIREBASE ----------------//

  void _subscribe() {
    _subscription = _repository.watchDepartments().listen(
      (data) {
        departments = data;
        isLoading = false;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  //---------------- FILTER ----------------//

  List<DepartmentModel> get filteredDepartments {
    List<DepartmentModel> filtered = List.from(departments);

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((department) {
        return department.name
                .toLowerCase()
                .contains(searchQuery) ||
            department.code
                .toLowerCase()
                .contains(searchQuery) ||
            department.hodName
                .toLowerCase()
                .contains(searchQuery);
      }).toList();
    }

    if (selectedStatus != "All") {
      filtered = filtered.where((department) {
        if (selectedStatus == "Active") {
          return department.status ==
              DepartmentStatus.active;
        }

        return department.status ==
            DepartmentStatus.inactive;
      }).toList();
    }

    return filtered;
  }

  //---------------- SEARCH ----------------//

  void searchDepartments(String value) {
    searchQuery = value.trim().toLowerCase();
    notifyListeners();
  }

  //---------------- STATUS FILTER ----------------//

  void filterStatus(String value) {
    selectedStatus = value;
    notifyListeners();
  }

  //---------------- CRUD ----------------//

  Future<void> addDepartment(
    DepartmentModel department,
  ) async {
    await _repository.createDepartment(department);
  }

  Future<void> updateDepartment(
    DepartmentModel department,
  ) async {
    await _repository.updateDepartment(department);
  }

  Future<void> deleteDepartment(
    String id,
  ) async {
    await _repository.deleteDepartment(id);
  }

  //---------------- SELECTION ----------------//

  bool isSelected(String id) =>
      selectedDepartments.contains(id);

  bool get hasSelection =>
      selectedDepartments.isNotEmpty;

  int get selectedCount =>
      selectedDepartments.length;

  void toggleSelection(String id) {
    if (selectedDepartments.contains(id)) {
      selectedDepartments.remove(id);
    } else {
      selectedDepartments.add(id);
    }

    notifyListeners();
  }

  void clearSelection() {
    selectedDepartments.clear();
    notifyListeners();
  }

  bool get isAllSelected {
    if (filteredDepartments.isEmpty) {
      return false;
    }

    return selectedDepartments.length ==
        filteredDepartments.length;
  }

  void selectAll() {
    selectedDepartments.clear();

    for (final department in filteredDepartments) {
      selectedDepartments.add(department.id);
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

  //---------------- BULK DELETE ----------------//

  Future<void> deleteSelectedDepartments() async {
    await _repository.bulkDelete(
      selectedDepartments.toList(),
    );

    clearSelection();
  }

  //---------------- DASHBOARD ----------------//

  int get totalDepartments =>
      departments.length;
int get totalPrograms => 0;

int get totalFaculty => 0;

int get totalStudents => 0;
  int get activeDepartments => departments
      .where(
        (e) =>
            e.status ==
            DepartmentStatus.active,
      )
      .length;

  int get inactiveDepartments => departments
      .where(
        (e) =>
            e.status ==
            DepartmentStatus.inactive,
      )
      .length;
}