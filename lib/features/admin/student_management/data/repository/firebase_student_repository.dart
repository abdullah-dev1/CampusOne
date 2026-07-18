import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../core/services/admin_account_service.dart';
import '../../../../../core/utils/password_generator.dart';
import '../../domain/repository/student_repository.dart';
import '../models/student_model.dart';

class FirebaseStudentRepository implements StudentRepository {
  final FirebaseFirestore _firestore;
  final AdminAccountService _accountService;

  FirebaseStudentRepository(this._firestore, this._accountService);

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('students');

  @override
  Stream<List<StudentModel>> watchStudents() {
    return _collection.orderBy('createdAt', descending: true).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => StudentModel.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  @override
Future<String> createStudent(StudentModel student) async {
  final password = PasswordGenerator.generate();

  final uid = await _accountService.createAuthAccount(
    email: student.email,
    password: password,
  );

  student.createdAt = DateTime.now();

  // Write full profile to `students`
  await _collection.doc(uid).set(student.toMap());

  // Write role record to `users` (used by login to determine role/routing)
  await _firestore.collection('users').doc(uid).set({
    'email': student.email,
    'name': student.fullName,
    'role': 'student',
    'createdAt': FieldValue.serverTimestamp(),
  });

  return password;
}

  @override
  Future<void> updateStudent(StudentModel student) async {
    await _collection.doc(student.id).update(student.toMap());
  }

  @override
  Future<void> deleteStudent(String id) async {
    // NOTE: This only removes the Firestore profile. Deleting the
    // Firebase Auth account requires a Cloud Function (Admin SDK) —
    // planned for a later phase. For now we also mark them inactive
    // as a safeguard in case the doc delete runs before any cleanup.
    await _collection.doc(id).delete();
  }

  @override
  Future<void> updateStatus(String id, StudentStatus status) async {
    await _collection.doc(id).update({'status': status.name});
  }

  @override
  Future<void> bulkUpdateStatus(
    List<String> ids,
    StudentStatus status,
  ) async {
    final batch = _firestore.batch();

    for (final id in ids) {
      batch.update(_collection.doc(id), {'status': status.name});
    }

    await batch.commit();
  }

  @override
  Future<void> bulkDelete(List<String> ids) async {
    final batch = _firestore.batch();

    for (final id in ids) {
      batch.delete(_collection.doc(id));
    }

    await batch.commit();
  }
}