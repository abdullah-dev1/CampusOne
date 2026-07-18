class CourseStudentModel {
  final String id;
  final String name;
  final String registrationNo;
  final double attendance;
  final double cgpa;
final String department;

final String session;

final int semester;

final String section;

final int credits;

final String email;
  const CourseStudentModel({
    required this.id,
    required this.name,
    required this.registrationNo,
    required this.attendance,
    required this.cgpa,
    required this.department,
required this.session,
required this.semester,
required this.section,
required this.credits,
required this.email,
  });
}