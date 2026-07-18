import '../../data/models/student_model.dart';

abstract class StudentRepository {
  Stream<List<StudentModel>> watchStudents();

  /// Creates the student's Auth account + Firestore doc.
  /// Returns the generated temporary password.
  Future<String> createStudent(StudentModel student);

  Future<void> updateStudent(StudentModel student);

  Future<void> deleteStudent(String id);

  Future<void> updateStatus(String id, StudentStatus status);

  Future<void> bulkUpdateStatus(List<String> ids, StudentStatus status);

  Future<void> bulkDelete(List<String> ids);
}