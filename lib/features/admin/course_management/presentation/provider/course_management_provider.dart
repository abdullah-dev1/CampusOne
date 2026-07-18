import 'package:flutter/material.dart';

import '../../data/models/course_model.dart';
import '../../domain/repository/course_repository.dart';

class CourseManagementProvider extends ChangeNotifier {
  CourseManagementProvider(
    this._repository, {
    bool autoLoad = true,
  }) {
    if (autoLoad) {
      loadCourses();
    }
  }

  final CourseRepository _repository;

  final List<CourseModel> _courses = [];
  final Set<String> _selectedIds = {};

  bool _isLoading = false;
  bool _useDummyData = false;

  String _searchQuery = '';
  String _selectedDepartment = '';
  String _selectedSemester = 'All';
  CourseType? _selectedType;
  CourseStatus? _statusFilter;

  bool get isLoading => _isLoading;

  List<CourseModel> get allCourses => List.unmodifiable(_courses);

  List<CourseModel> get courses => filteredCourses;

  List<CourseModel> get filteredCourses {
    return _courses.where((course) {
      final matchesSearch = _searchQuery.isEmpty ||
          course.courseTitle
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          course.courseCode
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          course.department
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());

      final matchesDepartment = _selectedDepartment.isEmpty ||
          course.department == _selectedDepartment;

      final matchesSemester = _selectedSemester == 'All' ||
          course.semester == _selectedSemester;

      final matchesType =
          _selectedType == null || course.type == _selectedType;

      final matchesStatus =
          _statusFilter == null || course.status == _statusFilter;

      return matchesSearch &&
          matchesDepartment &&
          matchesSemester &&
          matchesType &&
          matchesStatus;
    }).toList();
  }

  List<String> get departments {
    return _courses.map((course) => course.department).toSet().toList()
      ..sort();
  }

  String get selectedDepartment => _selectedDepartment;

  String get selectedSemester => _selectedSemester;

  CourseType? get selectedType => _selectedType;

  int get totalCourses => _courses.length;

  int get activeCourses =>
      _courses.where((course) => course.status == CourseStatus.active).length;

  int get inactiveCourses =>
      _courses.where((course) => course.status == CourseStatus.inactive).length;

  int get totalDepartments => departments.length;

  Map<String, int> get coursesByType {
    final data = <String, int>{
      'Core': 0,
      'Elective': 0,
    };

    for (final course in _courses) {
      if (course.type == CourseType.core) {
        data['Core'] = (data['Core'] ?? 0) + 1;
      } else {
        data['Elective'] = (data['Elective'] ?? 0) + 1;
      }
    }

    return data;
  }

  void loadDummyData(List<CourseModel> data) {
    _useDummyData = true;
    _courses
      ..clear()
      ..addAll(data);
    _syncDefaultDepartment();
    notifyListeners();
  }

  void searchCourses(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void filterDepartment(String value) {
    _selectedDepartment = value;
    notifyListeners();
  }

  void filterSemester(String value) {
    _selectedSemester = value;
    notifyListeners();
  }

  void filterType(CourseType? type) {
    _selectedType = type;
    notifyListeners();
  }

  void filterStatus(CourseStatus? status) {
    _statusFilter = status;
    notifyListeners();
  }

  Future<void> loadCourses() async {
    if (_useDummyData) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final results = await _repository.getCourses();
      if (_useDummyData) {
        return;
      }

      _courses
        ..clear()
        ..addAll(results);
      _syncDefaultDepartment();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addCourse(CourseModel course) async {
    if (_useDummyData) {
      _courses.insert(0, course);
      _syncDefaultDepartment();
      notifyListeners();
      return;
    }

    await _repository.addCourse(course);
    await loadCourses();
  }

  Future<void> updateCourse(CourseModel course) async {
    if (_useDummyData) {
      final index = _courses.indexWhere((item) => item.id == course.id);
      if (index != -1) {
        _courses[index] = course;
        _syncDefaultDepartment();
        notifyListeners();
      }
      return;
    }

    await _repository.updateCourse(course);
    await loadCourses();
  }

  Future<void> deleteCourse(String id) async {
    if (_useDummyData) {
      _courses.removeWhere((course) => course.id == id);
      _selectedIds.remove(id);
      _syncDefaultDepartment();
      notifyListeners();
      return;
    }

    await _repository.deleteCourse(id);
    await loadCourses();
  }

  Future<void> toggleStatus(String id) async {
    final index = _courses.indexWhere((course) => course.id == id);
    if (index == -1) {
      return;
    }

    final course = _courses[index];
    final updatedCourse = course.copyWith(
      status: course.status == CourseStatus.active
          ? CourseStatus.inactive
          : CourseStatus.active,
      updatedAt: DateTime.now(),
    );

    if (_useDummyData) {
      _courses[index] = updatedCourse;
      notifyListeners();
      return;
    }

    await _repository.updateCourse(updatedCourse);
    await loadCourses();
  }

  bool isSelected(String id) => _selectedIds.contains(id);

  void toggleSelection(String id) {
    if (_selectedIds.contains(id)) {
      _selectedIds.remove(id);
    } else {
      _selectedIds.add(id);
    }
    notifyListeners();
  }

  void clearSelection() {
    _selectedIds.clear();
    notifyListeners();
  }

  bool get hasSelection => _selectedIds.isNotEmpty;

  int get selectedCount => _selectedIds.length;

  Future<void> deleteSelectedCourses() async {
    if (_selectedIds.isEmpty) {
      return;
    }

    if (_useDummyData) {
      _courses.removeWhere((course) => _selectedIds.contains(course.id));
      _selectedIds.clear();
      _syncDefaultDepartment();
      notifyListeners();
      return;
    }

    await _repository.deleteSelectedCourses(_selectedIds.toList());
    _selectedIds.clear();
    await loadCourses();
  }

  void _syncDefaultDepartment() {
    if (_selectedDepartment.isEmpty && departments.isNotEmpty) {
      _selectedDepartment = departments.first;
    } else if (_selectedDepartment.isNotEmpty &&
        departments.isNotEmpty &&
        !departments.contains(_selectedDepartment)) {
      _selectedDepartment = departments.first;
    }
  }
}
