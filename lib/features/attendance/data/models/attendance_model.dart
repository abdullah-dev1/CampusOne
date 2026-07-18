import '../../../admin/student_management/data/models/student_model.dart';

enum AttendanceStatus {
  none,
 present,
 absent,
 late,
}

class AttendanceModel {
  final StudentModel student;

  AttendanceStatus status;

  AttendanceModel({
    required this.student,
    this.status = AttendanceStatus.none,
  });

  String get studentId => student.id;

  String get studentName => student.fullName;

  String get registrationNo => student.registrationNo;
}