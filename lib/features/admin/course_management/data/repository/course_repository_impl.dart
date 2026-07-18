import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/repository/course_repository.dart';
import '../models/course_model.dart';

class CourseRepositoryImpl
    implements CourseRepository {
  final FirebaseFirestore _firestore;

  CourseRepositoryImpl({
    FirebaseFirestore? firestore,
  }) : _firestore =
            firestore ?? FirebaseFirestore.instance;

  static const String _collection =
      "courses";

  @override
  Future<List<CourseModel>>
      getCourses() async {
    try {
      final snapshot =
          await _firestore
              .collection(_collection)
              .orderBy(
                "createdAt",
                descending: true,
              )
              .get();

      return snapshot.docs
          .map(
            (doc) => CourseModel.fromMap({
              ...doc.data(),
              'id': doc.id,
            }),
          )
          .toList();
    } catch (e) {
      throw Exception(
        "Failed to load courses: $e",
      );
    }
  }

  @override
  Future<void> addCourse(
    CourseModel course,
  ) async {
    try {
      final document =
          _firestore
              .collection(_collection)
              .doc();

      final newCourse = course.copyWith(
        id: document.id,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await document.set(
        newCourse.toMap(),
      );
    } catch (e) {
      throw Exception(
        "Failed to add course: $e",
      );
    }
  }

  @override
  Future<void> updateCourse(
    CourseModel course,
  ) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(course.id)
          .update(
            course.copyWith(
              updatedAt: DateTime.now(),
            ).toMap(),
          );
    } catch (e) {
      throw Exception(
        "Failed to update course: $e",
      );
    }
  }

  @override
  Future<void> deleteCourse(
    String courseId,
  ) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(courseId)
          .delete();
    } catch (e) {
      throw Exception(
        "Failed to delete course: $e",
      );
    }
  }

  @override
  Future<void> deleteSelectedCourses(
    List<String> ids,
  ) async {
    final batch = _firestore.batch();

    for (final id in ids) {
      batch.delete(
        _firestore
            .collection(_collection)
            .doc(id),
      );
    }

    await batch.commit();
  }
}