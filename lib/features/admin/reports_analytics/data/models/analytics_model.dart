class AnalyticsModel {
  // ==========================
  // OVERVIEW
  // ==========================

  final int totalStudents;
  final int totalLecturers;
  final int totalCourses;
  final int totalDepartments;
  final int totalNotices;

  // ==========================
  // STATUS
  // ==========================

  final int activeStudents;
  final int inactiveStudents;

  final int activeLecturers;
  final int inactiveLecturers;

  final int activeCourses;
  final int inactiveCourses;

  final int activeDepartments;
  final int inactiveDepartments;

  final int publishedNotices;
  final int draftNotices;
  final int archivedNotices;
  final int pinnedNotices;


  // ==========================
  // CHART DATA
  // ==========================

  final Map<String, int> studentsByDepartment;

  final Map<String, int> lecturersByDepartment;

  final Map<String, int> coursesByDepartment;

  final Map<String, int> noticesByCategory;

  const AnalyticsModel({

    required this.totalStudents,
    required this.totalLecturers,
    required this.totalCourses,
    required this.totalDepartments,
    required this.totalNotices,

    required this.activeStudents,
    required this.inactiveStudents,

    required this.activeLecturers,
    required this.inactiveLecturers,

    required this.activeCourses,
    required this.inactiveCourses,

    required this.activeDepartments,
    required this.inactiveDepartments,

    required this.publishedNotices,
    required this.draftNotices,
    required this.archivedNotices,
    required this.pinnedNotices,

    required this.largestDepartment,
    required this.departmentWithMostCourses,
    required this.newestNotice,

    required this.averageStudentsPerDepartment,
    required this.averageCoursesPerDepartment,
    required this.averageStudentsPerLecturer,

    required this.studentsByDepartment,
    required this.lecturersByDepartment,
    required this.coursesByDepartment,
    required this.noticesByCategory,
  });
}