import '../../data/models/department_model.dart';

abstract class DepartmentRepository {
  //==================== READ ====================//

  Stream<List<DepartmentModel>> watchDepartments();

  //==================== CREATE ====================//

  Future<void> createDepartment(
    DepartmentModel department,
  );

  //==================== UPDATE ====================//

  Future<void> updateDepartment(
    DepartmentModel department,
  );

  //==================== DELETE ====================//

  Future<void> deleteDepartment(
    String id,
  );

  //==================== STATUS ====================//

  Future<void> updateStatus(
    String id,
    DepartmentStatus status,
  );

  //==================== BULK STATUS ====================//

  Future<void> bulkUpdateStatus(
    List<String> ids,
    DepartmentStatus status,
  );

  //==================== BULK DELETE ====================//

  Future<void> bulkDelete(
    List<String> ids,
  );
}