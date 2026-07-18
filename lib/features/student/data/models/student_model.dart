class StudentModel {
  final String id;
  final String name;
  final String email;
  final String registrationNo;
  final String department;
  final String program;
  final String semester;
  final String session;
  final String profileImage;

  final double cgpa;
  final int credits;
  final double attendance;

  const StudentModel({
    required this.id,
    required this.name,
    required this.email,
    required this.registrationNo,
    required this.department,
    required this.program,
    required this.semester,
    required this.session,
    required this.profileImage,
    required this.cgpa,
    required this.credits,
    required this.attendance,
  });
}