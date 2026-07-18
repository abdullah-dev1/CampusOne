import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/repository/department_repository.dart';
import '../models/department_model.dart';

class FirebaseDepartmentRepository
    implements DepartmentRepository {
  final FirebaseFirestore _firestore;

  FirebaseDepartmentRepository(
    this._firestore,
  );

  CollectionReference<Map<String, dynamic>>
      get _collection =>
          _firestore.collection('departments');

  //==================== READ ====================//

  @override
  Stream<List<DepartmentModel>>
      watchDepartments() {
    return _collection
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => DepartmentModel.fromMap(
                  doc.id,
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  //==================== CREATE ====================//

  @override
  Future<void> createDepartment(
    DepartmentModel department,
  ) async {
    department.createdAt = DateTime.now();

    final doc = _collection.doc();

    department.id = doc.id;

    await doc.set(
      department.toMap(),
    );
  }

  //==================== UPDATE ====================//

  @override
  Future<void> updateDepartment(
    DepartmentModel department,
  ) async {
    await _collection
        .doc(department.id)
        .update(
          department.toMap(),
        );
  }

  //==================== DELETE ====================//

  @override
  Future<void> deleteDepartment(
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
    DepartmentStatus status,
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
    DepartmentStatus status,
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