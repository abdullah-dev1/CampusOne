import 'package:flutter/material.dart';

class AdminProvider extends ChangeNotifier {
  int totalStudents = 420;
  int totalLecturers = 32;
  int totalCourses = 18;
  int totalDepartments = 5;
  int totalNotices = 14;
  int activeUsers = 247;

  double attendanceRate = 92;
  double feeCollection = 81;
  double courseCompletion = 74;
  double resultPublished = 65;
String adminName = "Muhammad Abdullah";

String currentSemester = "Fall 2026";

String academicYear = "2026-2027";

int totalSections = 12;

int attendanceToday = 92;

int activeNotices = 14;
  void loadDashboard() {
    notifyListeners();
  }
}