class ResultModel {
  final String courseCode;
  final String courseTitle;
  final int creditHours;
  final String grade;
  final double gradePoint;
  final String semester;

  const ResultModel({
    required this.courseCode,
    required this.courseTitle,
    required this.creditHours,
    required this.grade,
    required this.gradePoint,
    required this.semester,
  });
}