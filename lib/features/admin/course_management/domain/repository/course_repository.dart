import '../../data/models/course_model.dart';

abstract class CourseRepository {
  Future<List<CourseModel>> getCourses();

  Future<void> addCourse(
    CourseModel course,
  );

  Future<void> updateCourse(
    CourseModel course,
  );

  Future<void> deleteCourse(
    String courseId,
  );

  Future<void> deleteSelectedCourses(
    List<String> ids,
  );
}