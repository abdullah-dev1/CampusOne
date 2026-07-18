import '../../data/models/lecturer_model.dart';

abstract class LecturerRepository {
  //---------------- READ ----------------//

  Stream<List<LecturerModel>> watchLecturers();

  //---------------- CREATE ----------------//

  /// Creates Firebase Auth account
  /// Returns generated temporary password
  Future<String> createLecturer(
    LecturerModel lecturer,
  );

  //---------------- UPDATE ----------------//

  Future<void> updateLecturer(
    LecturerModel lecturer,
  );

  //---------------- DELETE ----------------//

  Future<void> deleteLecturer(
    String id,
  );

  //---------------- STATUS ----------------//

  Future<void> updateStatus(
    String id,
    LecturerStatus status,
  );

  //---------------- BULK ----------------//

  Future<void> bulkUpdateStatus(
    List<String> ids,
    LecturerStatus status,
  );

  Future<void> bulkDelete(
    List<String> ids,
  );
}