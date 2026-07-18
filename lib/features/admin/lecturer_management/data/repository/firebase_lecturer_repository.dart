import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../core/services/admin_account_service.dart';
import '../../../../../core/utils/password_generator.dart';
import '../../domain/repository/lecturer_repository.dart';
import '../models/lecturer_model.dart';

class FirebaseLecturerRepository implements LecturerRepository {
  final FirebaseFirestore _firestore;
  final AdminAccountService _accountService;

  FirebaseLecturerRepository(
    this._firestore,
    this._accountService,
  );

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('lecturers');

  //==================== READ ====================//

  @override
  Stream<List<LecturerModel>> watchLecturers() {
    return _collection
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => LecturerModel.fromMap(
                  doc.id,
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  //==================== CREATE ====================//

  @override
  Future<String> createLecturer(
    LecturerModel lecturer,
  ) async {
    final password = PasswordGenerator.generate();

    final uid =
        await _accountService.createAuthAccount(
      email: lecturer.email,
      password: password,
    );

    lecturer.createdAt = DateTime.now();

    // Lecturer Profile
    await _collection
        .doc(uid)
        .set(
          lecturer.toMap(),
        );

    // User Role
    await _firestore
        .collection('users')
        .doc(uid)
        .set({
      'email': lecturer.email,
      'name': lecturer.fullName,
      'role': 'lecturer',
      'createdAt':
          FieldValue.serverTimestamp(),
    });

    return password;
  }

  //==================== UPDATE ====================//

  @override
  Future<void> updateLecturer(
    LecturerModel lecturer,
  ) async {
    await _collection
        .doc(lecturer.id)
        .update(
          lecturer.toMap(),
        );
  }

  //==================== DELETE ====================//

  @override
  Future<void> deleteLecturer(
    String id,
  ) async {
    await _collection
        .doc(id)
        .delete();
  }

  //==================== STATUS ====================//

  @override
  Future<void> updateStatus(
    String id,
    LecturerStatus status,
  ) async {
    await _collection
        .doc(id)
        .update({
      'status': status.name,
    });
  }

  //==================== BULK STATUS ====================//

  @override
  Future<void> bulkUpdateStatus(
    List<String> ids,
    LecturerStatus status,
  ) async {
    final batch = _firestore.batch();

    for (final id in ids) {
      batch.update(
        _collection.doc(id),
        {
          'status': status.name,
        },
      );
    }

    await batch.commit();
  }

  //==================== BULK DELETE ====================//

  @override
  Future<void> bulkDelete(
    List<String> ids,
  ) async {
    final batch = _firestore.batch();

    for (final id in ids) {
      batch.delete(
        _collection.doc(id),
      );
    }

    await batch.commit();
  }
}